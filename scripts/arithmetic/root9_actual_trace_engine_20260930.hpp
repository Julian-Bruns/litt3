// New actual-source divided traces for the accepted root-nine source.
// The coefficient input is an export of the existing exact source G_i.
#pragma once
#include "degree140_low_trace_infinity_20260929.hpp"
namespace root9trace {
using namespace criticaltrace;
inline std::array<std::vector<Term>,4> numerator,denominator;
inline Poly V;
inline void load(const std::string&path){
 baseP=Poly{11,22,18,5,19,20,15,16,9,22,1};V=Poly{neg(9),1};
 T=scale(pdivide(A,Poly{neg(25),1}),inv(13));
 std::ifstream in(path);if(!in)throw std::runtime_error("missing root9 source");
 for(int i=0;i<4;i++){
  int n,d;in>>n>>d;numerator[i].resize(n);denominator[i].resize(d);
  for(auto&t:numerator[i])in>>t.i>>t.j>>t.h>>t.w>>t.c;
  for(auto&t:denominator[i]){t.i=t.j=0;in>>t.h>>t.w>>t.c;}
 }if(!in)throw std::runtime_error("truncated root9 source");
}
inline std::array<Curve,4> evaluate_source(F h,F w){
 std::array<Curve,4> out;
 for(int i=0;i<4;i++){
  F den=0;for(auto&t:denominator[i])den=add(den,mul(t.c,mul(power(h,t.h),power(w,t.w))));
  for(auto&t:numerator[i]){
   auto&p=out[i][t.j];if(p.size()<=size_t(t.i))p.resize(t.i+1);
   p[t.i]=add(p[t.i],divide(mul(t.c,mul(power(h,t.h),power(w,t.w))),den));
  }for(auto&p:out[i])p.trim();
 }return out;
}
inline void install(const std::array<Curve,4>&gs){
 for(int i=0;i<4;i++){family[i].clear();for(int j=0;j<3;j++)for(int k=0;k<(int)gs[i][j].size();k++)if(gs[i][j][k])family[i].push_back({k,j,0,0,gs[i][j][k]});}
}
struct Data{std::array<Curve,3> ds;Curve B;std::array<Curve,4> gs;};
inline Data data(F h,F w){
 auto gs=evaluate_source(h,w);auto ds=quadratic(gs);ds[0]=divp(ds[0],V);ds[2]=cxmul(ds[2],V);
 auto a=gs[0],b=gs[1],c=gs[2],e=gs[3],q=con(Q);
 auto tau=cmul(con(ppow(T,3)*ppow(baseP,3)),mon(0,1));
 auto a3=cpow(a,3),a5=cmul(a3,cpow(a,2)),b5=cfrob5(b);
 auto d=cadd(cpow(b,2),cscale(cmul(a,c),2));
 auto BB=cadd(cadd(cmul(a5,cpow(q,2)),cmul(b5,q)),cscale(cfrob5(c),2));
 auto TT=cadd(b5,cscale(cmul(a5,q),2));
 auto JJ=csub(csub(cscale(cmul(a3,q),2),cmul(e,d)),cmul(b,cpow(c,2)));
 auto MM=csub(cmul(cmul(tau,d),TT),cmul(JJ,BB));
 auto B=divp(divy(cmul(d,MM),37),ppow(T,5));
 return {ds,B,gs};
}
struct Fibre{Poly R,Y,g;std::vector<F> ts;};
inline Fibre fibre(const Data&d,F ell){
 auto E=cadd(cadd(d.ds[0],cscale(d.ds[1],ell)),cscale(d.ds[2],power(ell,2)));
 Poly R=norm(E);if(R.deg()!=140)throw std::runtime_error("lost root9 degree140");R=scale(R,inv(R.back()));
 auto&e0=E[0];auto&e1=E[1];auto&e2=E[2];
 Poly Y=times(baseP*e2*e2-e0*e1,inverse_mod(e1*e1-e0*e2,R),R);
 auto El=cadd(d.ds[1],cscale(d.ds[2],mul(2,ell)));
 Poly Eiv=inverse_mod(evaluate_curve(El,Y,R),R);
 Poly g=scale(times(times(evaluate_curve(delta(E),Y,R),evaluate_curve(d.B,Y,R),R),times(Eiv,Eiv,R),R),4);
 return {R,Y,g,newton(R)};
}
struct Multiplier{int x,y,v;};
inline std::vector<F> values(const Data&d,F ell,const std::vector<Multiplier>&ms){
 auto f=fibre(d,ell);std::vector<F> out;
 for(auto m:ms){Poly t=times(f.g,T*ppow(V,m.v)*ppow(Poly{0,1},m.x),f.R);for(int j=0;j<m.y;j++)t=times(t,f.Y,f.R);out.push_back(trace(t,f.ts));}
 return out;
}
inline infinitytrace::Expansion expansion(F h,F w,bool short_frame){
 auto gs=evaluate_source(h,w);auto e=infinitytrace::expand_source(gs,short_frame);
 using namespace infinitytrace;
 S v=polynomial(V);e.aa=quotient(e.aa,v);e.bb=quotient(e.bb,v);e.cc=quotient(e.cc,v);e.ee=quotient(e.ee,v);
 e.tt=quotient(e.tt,v);e.dt=times(deriv(e.tt),e.delta_factor);
 for(auto&b:e.branches){b.ss=quotient(b.ss,v);b.lambda=quotient(b.lambda,v);}
 return e;
}
}
