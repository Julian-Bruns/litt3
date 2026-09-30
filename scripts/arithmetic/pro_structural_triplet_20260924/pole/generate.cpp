// Produce the complete finite-data certificate. No search over geometric models.
#include "field_and_system.hpp"
#include <fstream>
#include <filesystem>
#include <set>
using namespace std;

void write_u32(ostream& o,uint32_t n) {for(int i=0;i<4;i++)o.put(char((n>>(8*i))&255));}
template<size_t N> void json_array(ostream& o,const array<int,N>& a) {
    o<<"[";for(size_t i=0;i<N;i++){if(i)o<<",";o<<a[i];}o<<"]";
}
void json_vector(ostream& o,const vector<int>& a) {
    o<<"[";for(size_t i=0;i<a.size();i++){if(i)o<<",";o<<a[i];}o<<"]";
}
struct Reduction {
    int rank=0;
    array<int,7> witness{};
    array<int,4> particular{};
    vector<array<int,4>> kernel;
};
Reduction reduce_system(array<array<int,5>,7> a) {
    array<array<int,7>,7> change{};
    for(int i=0;i<7;i++)change[i][i]=1;
    vector<int> pivots;
    int r=0;
    for(int c=0;c<4;c++) {
        int p=r;while(p<7&&!a[p][c])p++;
        if(p==7)continue;
        swap(a[p],a[r]);swap(change[p],change[r]);
        int iv=inv(a[r][c]);
        for(int j=0;j<5;j++)a[r][j]=mul(a[r][j],iv);
        for(int j=0;j<7;j++)change[r][j]=mul(change[r][j],iv);
        for(int i=0;i<7;i++)if(i!=r&&a[i][c]) {
            int factor=a[i][c];
            for(int j=0;j<5;j++)a[i][j]=sub(a[i][j],mul(factor,a[r][j]));
            for(int j=0;j<7;j++)change[i][j]=sub(change[i][j],mul(factor,change[r][j]));
        }
        pivots.push_back(c);r++;
    }
    Reduction out;out.rank=r;
    for(int i=r;i<7;i++)if(a[i][4]) {
        out.rank=-1;
        int iv=inv(a[i][4]);
        for(int j=0;j<7;j++)out.witness[j]=mul(change[i][j],iv);
        return out;
    }
    for(int i=0;i<r;i++)out.particular[pivots[i]]=a[i][4];
    for(int c=0;c<4;c++)if(find(pivots.begin(),pivots.end(),c)==pivots.end()) {
        array<int,4> v{};v[c]=1;
        for(int i=0;i<r;i++)v[pivots[i]]=neg(a[i][c]);
        out.kernel.push_back(v);
    }
    return out;
}
int main(int argc,char**argv) {
    try {
        if(argc!=2)throw runtime_error("Usage: generate OUTPUT_DIRECTORY");
        filesystem::path dest(argv[1]);filesystem::create_directories(dest);
        init();endpoints_init();
        ofstream binary(dest/"linear_witnesses.bin",ios::binary);
        ofstream js(dest/"consistent_systems.json");
        if(!binary||!js)throw runtime_error("Cannot open output files");
        binary.write("SFCPLIN1",8);write_u32(binary,787176);write_u32(binary,7);
        js<<"{\n\"format\":\"SFCPEP-1\",\n\"systems\":[\n";
        int inconsistent=0,consistent=0,total=0,roots_total=0,minimum_distinct=5;
        array<int,5> ranks{};
        for(int z=0;z<116;z++)for(int f=0;f<116;f++)for(int g=f;g<116;g++) {
            total++;
            auto s=system_at(z,f,g);auto r=reduce_system(s.augmented);
            for(int x:r.witness)write_u32(binary,x);
            if(r.rank<0) {inconsistent++;continue;}
            if(consistent++)js<<",\n";
            ranks[r.rank]++;
            js<<"{\"case\":["<<z<<","<<f<<","<<g<<"],\"rank\":"<<r.rank<<",\"augmented\":[";
            for(int i=0;i<7;i++){if(i)js<<",";json_array(js,s.augmented[i]);}js<<"],\"particular\":";
            json_array(js,r.particular);js<<",\"kernel\":[";
            for(size_t i=0;i<r.kernel.size();i++){if(i)js<<",";json_array(js,r.kernel[i]);}js<<"]";
            if(r.rank==4) {
                auto value=full_residual(s,r.particular);
                js<<",\"full_residual\":";json_array(js,coords(value));
                if(value.zero())throw runtime_error("Unexpected rank-four survivor");
            } else {
                if(r.rank!=3)throw runtime_error("Unexpected higher-dimensional consistent system");
                auto direction=r.kernel[0];
                auto point=[&](int h) {array<int,4> x;for(int j=0;j<4;j++)x[j]=add(r.particular[j],mul(h,direction[j]));return x;};
                const C c=code(22)*C(2),c2=c*c;
                auto scalar=[&](L v) {for(int j=1;j<4;j++)if(!v.c[j].zero())throw runtime_error("Non-scalar residual");C a=v.c[0]*ci(c2);if(a.b)throw runtime_error("Residual not in C^2 F");return a.a;};
                int k0=scalar(full_residual(s,point(0))), a1=scalar(full_residual(s,point(1))), am1=scalar(full_residual(s,point(4)));
                int k1=mul(3,sub(a1,am1)), k2=mul(3,sub(add(a1,am1),mul(2,k0)));
                if(!k2)throw runtime_error("Unexpected degenerate quadratic");
                vector<int> roots;
                for(int h=0;h<Q;h++)if(!add(k0,mul(h,add(k1,mul(h,k2)))))roots.push_back(h);
                if(roots.size()!=0&&roots.size()!=2)throw runtime_error("Unexpected quadratic root count");
                js<<",\"quadratic\":";json_array(js,array<int,3>{k0,k1,k2});js<<",\"roots\":";json_vector(js,roots);
                js<<",\"candidates\":[";
                for(size_t i=0;i<roots.size();i++) {
                    if(i)js<<",";auto x=point(roots[i]);
                    if(!full_residual(s,x).zero())throw runtime_error("Quadratic root failed full equation");
                    auto row=fourier_row(x);set<int> values(row.begin(),row.end());
                    int number=values.size();minimum_distinct=min(minimum_distinct,number);
                    if(number<4)throw runtime_error("Possible pole-multiplicity survivor: investigation required");
                    roots_total++;
                    js<<"{\"parameter\":"<<roots[i]<<",\"moments\":";json_array(js,x);
                    js<<",\"fourier_base\":";json_array(js,row);js<<",\"distinct_values\":"<<number<<"}";
                }
                js<<"]";
            }
            js<<"}";
        }
        js<<"\n],\n\"summary\":{\"total_cases\":"<<total<<",\"inconsistent\":"<<inconsistent<<",\"consistent\":"<<consistent
          <<",\"rank3\":"<<ranks[3]<<",\"rank4\":"<<ranks[4]<<",\"quadratic_roots\":"<<roots_total<<",\"minimum_distinct_values\":"<<minimum_distinct<<"}\n}\n";
        if(total!=787176||inconsistent!=787146||consistent!=30||ranks[3]!=29||ranks[4]!=1||roots_total!=42||minimum_distinct!=4)throw runtime_error("Unexpected final classification");
        cout<<"PASS: generated 787146 normalized inconsistency witnesses for all 787176 cases.\n";
        cout<<"PASS: 29 rank-three systems and one rank-four system remain.\n";
        cout<<"PASS: all 42 quadratic-root candidates have at least four Fourier residues.\n";
        cout<<"RESULT: endpoint/multiplicity necessary system is EMPTY.\n";
    } catch(const exception& e) {cerr<<"ERROR: "<<e.what()<<"\n";return 1;}
}

