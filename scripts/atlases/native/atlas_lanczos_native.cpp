// Runtime playground: symmetric look-ahead Lanczos over F25.
// Candidate finder ONLY. Termination/breakdown is not an ideal conclusion.
// The only accepted result is a scalar-replayed M^t lambda=e_last.
// Variable blocks handle isotropic Krylov vectors without dividing by zero.
#define ATLAS_BLACKBOX_LIBRARY
#include "../algebra/atlas_sparse_blackbox.cpp"
#include "atlas_macaulay_factor.hpp"
#include "atlas_component_gram.hpp"
#include <filesystem>
#include <sstream>
#include <csignal>
#include <cstdlib>
#include <memory>
#include <sys/resource.h>

static volatile std::sig_atomic_t interrupted=0;
static void request_stop(int){interrupted=1;}
static uint64_t hash_extend(uint64_t h,const void*p,size_t n) {
    auto b=static_cast<const uint8_t*>(p);
    for(size_t i=0;i<n;i++){h^=b[i];h*=1099511628211ULL;}return h;
}
static void atomic_text(const std::filesystem::path&p,const std::string&s) {
    auto tmp=p;tmp+=".tmp";std::ofstream f(tmp);f<<s<<'\n';f.close();
    if(!f)throw std::runtime_error("diagnostic write failure");std::filesystem::rename(tmp,p);
}

