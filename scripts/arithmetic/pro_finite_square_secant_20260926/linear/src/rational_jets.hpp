#pragma once
#include "bivariate.hpp"
namespace exact {
inline Bi DEN;
inline std::vector<Bi> dpowers;
inline Bi dpow(int n){if(n<0)throw std::runtime_error("negative denominator power");if(dpowers.empty())dpowers.push_back(Bi(1));while(int(dpowers.size())<=n)dpowers.push_back(dpowers.back()*DEN);return dpowers[n];}
inline bool divisible_den(const Bi&a){
 // DEN=w^3-pivot. Its root is invertible, including for negative Laurent exponents.
 F root=neg(DEN.t.at({0,0}));Bi rem;for(auto[e,c]:a.t){int k=e.second/3,r=e.second%3;if(r<0){r+=3;k--;}accum(rem,{e.first,r},mul(c,fpow(root,k)));}return rem.zero();
}
struct Rat {
 Bi n;int d=0;
 Rat()=default;Rat(F a):n(a){}Rat(Bi a):n(std::move(a)){}Rat(Bi a,int p):n(std::move(a)),d(p){normalize();}
 void normalize(){if(n.zero()){d=0;return;}while(d>0&&divisible_den(n)){n=exactdivide(n,DEN);d--;}}
 bool zero()const{return n.zero();}
};
inline Rat operator+(const Rat&a,const Rat&b){int d=std::max(a.d,b.d);return Rat(a.n*dpow(d-a.d)+b.n*dpow(d-b.d),d);}
inline Rat operator-(const Rat&a,const Rat&b){int d=std::max(a.d,b.d);return Rat(a.n*dpow(d-a.d)-b.n*dpow(d-b.d),d);}
inline Rat operator*(const Rat&a,const Rat&b){return Rat(a.n*b.n,a.d+b.d);}
inline Rat scale(Rat a,F c){a.n=scale(a.n,c);a.normalize();return a;}
inline Rat power(Rat a,unsigned n){Rat b(1);while(n){if(n&1)b=b*a;a=a*a;n>>=1;}return b;}
using RJet=std::vector<Rat>;
inline RJet rjadd(RJet a,const RJet&b,int n){a.resize(n);for(int i=0;i<std::min<int>(n,b.size());i++)a[i]=a[i]+b[i];return a;}
inline RJet rjscale(RJet a,F c){for(auto&b:a)b=scale(b,c);return a;}
inline RJet rjmul(const RJet&a,const RJet&b,int n){RJet c(n);for(int i=0;i<std::min<int>(n,a.size());i++)if(!a[i].zero())for(int j=0;j<std::min<int>(n-i,b.size());j++)if(!b[j].zero())c[i+j]=c[i+j]+a[i]*b[j];return c;}
inline RJet rjpow(RJet a,unsigned n,int len){RJet b(len);b[0]=Rat(1);while(n){if(n&1)b=rjmul(b,a,len);a=rjmul(a,a,len);n>>=1;}return b;}
inline RJet rjshift(RJet a,int s,int n){RJet b(n);for(int i=0;i<int(a.size());i++)if(i+s>=0&&i+s<n)b[i+s]=a[i];return b;}
inline RJet rationalize(const Jet&j,int d){RJet r;for(auto &b:j)r.emplace_back(b,d);return r;}
}
