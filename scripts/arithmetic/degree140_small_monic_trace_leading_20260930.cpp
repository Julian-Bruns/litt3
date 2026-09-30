// New low-degree trace leading terms. Only infinity residues above the
// finite-endpoint degree bound are used for the monic degree-seven test.
#include "degree140_infinity_trace_20260929.hpp"
#include <map>
using namespace infinitytrace;

std::array<F,3> endpoint_degree_five(F h,F w){
 auto g=evaluate(h,w);Poly l{18,20,20,15};
 Poly b0=g[1][0]-scale(l*g[0][0],3);
 Poly pi=xgcd(baseP,T)[1],u=pdivide(Q-frob5(l),ppow(T,3));
 Poly a=criticaltrace::rem(derivative(T)*ppow(u,7)*b0*ppow(pi,12),T);
 auto ns=newton(T);std::array<F,3> out{};
 for(int j=0;j<3;j++){out[j]=mul(4,trace(a,ns));a=criticaltrace::rem(a*Poly{0,1},T);}
 return out;
}
int main(int argc,char**argv){try{
 if(argc!=3)throw std::runtime_error("usage: small_monic FIELD_DIRECTORY FAMILY_TEXT");
  loadfield(argv[1]);load(argv[2]);CAP=160;
 std::array<std::map<std::pair<int,int>,F>,3> epcoeff;
 Poly l{18,20,20,15}, pi=xgcd(baseP,T)[1], uu=pdivide(Q-frob5(l),ppow(T,3));
 Poly pref=criticaltrace::rem(derivative(T)*ppow(uu,7)*ppow(pi,12),T);
 auto ns=newton(T);
 for(int k=0;k<2;k++)for(const auto&t:family[k])if(t.j==0){
  Poly monomial(t.i+1);monomial[t.i]=t.c;
  Poly term=criticaltrace::rem(pref*monomial*(k?Poly{1}:scale(l,2)),T);
  for(int j=0;j<3;j++){
   auto key=std::make_pair(t.h,t.w);
   epcoeff[j][key]=add(epcoeff[j][key],mul(4,trace(term,ns)));
   term=criticaltrace::rem(term*Poly{0,1},T);
  }
 }
 F c7=mul(3,mul(103636,mul(power(246025,2),power(EPS,-5))));
 std::cout<<"{\"C7\":"<<c7<<",\"naive_endpoint5_numerators_omit_moving_K4\":[";
 for(int j=0;j<3;j++){
  if(j)std::cout<<',';std::cout<<'[';bool firstterm=true;
  for(auto &[key,c]:epcoeff[j])if(c){if(!firstterm)std::cout<<',';firstterm=false;std::cout<<'['<<key.first<<','<<key.second<<','<<c<<']';}
  std::cout<<']';
 }
 std::cout<<"],\"samples\":[";bool first=true;
 for(F h:std::array<F,3>{2,5,17})for(F w:std::array<F,3>{3,7,11}){
  auto e=expand(h,w,true);S tt=polynomial(T);std::array<F,3> highest{},q5{};
  for(auto&b:e.branches){
   S common=times(times(times(b.eta,inverse(b.phi)),pow(deriv(b.lambda),2)),e.delta_factor);
   for(int j=0;j<3;j++){
    int n=6+j;S om=times(times(common,pow(b.lambda,-n-1)),tt);
    highest[j]=sub(highest[j],om.at(3*j-1));
    S base=times(common,pow(b.lambda,-6));q5[j]=sub(q5[j],base.at(3*j-1));
   }
  }
  F predicted=mul(c7,mul(w,power(h,-13)));
  if(highest[1]!=predicted)throw std::runtime_error("degree-seven leading identity failed");
  auto ec=endpoint_degree_five(h,w);for(int j=0;j<3;j++)q5[j]=add(q5[j],ec[j]);
  if(!first)std::cout<<',';first=false;
  std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"tQ_leading\":["<<highest[0]<<','<<highest[1]<<','<<highest[2]
           <<"],\"Q_degree5\":["<<q5[0]<<','<<q5[1]<<','<<q5[2]<<"],\"endpoint_degree5\":["<<ec[0]<<','<<ec[1]<<','<<ec[2]<<"]}";
 }
 std::cout<<"],\"scope\":\"new leading formula fixtures, not a geometric locus decision\"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
