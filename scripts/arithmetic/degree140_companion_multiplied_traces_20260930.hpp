// Short-coordinate companion traces, retaining the coordinate-change residues.
#pragma once
#include "degree140_endpoint_multiplied_traces_20260929.hpp"
namespace companionmultiplied {
using namespace infinitytrace;
inline std::array<F,3> coordinate_constants(F h,F w){
 auto gs=criticaltrace::evaluate(h,w);
 auto disc=criticaltrace::divp(cadd(cpow(gs[1],2),cscale(cmul(gs[0],gs[2]),2)),ppow(baseP,2));
 Poly nn=criticaltrace::B0-Poly{18,20,20,15};
 Poly rr=criticaltrace::rem(nn*ppow(Poly{neg(25),1},2)*disc[0]*disc[1],baseP);
 auto ts=criticaltrace::newton(scale(baseP,inv(baseP.back())));
 // The specified orientation is eta=-(3*a*W+b), so the residue shift
 // has the opposite sign to the un-oriented quadratic square root.
 std::array<F,3> out{};F factor=neg(mul(2,mul(3,power(13,2))));
 for(int j=0;j<3;j++){
  out[j]=mul(factor,criticaltrace::trace(rr,ts));
  rr=criticaltrace::rem(rr*Poly{0,1},baseP);
 }
 return out;
}
inline std::array<Poly,3> profiles(F h,F w,bool correct_coordinate=true){
 using namespace lowtrace;
 Expansion e=expand(h,w,true);std::array<Polar,3> pol;
 for(int n=0;n<3;n++)pol[n]=polar(e,-1,n);
 S factor=pow(polynomial(criticaltrace::T),4);
 std::array<Poly,3> out{Poly(14),Poly(15),Poly(15)};
 for(auto&b:e.branches){
  std::array<S,3> ps;
  for(int n=0;n<3;n++){
   ps[n]=scal(peval(pol[n].hp,b.wbar),4);
   for(auto&[c,d]:pol[n].pieces)ps[n]=plus(ps[n],quotient(peval(c,b.wbar),pow(b.phi,d)));
   ps[n]=times(times(times(ps[n],b.eta),e.omega),factor);
  }
  S li=inverse(b.lambda);
  S om=times(times(times(times(b.eta,inverse(b.phi)),pow(deriv(b.lambda),2)),e.delta_factor),times(li,factor));
  for(int n=0;n<=14;n++){
   S val=scal(om,4);if(n<3)val=plus(val,ps[n]);
   for(int j=0;j<3;j++)if(n<(int)out[j].size())out[j][n]=add(out[j][n],val.at(3*j-1));
   om=times(om,li);
  }
 }
 auto cc=endpointtrace::closed_constants(h,w);
 auto shift=coordinate_constants(h,w);
 for(int j=0;j<3;j++){
  out[j][0]=add(out[j][0],cc[1][j]);
  if(correct_coordinate)out[j][0]=sub(out[j][0],shift[j]);
  out[j].trim();
 }
 return out;
}
}
