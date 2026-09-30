// Infinity contribution to the low-degree traces, with a universal
// proper-in-W polar replacement. Endpoint residues are separate.
#pragma once
#include "degree140_infinity_trace_20260929.hpp"
namespace lowtrace {
using namespace infinitytrace;
using P=std::vector<S>;
inline P padd(P a,const P&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=plus(a[i],b[i]);return a;}
inline P pscale(P a,const S&b){for(auto&c:a)c=times(c,b);return a;}
inline P pmul(const P&a,const P&b){if(a.empty()||b.empty())return {};P c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=plus(c[i+j],times(a[i],b[j]));return c;}
inline P ppower(P a,int n){P b{constant(1)};while(n){if(n&1)b=pmul(b,a);n>>=1;if(n)a=pmul(a,a);}return b;}
inline S peval(const P&a,const S&x){S o;for(int i=(int)a.size()-1;i>=0;i--)o=plus(times(o,x),a[i]);return o;}
inline P polynomial_part(P a,const P&monic){if(a.size()<monic.size())return {};P q(a.size()-monic.size()+1);for(int i=(int)q.size()-1;i>=0;i--){q[i]=a[i+monic.size()-1];for(size_t j=0;j+1<monic.size();j++)a[i+j]=minus(a[i+j],times(q[i],monic[j]));}return q;}
inline int binomial_negative(int n,int k){long long b=1;for(int j=1;j<=k;j++)b=b*(n-j+1)/j;int r=b%5;return r<0?r+5:r;}
struct Polar{std::vector<std::pair<P,int>> pieces;P hp;};
inline Polar polar(const Expansion&e,int m,int n){
 P sp{e.ee,e.cc,e.bb,e.aa},ph(6);ph[0]=e.qbar;ph[5]=constant(1);
 P ds;for(auto&s:sp)ds.push_back(times(deriv(s),e.delta_factor));
 P nn=padd(P{e.dt},pscale(sp,scal(e.bbphi,4)));
 std::array<P,5> dd{P{scal(times(pow(e.tt,2),pow(e.bbphi,2)),4)},pscale(nn,scal(times(e.tt,e.bbphi),1)),padd(ppower(nn,2),pscale(ds,times(e.tt,e.bbphi))),pscale(pmul(nn,ds),constant(2)),ppower(ds,2)};
 Polar out;int k=4-m-2*n;
 for(int j=0;j<k;j++){
  P cj;for(int i=0;i<=std::min(j,4);i++){
   int b=binomial_negative(-n-1,j-i);if(!b)continue;
   S factor=scal(pow(e.tt,-n-1-j+i),b);if((n+1)%2)factor=scal(factor,4);
   cj=padd(cj,pscale(pmul(dd[i],ppower(sp,j-i)),factor));
  }
  out.hp=padd(out.hp,polynomial_part(cj,ppower(ph,k-j)));out.pieces.push_back({cj,k-j});
 }
 return out;
}
inline std::array<std::vector<Poly>,2> profiles(F h,F w,const std::vector<std::pair<int,int>>&fs,int eta_power=1){
 Expansion e=expand(h,w);int p=0;for(auto[i,j]:fs)p=std::max(p,3*i+10*j);
 std::array<std::vector<Poly>,2> out;
 for(int t=0;t<2;t++){
  int m=-t,shift=16*(1-eta_power);
  int maxn=t?std::max(5,std::max((17+p-shift)/4,(33+p-shift)/7)):std::max(2,std::max((37+p-shift)/4,(40+p-shift)/7));out[t].assign(fs.size(),Poly(maxn+1));
  for(int n=0;n<=maxn;n++){
   auto pol=polar(e,m,n);
   for(auto&b:e.branches){
    S ps=scal(peval(pol.hp,b.wbar),4);for(auto&[c,d]:pol.pieces)ps=plus(ps,quotient(peval(c,b.wbar),pow(b.phi,d)));
    S multiplier=pow(b.eta,eta_power);
    ps=times(times(ps,multiplier),e.omega);
    S om=times(times(times(multiplier,pow(b.phi,m)),pow(deriv(b.lambda),2)),times(e.delta_factor,pow(b.lambda,-n-1)));
    S val=minus(ps,om);std::array<S,3> vals{val,times(val,e.y),times(val,pow(e.y,2))};
    for(size_t j=0;j<fs.size();j++)out[t][j][n]=add(out[t][j][n],vals[fs[j].second].at(3*fs[j].first-1));
   }
  }
  for(auto&v:out[t])v.trim();
 }
 return out;
}
}
