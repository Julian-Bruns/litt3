// Exact F25 sparse/block products for atlas certificate matrices.
// Input: uint32 rows,columns; for each row count, uint32 indices[count],
// uint8 coefficients[count]. Coefficient c0+5*c1 means c0+c1*a, a^2=a+3.
// Diagnostic only: no rank or polynomial-ideal conclusion is inferred.
#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <random>
#include <stdexcept>
#include <vector>
#include <omp.h>
#ifdef __aarch64__
#include <arm_neon.h>
#endif

using Clock=std::chrono::steady_clock;
using Bytes=std::vector<uint8_t>;
static uint8_t product[25][32],lo[25][32],hi[25][32];
static uint8_t add(uint8_t a,uint8_t b) {
    return (a%5+b%5)%5+5*((a/5+b/5)%5);
}
static void init_field() {
    for(int a=0;a<25;a++) for(int b=0;b<25;b++) {
        lo[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5;
        hi[a][b]=(a%5*(b/5)+a/5*(b%5)+a/5*(b/5))%5;
        product[a][b]=lo[a][b]+5*hi[a][b];
    }
}
struct CSR {
    uint32_t rows=0,cols=0;
    std::vector<uint64_t> ptr;
    std::vector<uint32_t> idx;
    Bytes val;
    explicit CSR(const char* name) {
        std::ifstream f(name,std::ios::binary);
        auto read=[&](void* p,size_t n){if(!f.read((char*)p,n))throw std::runtime_error("truncated matrix");};
        read(&rows,4);read(&cols,4);
        if(!rows||!cols||rows>10000000||cols>10000000)throw std::runtime_error("bad dimensions");
        ptr.push_back(0);
        for(uint32_t i=0;i<rows;i++) {
            uint32_t n;read(&n,4);
            if(n>cols)throw std::runtime_error("bad row length");
            size_t p=idx.size();idx.resize(p+n);val.resize(p+n);
            read(idx.data()+p,4*n);read(val.data()+p,n);
            for(size_t j=p;j<p+n;j++) {
                if(idx[j]>=cols||val[j]==0||val[j]>=25)throw std::runtime_error("bad term");
            }
            ptr.push_back(idx.size());
        }
        char extra;if(f.get(extra))throw std::runtime_error("trailing matrix bytes");
    }
    CSR()=default;
    CSR transpose() const {
        CSR t;t.rows=cols;t.cols=rows;t.ptr.resize(cols+1);
        for(auto j:idx)++t.ptr[j+1];
        for(size_t j=1;j<t.ptr.size();j++)t.ptr[j]+=t.ptr[j-1];
        auto next=t.ptr;t.idx.resize(idx.size());t.val.resize(val.size());
        for(uint32_t i=0;i<rows;i++)for(uint64_t q=ptr[i];q<ptr[i+1];q++) {
            size_t p=next[idx[q]]++;t.idx[p]=i;t.val[p]=val[q];
        }
        return t;
    }
    void apply(const Bytes& x,Bytes& y,int block,bool reference=false) const {
        if(x.size()!=size_t(cols)*block)throw std::runtime_error("bad vector size");
        y.resize(size_t(rows)*block);
        #pragma omp parallel for schedule(static)
        for(uint32_t i=0;i<rows;i++) {
            if(reference) {
                for(int b=0;b<block;b++) {
                    uint8_t z=0;
                    for(uint64_t j=ptr[i];j<ptr[i+1];j++)z=add(z,product[val[j]][x[size_t(idx[j])*block+b]]);
                    y[size_t(i)*block+b]=z;
                }
                continue;
            }
            for(int b=0;b<block;) {
                #ifdef __aarch64__
                if(b+16<=block) {
                    uint32_t sums0[16]={},sums1[16]={};
                    for(uint64_t start=ptr[i];start<ptr[i+1];start+=4096) {
                        uint16x8_t a0=vdupq_n_u16(0),a1=a0,b0=a0,b1=a0;
                        for(uint64_t j=start;j<std::min(start+4096,ptr[i+1]);j++) {
                            uint8x16_t v=vld1q_u8(x.data()+size_t(idx[j])*block+b);
                            uint8x16x2_t t0={{vld1q_u8(lo[val[j]]),vld1q_u8(lo[val[j]]+16)}};
                            uint8x16x2_t t1={{vld1q_u8(hi[val[j]]),vld1q_u8(hi[val[j]]+16)}};
                            auto z0=vqtbl2q_u8(t0,v),z1=vqtbl2q_u8(t1,v);
                            a0=vaddw_u8(a0,vget_low_u8(z0));a1=vaddw_u8(a1,vget_high_u8(z0));
                            b0=vaddw_u8(b0,vget_low_u8(z1));b1=vaddw_u8(b1,vget_high_u8(z1));
                        }
                        uint16_t s0[16],s1[16];vst1q_u16(s0,a0);vst1q_u16(s0+8,a1);
                        vst1q_u16(s1,b0);vst1q_u16(s1+8,b1);
                        for(int j=0;j<16;j++){sums0[j]+=s0[j];sums1[j]+=s1[j];}
                    }
                    for(int j=0;j<16;j++)y[size_t(i)*block+b+j]=sums0[j]%5+5*(sums1[j]%5);
                    b+=16;continue;
                }
                #endif
                uint64_t a0=0,a1=0;
                for(uint64_t j=ptr[i];j<ptr[i+1];j++) {
                    auto c=val[j],v=x[size_t(idx[j])*block+b];a0+=lo[c][v];a1+=hi[c][v];
                }
                y[size_t(i)*block+b]=a0%5+5*(a1%5);++b;
            }
        }
    }
};
static uint64_t checksum(const Bytes& b) {
    uint64_t h=1469598103934665603ULL;for(auto c:b){h^=c;h*=1099511628211ULL;}return h;
}
static void bench(const CSR& A,const char* name,int block,int reps) {
    std::mt19937 rng(125+block);Bytes x(size_t(A.cols)*block),y,ref;
    for(auto& c:x)c=rng()%25;
    A.apply(x,y,block);A.apply(x,ref,block,true);
    if(y!=ref)throw std::runtime_error("optimized/reference product mismatch");
    auto start=Clock::now();
    for(int r=0;r<reps;r++) {
        // Keep inputs changing, as in Krylov products, without timing RNG.
        x[r%x.size()]=(x[r%x.size()]+1)%25;A.apply(x,y,block);
    }
    double secs=std::chrono::duration<double>(Clock::now()-start).count()/reps;
    std::cout<<"{\"direction\":\""<<name<<"\",\"block\":"<<block
      <<",\"seconds_per_product\":"<<secs<<",\"field_products_per_second\":"
      <<double(A.val.size())*block/secs<<",\"reference_replay\":true,\"output_checksum\":"
      <<checksum(y)<<"}"<<std::endl;
}
#ifndef ATLAS_BLACKBOX_LIBRARY
int main(int argc,char** argv)try {
    if(argc<2)throw std::runtime_error("usage: program matrix.bin [threads=10] [reps=40]");
    int threads=argc>2?std::stoi(argv[2]):10,reps=argc>3?std::stoi(argv[3]):40;
    if(threads<1||threads>10||reps<1)throw std::runtime_error("bad threads/reps");
    omp_set_num_threads(threads);omp_set_dynamic(0);init_field();
    auto start=Clock::now();CSR A(argv[1]),AT=A.transpose();
    size_t maxrow=0;for(size_t i=0;i<A.rows;i++)maxrow=std::max(maxrow,size_t(A.ptr[i+1]-A.ptr[i]));
    std::cout<<std::setprecision(9)<<"{\"rows\":"<<A.rows<<",\"columns\":"<<A.cols
      <<",\"nonzeros\":"<<A.val.size()<<",\"max_row\":"<<maxrow<<",\"threads\":"<<threads
      <<",\"load_transpose_seconds\":"<<std::chrono::duration<double>(Clock::now()-start).count()<<"}"<<std::endl;
    for(int b:{1,4,16,32}){bench(A,"A",b,reps);bench(AT,"AT",b,reps);}
    // All columns of two full block products were independently replayed.
    return 0;
}catch(const std::exception& e){std::cerr<<e.what()<<std::endl;return 1;}
#endif
