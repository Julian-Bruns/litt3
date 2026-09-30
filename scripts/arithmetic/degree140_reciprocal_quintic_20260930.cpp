// New degree-five reciprocal traces, using only local residues.
// This source constructs sample polynomials, not a parameter-locus proof.
#include "degree140_infinity_trace_20260929.hpp"
#include "degree140_endpoint_trace_native_20260929.hpp"
using namespace infinitytrace;

std::array<Poly,3> reciprocal_profiles(F h,F w){
 auto e=expand(h,w,true);std::array<Poly,3> out{Poly(6),Poly(6),Poly(6)};
 // Above degree two only the two infinities and fixed endpoint branches
 // contribute. Lower terms additionally require the proper-pole correction.
 auto ec=endpointtrace::correction(h,w);
 for(int n=3;n<=5;n++)for(int j=0;j<3;j++)out[j][n]=ec[1][n][j];
 for(auto&b:e.branches){
  S base=times(times(times(b.eta,inverse(b.phi)),pow(deriv(b.lambda),2)),e.delta_factor);
  for(int n=3;n<=5;n++){
   S om=times(base,pow(b.lambda,-n-1));
   for(int j=0;j<3;j++)out[j][n]=sub(out[j][n],om.at(3*j-1));
  }
 }
 return out;
}
int main(int argc,char**argv){try{
 if(argc!=3)throw std::runtime_error("usage: reciprocal_quintic FIELD FAMILY");
 loadfield(argv[1]);load(argv[2]);infinitytrace::CAP=160;endpointtrace::CAP=36;
 std::cout<<"{\"scope\":\"new top-three reciprocal coefficients\",\"rows\":[";bool first=true;
 for(F h:std::array<F,3>{2,5,17})for(F w:std::array<F,3>{3,7,11}){
  auto p=reciprocal_profiles(h,w);
  // The tempting fixed-endpoint expression <93413>*w omits the fourth
  // power of the moving Lambda pole coefficient. It is NOT the actual
  // degree-five coefficient; retain the full local correction here.
  if(!first)std::cout<<',';first=false;
  std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"coeff\":[";
  for(int j=0;j<3;j++){if(j)std::cout<<',';std::cout<<'[';for(int n=3;n<=5;n++){if(n>3)std::cout<<',';std::cout<<p[j][n];}std::cout<<']';}
  std::cout<<"]}";
 }
 std::cout<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
