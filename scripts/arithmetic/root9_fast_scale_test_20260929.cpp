// Same exact square-tail criterion, with faster large finite-field arithmetic.
#define main accepted_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main
#include "root9_fast_finite_20260929.hpp"
void writefe(std::ostream&o,const Poly<FE>&p){o<<'[';for(int i=0;i<=p.deg();i++){if(i)o<<',';json(o,p[i].p);}o<<']';}
int main(int argc,char**argv){try{
 if(argc<4)throw std::runtime_error("usage source-root finite-incidence.json output.json [factor-index]");init(argv[1]);ptree in;boost::property_tree::read_json(argv[2],in);std::ofstream out(argv[3]);out<<"{\"blocks\":[";bool first=true;int idx=0;
 for(auto&[key,b]:in.get_child("blocks")){
  if(argc>4&&idx++!=std::stoi(argv[4]))continue;auto st=std::chrono::steady_clock::now();FP mod=frow(b.get_child("modulus")),uq=frow(b.get_child("coordinates.3"));FE::setmod(mod);FP qp=b.get_child_optional("coordinates.q")?frow(b.get_child("coordinates.q")):FP(std::vector<F>{0,1});FE q(qp),u(uq);
  if(!u)throw std::runtime_error("input outside u unit chart");auto ui=u.inverse();auto ss=(at(getrow("a0"),q)+at(getrow("b"),q)*ui+at(getrow("c"),q)*ui.pow(2)+at(getrow("e"),q)*ui.pow(3))/at(getrow("d"),q);if(!ss)throw std::runtime_error("input outside F6 unit chart");
  // Bounded independent arithmetic controls in every actual coefficient field.
  uint64_t seed=20260929;for(int k=0;k<4;k++){std::vector<F>aa(mod.deg()),bb(mod.deg());for(auto&v:aa){seed^=seed<<13;seed^=seed>>7;seed^=seed<<17;v=F(seed%F::N);}for(auto&v:bb){seed^=seed<<13;seed^=seed>>7;seed^=seed<<17;v=F(seed%F::N);}FE a{FP(aa)},c{FP(bb)};assert((a*c).p==(a.p*c.p).mod(mod));assert(a.fifth().p==a.p.fifth().mod(mod));assert(a*a.inverse()==FE(1));}
  std::cout<<"ARITHMETIC_PASS "<<mod.deg()<<std::endl;auto co=weighted_small_critical(q,u);auto rr=norm_small(co,q);assert(rr[0].deg()==140);auto ta=tails(rr,74);std::cout<<"TAILS "<<mod.deg()<<" SECONDS "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-st).count()<<std::endl;
  auto[g,U,V]=xgcd(ta[71],ta[72]);Poly<FE>W;
  if(g.deg()>0){auto[gg,A,B]=xgcd(g,ta[73]);if(gg.deg()>0)throw std::runtime_error("three tails have nonconstant gcd");U=A*U;V=A*V;W=B;}
  assert(U*ta[71]+V*ta[72]+W*ta[73]==Poly<FE>(1));if(!first)out<<',';first=false;out<<"{\"modulus\":";json(out,mod);out<<",\"u\":";json(out,uq);out<<",\"C71\":";writefe(out,ta[71]);out<<",\"C72\":";writefe(out,ta[72]);out<<",\"U\":";writefe(out,U);out<<",\"V\":";writefe(out,V);if(W){out<<",\"C73\":";writefe(out,ta[73]);out<<",\"W\":";writefe(out,W);}out<<'}';out.flush();std::cout<<"BEZOUT_PASS "<<mod.deg()<<" SECONDS "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-st).count()<<std::endl;
 }out<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
