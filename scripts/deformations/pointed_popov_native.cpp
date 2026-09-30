// Exact weak-Popov insertion over a supplied finite-field table.
// No polynomial inversions; each pivot is normalized by a field unit.
// Packet and result files must be stored outside the research workspace.
#include <algorithm>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <vector>
#include <chrono>

using Byte=std::uint8_t;
using Clock=std::chrono::steady_clock;
struct Field {
    unsigned q=0;
    std::vector<Byte> add,mul,neg,inv;
    Byte plus(Byte a,Byte b) const {return add[unsigned(a)*q+b];}
    Byte times(Byte a,Byte b) const {return mul[unsigned(a)*q+b];}
    Byte minus(Byte a,Byte b) const {return plus(a,neg[b]);}
};
struct Row {
    unsigned n=0;
    std::vector<Byte> c; // coefficient first, then column
    int degree() const {return c.empty()?-1:int(c.size()/n)-1;}
    void trim(){while(!c.empty() && std::all_of(c.end()-n,c.end(),[](Byte a){return a==0;}))c.resize(c.size()-n);}
    int position() const {
        if(c.empty())return -1;
        for(int j=int(n)-1;j>=0;--j)if(c[c.size()-n+j])return j;
        throw std::runtime_error("untrimmed row");
    }
    void scale(Byte a,const Field& f){for(auto &v:c)v=f.times(a,v);}
};
static std::uint64_t hash(const std::vector<Byte>& a){
    std::uint64_t h=1469598103934665603ULL;
    for(Byte c:a){h^=c;h*=1099511628211ULL;}
    return h;
}
static std::uint32_t read32(std::ifstream& in){
    Byte b[4];in.read(reinterpret_cast<char*>(b),4);
    if(!in)throw std::runtime_error("short packet");
    return unsigned(b[0])|(unsigned(b[1])<<8)|(unsigned(b[2])<<16)|(unsigned(b[3])<<24);
}
static std::vector<Byte> readbytes(std::ifstream& in,std::size_t n){
    std::vector<Byte> v(n);in.read(reinterpret_cast<char*>(v.data()),n);
    if(!in)throw std::runtime_error("short packet");return v;
}
static void insert(std::vector<std::unique_ptr<Row>>& basis,Row row,const Field& f,
                   std::uint64_t& steps){
    row.trim();
    while(!row.c.empty()){
        int d=row.degree(),j=row.position();
        if(!basis[j]){
            row.scale(f.inv[row.c[d*row.n+j]],f);
            basis[j]=std::make_unique<Row>(std::move(row));return;
        }
        if(d<basis[j]->degree()){
            row.scale(f.inv[row.c[d*row.n+j]],f);
            std::swap(row,*basis[j]);
            d=row.degree();j=row.position();
        }
        const Row& old=*basis[j];
        if(old.position()!=j || old.c[old.degree()*old.n+j]!=1)
            throw std::runtime_error("invalid normalized pivot");
        unsigned shift=unsigned(d-old.degree())*row.n;
        Byte factor=row.c[d*row.n+j];
        for(std::size_t i=0;i<old.c.size();++i)
            row.c[shift+i]=f.minus(row.c[shift+i],f.times(factor,old.c[i]));
        row.trim();++steps;
        if(!row.c.empty() && (row.degree()>d || (row.degree()==d && row.position()>=j)))
            throw std::runtime_error("row measure did not decrease");
    }
}
static Row multiply(const Row& row,const std::vector<Byte>& A,
                    const std::vector<Byte>& B,const Field& f){
    Row out;out.n=row.n;
    if(row.c.empty())return out;
    unsigned n=row.n;out.c.assign(row.c.size()+n,0);
    for(int d=0;d<=row.degree();++d){
        Byte* here=out.c.data()+d*n;
        Byte* next=here+n;
        for(unsigned i=0;i<n;++i){
            Byte a=row.c[d*n+i];if(!a)continue;
            const Byte* products=f.mul.data()+unsigned(a)*f.q;
            const Byte* ai=A.data()+i*n;
            const Byte* bi=B.data()+i*n;
            for(unsigned j=0;j<n;++j){
                here[j]=f.plus(here[j],products[ai[j]]);
                next[j]=f.plus(next[j],products[bi[j]]);
            }
        }
    }
    out.trim();return out;
}
int main(int argc,char**argv){
    try {
        if(argc!=3)throw std::runtime_error("usage: native packet result");
        std::ifstream in(argv[1],std::ios::binary);
        if(!in)throw std::runtime_error("cannot open packet");
        if(read32(in)!=0x31504f50)throw std::runtime_error("wrong packet format");
        Field f;f.q=read32(in);
        if(f.q<2 || f.q>256)throw std::runtime_error("field outside byte range");
        f.add=readbytes(in,f.q*f.q);f.mul=readbytes(in,f.q*f.q);
        f.neg=readbytes(in,f.q);f.inv=readbytes(in,f.q);
        for(unsigned a=0;a<f.q;++a){
            if(f.plus(a,0)!=a || f.times(a,1)!=a || f.plus(a,f.neg[a])!=0)
                throw std::runtime_error("bad field packet");
            if(a && f.times(a,f.inv[a])!=1)throw std::runtime_error("bad inverse");
        }
        unsigned count=read32(in);
        std::ofstream out(argv[2]);if(!out)throw std::runtime_error("cannot open result");
        out<<"{\"kind\":\"exact_native_popov\",\"blocks\":[\n";
        auto begin=Clock::now();
        for(unsigned block=0;block<count;++block){
            unsigned label=read32(in),part=read32(in),n=read32(in);
            auto A=readbytes(in,n*n),B=readbytes(in,n*n);
            auto C=readbytes(in,2*n),D=readbytes(in,2*n);
            std::vector<Row> rows(2);
            for(unsigned r=0;r<2;++r){
                rows[r].n=n;rows[r].c.resize(2*n);
                for(unsigned j=0;j<n;++j){rows[r].c[j]=C[r*n+j];rows[r].c[n+j]=D[r*n+j];}
                rows[r].trim();
            }
            std::vector<std::unique_ptr<Row>> basis(n);
            std::uint64_t steps=0;
            bool full=false;
            if(block)out<<",\n";
            out<<"{\"torsion\":"<<label<<",\"block\":"<<part<<",\"columns\":"<<n<<",\"stages\":[\n";
            for(unsigned power=0;power<n;++power){
                std::uint64_t hashes[2]={hash(rows[0].c),hash(rows[1].c)};
                for(const auto& row:rows)insert(basis,row,f,steps);
                unsigned rank=0,sum=0;
                for(const auto& v:basis)if(v){++rank;sum+=unsigned(v->degree());}
                full=(rank==n && sum==0);
                if(power)out<<",\n";
                out<<"{\"power\":"<<power<<",\"rank\":"<<rank<<",\"pivot_degree_sum\":"<<sum
                   <<",\"row_hashes\":[\""<<hashes[0]<<"\",\""<<hashes[1]<<"\"]}";
                if(power%20==0 || full){
                    double seconds=std::chrono::duration<double>(Clock::now()-begin).count();
                    std::cout<<label<<":"<<part<<" power="<<power<<" rank="<<rank<<" degree_sum="<<sum<<" seconds="<<seconds<<std::endl;
                    out.flush();
                }
                if(full)break;
                for(auto& row:rows)row=multiply(row,A,B,f);
            }
            out<<"],\"whole_row_module\":"<<(full?"true":"false")<<",\"row_reductions\":"<<steps<<"}";out.flush();
        }
        if(in.peek()!=std::ifstream::traits_type::eof())throw std::runtime_error("unread packet bytes");
        out<<"],\"seconds\":"<<std::chrono::duration<double>(Clock::now()-begin).count()<<"}\n";
    } catch(const std::exception& e){std::cerr<<e.what()<<std::endl;return 1;}
    return 0;
}
