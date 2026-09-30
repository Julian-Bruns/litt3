#include <cstdint>
#include <vector>
#include <algorithm>
#include <stdexcept>
using F=uint32_t;
static constexpr int Q=390625, ORD=Q-1, HALF=625;
static std::vector<F> addtab, exps, logs;
static F generator=0;
static F add25(F a,F b){return ((a%5+b%5)%5)+5*((a/5+b/5)%5);}
static F neg25(F a){return (5-a%5)%5+5*((5-a/5)%5);}
static F mul25(F a,F b){F a0=a%5,a1=a/5,b0=b%5,b1=b/5;return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5);}
static F rawmul(F a,F b){F aa[4],bb[4],cc[7]={};for(int i=0;i<4;i++){aa[i]=a%25;a/=25;bb[i]=b%25;b/=25;}for(int i=0;i<4;i++)for(int j=0;j<4;j++)cc[i+j]=add25(cc[i+j],mul25(aa[i],bb[j]));F rel[4]={neg25(5),neg25(2),neg25(6),neg25(7)};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)cc[i-4+j]=add25(cc[i-4+j],mul25(cc[i],rel[j]));F r=0;for(int i=3;i>=0;i--)r=25*r+cc[i];return r;}
static F rawpow(F a,uint64_t n){F r=1;for(;n;n>>=1,a=rawmul(a,a))if(n&1)r=rawmul(r,a);return r;}
static inline F add(F a,F b){return addtab[(a%HALF)*HALF+b%HALF]+HALF*addtab[(a/HALF)*HALF+b/HALF];}
static inline F mul(F a,F b){return (!a||!b)?0:exps[logs[a]+logs[b]];}
static inline F neg(F a){return mul(4,a);}
static inline F inv(F a){return exps[ORD-logs[a]];}

