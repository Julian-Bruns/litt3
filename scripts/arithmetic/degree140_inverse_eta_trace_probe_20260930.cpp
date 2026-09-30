// New conceptual probe: Tr(f*delta(Lambda)/eta), f=1,x,x^2.
// Direct degree140 algebra only. The inferred degree is checked at
// additional scales; these point tests are not a universal proof.
#include "degree140_trace_engine_20260929.hpp"
int main(int argc,char**argv){try{
 if(argc!=5)throw std::runtime_error("usage: inverse_eta_probe FIELD FAMILY H W");
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);
 exact::F h=std::stoi(argv[3]),w=std::stoi(argv[4]);auto d=criticaltrace::data(h,w);
 std::vector<exact::F> xs;std::array<std::vector<exact::F>,3> ys;
 for(exact::F ell=1;ell<390625&&xs.size()<10;ell++){
  try{
   auto f=criticaltrace::fibre(d,ell);
   auto Eell=exact::cadd(d.ds[1],exact::cscale(d.ds[2],exact::mul(2,ell)));
   auto etainv=criticaltrace::times(criticaltrace::evaluate_curve(d.B,f.Y,f.R),criticaltrace::inverse_mod(criticaltrace::evaluate_curve(Eell,f.Y,f.R),f.R),f.R);
   auto v=criticaltrace::times(f.v,criticaltrace::times(etainv,etainv,f.R),f.R);
   xs.push_back(ell);for(int j=0;j<3;j++)ys[j].push_back(criticaltrace::trace(v,f.ts,j));
  }catch(const std::exception&e){if(std::string(e.what())!="bad projection fibre")throw;}
 }
 std::cout<<"{\"scope\":\"fixed-ratio inverse-eta degree probe\",\"h\":"<<h<<",\"w\":"<<w<<",\"scale_count\":"<<xs.size()<<",\"profiles\":[";
 for(int j=0;j<3;j++){if(j)std::cout<<',';auto p=criticaltrace::interpolate(xs,ys[j]);exact::jsonpoly(std::cout,p);}
 std::cout<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
