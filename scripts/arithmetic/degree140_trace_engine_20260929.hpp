// New native engine for the incoming normalized trace construction.
// Exact coded F_(5^8); family data and field tables are accepted inputs.
#pragma once
#include "fast.hpp"
#include <chrono>
#include <sstream>
using namespace exact;
namespace criticaltrace {
inline Poly A{1,21,14,22,13},Q{0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24};
inline Poly B0{8,14,19,2,10,19,3,24,18,16},T;
constexpr F EPS=359499;
struct Term{int i,j,h,w;F c;};
inline std::array<std::vector<Term>,4> family;
inline Curve mon(int i,int j,F c=1){Curve r{};r[j].resize(i+1);r[j][i]=c;return r;}
inline Curve divy(const Curve&a,int n){Curve r;for(int j=0;j<3;j++){int s=(j-n)%3;if(s<0)s+=3;int k=(n+s-j)/3;r[s]=k>=0?pdivide(a[j],ppow(baseP,k)):a[j]*ppow(baseP,-k);}return r;}
inline Curve divp(Curve a,const Poly&p){for(auto&x:a)x=pdivide(x,p);return a;}
inline Curve delta(const Curve&a){
 Curve r{};for(int j=0;j<3;j++){
  Curve d{};d[j]=derivative(a[j]);r=cadd(r,cmul(mon(0,2,3),d));
  if(j){Curve e{};e[j-1]=scale(a[j]*derivative(baseP),j);r=cadd(r,e);}
 }return r;
}
inline F coefficient(const Curve&a,int i,int j){return a[j].coef(i);}
inline void load(const std::string&path){
 baseP=Poly{11,22,18,5,19,20,15,16,9,22,1};T=scale(pdivide(A,Poly{neg(25),1}),inv(13));
 std::ifstream f(path);if(!f)throw std::runtime_error("missing family coefficient file");
 for(auto&g:family){int n;f>>n;g.resize(n);for(auto&t:g)f>>t.i>>t.j>>t.h>>t.w>>t.c;}
}
inline std::array<Curve,4> evaluate(F h,F w){
 std::array<Curve,4> out;
 for(int k=0;k<4;k++)for(const auto&t:family[k]){
  Poly&p=out[k][t.j];if(p.size()<=size_t(t.i))p.resize(t.i+1);
  p[t.i]=add(p[t.i],mul(t.c,mul(power(h,t.h),power(w,t.w))));
 }for(auto&g:out)for(auto&p:g)p.trim();return out;
}
inline std::array<Curve,3> quadratic(const std::array<Curve,4>&gs){
 auto a=gs[0],b=gs[1],c=gs[2],e=gs[3];auto q=con(Q),tau=cmul(con(ppow(T,3)*ppow(baseP,3)),mon(0,1));
 auto a2=cpow(a,2),a3=cmul(a2,a),a4=cmul(a3,a),a5=cmul(a4,a);
 auto b2=cpow(b,2),b3=cmul(b2,b),b4=cmul(b3,b),b5=cmul(b4,b);
 auto c2=cpow(c,2),c3=cmul(c2,c),c4=cmul(c3,c),c5=cmul(c4,c);
 auto d=cadd(b2,cscale(cmul(a,c),2));
 auto BB=cadd(cadd(cmul(a5,cpow(q,2)),cmul(b5,q)),cscale(c5,2));
 auto TT=cadd(b5,cscale(cmul(a5,q),2));
 auto UU=cadd(cadd(cscale(cmul(e,a2),2),cmul(cmul(a,b),c)),cscale(b3,2));
 auto KK=cadd(cadd(cadd(cmul(a,c3),cmul(b2,c2)),cmul(b3,e)),cadd(cscale(cmul(a2,cpow(e,2)),3),cscale(cmul(cmul(a,b),cmul(c,e)),3)));
 auto CC=cadd(cadd(cadd(cscale(cmul(cmul(q,e),a5),2),cmul(cmul(q,a4),cmul(b,c))),cscale(cmul(cmul(q,a3),b3),2)),cmul(e,b5));
 CC=cadd(csub(csub(CC,cmul(a2,c4)),cscale(cmul(cmul(a,b2),c3),2)),cmul(b4,c2));
 auto D2=cscale(cpow(BB,2),4);
 auto D1=cadd(cscale(cmul(BB,CC),4),cscale(cmul(tau,csub(cpow(TT,2),cscale(cmul(a5,BB),2))),4));
 auto D0=cadd(cadd(cscale(cmul(cmul(a3,BB),KK),3),cscale(cmul(cmul(tau,a3),cadd(cscale(cmul(UU,TT),3),cpow(d,4))),4)),cscale(cmul(cpow(tau,2),cpow(a,10)),4));
 std::array<Curve,3> out{D0,D1,D2};for(auto&g:out)g=divp(divy(g,40),ppow(T,5));return out;
}
struct Data {std::array<Curve,3> ds;Curve B;std::array<Curve,5> primitive;F sign;};
inline Data data(F h,F w){
 F qv=power(w,3),hv=mul(h,w);Poly a0{89654,311173,214299,163299,315361,33043,356725,245794};
 F a=eval(a0,qv),psi=add(a,mul(hv,mul(qv,add(299833,mul(232505,qv)))));
 if(!h||!w||qv==1||qv==15383||!a||!psi)throw std::runtime_error("ratio outside prescribed open");
 auto gs=evaluate(h,w);auto ds=quadratic(gs);
 auto aa=gs[0],b=gs[1],c=gs[2],e=gs[3];auto q=con(Q),tau=cmul(con(ppow(T,3)*ppow(baseP,3)),mon(0,1));
 auto a3=cpow(aa,3),a5=cmul(a3,cpow(aa,2)),b5=cfrob5(b);
 auto d=cadd(cpow(b,2),cscale(cmul(aa,c),2));
 auto BB=cadd(cadd(cmul(a5,cpow(q,2)),cmul(b5,q)),cscale(cfrob5(c),2));
 auto TT=cadd(b5,cscale(cmul(a5,q),2));
 auto JJ=csub(csub(cscale(cmul(a3,q),2),cmul(e,d)),cmul(b,cpow(c,2)));
 auto MM=csub(cmul(cmul(tau,d),TT),cmul(JJ,BB));
 auto B=divp(divy(cmul(d,MM),37),ppow(T,5));
 F sign=divide(mul(coefficient(B,40,0),EPS),coefficient(ds[1],42,1));
 if(sign!=1&&sign!=4)throw std::runtime_error("critical orientation mismatch");B=cscale(B,sign);
 Curve bb=divy(csub(b,cscale(cmul(con(B0),aa),3)),3);
 Curve cc=divy(cadd(csub(c,cscale(cmul(con(B0),b),2)),cscale(cmul(con(ppow(B0,2)),aa),3)),4);
 Curve ee=divy(csub(cadd(csub(e,cmul(con(B0),c)),cmul(con(ppow(B0,2)),b)),cmul(con(ppow(B0,3)),aa)),5);
 Curve qq=divy(con(Q-frob5(B0)),5);aa=divy(aa,2);
 return {ds,B,{aa,bb,cc,ee,qq},sign};
}
inline Poly rem(const Poly&a,const Poly&R){return divmod(a,R).second;}
inline Poly times(const Poly&a,const Poly&b,const Poly&R){return rem(a*b,R);}
inline Poly inverse_mod(const Poly&a,const Poly&R){auto z=xgcd(a,R);if(z[0]!=Poly{1})throw std::runtime_error("bad projection fibre");return rem(z[1],R);}
inline Poly evaluate_curve(const Curve&a,const Poly&Y,const Poly&R){return rem(a[0]+times(a[1],Y,R)+times(a[2],times(Y,Y,R),R),R);}
inline std::vector<F> newton(const Poly&R){
 int N=R.deg();std::vector<F> out(N+2);out[0]=N%5;
 for(int k=1;k<N+2;k++){F v=k<N?mul(k%5,R[N-k]):0;for(int i=1;i<(k<N?k:N+1);i++)v=add(v,mul(R[N-i],out[k-i]));out[k]=neg(v);}return out;
}
inline F trace(const Poly&f,const std::vector<F>&ts,int shift=0){if(shift<0||f.size()+size_t(shift)>ts.size())throw std::runtime_error("Newton trace range exceeded; reduce the multiplier modulo the fibre first");F r=0;for(size_t j=0;j<f.size();j++)r=add(r,mul(f[j],ts[j+shift]));return r;}
struct Fibre {Poly R,Y,v,phi;std::vector<F> ts;};
inline Fibre fibre(const Data&d,F ell){
 auto E=cadd(cadd(d.ds[0],cscale(d.ds[1],ell)),cscale(d.ds[2],power(ell,2)));
 Poly R=norm(E);if(R.deg()!=140)throw std::runtime_error("lost degree140");R=scale(R,inv(R.back()));
 const auto&e0=E[0];const auto&e1=E[1];const auto&e2=E[2];
 Poly Y=times(baseP*e2*e2-e0*e1,inverse_mod(e1*e1-e0*e2,R),R);
 Poly Binv=inverse_mod(evaluate_curve(d.B,Y,R),R);
 Poly v=scale(times(evaluate_curve(delta(E),Y,R),Binv,R),4);
 Poly eta=times(evaluate_curve(cadd(d.ds[1],cscale(d.ds[2],mul(2,ell))),Y,R),Binv,R);
 Poly av=evaluate_curve(d.primitive[0],Y,R),bv=evaluate_curve(d.primitive[1],Y,R),qv=evaluate_curve(d.primitive[4],Y,R);
 Poly W=times(scale(bv,3)+scale(eta,mul(2,d.sign)),inverse_mod(av,R),R);
 Poly W2=times(W,W,R),W5=times(times(W2,W2,R),W,R),phi=rem(W5+qv,R);
 return {R,Y,v,phi,newton(R)};
}
inline std::array<F,5> values(const Data&d,F ell){
 auto f=fibre(d,ell);Poly vf=times(f.v,inverse_mod(f.phi,f.R),f.R);
 return {trace(f.v,f.ts),trace(f.v,f.ts,1),trace(vf,f.ts),trace(vf,f.ts,1),trace(vf,f.ts,2)};
}
inline Poly interpolate(const std::vector<F>&xs,const std::vector<F>&ys){
 Poly out{},base{1};for(size_t i=0;i<xs.size();i++){F d=divide(sub(ys[i],eval(out,xs[i])),eval(base,xs[i]));out=out+scale(base,d);base=base*Poly{neg(xs[i]),1};}return out;
}
inline std::array<Poly,5> profile(F h,F w){
 Data d=data(h,w);std::vector<F> xs;std::array<std::vector<F>,5> ys;
 for(F ell=0;xs.size()<14&&ell<390625;ell++){
  try {auto v=values(d,ell);xs.push_back(ell);for(int j=0;j<5;j++)ys[j].push_back(v[j]);}
  catch(const std::exception&e){if(std::string(e.what())!="bad projection fibre")throw;}
 }
 if(xs.size()!=14)throw std::runtime_error("not enough valid interpolation fibres");
 int bound[5]={9,10,5,5,5};std::array<Poly,5> out;
 for(int j=0;j<5;j++){out[j]=interpolate(xs,ys[j]);if(out[j].deg()>bound[j])throw std::runtime_error("trace degree bound failed");}
 if(out[0].deg()!=9||out[1].deg()!=10)throw std::runtime_error("leading trace unit missing");return out;
}
inline std::array<Poly,3> positive_profile(F h,F w,int m){
 if(m<1||m>4)throw std::runtime_error("positive multiplier range");
 Data d=data(h,w);std::vector<F> xs;std::array<std::vector<F>,3> ys;
 int zero_bound=(5*m-2)/3;
 int top=zero_bound+(37+20*m+6)/4;
 for(F ell=1;xs.size()<size_t(top+1)&&ell<390625;ell++){
  try{
   auto f=fibre(d,ell);Poly val=f.v;
   for(int i=0;i<m;i++)val=times(val,f.phi,f.R);
   xs.push_back(ell);
   for(int j=0;j<3;j++)ys[j].push_back(mul(power(ell,zero_bound),trace(val,f.ts,j)));
  }catch(const std::exception&e){if(std::string(e.what())!="bad projection fibre")throw;}
 }
 if(xs.size()!=size_t(top+1))throw std::runtime_error("not enough positive-multiplier fibres");
 std::array<Poly,3> out;
 for(int j=0;j<3;j++){
  out[j]=interpolate(xs,ys[j]);
  int bound=zero_bound+(37+20*m+3*j)/4;
  if(out[j].deg()>bound)throw std::runtime_error("positive-multiplier degree bound failed");
 }
 return out;
}
}
