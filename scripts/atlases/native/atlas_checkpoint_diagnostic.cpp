// Read-only native-F25 analysis of the ABI-checked F5 F4 checkpoint.
// No new ideal membership, completion or emptiness claim is made here.
// The checksum and every row coefficient are checked, not sampled.
#include <algorithm>
#include <array>
#include <atomic>
#include <chrono>
#include <cstdint>
#include <cstring>
#include <fcntl.h>
#include <iostream>
#include <map>
#include <numeric>
#include <omp.h>
#include <stdexcept>
#include <string>
#include <sys/mman.h>
#include <sys/stat.h>
#include <thread>
#include <unistd.h>
#include <vector>
using namespace std;
using Clock=chrono::steady_clock;
static void need(bool b,const char* s){if(!b)throw runtime_error(s);}
struct Input {
    const uint8_t* p; size_t size,pos=0; int fd;
    Input(const char* name){fd=open(name,O_RDONLY);need(fd>=0,"open");struct stat st;
        need(fstat(fd,&st)==0,"stat");size=st.st_size;
        p=(const uint8_t*)mmap(nullptr,size,PROT_READ,MAP_PRIVATE,fd,0);need(p!=MAP_FAILED,"mmap");}
    ~Input(){munmap((void*)p,size);close(fd);}
    const uint8_t* take(size_t n){need(n<=size-pos,"truncated input");auto q=p+pos;pos+=n;return q;}
    template<class T>T get(){T t;memcpy(&t,take(sizeof(T)),sizeof(T));return t;}
};
static uint32_t u32(const uint8_t* p){uint32_t v;memcpy(&v,p,4);return v;}
static uint16_t u16(const uint8_t* p){uint16_t v;memcpy(&v,p,2);return v;}
struct Row {uint32_t n;const uint8_t *ids,*coeff;};
struct Result {uint32_t lm=UINT32_MAX,terms=0;uint8_t lc=0;uint64_t fingerprint=0;};
int main(int argc,char** argv)try {
    need(argc==3||argc==4,"usage: atlas_checkpoint_diagnostic CHECKPOINT THREADS [RREF_DEGREE]");
    int nt=stoi(argv[2]);need(nt>=1&&nt<=10,"threads outside1..10");
    int rref_degree=argc==4?stoi(argv[3]):0;need(rref_degree>=0&&rref_degree<=3,"RREF degree outside0..3");
    omp_set_num_threads(nt);
    auto start=Clock::now();auto seconds=[&](){return chrono::duration<double>(Clock::now()-start).count();};
    Input in(argv[1]);uint64_t hash=14695981039346656037ULL;
    for(size_t j=0;j+8<in.size;++j){hash^=in.p[j];hash*=1099511628211ULL;}
    uint64_t saved;memcpy(&saved,in.p+in.size-8,8);need(hash==saved,"checkpoint checksum");
    cerr<<"checksum PASS "<<seconds()<<"s\n";
    array<uint64_t,15> h;for(auto& z:h)z=in.get<uint64_t>();
    need(h[0]==0x41544c4153463443ULL&&h[1]==1&&h[2]==0x01020304,"header");
    need(h[3]==2&&h[4]==4&&h[5]==16&&h[6]==8&&h[7]==6&&h[8]==5&&h[10]==0&&h[11]==0&&h[12]==8&&h[13]==2,"ABI");
    array<uint64_t,16> d;for(auto& z:d)z=in.get<uint64_t>();
    size_t nr=d[0],nl=d[5],nm=d[7],hsz=d[9],nv=d[11],evl=d[12],ndv=d[13],bpv=d[14];
    need(nv==h[9]&&nv>=2&&nv<=64&&evl==nv+1,"variables");
    auto ex=in.take(nm*evl*2);in.take(nm*16+hsz*4+ndv*bpv*4+ndv*4+evl*4);
    auto red=in.take(nr);in.take(nl*8);vector<Row> rows;
    for(size_t i=0;i<nr;++i){uint64_t n=in.get<uint64_t>();auto meta=in.take((n+6)*4);
        need(n>0&&u32(meta+20)==n&&u32(meta+12)<nr,"row header");
        rows.push_back({uint32_t(n),meta+24,in.take(n)});}
    auto np=in.get<uint64_t>();in.get<uint64_t>();in.take(np*40);in.take(16*8+32);
    need(in.pos+8==in.size,"end position");
    auto exp=[&](uint32_t m,size_t i){return u16(ex+2*(m*evl+i+1));};
    vector<uint32_t> order(nm),rank(nm),native_source;
    iota(order.begin(),order.end(),0);
    vector<uint16_t> degrees(nm),adegrees(nm);
    for(uint32_t m=0;m<nm;++m){size_t sum=0;for(size_t i=0;i<nv;++i)sum+=exp(m,i);
        need(sum==u16(ex+2*m*evl),"monomial degree");adegrees[m]=exp(m,nv-1);degrees[m]=sum-adegrees[m];}
    auto cmp=[&](uint32_t a,uint32_t b){if(degrees[a]!=degrees[b])return degrees[a]>degrees[b];
        for(size_t i=nv-1;i-->0;)if(exp(a,i)!=exp(b,i))return exp(a,i)<exp(b,i);
        return false;};
    sort(order.begin(),order.end(),cmp);
    for(auto m:order){if(native_source.empty()||cmp(native_source.back(),m))native_source.push_back(m);
        rank[m]=native_source.size()-1;}
    // Encoding c0+5*c1 and a^2=a+3, i.e. a^2+4a+2=0.
    uint8_t add[25][25],mul[25][25];
    for(int a=0;a<25;++a)for(int b=0;b<25;++b){
        add[a][b]=((a%5+b%5)%5)+5*((a/5+b/5)%5);
        int aa=a%5,ab=a/5,ba=b%5,bb=b/5;
        mul[a][b]=(aa*ba+3*ab*bb)%5+5*((aa*bb+ab*ba+ab*bb)%5);}
    vector<array<uint8_t,5>> coefficient(1+*max_element(adegrees.begin(),adegrees.end()));
    uint8_t ap=1;for(auto& r:coefficient){for(int c=0;c<5;++c)r[c]=mul[ap][c];ap=mul[ap][5];}
    vector<Result> result(nr);atomic<uint32_t> next{0},finished{0};atomic<uint64_t> terms{0};
    vector<thread> workers;auto converted_start=seconds();
    for(int t=0;t<nt;++t)workers.emplace_back([&]{
        vector<uint8_t> acc(native_source.size()),seen(native_source.size());vector<uint32_t> touched;
        for(;;){uint32_t i=next.fetch_add(1);if(i>=nr)break;const auto& row=rows[i];
            touched.clear();for(uint32_t j=0;j<row.n;++j){uint32_t m=u32(row.ids+4*j);
                need(m<nm&&row.coeff[j]<5,"row term");uint32_t r=rank[m];
                if(!seen[r]){seen[r]=1;touched.push_back(r);}
                acc[r]=add[acc[r]][coefficient[adegrees[m]][row.coeff[j]]];}
            Result rr;for(uint32_t r:touched){if(acc[r]){++rr.terms;
                    if(r<rr.lm){rr.lm=r;rr.lc=acc[r];}
                    // Order-independent diagnostic fingerprint, NOT a proof hash.
                    rr.fingerprint+=((uint64_t(r)+1)*0x9e3779b97f4a7c15ULL)^acc[r];}
                acc[r]=0;seen[r]=0;}
            result[i]=rr;terms.fetch_add(row.n);auto done=finished.fetch_add(1)+1;
            if(done%5000==0)cerr<<"converted "<<done<<"/"<<nr<<" rows "<<seconds()<<"s\n";
        }});
    for(auto& t:workers)t.join();
    map<array<int,3>,size_t> leading;map<uint32_t,size_t> multiplicity;size_t total=0,zero=0,changed=0,redundant=0;
    for(size_t i=0;i<nr;++i){redundant+=bool(red[i]);auto& r=result[i];total+=r.terms;
        if(r.lm==UINT32_MAX){++zero;continue;}auto m=native_source[r.lm];int v=0,b=0;
        for(size_t j=0;j<nv-1;++j)(j<32?v:b)+=exp(m,j);
        ++leading[{v,b,int(degrees[m])}];++multiplicity[r.lm];changed+=r.lm!=rank[u32(rows[i].ids)];}
    // Choose one exact polynomial for every native leading monomial.
    // Count its tail's dependence on this fixed triangular reducer set.
    vector<int32_t> owner(native_source.size(),-1);vector<uint32_t> dependencies(nr,0);
    vector<uint64_t> dependency_work(nr,0);vector<uint32_t> selected_pivots;
    for(size_t i=0;i<nr;++i)if(result[i].terms){auto r=result[i].lm;int old=owner[r];
        if(old<0||result[i].terms<result[old].terms)owner[r]=i;}
    for(auto i:owner)if(i>=0)selected_pivots.push_back(i);
    #pragma omp parallel
    {
        vector<uint8_t> acc(native_source.size()),seen(native_source.size());vector<uint32_t> touched;
        #pragma omp for schedule(dynamic,16)
        for(size_t k0=0;k0<selected_pivots.size();++k0){uint32_t i=selected_pivots[k0];auto row=rows[i];touched.clear();
            for(uint32_t j=0;j<row.n;++j){uint32_t m=u32(row.ids+4*j),r=rank[m];
                if(!seen[r]){seen[r]=1;touched.push_back(r);}acc[r]=add[acc[r]][coefficient[adegrees[m]][row.coeff[j]]];}
            for(auto r:touched){if(acc[r]&&r!=result[i].lm){need(r>result[i].lm,"native order not triangular");
                    if(owner[r]>=0){++dependencies[i];dependency_work[i]+=result[owner[r]].terms;}}
                acc[r]=0;seen[r]=0;}
        }
    }
    uint64_t dependent_terms=0,naive_cached_updates=0;size_t already_reduced=0;
    for(auto i:selected_pivots){dependent_terms+=dependencies[i];naive_cached_updates+=dependency_work[i];already_reduced+=dependencies[i]==0;}
    cerr<<"triangular cache: "<<already_reduced<<"/"<<selected_pivots.size()<<" already tail-reduced; "
        <<dependent_terms<<" pivot-tail terms; one-step raw cost "<<naive_cached_updates<<"\n";
    size_t matrix_rows=0,matrix_cols=0,matrix_rank=0;uint64_t updates=0;double rref_seconds=0;
    map<int,size_t> rref_leading_degrees;
    if(rref_degree){
        auto rstart=seconds();vector<uint32_t> selected,columns;vector<int32_t> colindex(native_source.size(),-1);
        for(uint32_t i=0;i<nr;++i)if(result[i].terms&&degrees[native_source[result[i].lm]]<=rref_degree)selected.push_back(i);
        for(auto i:selected)for(uint32_t j=0;j<rows[i].n;++j)colindex[rank[u32(rows[i].ids+4*j)]]=0;
        for(uint32_t r=0;r<colindex.size();++r)if(colindex[r]==0){colindex[r]=columns.size();columns.push_back(r);}
        matrix_rows=selected.size();matrix_cols=columns.size();
        vector<vector<uint8_t>> matrix(matrix_rows,vector<uint8_t>(matrix_cols));
        #pragma omp parallel for schedule(dynamic,8)
        for(size_t i=0;i<matrix_rows;++i){auto& row=rows[selected[i]];auto& z=matrix[i];
            for(uint32_t j=0;j<row.n;++j){uint32_t m=u32(row.ids+4*j);int c=colindex[rank[m]];
                z[c]=add[z[c]][coefficient[adegrees[m]][row.coeff[j]]];}}
        uint8_t inv[25]={0},neg[25],subtract[25][625];
        for(int a=0;a<25;++a){neg[a]=(5-a%5)%5+5*((5-a/5)%5);
            if(a)for(int b=1;b<25;++b)if(mul[a][b]==1)inv[a]=b;}
        for(int a=0;a<25;++a)for(int b=0;b<25;++b)for(int c=0;c<25;++c)subtract[a][25*b+c]=add[c][neg[mul[a][b]]];
        cerr<<"native linear elimination "<<matrix_rows<<" x "<<matrix_cols<<"\n";
        for(size_t c=0;c<matrix_cols&&matrix_rank<matrix_rows;++c){
            size_t pivot=matrix_rank;while(pivot<matrix_rows&&!matrix[pivot][c])++pivot;if(pivot==matrix_rows)continue;
            swap(matrix[pivot],matrix[matrix_rank]);auto& p=matrix[matrix_rank];uint8_t scale=inv[p[c]];need(scale,"pivot inverse");
            for(size_t j=c;j<matrix_cols;++j)p[j]=mul[scale][p[j]];
            uint64_t changed_rows=0;
            #pragma omp parallel for schedule(static) reduction(+:changed_rows)
            for(size_t i=matrix_rank+1;i<matrix_rows;++i){auto& row=matrix[i];uint8_t a=row[c];if(!a)continue;
                ++changed_rows;auto table=subtract[a];row[c]=0;
                for(size_t j=c+1;j<matrix_cols;++j)row[j]=table[25*p[j]+row[j]];}
            updates+=changed_rows*(matrix_cols-c-1);++matrix_rank;
            ++rref_leading_degrees[degrees[native_source[columns[c]]]];
            if(matrix_rank%250==0)cerr<<"pivots "<<matrix_rank<<" updates "<<updates<<" seconds "<<seconds()-rstart<<"\n";
        }
        rref_seconds=seconds()-rstart;
        // This is echelon reduction of the selected LINEAR row span only.
        // No multiplied rows, omitted constraints or degree bound on a GB.
        cerr<<"native linear elimination DONE rank "<<matrix_rank<<"/"<<matrix_rows<<" in "<<rref_seconds<<"s\n";
    }
    cout<<"{\n  \"threads\": "<<nt<<",\n  \"checkpoint_checksum_verified\": true,\n"
        <<"  \"basis_rows\": "<<nr<<",\n  \"encoded_terms\": "<<terms.load()<<",\n"
        <<"  \"native_terms\": "<<total<<",\n  \"native_zero_rows\": "<<zero<<",\n"
        <<"  \"native_distinct_leading_monomials\": "<<multiplicity.size()<<",\n"
        <<"  \"native_reordered_leading_rows\": "<<changed<<",\n"
        <<"  \"native_monomials\": "<<native_source.size()<<",\n"
        <<"  \"marked_redundant_rows\": "<<redundant<<",\n"
        <<"  \"already_tail_reduced_pivots\": "<<already_reduced<<",\n"
        <<"  \"pivot_tail_dependencies\": "<<dependent_terms<<",\n"
        <<"  \"one_step_raw_tail_update_estimate\": "<<naive_cached_updates<<",\n"
        <<"  \"conversion_seconds\": "<<seconds()-converted_start<<",\n"
        <<"  \"total_seconds\": "<<seconds()<<",\n  \"native_leading_bidegrees\": {";
    bool first=true;for(auto [e,n]:leading){cout<<(first?"\n":",\n")<<"    \""<<e[0]<<","<<e[1]<<","<<e[2]<<"\": "<<n;first=false;}
    cout<<"\n  },\n  \"linear_span_test\": {\"degree\": "<<rref_degree<<", \"rows\": "<<matrix_rows
        <<", \"columns\": "<<matrix_cols<<", \"rank\": "<<matrix_rank<<", \"coefficient_updates\": "<<updates
        <<", \"seconds\": "<<rref_seconds<<", \"leading_degrees\": {";
    first=true;for(auto [d,n]:rref_leading_degrees){cout<<(first?"":", ")<<'"'<<d<<"\": "<<n;first=false;}
    cout<<"}},\n  \"scope\": \"Exact coefficient conversion and selected linear row span diagnostic only; no completed basis or atlas exclusion.\"\n}\n";
    return 0;
} catch(const exception& e){cerr<<"ERROR "<<e.what()<<'\n';return 1;}