static uint8_t minusf[25][25],inversef[25];
static void tables() {
    init_field();
    for(int a=0;a<25;a++)for(int b=0;b<25;b++) {
        minusf[a][b]=(a%5-b%5+5)%5+5*((a/5-b/5+5)%5);
        if(product[a][b]==1)inversef[a]=b;
    }
}
static uint8_t inner(const Bytes&a,const Bytes&b) {
    uint64_t p=0,q=0;
    for(size_t i=0;i<a.size();i++){p+=lo[a[i]][b[i]];q+=hi[a[i]][b[i]];}
    return p%5+5*(q%5);
}
static bool invert(Bytes a,Bytes&out,int n) {
    out.assign(n*n,0);for(int i=0;i<n;i++)out[i*n+i]=1;
    for(int j=0;j<n;j++) {
        int p=j;while(p<n&&!a[p*n+j])++p;
        if(p==n)return false;
        for(int i=0;i<n;i++){std::swap(a[j*n+i],a[p*n+i]);std::swap(out[j*n+i],out[p*n+i]);}
        auto c=inversef[a[j*n+j]];
        for(int i=0;i<n;i++){a[j*n+i]=product[c][a[j*n+i]];out[j*n+i]=product[c][out[j*n+i]];}
        for(int r=0;r<n;r++)if(r!=j) {
            auto d=a[r*n+j];
            for(int i=0;i<n;i++) {
                a[r*n+i]=minusf[a[r*n+i]][product[d][a[j*n+i]]];
                out[r*n+i]=minusf[out[r*n+i]][product[d][out[j*n+i]]];
            }
        }
    }
    return true;
}
struct Block {
    std::vector<Bytes> v,av;
    Bytes inv;
    // Exact projection orthogonal for <x,y>_A=x^t A y.
    void project(Bytes&w)const {
        size_t r=v.size();if(!r)return;
        Bytes d(r),c(r);
        for(size_t j=0;j<r;j++)d[j]=inner(av[j],w);
        for(size_t i=0;i<r;i++)for(size_t j=0;j<r;j++)c[i]=add(c[i],product[inv[i*r+j]][d[j]]);
        #pragma omp parallel for schedule(static)
        for(size_t k=0;k<w.size();k++) {
            auto a=w[k];
            for(size_t i=0;i<r;i++)a=minusf[a][product[c[i]][v[i][k]]];
            w[k]=a;
        }
    }
    bool nondegenerate() {
        size_t r=v.size();Bytes h(r*r);
        for(size_t i=0;i<r;i++)for(size_t j=0;j<r;j++)h[i*r+j]=inner(v[i],av[j]);
        for(size_t i=0;i<r;i++)for(size_t j=0;j<r;j++)
            if(h[i*r+j]!=h[j*r+i])throw std::runtime_error("asymmetric exact block Gram");
        return invert(std::move(h),inv,r);
    }
    void solution_update(Bytes&z)const {
        // Target is e_last, so V^t target consists of last coordinates.
        size_t r=v.size();Bytes c(r);
        for(size_t i=0;i<r;i++)for(size_t j=0;j<r;j++)c[i]=add(c[i],product[inv[i*r+j]][v[j].back()]);
        #pragma omp parallel for schedule(static)
        for(size_t k=0;k<z.size();k++) {
            auto a=z[k];for(size_t i=0;i<r;i++)a=add(a,product[v[i][k]][c[i]]);z[k]=a;
        }
    }
};
int main(int argc,char**argv)try {
    if(argc<5)throw std::runtime_error("usage: program matrix.bin output_directory seconds equations [seed=20260908] [max_lookahead=8] [threads=10] [diagonal_mode=0] [column_scaling=0]");
    std::filesystem::path out(argv[2]);
    bool resume=std::filesystem::exists(out/"checkpoint.bin");
    if(!resume&&!std::filesystem::create_directory(out))throw std::runtime_error("use a fresh directory or a checkpoint");
    if(std::filesystem::exists(out/"solution.bin")||std::filesystem::exists(out/"dual.bin"))
        throw std::runtime_error("completed certificate exists; verify it instead of rerunning");
    int seed=argc>5?std::stoi(argv[5]):20260908;
    int maximum=argc>6?std::stoi(argv[6]):8;
    double limit=std::stod(argv[3]);
    if(limit<=0||maximum<1||maximum>32)throw std::runtime_error("bad diagnostic limit");
    unsigned threads=argc>7?std::stoul(argv[7]):10;
    if(!threads||threads>10)throw std::runtime_error("thread limit");
    omp_set_num_threads(threads);omp_set_dynamic(0);tables();
    auto start=Clock::now();auto seconds=[&](){return std::chrono::duration<double>(Clock::now()-start).count();};
    CSR M(argv[1]);MacaulayFactor F(M,std::stoul(argv[4]));
    const char* team_setting=std::getenv("ATLAS_GRAM_TEAM");
    bool team=team_setting&&std::string(team_setting)!="0";
    const char* prime_setting=std::getenv("ATLAS_GRAM_PRIME_INPUT");
    bool prime=prime_setting&&std::string(prime_setting)!="0";
    if(prime&&std::any_of(M.val.begin(),M.val.end(),[](auto c){return c>=5;}))
        throw std::runtime_error("prime-input Gram requested for nonprime matrix");
    Bytes row_mask;
    const char* mask_path=std::getenv("ATLAS_ROW_MASK");
    if(mask_path) {
        std::ifstream f(mask_path,std::ios::binary);row_mask.resize(M.rows);
        if(!f.read((char*)row_mask.data(),row_mask.size()))throw std::runtime_error("truncated row mask");
        char extra;if(f.get(extra))throw std::runtime_error("trailing row mask bytes");
        if(std::any_of(row_mask.begin(),row_mask.end(),[](auto c){return c>1;}))
            throw std::runtime_error("row mask must contain only zero or one");
    }
    std::unique_ptr<ComponentGram> component;
    const char* component_setting=std::getenv("ATLAS_GRAM_COMPONENTS");
    if(!F.neq&&mask_path)throw std::runtime_error("use an explicitly compact matrix for sparse masked search");
    if(F.neq&&(mask_path||(component_setting&&std::string(component_setting)!="0")))
        component=std::make_unique<ComponentGram>(M,F,mask_path?&row_mask:nullptr,prime);
    if(component&&component->active_columns==M.cols&&!mask_path)component.reset();
    size_t search_columns=component?component->active_columns:M.cols;
    if(team)omp_set_schedule(omp_sched_dynamic,2048);
    int column_mode=argc>9?std::stoi(argv[9]):0;
    if(column_mode<0||column_mode>1)throw std::runtime_error("bad column scaling mode");
    Bytes column(M.cols,1),scaled(M.cols);
    std::unique_ptr<CSR> sparse_transpose;
    Bytes sparse_rows;
    if(!F.neq)sparse_transpose=std::make_unique<CSR>(M.transpose());
    if(column_mode) {
        std::mt19937 crng(uint32_t(seed)^0x36e92917U);
        for(auto&c:column)c=1+crng()%24;
        column.back()=1;
    }
    auto scale=[&](const Bytes&x,Bytes&y){
        y.resize(M.cols);
        #pragma omp parallel for schedule(static)
        for(size_t j=0;j<M.cols;j++)y[j]=product[column[j]][x[j]];
    };
    // Congruence E M^t D M E, with E_last=1. Certificates in ORIGINAL
    // coordinates are lambda=D M E z (primal) and E w (dual).
    auto gram=[&](const Bytes& x,const Bytes& d,Bytes& y){
        if(column_mode)scale(x,scaled);
        const Bytes&input=column_mode?scaled:x;
        if(sparse_transpose) {
            M.apply(input,sparse_rows,1);
            #pragma omp parallel for schedule(static)
            for(size_t i=0;i<M.rows;i++)sparse_rows[i]=product[sparse_rows[i]][d[i]];
            sparse_transpose->apply(sparse_rows,y,1);
        }else if(component)component->gram(input,d,y);
        else if(prime)F.gram_prime_team(input,d,y);
        else if(team)F.gram_team(input,d,y);else F.gram(input,d,y);
        if(column_mode)scale(y,y);
    };
    std::mt19937 rng(seed);Bytes diagonal(M.rows),z(M.cols,0),w(M.cols,0),av;
    for(auto&x:diagonal)x=1+rng()%24;w.back()=1;
    int mode=argc>8?std::stoi(argv[8]):0;
    if(mode<0||mode>4)throw std::runtime_error("bad diagonal mode");
    if(!F.neq&&mode>1)throw std::runtime_error("factored diagonal mode requires a factored matrix");
    if(mode) {
        Bytes equation(F.neq,1),multiplier(F.nmult,1);
        if(mode==2||mode==4)for(auto&c:equation)c=1+rng()%24;
        if(mode==3||mode==4)for(auto&c:multiplier)c=1+rng()%24;
        for(size_t i=0;i<M.rows;i++)diagonal[i]=F.neq?product[equation[i%F.neq]][multiplier[i/F.neq]]:1;
    }
    if(mask_path)for(size_t i=0;i<M.rows;i++)if(!row_mask[i])diagonal[i]=0;
    Block previous,last,current;
    size_t steps=0,dimension=0,blocks=0;double gram_time=0,projection_time=0,small_time=0,update_time=0;
    std::vector<size_t> widths(maximum+1,0);
    uint64_t matrix_hash=1469598103934665603ULL;
    for(auto part:{std::pair<const void*,size_t>{&M.rows,4},{&M.cols,4},
        {M.ptr.data(),M.ptr.size()*8},{M.idx.data(),M.idx.size()*4},{M.val.data(),M.val.size()}})
        matrix_hash=hash_extend(matrix_hash,part.first,part.second);
    // Masked and unmasked Krylov states must NEVER share a checkpoint.
    if(mask_path) {
        const uint64_t tag=0x524f575f4d41534bULL;
        matrix_hash=hash_extend(matrix_hash,&tag,sizeof(tag));
        matrix_hash=hash_extend(matrix_hash,row_mask.data(),row_mask.size());
    }
    double inherited=0,checkpoint_seconds=0,last_checkpoint=seconds();
    size_t checkpoint_count=0;
    if(resume) {
        std::ifstream f(out/"checkpoint.bin",std::ios::binary);uint64_t hash=1469598103934665603ULL;
        auto readraw=[&](void*p,size_t n){if(!f.read((char*)p,n))throw std::runtime_error("truncated checkpoint");hash=hash_extend(hash,p,n);};
        auto read=[&](auto&x){readraw(&x,sizeof(x));};
        uint64_t magic,h;int oldseed,oldmax,oldmode;size_t oldeq;
        read(magic);read(h);read(oldseed);read(oldmax);read(oldmode);read(oldeq);
        if(magic!=(column_mode?0x4c414e435a4f5332ULL:0x4c414e435a4f5331ULL)||h!=matrix_hash||oldseed!=seed||oldmax!=maximum||oldmode!=mode||oldeq!=F.neq)
            throw std::runtime_error("checkpoint/input/configuration mismatch");
        read(inherited);read(steps);read(dimension);read(blocks);
        read(gram_time);read(projection_time);read(small_time);read(update_time);read(checkpoint_seconds);read(checkpoint_count);
        for(auto&n:widths)read(n);
        auto bytes=[&](Bytes&v,size_t expected){uint64_t n;read(n);if(n!=expected)throw std::runtime_error("bad checkpoint vector length");v.resize(n);readraw(v.data(),n);if(std::any_of(v.begin(),v.end(),[](auto c){return c>=25;}))throw std::runtime_error("bad checkpoint coefficient");};
        bytes(diagonal,M.rows);bytes(z,M.cols);bytes(w,M.cols);
        for(Block*b:{&previous,&last,&current}) {
            uint64_t n;read(n);if(n>size_t(maximum))throw std::runtime_error("bad checkpoint block width");
            b->v.resize(n);b->av.resize(n);
            for(auto&v:b->v)bytes(v,M.cols);for(auto&v:b->av)bytes(v,M.cols);bytes(b->inv,n*n);
        }
        uint64_t saved;if(!f.read((char*)&saved,8)||saved!=hash)throw std::runtime_error("checkpoint checksum mismatch");
        char extra;if(f.get(extra))throw std::runtime_error("trailing checkpoint bytes");
        bool invalid_diagonal=false;
        for(size_t i=0;i<M.rows;i++)if(bool(diagonal[i])!=(!mask_path||bool(row_mask[i])))invalid_diagonal=true;
        if(dimension>M.cols||steps>M.cols+maximum||invalid_diagonal)
            throw std::runtime_error("invalid checkpoint state");
    }
    auto checkpoint=[&](){
        auto begin=seconds();std::ofstream f(out/"checkpoint.tmp",std::ios::binary);uint64_t hash=1469598103934665603ULL;
        auto raw=[&](const void*p,size_t n){f.write((const char*)p,n);hash=hash_extend(hash,p,n);};
        auto put=[&](auto x){raw(&x,sizeof(x));};
        put(uint64_t(column_mode?0x4c414e435a4f5332ULL:0x4c414e435a4f5331ULL));put(matrix_hash);put(seed);put(maximum);put(mode);put(size_t(F.neq));
        put(inherited+seconds());put(steps);put(dimension);put(blocks);
        put(gram_time);put(projection_time);put(small_time);put(update_time);put(checkpoint_seconds);put(checkpoint_count+1);
        for(auto n:widths)put(n);
        auto bytes=[&](const Bytes&v){put(uint64_t(v.size()));raw(v.data(),v.size());};
        bytes(diagonal);bytes(z);bytes(w);
        for(const Block*b:{&previous,&last,&current}) {
            put(uint64_t(b->v.size()));for(auto&v:b->v)bytes(v);for(auto&v:b->av)bytes(v);bytes(b->inv);
        }
        f.write((const char*)&hash,8);f.close();if(!f)throw std::runtime_error("checkpoint write failure");
        std::filesystem::rename(out/"checkpoint.tmp",out/"checkpoint.bin");
        ++checkpoint_count;checkpoint_seconds+=seconds()-begin;last_checkpoint=seconds();
    };
    std::signal(SIGTERM,request_stop);std::signal(SIGINT,request_stop);
    size_t initial_steps=steps;double search_start=seconds();
    auto diagnostic=[&](const std::string&stage) {
        struct rusage usage;getrusage(RUSAGE_SELF,&usage);
        double cpu=usage.ru_utime.tv_sec+usage.ru_utime.tv_usec*1e-6+usage.ru_stime.tv_sec+usage.ru_stime.tv_usec*1e-6;
        double search_seconds=seconds()-search_start;
        std::ostringstream o;o<<std::setprecision(10)<<"{\"stage\":\""<<stage<<"\",\"steps\":"<<steps
          <<",\"dimension\":"<<dimension<<",\"columns\":"<<M.cols<<",\"seconds\":"<<seconds()
          <<",\"search_columns\":"<<search_columns
          <<",\"cumulative_seconds\":"<<inherited+seconds()
          <<",\"percent_of_dimension\":"<<100.*steps/search_columns
          <<",\"estimated_remaining_seconds\":"<<(steps>initial_steps?search_seconds*(search_columns-std::min(search_columns,steps))/(steps-initial_steps):-1)
          <<",\"eta_basis\":\"remaining matrix-dimension Krylov steps at measured rate; heuristic\""
          <<",\"gram_seconds\":"<<gram_time<<",\"projection_seconds\":"<<projection_time
          <<",\"small_gram_seconds\":"<<small_time<<",\"update_seconds\":"<<update_time
          <<",\"checkpoint_seconds\":"<<checkpoint_seconds<<",\"checkpoint_count\":"<<checkpoint_count
          <<",\"cpu_seconds\":"<<cpu<<",\"average_cpu_cores\":"<<cpu/seconds()
          <<",\"peak_rss_native\":"<<usage.ru_maxrss<<",\"threads\":"<<threads<<"}";
        atomic_text(out/"progress.json",o.str());std::cout<<o.str()<<std::endl;
    };
    // Check the accelerated operator against scalar arithmetic on this input.
    {
        Bytes probe(M.cols),fast,tmp,scalar;std::mt19937 test_rng(42);
        for(size_t j=0;j<probe.size();j++)probe[j]=!component||component->active[j]?test_rng()%25:0;
        gram(probe,diagonal,fast);
        scale(probe,scaled);M.apply(scaled,tmp,1,true);
        for(size_t i=0;i<tmp.size();i++)tmp[i]=product[tmp[i]][diagonal[i]];
        CSR MT=M.transpose();MT.apply(tmp,scalar,1,true);scale(scalar,scalar);
        if(fast!=scalar)throw std::runtime_error("input-specific fused Gram/scalar mismatch");
    }
    search_start=seconds();
    double last_diagnostic=seconds();
    std::string status="diagnostic_inconclusive";Bytes dual;
    const size_t rank_bound=std::min<size_t>(search_columns,component?component->active_rows:M.rows);
    int lost_initial_orthogonality=-1;
    int radical_target=-1;size_t radical_original_nonzeros=0;
    std::cout<<"{\"stage\":\"start\",\"columns\":"<<M.cols<<",\"rows\":"<<M.rows
        <<",\"seed\":"<<seed<<",\"max_lookahead\":"<<maximum<<",\"diagonal_mode\":"<<mode
        <<",\"threads\":"<<threads<<",\"column_scaling\":"<<column_mode<<",\"resumed\":"<<(resume?"true":"false")
        <<",\"nonzeros\":"<<M.val.size()<<",\"persistent_team\":"<<(team?"true":"false")
        <<",\"search_columns\":"<<search_columns<<",\"component_groups\":"<<(component?component->parts.size():0)
        <<",\"selected_rows\":"<<(mask_path?std::count(row_mask.begin(),row_mask.end(),1):M.rows)
        <<",\"row_masked\":"<<(mask_path?"true":"false")
        <<",\"scalar_gram_replay\":true}"<<std::endl;
    while(dimension<=rank_bound) {
        if(seconds()>limit||interrupted){checkpoint();diagnostic("checkpointed_pause");return 2;}
        if(std::all_of(w.begin(),w.end(),[](auto c){return !c;})) {status="krylov_closed_candidate";break;}
        auto t=seconds();gram(w,diagonal,av);gram_time+=seconds()-t;++steps;
        // e_last belongs to the FIRST completed Krylov block. Every later
        // block, including an unfinished look-ahead block, must be A-orthogonal
        // to it. Thus (A w)_last=0. This checks a GLOBAL recurrence invariant
        // at zero dot-product cost, unlike checking only the adjacent blocks.
        // A saved real run lost it while adjacent-block checks still passed.
        if(blocks&&av.back()) {
            lost_initial_orthogonality=av.back();
            status="initial_orthogonality_lost_inconclusive";
            break;
        }
        if(std::all_of(av.begin(),av.end(),[](auto c){return !c;})) {
            Bytes original;scale(w,scaled);M.apply(scaled,original,1,true);
            radical_target=scaled.back();
            radical_original_nonzeros=std::count_if(original.begin(),original.end(),[](auto c){return c!=0;});
            if(radical_target&&!radical_original_nonzeros) {
                dual=scaled;status="bounded_ansatz_dual_verified";break;
            }
            std::ofstream f(out/"radical.bin",std::ios::binary);f.write((char*)scaled.data(),scaled.size());
            bool masked_null=mask_path&&radical_target;
            if(mask_path)for(size_t i=0;i<M.rows;i++)if(row_mask[i]&&original[i])masked_null=false;
            // This is only a masked certificate candidate. A field-aware
            // reverse elimination must extend it before original-M replay.
            status=masked_null?"masked_dual_requires_extension":"gram_radical_inconclusive";break;
        }
        current.v.push_back(std::move(w));current.av.push_back(std::move(av));
        t=seconds();bool accepted=current.nondegenerate();small_time+=seconds()-t;
        if(accepted) {
            size_t r=current.v.size();widths[r]++;dimension+=r;blocks++;
            // Pairwise A-orthogonal nondegenerate blocks cannot have total
            // dimension exceeding rank(A)<=min(active rows,active columns).
            if(dimension>rank_bound){status="rank_bound_overrun_inconclusive";break;}
            // Early blocks give an inexpensive check of the three-term
            // orthogonality recurrence; not a replacement for final replay.
            if(blocks<=20)for(const auto&b:{&previous,&last})
                for(auto&v:b->v)for(auto&a:current.av)
                    if(inner(v,a))throw std::runtime_error("lost adjacent-block orthogonality");
            t=seconds();current.solution_update(z);update_time+=seconds()-t;
            w=current.av.back();previous=std::move(last);last=std::move(current);current=Block();
        }else {
            if(current.v.size()>=size_t(maximum)){status="lookahead_limit_inconclusive";break;}
            w=current.av.back();
        }
        t=seconds();previous.project(w);last.project(w);projection_time+=seconds()-t;
        if(seconds()-last_checkpoint>=20)checkpoint();
        if(steps%2000==0||seconds()-last_diagnostic>=15) {
            diagnostic("lanczos");last_diagnostic=seconds();
        }
    }
    // Regardless of the heuristic search's exit, only this original exact
    // identity can justify reporting a unit certificate.
    Bytes lambda,check;scale(z,scaled);M.apply(scaled,lambda,1,true);
    for(size_t i=0;i<lambda.size();i++)lambda[i]=product[diagonal[i]][lambda[i]];
    CSR MT=M.transpose();MT.apply(lambda,check,1,true);
    bool good=check.back()==1&&std::all_of(check.begin(),check.end()-1,[](auto x){return !x;});
    if(good){std::ofstream f(out/"solution.bin",std::ios::binary);f.write((char*)lambda.data(),lambda.size());status="linear_certificate_verified";}
    if(!dual.empty()){std::ofstream f(out/"dual.bin",std::ios::binary);f.write((char*)dual.data(),dual.size());}
    diagnostic(status);
    std::ostringstream result;result<<"{\"status\":\""<<status<<"\",\"primal_verified\":"<<(good?"true":"false")
        <<",\"dual_verified\":"<<(!dual.empty()?"true":"false")
        <<",\"rank_upper_bound\":"<<rank_bound<<",\"lost_initial_orthogonality\":"<<lost_initial_orthogonality
        <<",\"column_scaling\":"<<column_mode<<",\"radical_target\":"<<radical_target
        <<",\"radical_original_nonzeros\":"<<radical_original_nonzeros
        <<",\"seconds\":"<<seconds()<<",\"steps\":"<<steps<<",\"dimension\":"<<dimension
        <<",\"gram_seconds\":"<<gram_time<<",\"projection_seconds\":"<<projection_time
        <<",\"small_gram_seconds\":"<<small_time<<",\"update_seconds\":"<<update_time<<",\"block_histogram\":[";
    for(size_t i=1;i<widths.size();i++)result<<(i>1?",":"")<<widths[i];
    result<<"]}";atomic_text(out/"result.json",result.str());std::cout<<result.str()<<std::endl;
    return good||!dual.empty()?0:2;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}
