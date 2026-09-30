#define main companion_main
#include "companion.cpp"
#undef main
#include "polynomial_tools.hpp"
#include <omp.h>
struct Place {int pole;FP f,phi;int kind;}; // 0 split, 1 inert, 2 ramified
int main(int argc,char**argv){try{
 assert(argc==5);init(argv[1]);setup_rational();FastK::init();std::string input=argv[2],output=argv[3];omp_set_num_threads(std::stoi(argv[4]));
 auto z=readjson(input);std::array<Poly<Rat>,3>t;for(int i=0;i<3;i++)t[i]=ratpoly(z.get_child("C"+std::to_string(i+71)));assert(t[0].deg()==53&&t[1].deg()==54&&t[2].deg()==54);z.clear();
 std::vector<Place>places;auto S0=frow(BOUNDARY.get_child("s_numerator_constant"));
 for(int k=0;k<5;k++)for(auto&f:factor_squarefree(Rat::factors[k])){
  FP cv=mod_fast(Rat::CC,f),phi;int kind=0;
  if(!cv){assert(mod_fast(derivative(Rat::CC),f));kind=2;}
  else if(k==0||k==2)phi=mod_fast(getrow("c"),f);
  else if(k==3)phi=mod_fast(getrow("c").scale(F(3)),f);
  else if(k==4){auto[g,v,w]=xgcd(cv,f);assert(g==FP(1));phi=mod_fast(S0*v,f);}
  else {assert(f.deg()==1&&cv.deg()==0);if(F::logs[cv[0].v]%2)kind=1;else phi=FP(F(F::exps[F::logs[cv[0].v]/2]));}
  if(kind==0)assert(!mod_fast(phi*phi-Rat::CC,f));places.push_back({k,f,phi,kind});
 }
 int maxnorm=0;for(auto&p:t)for(auto&r:p.c)maxnorm=std::max(maxnorm,std::max(2*r.a.deg(),2*r.b.deg()+14));
 std::vector<Valuation>vs;for(auto&p:places){vs.emplace_back(p.f);vs.back().prepare(maxnorm);}
 // All binary-power caches are now immutable during the parallel loop.
 std::array<std::vector<std::array<std::vector<int>,2>>,3>val;
 std::array<std::array<std::vector<int>,2>,3>infty;
 std::array<std::array<int,5>,3>den{};
 for(int n=0;n<3;n++){val[n].resize(places.size());for(auto&v:val[n])for(auto&w:v)w.resize(t[n].deg()+1,100000000);for(auto&w:infty[n])w.resize(t[n].deg()+1,100000000);for(auto&r:t[n].c)for(int k=0;k<5;k++)den[n][k]=std::max(den[n][k],r.den[k]);}
 F lc=Rat::CC.c.back(),lroot;bool infsplit=F::logs[lc.v]%2==0;if(infsplit)lroot=F(F::exps[F::logs[lc.v]/2]);
 auto start=std::chrono::steady_clock::now();std::vector<std::pair<int,int>>tasks;for(int n=0;n<3;n++)for(int i=0;i<=t[n].deg();i++)tasks.emplace_back(n,i);
 #pragma omp parallel for schedule(dynamic,1)
 for(int idx=0;idx<(int)tasks.size();idx++){
  auto[n,i]=tasks[idx];const Rat&r=t[n].c[i];if(!r)continue;FP norm=r.a*r.a-r.b*r.b*Rat::CC;assert(norm);
  int da=r.a.deg(),db=r.b? r.b.deg()+7:-100000000,w=std::max(da,db),dd=0;for(int k=0;k<5;k++)dd+=r.den[k]*Rat::factors[k].deg();
  int dp=w,dm=w;if(da==db&&infsplit){F plus=r.a.c.back()+r.b.c.back()*lroot;if(!plus)dp=norm.deg()-w;else dm=norm.deg()-w;assert(dp+dm==norm.deg());}else assert(norm.deg()==2*w);
  infty[n][0][i]=dd-dp;infty[n][1][i]=dd-dm;
  for(int j=0;j<(int)places.size();j++){
   const auto&p=places[j];auto[oa,qa]=vs[j].remove(r.a);auto[ob,qb]=vs[j].remove(r.b);int h=std::min(oa,ob),nv=vs[j].order(norm),k=r.den[p.pole];
   if(p.kind==2){assert(nv==std::min(2*oa,2*ob+1));val[n][j][0][i]=nv-2*k;continue;}
   int va=h,vb=h;
   if(p.kind==1)assert(nv==2*h);
   else if(nv>2*h){assert(oa==ob);auto plus=mod_fast(qa+qb*p.phi,p.f);auto minus=mod_fast(qa-qb*p.phi,p.f);assert(bool(plus)!=bool(minus));if(!plus)va=nv-h;else vb=nv-h;}
   else assert(nv==2*h);
   val[n][j][0][i]=va-k;val[n][j][1][i]=vb-k;
  }
  if(idx%10==0){
   #pragma omp critical
   std::cout<<"{\"tail_coefficient_valuations_completed\":"<<idx<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
  }
 }
 std::array<std::vector<long long>,2>bounds;std::array<long long,2>infb,degree;
 for(int j=0;j<2;j++){
  int oth=j+1;infb[j]=0;for(int s=0;s<2;s++)infb[j]+=resultant_lower_valuation(infty[0][s],infty[oth][s]);degree[j]=-infb[j];
  for(int k=0;k<(int)places.size();k++){long long v=0;for(int s=0;s<(places[k].kind==2?1:2);s++)v+=resultant_lower_valuation(val[0][k][s],val[oth][k][s]);bounds[j].push_back(v);degree[j]-=v*places[k].f.deg();}
  std::cout<<"{\"pair\":[71,"<<72+j<<"],\"projected_polynomial_degree_bound\":"<<degree[j]<<",\"infinity_valuation_lower\":"<<infb[j]<<",\"finite_norm_valuation_lower\":[";for(int k=0;k<(int)places.size();k++){if(k)std::cout<<',';std::cout<<bounds[j][k];}std::cout<<"]}"<<std::endl;
 }
 std::ofstream o(output);o<<"{\"tail_mu_degrees\":[53,54,54],\"common_denominators\":[";for(int n=0;n<3;n++){if(n)o<<',';o<<'[';for(int k=0;k<5;k++){if(k)o<<',';o<<den[n][k];}o<<']';}o<<"],\"places\":[";
 for(int j=0;j<(int)places.size();j++){if(j)o<<',';auto&p=places[j];o<<"{\"pole_index\":"<<p.pole<<",\"modulus\":";json(o,p.f);o<<",\"kind\":"<<p.kind<<",\"xi_residue\":";json(o,p.phi);o<<",\"coefficient_valuations\":[";for(int n=0;n<3;n++){if(n)o<<',';o<<'[';for(int s=0;s<2;s++){if(s)o<<',';o<<'[';for(int i=0;i<=t[n].deg();i++){if(i)o<<',';o<<val[n][j][s][i];}o<<']';}o<<']';}o<<"],\"norm_resultant_valuation_bounds\":["<<bounds[0][j]<<','<<bounds[1][j]<<"]}";}
 o<<"],\"infinity_coefficient_valuations\":[";for(int n=0;n<3;n++){if(n)o<<',';o<<'[';for(int s=0;s<2;s++){if(s)o<<',';o<<'[';for(int i=0;i<=t[n].deg();i++){if(i)o<<',';o<<infty[n][s][i];}o<<']';}o<<']';}o<<"],\"infinity_valuation_bounds\":["<<infb[0]<<','<<infb[1]<<"],\"projected_degree_bounds\":["<<degree[0]<<','<<degree[1]<<"]}\n";
 std::cout<<"{\"projection_bounds\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
 }catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<std::endl;return 1;}}
