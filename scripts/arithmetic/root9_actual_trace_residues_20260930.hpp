// Root-nine residue profiles. The v^2 multiplier removes the marked
// branch contribution; the three fixed t-endpoints have a closed trace.
#pragma once
#include "root9_actual_trace_engine_20260930.hpp"
namespace root9residue {
using namespace infinitytrace;
using namespace lowtrace;
inline std::vector<Poly> profiles(F h,F w,const std::vector<std::pair<int,int>>&fs,int vp=2){
 Expansion e=root9trace::expansion(h,w,true);
 P sp{e.ee,e.cc,e.bb,e.aa},ds;for(auto&s:sp)ds.push_back(times(deriv(s),e.delta_factor));
 P sp2=ppower(sp,2),sp3=pmul(sp2,sp);
 P nh=padd(padd(pscale(sp3,pow(e.bbphi,2)),pscale(sp2,scal(times(e.dt,e.bbphi),2))),pscale(pmul(sp,ds),scal(times(e.tt,e.bbphi),3)));
 P hp(5);S ti2=pow(e.tt,-2);for(int j=0;j<5;j++)hp[j]=j+5<(int)nh.size()?times(nh[j+5],ti2):S();
 S endpoint_factor=polynomial(T*ppow(root9trace::V,vp));std::vector<Poly> out;int maxn=0;
 for(auto[ix,iy]:fs){int p=9+3*vp+3*ix+10*iy,n=std::max(2,(5+p)/4);maxn=std::max(maxn,n);out.push_back(Poly(n+1));}
 for(auto&b:e.branches){
  S dS=times(deriv(b.ss),e.delta_factor),np=plus(e.dt,times(e.bbphi,b.ss)),pi=inverse(b.phi);
  S c2=minus(scal(times(e.bbphi,dS),4),quotient(pow(np,2),e.tt));
  S c3=quotient(times(np,minus(times(b.ss,np),scal(times(e.tt,dS),2))),pow(e.tt,2));
  S ps0=minus(plus(plus(times(times(e.tt,pow(e.bbphi,2)),pow(pi,4)),scal(times(times(e.bbphi,e.dt),pow(pi,3)),4)),plus(times(c2,pow(pi,2)),times(c3,pi))),peval(hp,b.wbar));
  S ps1=plus(scal(times(pow(e.bbphi,2),pow(pi,2)),4),quotient(times(times(e.bbphi,np),pi),e.tt));
  S ei=inverse(b.eta),common=times(times(ei,e.omega),endpoint_factor);ps0=times(ps0,common);ps1=times(ps1,common);
  S li=inverse(b.lambda),om=times(times(times(ei,pow(deriv(b.lambda),2)),e.delta_factor),times(li,endpoint_factor));
  for(int n=0;n<=maxn;n++){
   S rr=scal(om,4);if(n==0)rr=plus(rr,ps0);if(n==1)rr=plus(rr,ps1);
   std::array<S,3> ys{rr,times(rr,e.y),times(rr,pow(e.y,2))};
   for(size_t j=0;j<fs.size();j++)if(n<(int)out[j].size())out[j][n]=add(out[j][n],ys[fs[j].second].at(3*fs[j].first-1));
   om=times(om,li);
  }
 }
 auto gs=root9trace::evaluate_source(h,w);auto red=[](const Poly&p){return divmod(p,T).second;};
 Poly l{18,20,20,15},u=pdivide(Q-frob5(l),ppow(T,3)),pinv=xgcd(baseP,T)[1];
 Poly vm=vp?ppow(root9trace::V,vp-1):xgcd(root9trace::V,T)[1];
 F s0=3,s1=neg(T[2]),s2=sub(mul(T[2],T[2]),mul(2,T[1]));
 for(size_t j=0;j<fs.size();j++){
  auto[ix,iy]=fs[j];if(iy<0||iy>2)throw std::runtime_error("invalid multiplier character");
  Poly v=red(derivative(T)*u*gs[0][2-iy]*pinv*vm*ppow(Poly{0,1},ix));
  F c=mul(2,add(add(mul(s0,v.coef(0)),mul(s1,v.coef(1))),mul(s2,v.coef(2))));
  out[j][0]=add(out[j][0],c);out[j].trim();
 }return out;
}
}
