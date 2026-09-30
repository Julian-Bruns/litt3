// Bounded exact DVR fixtures for the separately proved content theorem.
#include "../forward/resultant_engine.hpp"
std::array<Poly,3> dcoef(Poly a,Poly b,Poly c,Poly d,Poly Q0,Poly C){
 auto a2=a*a,a3=a2*a,a4=a2*a2,a5=a4*a,b2=b*b,b3=b2*b,b4=b2*b2,b5=b4*b,c2=c*c,c3=c2*c,c4=c2*c2,c5=c4*c;
 auto E=a*d-b*c,Delta=b2+a*c,T=c5-Q0*b5+Q0*Q0*a5,U=scale(Q0*a5,2)-b5;
 auto V=-(d*b5)-scale(c2*b4,2)-scale(a*b2*c3,3)-scale(a2*c4,2)+Q0*(scale(a5*d,2)-a4*b*c+a3*b3);
 auto W=a2*d*d-a*b*c*d+scale(b2*c2,2)+b3*d+a*c3;
 auto M0=U*(scale(a*E,2)+b*Delta)-a2*V;
 return {a3*(T*W+C*M0)+C*C*a5*a5,T*V+C*(U*U-scale(a5*T,2)),T*T};
}
int valuation(const Poly& p){for(int i=0;i<=p.deg();i++)if(p.at(i))return i;return 1000000;}
F direct(F a,F b,F c,F d,F Q0,F C,F lambda){
 Poly S({d,c,ff::mul(3,b),ff::mul(2,a)}),D0({c,b,a});
 Poly U0({Q0,0,0,0,0,1});Poly f=scale(U0*U0,lambda)+U0*S+Poly(C);
 return sylvester(f,10,D0,2);
}
int main(){try{ff::init();init_source();Poly s=Poly::mon(1);
 std::vector<std::array<Poly,3>> primitive={
 {Poly(1)+s,s+s*s,Poly(3)+s},
 {s,Poly(1)+s,Poly(2)+s},
 {s,s*s,Poly(1)+s},
 {Poly(1),Poly(),Poly()},
 {Poly(1),Poly(2),Poly(1)},
 {Poly(),Poly(),Poly(1)},
 {Poly(),Poly(1),Poly(3)}};
 int count=0,checks=0;
 for(int p=0;p<(int)primitive.size();p++)for(int m=0;m<=4;m++){
 auto a=shift(primitive[p][0],m),b=shift(primitive[p][1],m),c=shift(primitive[p][2],m);
 Poly d=Poly(3)+s*s,Q0=(p==3?Poly():Poly(2)+s),C=Poly(1)+s+s*s*s;
 auto D=dcoef(a,b,c,d,Q0,C);int v=std::min({valuation(D[0]),valuation(D[1]),valuation(D[2])});
 if(v!=10*m)throw std::runtime_error("content valuation fixture mismatch");
 for(F z:std::vector<F>{0,1,7})for(F l:std::vector<F>{0,1,11}){
 F expected=ff::add(eval(D[0],z),ff::add(ff::mul(l,eval(D[1],z)),ff::mul(ff::mul(l,l),eval(D[2],z))));
 if(expected!=direct(eval(a,z),eval(b,z),eval(c,z),eval(d,z),eval(Q0,z),eval(C,z),l))throw std::runtime_error("direct Sylvester mismatch");checks++;}
 std::cout<<"DVR_FIXTURE type "<<p<<" min_derivative_valuation "<<m<<" resultant_content_valuation "<<v<<" PASS\n";count++;
 }
 std::cout<<"BOUNDED_CONTENT_IMPLEMENTATION_CHECKS "<<count<<" DIRECT_SYLVESTER_CHECKS "<<checks<<" PASS\n";
}catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