// Exact Karatsuba convolution over the original K-code field.
// No evaluation or field specialization occurs in this acceleration.
static std::vector<F> kmul(const F*a,int na,const F*b,int nb){
 while(na>0 && !a[na-1])--na;while(nb>0 && !b[nb-1])--nb;
 if(!na||!nb)return {};
 std::vector<F> out(na+nb-1,0);
 if(std::min(na,nb)<=24 || (int64_t)na*nb<=4096){
  for(int i=0;i<na;i++)if(a[i])for(int j=0;j<nb;j++)if(b[j])out[i+j]=add(out[i+j],mul(a[i],b[j]));
  return out;
 }
 int n=std::max(na,nb),h=(n+1)/2;
 if(na<=h || nb<=h){
  if(na<nb){std::swap(a,b);std::swap(na,nb);}
  auto lo=kmul(a,std::min(h,na),b,nb);
  auto hi=kmul(a+h,na-h,b,nb);
  for(size_t i=0;i<lo.size();i++)out[i]=add(out[i],lo[i]);
  for(size_t i=0;i<hi.size();i++)out[h+i]=add(out[h+i],hi[i]);
  return out;
 }
 auto lo=kmul(a,h,b,h);auto hi=kmul(a+h,na-h,b+h,nb-h);
 std::vector<F> sa(h,0),sb(h,0);
 for(int i=0;i<h;i++){sa[i]=add(a[i],h+i<na?a[h+i]:0);sb[i]=add(b[i],h+i<nb?b[h+i]:0);}
 auto mid=kmul(sa.data(),h,sb.data(),h);
 mid.resize(std::max({mid.size(),lo.size(),hi.size()}),0);
 for(size_t i=0;i<lo.size();i++)mid[i]=add(mid[i],neg(lo[i]));
 for(size_t i=0;i<hi.size();i++)mid[i]=add(mid[i],neg(hi[i]));
 for(size_t i=0;i<lo.size();i++)out[i]=add(out[i],lo[i]);
 for(size_t i=0;i<mid.size();i++)if(h+i<out.size())out[h+i]=add(out[h+i],mid[i]);
 for(size_t i=0;i<hi.size();i++)out[2*h+i]=add(out[2*h+i],hi[i]);
 return out;
}
extern "C" {
int ff_init(){if(generator)return generator;addtab.resize(HALF*HALF);for(int a=0;a<HALF;a++)for(int b=0;b<HALF;b++){int aa=a,bb=b,out=0,p=1;for(int i=0;i<4;i++,p*=5,aa/=5,bb/=5)out+=p*((aa%5+bb%5)%5);addtab[a*HALF+b]=out;}int primes[]={2,3,13,313};for(F a=25;a<Q;a++){bool ok=rawpow(a,ORD)==1;for(int p:primes)if(rawpow(a,ORD/p)==1)ok=false;if(ok){generator=a;break;}}if(!generator)return -1;exps.resize(2*ORD+1);logs.assign(Q,0);F z=1;for(int i=0;i<ORD;i++){if(i&&z==1)return -2;exps[i]=z;logs[z]=i;z=rawmul(z,generator);}if(z!=1)return -3;for(int i=ORD;i<=2*ORD;i++)exps[i]=exps[i-ORD];return generator;}
const F* ff_addtab(){return addtab.data();} const F* ff_exps(){return exps.data();} const F* ff_logs(){return logs.data();}
F ff_rawmul(F a,F b){return rawmul(a,b);} F ff_pow(F a,uint64_t n){if(!n)return 1;if(!a)return 0;return exps[(uint64_t(logs[a])*(n%ORD))%ORD];}
void ff_poly_mul(const F* a,int na,const F* b,int nb,F* c,int nc){std::fill(c,c+nc,0);if(int64_t(na)*nb>4096){auto t=kmul(a,na,b,nb);std::copy(t.begin(),t.begin()+std::min(int(t.size()),nc),c);return;}for(int i=0;i<na;i++)if(a[i])for(int j=0;j<nb&&i+j<nc;j++)if(b[j])c[i+j]=add(c[i+j],mul(a[i],b[j]));}
// Caller guarantees b is trimmed and nonzero and allocates na coefficients for r.
void ff_poly_divrem(const F* a,int na,const F* b,int nb,F* q,F* r){std::copy(a,a+na,r);std::fill(q,q+std::max(1,na-nb+1),0);F ib=inv(b[nb-1]);for(int i=na-nb;i>=0;i--){F z=mul(r[i+nb-1],ib);q[i]=z;if(z)for(int j=0;j<nb;j++)r[i+j]=add(r[i+j],neg(mul(z,b[j])));}}
int ff_rref(F* a,int nr,int nc,int* pivots){int row=0;for(int col=0;col<nc&&row<nr;col++){int p=row;while(p<nr&&!a[p*nc+col])p++;if(p==nr)continue;if(p!=row)for(int j=0;j<nc;j++)std::swap(a[row*nc+j],a[p*nc+j]);F z=inv(a[row*nc+col]);for(int j=col;j<nc;j++)a[row*nc+j]=mul(z,a[row*nc+j]);for(int i=0;i<nr;i++)if(i!=row&&a[i*nc+col]){F c=neg(a[i*nc+col]);for(int j=col;j<nc;j++)a[i*nc+j]=add(a[i*nc+j],mul(c,a[row*nc+j]));}pivots[row]=col;row++;}return row;}
}
static int ED=1;
static std::vector<F> EM={0,1};
static void emul(const F* a,const F* b,F* c){
 std::vector<F> t(2*ED-1,0);
 if(ED>32){auto z=kmul(a,ED,b,ED);std::copy(z.begin(),z.end(),t.begin());}
 else for(int i=0;i<ED;i++)if(a[i])for(int j=0;j<ED;j++)if(b[j])t[i+j]=add(t[i+j],mul(a[i],b[j]));
 for(int i=2*ED-2;i>=ED;i--)if(t[i])for(int j=0;j<ED;j++)t[i-ED+j]=add(t[i-ED+j],neg(mul(t[i],EM[j])));
 std::copy(t.begin(),t.begin()+ED,c);
}
static void trim(std::vector<F>&a){while(!a.empty()&&!a.back())a.pop_back();}
static std::vector<F> padd(const std::vector<F>&a,const std::vector<F>&b,bool minus=false){std::vector<F> c(std::max(a.size(),b.size()),0);for(size_t i=0;i<c.size();i++)c[i]=add(i<a.size()?a[i]:0,i<b.size()?(minus?neg(b[i]):b[i]):0);trim(c);return c;}
static std::vector<F> pmul(const std::vector<F>&a,const std::vector<F>&b){if(a.empty()||b.empty())return {};std::vector<F> c(a.size()+b.size()-1,0);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=add(c[i+j],mul(a[i],b[j]));trim(c);return c;}
static std::pair<std::vector<F>,std::vector<F>> pdiv(std::vector<F> a,const std::vector<F>&b){if(a.size()<b.size())return {{},a};std::vector<F> q(a.size()-b.size()+1,0);F z=inv(b.back());for(int i=int(a.size()-b.size());i>=0;i--){F c=mul(a[i+b.size()-1],z);q[i]=c;for(size_t j=0;j<b.size();j++)a[i+j]=add(a[i+j],neg(mul(c,b[j])));}trim(q);trim(a);return {q,a};}
static bool einv(const F*a,F*out){std::vector<F> r0=EM,r1(a,a+ED),s0,s1={1};trim(r1);while(!r1.empty()){auto qr=pdiv(r0,r1);auto s2=padd(s0,pmul(qr.first,s1),true);r0=r1;r1=qr.second;s0=s1;s1=s2;}if(r0.size()!=1)return false;F z=inv(r0[0]);std::fill(out,out+ED,0);for(size_t i=0;i<s0.size();i++)out[i]=mul(s0[i],z);return true;}
extern "C" {
int ex_context(const F*mod,int d){if(d<1||mod[d]!=1)return 0;ED=d;EM.assign(mod,mod+d+1);return 1;}
void ex_mul(const F*a,const F*b,F*c){emul(a,b,c);}
int ex_inv(const F*a,F*out){return einv(a,out);}
void ex_pow(const F*a,uint64_t n,F*out){std::vector<F> r(ED,0),b(a,a+ED),t(ED);r[0]=1;while(n){if(n&1){emul(r.data(),b.data(),t.data());r=t;}n>>=1;if(n){emul(b.data(),b.data(),t.data());b=t;}}std::copy(r.begin(),r.end(),out);}
void ex_poly_mul(const F*a,int na,const F*b,int nb,F*c,int nc){
 int stride=2*ED-1;std::vector<F> tmp(nc*stride,0);
 if(ED>=8 && int64_t(na)*nb*ED*ED>20000){
  std::vector<F> aa((na-1)*stride+ED,0),bb((nb-1)*stride+ED,0);
  for(int i=0;i<na;i++)std::copy(a+i*ED,a+(i+1)*ED,aa.begin()+i*stride);
  for(int i=0;i<nb;i++)std::copy(b+i*ED,b+(i+1)*ED,bb.begin()+i*stride);
  auto prod=kmul(aa.data(),aa.size(),bb.data(),bb.size());
  std::copy(prod.begin(),prod.begin()+std::min(prod.size(),tmp.size()),tmp.begin());
 } else for(int i=0;i<na;i++)for(int k=0;k<ED;k++)if(a[i*ED+k])for(int j=0;j<nb&&i+j<nc;j++)for(int l=0;l<ED;l++)if(b[j*ED+l]){
  int at=(i+j)*stride+k+l;tmp[at]=add(tmp[at],mul(a[i*ED+k],b[j*ED+l]));
 }
 for(int i=0;i<nc;i++){
  F*t=tmp.data()+i*stride;
  for(int k=stride-1;k>=ED;k--)if(t[k])for(int l=0;l<ED;l++)t[k-ED+l]=add(t[k-ED+l],neg(mul(t[k],EM[l])));
  std::copy(t,t+ED,c+i*ED);
 }
}
int ex_poly_divrem(const F*a,int na,const F*b,int nb,F*q,F*r){
 std::vector<F> ib(ED),z(ED),t(ED);
 if(!einv(b+(nb-1)*ED,ib.data()))return 0;
 std::copy(a,a+na*ED,r);std::fill(q,q+std::max(1,na-nb+1)*ED,0);
 for(int i=na-nb;i>=0;i--){emul(r+(i+nb-1)*ED,ib.data(),z.data());std::copy(z.begin(),z.end(),q+i*ED);
  for(int j=0;j<nb;j++){emul(z.data(),b+j*ED,t.data());for(int k=0;k<ED;k++)r[(i+j)*ED+k]=add(r[(i+j)*ED+k],neg(t[k]));}}
 return 1;
}
}
