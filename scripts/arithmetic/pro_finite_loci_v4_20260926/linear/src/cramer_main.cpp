#include "laurent.hpp"
int main(){try{input::init();for(int ir=0;ir<10;ir++){
 auto sp=reconstruct(F::code(input::roots[ir]));auto c=cramer(sp);
 if(c.pivot!=F::code(input::qp[ir]))throw std::runtime_error("listed pivot mismatch");
 std::ofstream out("data/cramer_"+std::to_string(c.r)+".json");out<<"{\"r\":"<<c.r<<",\"pivot\":"<<c.pivot<<",\"denominator_w\":";write_lw(out,c.d);out<<",\"determinant\":";write_lw(out,c.determinant);out<<",\"source_numerators_H_w\":[";
 int mh=-1,ml=INT_MAX,mw=INT_MIN;size_t terms=0;auto cc=coordinates();
 for(size_t k=0;k<c.num.size();k++){
  if(k)out<<",";write_lw(out,c.num[k]);mh=std::max(mh,c.num[k].degH());terms+=c.num[k].c.size();
  if(c.num[k]){auto[lo,hi]=c.num[k].rangeW();ml=std::min(ml,lo);mw=std::max(mw,hi);}
  // Under y -> zeta*y, w -> zeta*w, the original G_i have weight 1.
  int power=cc[k].j+(cc[k].n==0?2:0);c.num[k].as_q(1-power);
 }
 out<<"]}\n";
 std::cout<<"r="<<c.r<<" Cramer denominator=w^3-"<<c.pivot<<" determinant="<<c.det_scalar<<"*w^"<<c.det_w<<"*(w^3-pivot) Hdegree="<<mh<<" wrange="<<ml<<":"<<mw<<" total_terms="<<terms<<" equivariance PASS\n";
 // Exact field points verify graph, Cramer equations, and all original congruences.
 for(int j=1;j<=3;j++){
  F H=F::code(30+j),w=F::code(100+j);F d=w.pow(3)-c.pivot;std::vector<F> vals;for(auto p:c.num)vals.push_back(p.eval(H,w)/d);
  auto s=source_from_vector(vals);for(F b:constraints(s,sp.r))if(b)throw std::runtime_error("Cramer original source failure");
  std::vector<LW> cv;for(F b:vals)cv.push_back(LW(b));auto fj=F_jets(cv);for(int i=0;i<=5;i++)if(fj[i])throw std::runtime_error("Cramer F0..5 check");
 }
 std::cout<<"  three exact source/jet checks PASS\n";
 }}catch(const std::exception& e){std::cerr<<"FAIL "<<e.what()<<"\n";return 1;}}
