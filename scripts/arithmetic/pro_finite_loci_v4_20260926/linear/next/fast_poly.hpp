#pragma once
#include "../src/poly.hpp"
#include "fast_dft.hpp"
inline int fft_length(int need){static std::vector<int> ds; if(ds.empty()){for(int d=1;d<=kfield::N;d++)if(kfield::N%d==0)ds.push_back(d);}auto it=std::lower_bound(ds.begin(),ds.end(),need);if(it==ds.end())throw std::runtime_error("convolution too large for field transform");return *it;}
inline Poly fmul(const Poly& a,const Poly& b){
 if(!a||!b)return Poly();if(std::min(a.deg(),b.deg())<16||static_cast<long long>(a.c.size())*b.c.size()<10000)return a*b;
 int len=a.deg()+b.deg()+1,n=fft_length(len);Rows in(n,std::vector<F>(2));for(int i=0;i<=a.deg();i++)in[i][0]=a[i];for(int i=0;i<=b.deg();i++)in[i][1]=b[i];F rt=F::code(kfield::primitive).pow(kfield::N/n);
 auto fv=fdft(in,rt);in.clear();in.shrink_to_fit();Rows prod(n,std::vector<F>(1));for(int i=0;i<n;i++)prod[i][0]=fv[i][0]*fv[i][1];fv.clear();fv.shrink_to_fit();auto c=fdft(prod,rt.inv());F iv=F(n).inv();Poly out;out.c.resize(len);for(int i=0;i<len;i++)out.c[i]=c[i][0]*iv;for(int i=len;i<n;i++)if(c[i][0])throw std::runtime_error("product interpolation tail");out.trim();return out;
}
inline Poly freverse(const Poly& a,int degree){Poly b;b.c.resize(degree+1);for(int i=0;i<=degree;i++)b.c[degree-i]=a[i];b.trim();return b;}
inline Poly finv_series(const Poly& a,int n){if(!a[0])throw std::runtime_error("series inverse zero");Poly b(a[0].inv());for(int m=1;m<n;m*=2){int nn=std::min(n,2*m);auto t=fmul(a.trunc(nn),b).trunc(nn);b=fmul(b,Poly(2)-t).trunc(nn);}return b;}
inline std::pair<Poly,Poly> fdivrem(const Poly& a,const Poly& b){if(!b)throw std::runtime_error("div0");int d=a.deg()-b.deg();if(d<0)return {Poly(),a};if(d<32||b.deg()<128||static_cast<long long>(d+1)*b.c.size()<16000)return a.divrem(b);
 auto revA=freverse(a,a.deg()).trunc(d+1),revB=freverse(b,b.deg()).trunc(d+1);auto qr=fmul(revA,finv_series(revB,d+1)).trunc(d+1);auto q=freverse(qr,d);auto r=a-fmul(q,b);if(r.deg()>=b.deg())throw std::runtime_error("fast division remainder degree");return {q,r};}
struct PMat{Poly a=Poly(1),b,c,d=Poly(1);};
inline PMat pmmul(const PMat& A,const PMat& B){PMat C;C.a=fmul(A.a,B.a)+fmul(A.b,B.c);C.b=fmul(A.a,B.b)+fmul(A.b,B.d);C.c=fmul(A.c,B.a)+fmul(A.d,B.c);C.d=fmul(A.c,B.b)+fmul(A.d,B.d);return C;}
inline std::pair<Poly,Poly> pmapply(const PMat& M,const Poly& a,const Poly& b){return {fmul(M.a,a)+fmul(M.b,b),fmul(M.c,a)+fmul(M.d,b)};}
inline PMat pmeuclid(const Poly& q,const PMat& M){PMat C;C.a=M.c;C.b=M.d;C.c=M.a-fmul(q,M.c);C.d=M.b-fmul(q,M.d);return C;}
inline PMat half_gcd(const Poly& a,const Poly& b){
 int n=a.deg(),m=(n+1)/2;if(b.deg()<m)return PMat();if(n<=128){PMat M;auto c=a,d=b;while(d.deg()>=m){auto[q,r]=fdivrem(c,d);M=pmeuclid(q,M);c=d;d=r;}return M;}
 if(a.deg()<=b.deg())throw std::runtime_error("half gcd degree precondition");auto R=half_gcd(a.shift(-m),b.shift(-m));auto[c,d]=pmapply(R,a,b);if(d.deg()<m)return R;
 if(c.deg()<=d.deg())throw std::runtime_error("half gcd truncated step");auto[q,e]=fdivrem(c,d);R=pmeuclid(q,R);if(e.deg()<m)return R;
 int k=2*m-d.deg();if(k<0)throw std::runtime_error("half gcd invalid shift");auto S=half_gcd(d.shift(-k),e.shift(-k));return pmmul(S,R);
}
inline std::tuple<Poly,Poly,Poly> fxgcd(Poly a,Poly b,bool verbose=false){
 Poly origA=a,origB=b;PMat M;int iter=0;
 while(b){
  std::pair<int,int> old={a.deg(),b.deg()};if(a.deg()>b.deg()&&a.deg()>128&&2*b.deg()>=a.deg()){
   auto Q=half_gcd(a,b);auto[c,d]=pmapply(Q,a,b);M=pmmul(Q,M);a=c;b=d;
  }
  if(b){auto[q,r]=fdivrem(a,b);M=pmeuclid(q,M);a=b;b=r;}
  if(old.first>=old.second && std::pair<int,int>{a.deg(),b.deg()}>=old)throw std::runtime_error("gcd no degree progress");
  if(verbose)std::cout<<"xgcd step "<<++iter<<" degrees "<<a.deg()<<","<<b.deg()<<"\n"<<std::flush;
 }
 if(!a)return {Poly(),Poly(),Poly()};F iv=a.c.back().inv();a=a*iv;auto s=M.a*iv,t=M.b*iv;
 if(fmul(s,origA)+fmul(t,origB)!=a)throw std::runtime_error("xgcd Bezout verification");if(fdivrem(origA,a).second||fdivrem(origB,a).second)throw std::runtime_error("xgcd divisor verification");return {a,s,t};
}
