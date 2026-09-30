// New reciprocal degree-six leading coefficients for x^3 and y.
// Finite branches contribute only through degree five. Thus these are
// actual leading coefficients, obtained solely from infinity residues.
#include "degree140_infinity_trace_20260929.hpp"
using namespace infinitytrace;

std::array<F,2> leading6(F h,F w){
 auto e=expand(h,w,true);std::array<F,2> out{};
 for(auto&b:e.branches){
  S base=times(times(times(b.eta,inverse(b.phi)),pow(deriv(b.lambda),2)),e.delta_factor);
  S om=times(base,pow(b.lambda,-7));
  out[0]=sub(out[0],om.at(8)); // multiply x^3=xi^-9
  out[1]=sub(out[1],times(om,e.y).at(-1));
 }
 return out;
}
int main(int argc,char**argv){try{
 if(argc!=3)throw std::runtime_error("usage: degree_six_leading FIELD FAMILY");
 loadfield(argv[1]);load(argv[2]);CAP=128;
 std::cout<<"{\"scope\":\"new reciprocal leading-six fixtures; no zero-locus decision\",\"rows\":[";bool first=true;
 for(F h:std::array<F,5>{1,2,5,17,31})for(F w:std::array<F,5>{2,3,7,11,19}){
  auto a=leading6(h,w);
  if(!first)std::cout<<',';first=false;
  std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"x3\":"<<a[0]<<",\"y\":"<<a[1]<<"}";
 }
 std::cout<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
