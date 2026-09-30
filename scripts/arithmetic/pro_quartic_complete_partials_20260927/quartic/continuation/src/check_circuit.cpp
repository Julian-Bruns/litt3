#include "generic_kernel.hpp"
#include <random>
#include <map>
#include <fstream>
struct Gate{char op;int a,b;};
int main(int argc,char**argv){
 if(argc!=2){std::cerr<<"usage: check_circuit residual_circuit.txt\n";return 2;}
 init();init_labels();K eta=K::code(22),ie=eta.inverse();for(auto&lab:labels)for(F&f:lab)f=f.times(ie);
 std::ifstream in(argv[1]);if(!in)throw std::runtime_error("Cannot read circuit");int ni,ng;in>>ni>>ng;if(ni!=14)throw std::runtime_error("input count");std::vector<Gate>g(ng);for(auto&x:g)in>>x.op>>x.a>>x.b;int no;in>>no;std::map<std::string,std::vector<int>>outs;for(int i=0;i<no;++i){std::string n;int nn;in>>n>>nn;auto&v=outs[n];v.resize(nn);for(int&j:v)in>>j;}if(!in)throw std::runtime_error("bad circuit format");
 std::mt19937_64 rng(20260926);K z=zeta();uint64_t checks=0;
 std::vector<K>val(ng);std::array<K,14>inputs;
 for(int trial=0;trial<1000;++trial){IX qi,hi;qi[0]=0;int qph1=1+rng()%28,qph2;do{qph2=1+rng()%28;}while(qph2==qph1);qi[1]=4*qph1+rng()%4;qi[2]=4*qph2+rng()%4;qi[3]=rng()%116;
  int hph0=rng()%29,hph1,hph2;do{hph1=rng()%29;}while(hph1==hph0);do{hph2=rng()%29;}while(hph2==hph0||hph2==hph1);hi={int(4*hph0+rng()%4),int(4*hph1+rng()%4),int(4*hph2+rng()%4),int(rng()%116)};
  for(int i=0;i<3;++i){inputs[i]=z.pow(qi[i+1]/4);inputs[3+i]=K(1);for(int j=0;j<qi[i+1]%4;++j)inputs[3+i]=inputs[3+i]*K(2);}
  for(int i=0;i<4;++i){inputs[6+i]=z.pow(hi[i]/4);inputs[10+i]=K(1);for(int j=0;j<hi[i]%4;++j)inputs[10+i]=inputs[10+i]*K(2);}
  for(int i=0;i<ng;++i){auto x=g[i];if(x.op=='i')val[i]=inputs.at(x.a);else if(x.op=='c')val[i]=K::code(x.a);else{if(x.a>=i||x.b>=i||x.a<0||x.b<0)throw std::runtime_error("not a DAG");if(x.op=='+')val[i]=val[x.a]+val[x.b];else if(x.op=='*')val[i]=val[x.a]*val[x.b];else throw std::runtime_error("gate operation");}}
  auto get=[&](std::string n){return val.at(outs.at(n).at(0));};auto getf=[&](std::string n){F r;const auto&v=outs.at(n);if(v.size()!=4)throw std::runtime_error("vector size");for(int i=0;i<4;++i)r.c[i]=val.at(v[i]);return r;};
  EP Q=ep(qi),H=ep(hi);F A=Q.E,B=Q.C,C=H.C,D=H.E,W=A*D-B*C;Generic r=first_residual(A,B,C,D,W);if(!r.nonsingular)continue;second_residual(r,A,B,C,D,W);auto[x,y]=moments(r);
  if(get("delta_C")!=K(r.dy,0)||get("delta_E")!=K(r.dx,0)||get("d")!=K(r.den,0)||get("Y")!=r.Y||get("X")!=r.X||get("Z")!=r.Z||get("T")!=r.T)throw std::runtime_error("scalar circuit mismatch");
  F eps=(D-F(x))/(B-F(y)),G=getf("G");K E=get("E");if(E.zero()||G.times(E.inverse())!=eps)throw std::runtime_error("epsilon circuit mismatch");
  auto qs=endpoint(qi),hs=endpoint(hi);F eq3=eps*(qs[2]-F(x.frob(4)))+qs[3]+F(y.frob(8));F eq4=hs[2]+eps*(hs[3]+F(y.frob(1)))-F(x.frob(11));
  K m3=get("eq3_multiplier"),m4=get("eq4_multiplier");if(m3.zero()||m4.zero()||getf("eq3_cleared")!=eq3.times(m3)||getf("eq4_cleared")!=eq4.times(m4))throw std::runtime_error("full trace circuit mismatch");
  if(get("phase_unit").zero())throw std::runtime_error("phase ordering unit");
  bool cp=(!get("unit_patch_0").zero()||!get("unit_patch_2").zero());bool ep=!eps.c[3].zero()&&(!eps.c[0].zero()||!eps.c[2].zero());if(cp!=ep)throw std::runtime_error("oriented patch coverage mismatch");
  if(trial<12){std::cout<<"{\"kind\":\"circuit_sample_not_solution\",\"Q_ordered\":";print_ix(qi,std::cout);std::cout<<",\"H_ordered\":";print_ix(hi,std::cout);std::cout<<",\"X\":";pk(r.X);std::cout<<",\"Y\":";pk(r.Y);std::cout<<",\"Z\":";pk(r.Z);std::cout<<",\"T\":";pk(r.T);std::cout<<",\"G\":";pf(G);std::cout<<",\"E\":";pk(E);std::cout<<",\"eq3_cleared\":";pf(getf("eq3_cleared"));std::cout<<",\"eq4_cleared\":";pf(getf("eq4_cleared"));std::cout<<"}\n";}
  ++checks;
 }
 std::cerr<<"{\"status\":\"PASS\",\"circuit_root_inputs\":"<<ni<<",\"circuit_gates\":"<<ng<<",\"deterministic_full_trace_circuit_tests\":"<<checks<<",\"samples_are_solutions\":false,\"solver_executed\":false}\n";
}
