// Exhaustive triangular orbit-pair sieve. No field sampling is used in the scan.
// The rank-92 bilinear expression is exactly the first necessary residual Z.
#include "../../continuation/src/generic_kernel.hpp"
#include "factor_data.hpp"
#if defined(__AVX512VNNI__) && !defined(PORTABLE_DOT)
#include <immintrin.h>
#define USE_VNNI 1
#else
#define USE_VNNI 0
#endif
#include <omp.h>
#include <cstdlib>
#include <cstring>
#include <mutex>
#include <iomanip>
#include <atomic>
#include <memory>
using Clock=std::chrono::steady_clock;
constexpr int RANK=factors::rank, DIM=14*RANK, STRIDE=((DIM+63)/64)*64, BLOCKS=STRIDE/64;
struct Aligned {
 unsigned char*p;size_t size;
 explicit Aligned(size_t n):p(nullptr),size(n){if(posix_memalign((void**)&p,64,n))throw std::bad_alloc();std::memset(p,0,n);}
 ~Aligned(){free(p);} Aligned(const Aligned&)=delete;Aligned&operator=(const Aligned&)=delete;
};
using Features=std::array<K,RANK>;
std::vector<IX> reps;
std::vector<EP> eps;
std::vector<Features> qfeatures,hfeatures;
std::unique_ptr<Aligned> qdata;
std::array<K,14> basis;
std::array<K,29> zp;
std::mutex output_mutex;
int projection_start=0;
Features features(const EP&E,bool isq){
 const F&C=isq?E.E:E.C;const F&D=isq?E.C:E.E;
 std::array<K,14>v;int n=0;
 if(isq){for(int j=0;j<3;++j)v[n++]=C.c[j];for(int j=0;j<4;++j)v[n++]=D.c[j];}
 else {for(int j=0;j<4;++j)v[n++]=C.c[j];for(int j=0;j<3;++j)v[n++]=D.c[j];}
 for(int j=0;j<7;++j)v[j+7]=v[j].bar();
 const auto&M=isq?factors::QM:factors::HM;const auto&co=isq?factors::QC:factors::HC;
 std::array<K,factors::monoms>mon;
 for(int j=0;j<factors::monoms;++j){K z(1);for(int k=0;k<14;++k)for(int t=0;t<M[j][k];++t)z=z*v[k];mon[j]=z;}
 Features f{};for(int i=0;i<RANK;++i)for(int j=0;j<factors::monoms;++j)if(co[i][j])f[i]=f[i]+K::code(co[i][j])*mon[j];return f;
}
void digits(K x,unsigned char*out){for(int k=0;k<7;++k){out[k]=x.a%5;x.a/=5;out[k+7]=x.b%5;x.b/=5;}}
unsigned char*Qptr(int qi,int projection=0){return qdata->p+(size_t(projection)*reps.size()+qi)*STRIDE;}
void prepare(){
 init();init_labels();K ie=K::code(22).inverse();for(auto&lab:labels)for(F&f:lab)f=f.times(ie);
 for(int j=0;j<116;++j)for(int k=j;k<116;++k)for(int l=k;l<116;++l){IX ix={0,j,k,l};if(admissible(ix)&&canonical(ix)==ix)reps.push_back(ix);}
 if(reps.size()!=9776)throw std::runtime_error("wrong representative count");
 eps.reserve(reps.size());qfeatures.reserve(reps.size());hfeatures.reserve(reps.size());
 for(auto ix:reps){EP E=ep(ix);eps.push_back(E);qfeatures.push_back(features(E,true));hfeatures.push_back(features(E,false));}
 int p=1;for(int j=0;j<7;++j){basis[j]=K(p,0);basis[j+7]=K(0,p);p*=5;}
 zp[0]=K(1);for(int j=1;j<29;++j)zp[j]=zp[j-1]*zeta();
 qdata=std::make_unique<Aligned>(size_t(14)*reps.size()*STRIDE);
 #pragma omp parallel for schedule(static)
 for(int i=0;i<int(reps.size());++i)for(int f=0;f<RANK;++f)for(int b=0;b<14;++b){
  unsigned char d[14];digits(qfeatures[i][f]*basis[b],d);
  for(int p=0;p<14;++p)Qptr(i,p)[14*f+b]=d[(p+projection_start)%14];
 }
}
IX transformed(IX ix,int u,int shift,int type){
 int ff=1;for(int j=0;j<u;++j)ff=25*ff%29;
 for(int&v:ix)v=4*((ff*(v/4)+shift)%29)+(v%4+type)%4;
 std::sort(ix.begin(),ix.end());return ix;
}
void make_H(int hi,unsigned char*data,std::array<IX,812>&ixs){
 int rr=0;
 for(int u=0;u<7;++u){Features f;
  for(int j=0;j<RANK;++j)f[j]=hfeatures[hi][j].frob(2*u);
  for(int shift=0;shift<29;++shift){Features g;
   for(int j=0;j<RANK;++j)g[j]=f[j]*zp[(shift*factors::HW[j][0])%29];
   for(int type=0;type<4;++type){
    ixs[rr]=transformed(reps[hi],u,shift,type);auto*out=data+size_t(rr)*STRIDE;
    for(int j=0;j<RANK;++j){int t=1;for(int k=0;k<type*factors::HW[j][1];++k)t=t*2%5;digits(g[j].times(t),out+14*j);}
    ++rr;
   }
  }
 }
 if(rr!=812)throw std::runtime_error("orbit length");
}
inline int dot(const unsigned char*a,const unsigned char*b){
#if USE_VNNI
 __m512i acc=_mm512_setzero_si512();
 for(int k=0;k<BLOCKS;++k)acc=_mm512_dpbusd_epi32(acc,_mm512_load_si512(a+64*k),_mm512_load_si512(b+64*k));
 return _mm512_reduce_add_epi32(acc);
#else
 int s=0;for(int k=0;k<STRIDE;++k)s+=int(a[k])*int(b[k]);return s;
#endif
}
struct Counts {uint64_t total=0,first=0,full=0,boundary=0,generic=0,tpass=0,eq3=0,eq4=0;};
void exact_candidate(int qi,IX hx,Counts&ct,int hi,int orbit){
 EP H=ep(hx);F A=eps[qi].E,B=eps[qi].C,C=H.C,D=H.E,W=A*D-B*C;
 Generic r=first_residual(A,B,C,D,W);if(!r.nonsingular){++ct.boundary;return;}
 if(!r.Z.zero())throw std::runtime_error("sieve returned a nonzero Z");
 ++ct.generic;second_residual(r,A,B,C,D,W);auto[x,y]=moments(r);
 F eq6=W-A.times(x)-D.times(x.bar())+B.times(y.bar())+C.times(y)+F(K(sub(x.norm(),y.norm()),0));
 for(int j=1;j<4;++j)if(!eq6.c[j].zero())throw std::runtime_error("affine recovery failure");
 if(eq6.c[0]*K(mul(r.den,r.den),0)!=r.T)throw std::runtime_error("quadric scaling failure");
 std::lock_guard<std::mutex>lock(output_mutex);
 std::cout<<"{\"kind\":\"generic_Z_candidate\",\"q_index\":"<<qi<<",\"h_index\":"<<hi<<",\"orbit\":"<<orbit<<",\"Q\":";print_ix(reps[qi],std::cout);std::cout<<",\"H\":";print_ix(hx,std::cout);std::cout<<",\"delta_x\":"<<r.dx<<",\"delta_y\":"<<r.dy<<",\"x\":";pk(x);std::cout<<",\"y\":";pk(y);std::cout<<",\"T\":";pk(r.T);std::cout<<",\"equation6_residual\":";pk(eq6.c[0]);std::cout<<"}\n";
 if(!r.T.zero())return;
 ++ct.tpass;F epsilon=(D-F(x))/(B-F(y));if(epsilon*(A-F(x.bar()))!=C-F(y.bar()))throw std::runtime_error("first-two recovery failure");
 auto Qs=endpoint(reps[qi]),Hs=endpoint(hx);F eq3=epsilon*(Qs[2]-F(x.frob(4)))+Qs[3]+F(y.bar().frob(1));
 if(!eq3.zero())return;
 ++ct.eq3;F eq4=Hs[2]+epsilon*(Hs[3]+F(y.frob(1)))-F(x.bar().frob(4));if(!eq4.zero())return;
 ++ct.eq4;
 std::cout<<"{\"kind\":\"full_four_trace_candidate\",\"Q\":";print_ix(reps[qi],std::cout);std::cout<<",\"H\":";print_ix(hx,std::cout);std::cout<<",\"x\":";pk(x);std::cout<<",\"y\":";pk(y);std::cout<<",\"epsilon\":";pf(epsilon);std::cout<<"}\n";std::cout.flush();
}
inline void after_first(int qi,const unsigned char*h,IX ix,Counts&ct,int hi,int orbit){
 ++ct.first;for(int p=1;p<14;++p)if(dot(Qptr(qi,p),h)%5)return;
 ++ct.full;exact_candidate(qi,ix,ct,hi,orbit);
}
// Matrix microkernel: 4 Q rows by 4 H rows, with exact unsigned-byte x signed-byte VNNI dots.
void tile4(int qi,int hj,const unsigned char*H,const std::array<IX,812>&ixs,Counts&ct,int hi){
#if USE_VNNI
 const unsigned char*q0=Qptr(qi),*q1=Qptr(qi+1),*q2=Qptr(qi+2),*q3=Qptr(qi+3);
 const unsigned char*h0=H+size_t(hj)*STRIDE,*h1=h0+STRIDE,*h2=h1+STRIDE,*h3=h2+STRIDE;
 __m512i a00=_mm512_setzero_si512(),a01=a00,a02=a00,a03=a00,
 a10=a00,a11=a00,a12=a00,a13=a00,a20=a00,a21=a00,a22=a00,a23=a00,a30=a00,a31=a00,a32=a00,a33=a00;
 for(int k=0;k<BLOCKS;++k){int off=64*k;
  __m512i b0=_mm512_load_si512(h0+off),b1=_mm512_load_si512(h1+off),b2=_mm512_load_si512(h2+off),b3=_mm512_load_si512(h3+off);
  __m512i v=_mm512_load_si512(q0+off);a00=_mm512_dpbusd_epi32(a00,v,b0);a01=_mm512_dpbusd_epi32(a01,v,b1);a02=_mm512_dpbusd_epi32(a02,v,b2);a03=_mm512_dpbusd_epi32(a03,v,b3);
  v=_mm512_load_si512(q1+off);a10=_mm512_dpbusd_epi32(a10,v,b0);a11=_mm512_dpbusd_epi32(a11,v,b1);a12=_mm512_dpbusd_epi32(a12,v,b2);a13=_mm512_dpbusd_epi32(a13,v,b3);
  v=_mm512_load_si512(q2+off);a20=_mm512_dpbusd_epi32(a20,v,b0);a21=_mm512_dpbusd_epi32(a21,v,b1);a22=_mm512_dpbusd_epi32(a22,v,b2);a23=_mm512_dpbusd_epi32(a23,v,b3);
  v=_mm512_load_si512(q3+off);a30=_mm512_dpbusd_epi32(a30,v,b0);a31=_mm512_dpbusd_epi32(a31,v,b1);a32=_mm512_dpbusd_epi32(a32,v,b2);a33=_mm512_dpbusd_epi32(a33,v,b3);
 }
 int sums[16]={_mm512_reduce_add_epi32(a00),_mm512_reduce_add_epi32(a01),_mm512_reduce_add_epi32(a02),_mm512_reduce_add_epi32(a03),
 _mm512_reduce_add_epi32(a10),_mm512_reduce_add_epi32(a11),_mm512_reduce_add_epi32(a12),_mm512_reduce_add_epi32(a13),
 _mm512_reduce_add_epi32(a20),_mm512_reduce_add_epi32(a21),_mm512_reduce_add_epi32(a22),_mm512_reduce_add_epi32(a23),
 _mm512_reduce_add_epi32(a30),_mm512_reduce_add_epi32(a31),_mm512_reduce_add_epi32(a32),_mm512_reduce_add_epi32(a33)};
 #else
 int sums[16];for(int i=0;i<4;++i)for(int j=0;j<4;++j)sums[4*i+j]=dot(Qptr(qi+i),H+size_t(hj+j)*STRIDE);
#endif
 ct.total+=16;
 for(int i=0;i<4;++i)for(int j=0;j<4;++j)if(sums[4*i+j]%5==0)after_first(qi+i,H+size_t(hj+j)*STRIDE,ixs[hj+j],ct,hi,hj+j);
}
void check_arithmetic(int samples){
 std::array<IX,812>ixs;Aligned hd(size_t(812)*STRIDE);
 for(int s=0;s<samples;++s){int qi=(s*311+97)%reps.size(),hi=(s*557+11)%reps.size(),orbit=(s*173+29)%812;
  make_H(hi,hd.p,ixs);EP H=ep(ixs[orbit]);Features hf=features(H,false);unsigned char digs[14];
  for(int j=0;j<RANK;++j){digits(hf[j],digs);for(int b=0;b<14;++b)if(digs[b]!=hd.p[size_t(orbit)*STRIDE+14*j+b])throw std::runtime_error("orbit feature mismatch");}
  F A=eps[qi].E,B=eps[qi].C,C=H.C,D=H.E,W=A*D-B*C;auto r=first_residual(A,B,C,D,W);
  // The polynomial Z is also defined on the two norm boundaries; evaluate directly there.
  K dy(sub(C.c[3].norm(),B.c[3].norm()),0),dx(sub(A.c[1].norm(),D.c[1].norm()),0);
  K Y=B.c[3]*W.c[3].bar()-C.c[3].bar()*W.c[3],R=dy*W.c[1]+B.c[1]*Y.bar()+C.c[1]*Y;
  K X=A.c[1].bar()*R-D.c[1]*R.bar(),Z=dx*dy*W.c[2]-A.c[2]*X-D.c[2]*X.bar()+dx*(B.c[2]*Y.bar()+C.c[2]*Y);
  K z;for(int j=0;j<RANK;++j)z=z+qfeatures[qi][j]*hf[j];if(z!=Z)throw std::runtime_error("bilinear factor mismatch");
  digits(z,digs);for(int p=0;p<14;++p)if(dot(Qptr(qi,p),hd.p+size_t(orbit)*STRIDE)%5!=digs[(p+projection_start)%14])throw std::runtime_error("VNNI dot mismatch");
 }
 std::cerr<<"{\"kind\":\"arithmetic_checks\",\"status\":\"PASS\",\"samples\":"<<samples<<",\"projections_per_sample\":14,\"rank\":"<<RANK<<",\"stride\":"<<STRIDE<<"}\n";
}
int main(int argc,char**argv){
 if(argc<3){std::cerr<<"usage: full_scan start_h stop_h [threads] [check_samples] [first_projection:0..13]\n";return 2;}
 int start=std::stoi(argv[1]),stop=std::stoi(argv[2]),threads=argc>3?std::stoi(argv[3]):3,samples=argc>4?std::stoi(argv[4]):12;
 projection_start=argc>5?std::stoi(argv[5]):0;if(projection_start<0||projection_start>=14)throw std::runtime_error("projection range");
 omp_set_num_threads(threads);auto t0=Clock::now();prepare();if(start<0||stop>int(reps.size())||start>stop)throw std::runtime_error("range");check_arithmetic(samples);
 std::cerr<<"{\"kind\":\"prepared\",\"seconds\":"<<std::chrono::duration<double>(Clock::now()-t0).count()<<",\"representatives\":"<<reps.size()<<",\"threads\":"<<threads<<",\"first_projection\":"<<projection_start<<",\"VNNI\":"<<USE_VNNI<<"}\n";
 #pragma omp parallel for schedule(dynamic,1)
 for(int hi=start;hi<stop;++hi){auto th=Clock::now();Aligned hd(size_t(812)*STRIDE);std::array<IX,812>ixs;make_H(hi,hd.p,ixs);Counts ct;
  // q_index <= h_index gives complete coverage by endpoint interchange.
  int limit=hi+1,vec=limit-limit%4;
  for(int qb=0;qb<vec;qb+=64){int qe=std::min(qb+64,vec);for(int hj=0;hj<812;hj+=4)for(int qi=qb;qi<qe;qi+=4)tile4(qi,hj,hd.p,ixs,ct,hi);}
  for(int qi=vec;qi<limit;++qi)for(int hj=0;hj<812;++hj){++ct.total;if(dot(Qptr(qi),hd.p+size_t(hj)*STRIDE)%5==0)after_first(qi,hd.p+size_t(hj)*STRIDE,ixs[hj],ct,hi,hj);}
  if(ct.total!=uint64_t(812)*limit)throw std::runtime_error("coverage counter mismatch");
  std::lock_guard<std::mutex>lock(output_mutex);std::cerr<<"{\"kind\":\"full_scan_h_summary\",\"h_index\":"<<hi<<",\"pairs\":"<<ct.total<<",\"first_projection_zero\":"<<ct.first<<",\"Z_zero\":"<<ct.full<<",\"norm_boundary\":"<<ct.boundary<<",\"generic_Z_zero\":"<<ct.generic<<",\"T_zero\":"<<ct.tpass<<",\"eq3_zero\":"<<ct.eq3<<",\"eq4_zero\":"<<ct.eq4<<",\"seconds\":"<<std::chrono::duration<double>(Clock::now()-th).count()<<"}\n";
 }
 std::cerr<<"{\"kind\":\"completed\",\"start\":"<<start<<",\"stop\":"<<stop<<",\"seconds\":"<<std::chrono::duration<double>(Clock::now()-t0).count()<<"}\n";
}
