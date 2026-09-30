// Focused verification of exact DFT arithmetic over the whole rank12 algebra.
#define ROOT9_RANK 12
#define ROOT9_FAST_RAT_NORMALIZE
#define ROOT9_THREAD_RATIONAL
#define ROOT9_MARKED_NO_MAIN
#include <omp.h>
#include "root9_marked_function_field_20260929.cpp"
#include "root9_fourier_20260929.hpp"
int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("usage source-root");init(argv[1]);FastK::init();fourier_setup();
 FP z(std::vector<F>{0,1});Rat::setup(FP(0),{z,z+FP(1),z+FP(2),z+FP(3),z+FP(4)});
 std::array<Rat,12>mod{};mod[0]=Rat(1);mod[1]=Rat(2);MR::setup(mod);
 std::vector<MR>a(74),b(74);
 for(int i=0;i<74;i++)if(i%7==0||i==73){
  a[i].c[i%12]=Rat(FP(std::vector<F>{F(i+1),F(i+17),F(i+41)}));
  b[i].c[(i+3)%12]=Rat(FP(std::vector<F>{F(i+12),F(i+31)}));
  a[i].c[i%12].den[i%5]=1;b[i].c[(i+3)%12].den[(i+1)%5]=1;
 }
 auto round=transform156(transform156(a),true);for(int i=0;i<FN;i++)assert(round[i]==(i<74?a[i]:MR(0)));
 auto prod=convolution156(a,b,74);for(int n=0;n<74;n++){MR ref;for(int i=0;i<=n;i++)ref+=a[i]*b[n-i];assert(ref==prod[n]);}
 std::cout<<"DFT_ROUNDTRIP_AND_TRUNCATED_PRODUCT_PASS"<<std::endl;
 MR q(F(25));Curve<MR>::PQ=basepoly<MR>(PP).scale(q.inverse());Curve<MR>g;
 for(int j=0;j<3;j++){int cap=46-3*j;g.c[j].c.resize(cap+1);for(int i=0;i<=cap;i++)if(i%7==0||i==cap)g.c[j].c[i]=a[i+j]+b[i];}
 auto pq=Curve<MR>::PQ;auto direct=(g.c[0].pow(3)+g.c[1].pow(3)*pq+g.c[2].pow(3)*pq.pow(2)-(g.c[0]*g.c[1]*g.c[2]*pq).scale(MR(3))).scale(q.inverse());
 auto fast=curve_norm156(g,q);for(int i=0;i<=140;i++)assert(fast[i]==direct[i]);
 std::cout<<"WHOLE_RANK12_CUBIC_NORM_PASS coefficients141"<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
