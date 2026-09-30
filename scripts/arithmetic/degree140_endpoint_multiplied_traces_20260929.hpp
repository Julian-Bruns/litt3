// Degree11/12/13 trace equations; short primitive coordinate and fixed-algebra correction.
#pragma once
#include "degree140_low_trace_infinity_20260929.hpp"
#include "degree140_endpoint_trace_native_20260929.hpp"
namespace multipliedtrace {
using namespace infinitytrace;
inline std::array<Poly,3> profiles(F h,F w){
 Expansion e=expand(h,w,true);using namespace lowtrace;
 P sp{e.ee,e.cc,e.bb,e.aa},ds;for(auto&s:sp)ds.push_back(times(deriv(s),e.delta_factor));
 P s2=ppower(sp,2),s3=pmul(s2,sp);
 P nh=padd(padd(pscale(s3,pow(e.bbphi,2)),pscale(s2,scal(times(e.dt,e.bbphi),2))),pscale(pmul(sp,ds),scal(times(e.tt,e.bbphi),3)));
 P hp(5);S ti2=pow(e.tt,-2);for(int j=0;j<5;j++)hp[j]=j+5<(int)nh.size()?times(nh[j+5],ti2):S();
 S endpoint_factor=polynomial(T);std::array<Poly,3> out{Poly(12),Poly(13),Poly(14)};
 for(auto&b:e.branches){
  S dS=times(deriv(b.ss),e.delta_factor),np=plus(e.dt,times(e.bbphi,b.ss)),pi=inverse(b.phi);
  S c2=minus(scal(times(e.bbphi,dS),4),quotient(pow(np,2),e.tt));
  S c3=quotient(times(np,minus(times(b.ss,np),scal(times(e.tt,dS),2))),pow(e.tt,2));
  S ps0=minus(plus(plus(times(times(e.tt,pow(e.bbphi,2)),pow(pi,4)),scal(times(times(e.bbphi,e.dt),pow(pi,3)),4)),plus(times(c2,pow(pi,2)),times(c3,pi))),peval(hp,b.wbar));
  S ps1=plus(scal(times(pow(e.bbphi,2),pow(pi,2)),4),quotient(times(times(e.bbphi,np),pi),e.tt));
  S common=times(times(b.eta,e.omega),endpoint_factor);ps0=times(ps0,common);ps1=times(ps1,common);
  S li=inverse(b.lambda),om=times(times(times(b.eta,pow(deriv(b.lambda),2)),e.delta_factor),times(li,endpoint_factor));
  for(int n=0;n<=13;n++){
   S rr=scal(om,4);if(n==0)rr=plus(rr,ps0);if(n==1)rr=plus(rr,ps1);
   for(int j=0;j<3;j++)if(n<(int)out[j].size())out[j][n]=add(out[j][n],rr.at(3*j-1));
   om=times(om,li);
  }
 }
 auto cc=endpointtrace::closed_constants(h,w);for(int j=0;j<3;j++){out[j][0]=add(out[j][0],cc[0][j]);out[j].trim();}
 return out;
}
}
