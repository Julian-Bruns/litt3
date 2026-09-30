// Short-frame cubic/quartic/quintic traces. The change of polynomial part
// is a scalar times eta^-1, whose quadratic trace is zero. The finite
// endpoint correction is 2 Tr_{K[x]/t}(x^j t' U G2[2]/P).
#pragma once
#include "degree140_low_trace_infinity_20260929.hpp"
namespace inverseetashort {
using namespace infinitytrace;
inline std::array<F,3> constants(F h,F w){
 auto gs=evaluate(h,w);auto red=[](const Poly&p){return divmod(p,T).second;};
 Poly l{18,20,20,15},u=pdivide(Q-frob5(l),ppow(T,3));
 Poly pinv=xgcd(baseP,T)[1],v=red(derivative(T)*u*gs[0][2]*pinv);
 F s0=3,s1=neg(T[2]),s2=sub(mul(T[2],T[2]),mul(2,T[1]));
 std::array<F,3> out{};for(int j=0;j<3;j++){
  out[j]=mul(2,add(add(mul(s0,v.coef(0)),mul(s1,v.coef(1))),mul(s2,v.coef(2))));
  v=red(v*Poly{0,1});
 }return out;
}
inline std::vector<Poly> profiles_many(F h,F w,const std::vector<std::pair<int,int>>&fs){
 Expansion e=expand(h,w,true);using namespace lowtrace;
 P sp{e.ee,e.cc,e.bb,e.aa},ds;for(auto&s:sp)ds.push_back(times(deriv(s),e.delta_factor));
 P sp2=ppower(sp,2),sp3=pmul(sp2,sp);
 P nh=padd(padd(pscale(sp3,pow(e.bbphi,2)),pscale(sp2,scal(times(e.dt,e.bbphi),2))),pscale(pmul(sp,ds),scal(times(e.tt,e.bbphi),3)));
 P hp(5);S ti2=pow(e.tt,-2);for(int j=0;j<5;j++)hp[j]=j+5<(int)nh.size()?times(nh[j+5],ti2):S();
 S endpoint_factor=polynomial(T);std::vector<Poly> out;int maxn=0;
 for(auto[ix,iy]:fs){int p=9+3*ix+10*iy,n=std::max(2,std::max((5+p)/4,(8+p)/7));maxn=std::max(maxn,n);out.push_back(Poly(n+1));}
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
 auto gs=evaluate(h,w);auto red=[](const Poly&p){return divmod(p,T).second;};
 Poly l{18,20,20,15},u=pdivide(Q-frob5(l),ppow(T,3)),pinv=xgcd(baseP,T)[1];
 F s0=3,s1=neg(T[2]),s2=sub(mul(T[2],T[2]),mul(2,T[1]));
 for(size_t j=0;j<fs.size();j++){
  auto[ix,iy]=fs[j];if(iy<0||iy>2)throw std::runtime_error("invalid multiplier character");
  Poly v=red(derivative(T)*u*gs[0][2-iy]*pinv*ppow(Poly{0,1},ix));
  F c=mul(2,add(add(mul(s0,v.coef(0)),mul(s1,v.coef(1))),mul(s2,v.coef(2))));
  out[j][0]=add(out[j][0],c);out[j].trim();
 }
 return out;
}
inline std::array<Poly,3> profiles(F h,F w){auto p=profiles_many(h,w,{{0,0},{1,0},{2,0}});return {p[0],p[1],p[2]};}
}
