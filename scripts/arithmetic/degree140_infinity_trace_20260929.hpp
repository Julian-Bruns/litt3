// New residue realization of the positive-primitive traces.
// Accepted family coefficients; no replay of earlier certificates.
#pragma once
#include "degree140_trace_engine_20260929.hpp"
#include <limits>
namespace infinitytrace {
using namespace criticaltrace;
constexpr int INF=1000000;
inline thread_local int CAP=240;
struct S {
 int lo=0,prec=INF; std::vector<F> c;
 S()=default;
 S(int l,std::vector<F> v,int p=INF):lo(l),prec(p),c(std::move(v)){trim();}
 void trim(){
  if(prec!=INF&&lo+(int)c.size()>prec)c.resize(std::max(0,prec-lo));
  while(!c.empty()&&!c.back())c.pop_back();
  int j=0;while(j<(int)c.size()&&!c[j])j++;
  if(j){c.erase(c.begin(),c.begin()+j);lo+=j;}
  if(c.empty())lo=prec;
 }
 int val()const{return c.empty()?prec:lo;}
 F at(int e)const {if(e>=prec)throw std::runtime_error("series precision exhausted");return e>=lo&&e<lo+(int)c.size()?c[e-lo]:0;}
};
inline S mono(int e,F a=1){return S(e,{a});}
inline S constant(F a){return mono(0,a);}
inline S shift(S a,int n){if(a.lo!=INF)a.lo+=n;if(a.prec!=INF)a.prec+=n;return a;}
inline S cut(S a,int n,bool exact_polynomial=false){a.prec=std::min(a.prec,n);a.trim();if(exact_polynomial)a.prec=INF;return a;}
inline S scal(S a,F b){for(auto&x:a.c)x=mul(x,b);a.trim();return a;}
inline S plus(const S&a,const S&b){
 int p=std::min(a.prec,b.prec),lo=std::min(a.val(),b.val());
 if(lo>=p)return S(0,{},p);
 int hi=std::min(p,std::max(a.c.empty()?lo:a.lo+(int)a.c.size(),b.c.empty()?lo:b.lo+(int)b.c.size()));
 std::vector<F> c(std::max(0,hi-lo));
 for(int i=lo;i<hi;i++)c[i-lo]=add(a.at(i),b.at(i));return S(lo,std::move(c),p);
}
inline S minus(const S&a,const S&b){return plus(a,scal(b,4));}
inline S times(const S&a,const S&b){
 int p=std::min({INF,a.prec==INF?INF:a.prec+b.val(),b.prec==INF?INF:b.prec+a.val()});
 if(a.c.empty()||b.c.empty())return S(0,{},p);
 int lo=a.lo+b.lo,hi=std::min(p,a.lo+(int)a.c.size()+b.lo+(int)b.c.size()-1);
 if(hi>CAP){hi=CAP;p=std::min(p,CAP);}
 std::vector<F> c(std::max(0,hi-lo));
 for(int i=0;i<(int)a.c.size();i++)if(a.c[i])
  for(int j=0;j<(int)b.c.size()&&i+j<(int)c.size();j++)if(b.c[j])c[i+j]=add(c[i+j],mul(a.c[i],b.c[j]));
 return S(lo,std::move(c),p);
}
inline S inverse(const S&a){
 if(a.c.empty())throw std::runtime_error("inverse of zero series");
 int lo=-a.lo,p=std::min(CAP,a.prec==INF?CAP:a.prec-2*a.lo),n=p-lo;
 if(n<=0)throw std::runtime_error("inverse precision exhausted");
 std::vector<F> c(n);c[0]=inv(a.c[0]);
 for(int i=1;i<n;i++){F t=0;for(int j=1;j<=i&&j<(int)a.c.size();j++)if(a.c[j]&&c[i-j])t=add(t,mul(a.c[j],c[i-j]));c[i]=neg(mul(t,c[0]));}
 return S(lo,std::move(c),p);
}
inline S quotient(const S&a,const S&b){return times(a,inverse(b));}
inline S pow(S a,int n){if(n<0)return pow(inverse(a),-n);S o=constant(1);while(n){if(n&1)o=times(o,a);n>>=1;if(n)a=times(a,a);}return o;}
inline S fifth(const S&a){
 if(a.c.empty())return S(0,{},a.prec==INF?INF:5*a.prec);
 int p=a.prec==INF?INF:5*a.prec,lo=5*a.lo,hi=5*(a.lo+(int)a.c.size()-1)+1;
 if(hi>CAP){hi=CAP;p=std::min(p,CAP);}
 std::vector<F> c(std::max(0,hi-lo));for(int i=0;5*i<(int)c.size();i++)c[5*i]=power(a.c[i],5);
 return S(lo,std::move(c),p);
}
inline S deriv(const S&a){S o=a;if(o.lo!=INF)o.lo--;if(o.prec!=INF)o.prec--;for(int i=0;i<(int)o.c.size();i++){int e=(a.lo+i)%5;if(e<0)e+=5;o.c[i]=mul(e,o.c[i]);}o.trim();return o;}
inline S polynomial(const Poly&p){if(p.empty())return S();std::vector<F> c(3*p.deg()+1);int lo=-3*p.deg();for(int i=0;i<=p.deg();i++)c[-3*i-lo]=p[i];return S(lo,std::move(c));}
inline S evalcurve(const Curve&a,const S&y){return plus(plus(polynomial(a[0]),times(polynomial(a[1]),y)),times(polynomial(a[2]),pow(y,2)));}
inline S yunit(){
 static thread_local S cache;static thread_local int cached_cap=-1;if(cached_cap==CAP)return cache;
 S pp=shift(polynomial(baseP),30),u=constant(1);
 for(int n=1;n<CAP;n*=2){int old=CAP;CAP=std::min(old,2*n);u=minus(u,quotient(minus(pow(u,3),cut(pp,CAP)),scal(pow(u,2),3)));u=cut(u,CAP,true);CAP=old;}
 u.prec=CAP;u.trim();cache=u;cached_cap=CAP;return u;
}
struct Branch{S phi,eta,lambda,ss,wbar;};
struct Expansion{
 S y,omega,aa,bb,cc,ee,qbar,dt,bbphi,tt,delta_factor;
 std::array<Branch,2> branches;
};
inline Expansion expand_source(const std::array<Curve,4>&g,bool short_frame=false){
 S yu=yunit(),y=shift(yu,-10),omega=scal(shift(inverse(pow(yu,2)),16),4),df=inverse(omega);
 std::array<S,4> gs;for(int i=0;i<4;i++)gs[i]=evalcurve(g[i],y);
 S a=scal(shift(gs[0],35),3),b=scal(shift(gs[1],46),2),c=shift(gs[2],57);
 S rho=constant(neg(divide(c.at(0),b.at(0))));
 for(int n=1;n<CAP;n*=2){int old=CAP;CAP=std::min(old,2*n);S ax=cut(a,CAP),bx=cut(b,CAP),cx=cut(c,CAP);S fun=plus(plus(times(ax,pow(rho,2)),times(bx,rho)),cx);rho=minus(rho,quotient(fun,plus(scal(times(ax,rho),2),bx)));rho=cut(rho,CAP,true);CAP=old;}
 rho.prec=std::min({CAP,a.prec,b.prec,c.prec});rho.trim();
 S zs=shift(rho,-11),zl=minus(quotient(gs[1],gs[0]),zs),y5=fifth(y),tt=pow(polynomial(T),3);
 Expansion out;out.y=y;out.omega=omega;out.delta_factor=df;out.tt=tt;out.dt=times(deriv(tt),df);out.bbphi=scal(pow(polynomial(A),2),3);
 S bo=polynomial(short_frame?Poly{18,20,20,15}:B0);
 out.aa=quotient(gs[0],pow(y,2));out.bb=quotient(minus(gs[1],scal(times(bo,gs[0]),3)),pow(y,3));
 out.cc=quotient(plus(minus(gs[2],scal(times(bo,gs[1]),2)),scal(times(pow(bo,2),gs[0]),3)),pow(y,4));
 out.ee=quotient(minus(plus(minus(gs[3],times(bo,gs[2])),times(pow(bo,2),gs[1])),times(pow(bo,3),gs[0])),pow(y,5));
 out.qbar=quotient(minus(polynomial(Q),fifth(bo)),y5);
 for(int i=0;i<2;i++){
  S z=i?zs:zl,phi=quotient(plus(fifth(z),polynomial(Q)),y5);
  S ss=quotient(plus(plus(times(gs[0],pow(z,3)),times(gs[1],pow(z,2))),plus(times(gs[2],z),gs[3])),y5);
  S lambda=scal(plus(quotient(ss,phi),quotient(tt,pow(phi,2))),4);
  S eta=quotient(minus(scal(gs[1],3),times(gs[0],z)),scal(pow(y,3),2));
  out.branches[i]={phi,eta,lambda,ss,quotient(plus(z,bo),y)};
 }
 return out;
}
inline Expansion expand(F h,F w,bool short_frame=false){return expand_source(evaluate(h,w),short_frame);}
inline std::vector<Poly> all_profiles(F h,F w,const std::vector<std::pair<int,int>>& fs){
 Expansion e=expand(h,w);int pole=0;for(auto [i,j]:fs)pole=std::max(pole,3*i+10*j);
 int maxn=(57+pole)/4;
 std::vector<Poly> out(fs.size(),Poly(maxn+2));
 std::array<S,3> yps{constant(1),e.y,pow(e.y,2)};
 auto residues=[&](const S&s){std::array<S,3> ys{s,times(s,yps[1]),times(s,yps[2])};std::vector<F> r;for(auto [i,j]:fs)r.push_back(ys[j].at(3*i-1));return r;};
 S da=times(deriv(e.aa),e.delta_factor);
 S negres=times(quotient(times(pow(e.bb,2),pow(da,2)),e.aa),e.omega);
 auto rs=residues(negres);for(size_t j=0;j<fs.size();j++)out[j][0]=neg(rs[j]);
 for(auto&br:e.branches){
  S dl=deriv(br.lambda),base=times(times(br.eta,br.phi),times(pow(dl,2),e.delta_factor));
  S li=inverse(br.lambda),om=times(base,li);
  S B=e.bbphi,N=plus(e.dt,times(B,br.ss)),dS=times(deriv(br.ss),e.delta_factor);
  S psi1=scal(times(quotient(times(br.eta,pow(B,2)),br.phi),e.omega),4);
  S in=plus(minus(scal(quotient(times(e.tt,pow(B,2)),pow(br.phi,3)),4),scal(quotient(times(e.dt,B),pow(br.phi,2)),4)),quotient(minus(quotient(pow(N,2),e.tt),scal(times(B,dS),4)),br.phi));
  S psi0=scal(times(times(br.eta,in),e.omega),4);
  auto r0=residues(psi0),r1=residues(psi1);
  for(int n=0;n<=maxn;n++){
   auto rr=residues(om);
   for(size_t j=0;j<fs.size();j++){
    F r=neg(rr[j]);
    if(n==0)r=add(r,r0[j]);if(n==1)r=add(r,r1[j]);
    out[j][n+1]=add(out[j][n+1],r);
   }
   om=times(om,li);
  }
 }
 for(auto&p:out)p.trim();return out;
}
inline std::array<Poly,3> profiles(F h,F w){auto ps=all_profiles(h,w,{{0,0},{1,0},{2,0}});return {ps[0],ps[1],ps[2]};}
}
