#include "fraction.hpp"
int main(){try{input::init();for(int ir=0;ir<10;ir++){
 auto sp=reconstruct(F::code(input::roots[ir]));auto c=cramer(sp);FRACTION_PIVOT=c.pivot;
 std::vector<LF> coeff;for(auto a:c.num)coeff.emplace_back(a,1);
 auto fj=TF_jets(coeff);for(int i=0;i<6;i++)if(fj[i])throw std::runtime_error("symbolic F0..F5 failure");
 std::cout<<"raw F6 denominator power="<<fj[6].e<<" terms="<<fj[6].n.c.size()<<std::endl; if(fj[6].e>2)throw std::runtime_error("F6 denominator");auto theta=fj[6].n.as_q().shift(0,1);auto psi=(fj[6].n*frac_den().pow(2-fj[6].e)).as_q().shift(0,1);
 if(psi.degH()!=3)throw std::runtime_error("Psi H degree");
 LW lead;for(auto [e,a]:psi.c)if(e.first==3)lead.put({0,e.second},a);
 auto leadq=lead.rangeW();std::vector<F> lp(leadq.second-leadq.first+1);for(auto [e,a]:lead.c)lp[e.second-leadq.first]=a;
 Poly L(lp);
 if(L.eval(F::code(input::qr[ir])))throw std::runtime_error("q_r not a leading root");
 Poly known=(Poly::mon(1)-Poly(c.pivot))*(Poly::mon(1)-Poly(F::code(input::qr[ir])));
 auto qq=L.divrem(known);if(qq.second)throw std::runtime_error("leading coefficient lacks listed factors");
 // Every remaining quotient factor is checked to be a monomial, so no extra nonzero roots are hidden.
 int nz=0;for(auto a:qq.first.c)if(a)nz++;if(nz!=1)throw std::runtime_error("additional leading coefficient roots");
 std::ofstream out("data/psi_"+std::to_string(c.r)+".json");out<<"{\"r\":"<<c.r<<",\"pivot\":"<<c.pivot<<",\"q_r\":"<<input::qr[ir]<<",\"Psi_H_q\":";write_lw(out,psi);out<<",\"Theta_H_q\":";write_lw(out,theta);out<<",\"leading_H_coefficient_H_q\":";write_lw(out,lead);out<<"}\n";
 auto [lo,hi]=psi.rangeW();std::cout<<"r="<<c.r<<" symbolic F0..F5=0 PASS; F6=Psi/[q(q-pivot)^2], degH(Psi)="<<psi.degH()<<" qrange="<<lo<<":"<<hi<<" terms="<<psi.c.size()<<" leading roots={pivot,q_r} PASS\n";
 }}catch(const std::exception& e){std::cerr<<"FAIL "<<e.what()<<"\n";return 1;}}
