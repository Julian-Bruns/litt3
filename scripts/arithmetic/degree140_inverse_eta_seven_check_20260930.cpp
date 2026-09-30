#include "degree140_inverse_eta_short_20260930.hpp"
int main(int argc,char**argv){try{
 if(argc!=5)throw std::runtime_error("usage: inverse_eta_short FIELD FAMILY H W");
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);
 exact::F h=std::stoi(argv[3]),w=std::stoi(argv[4]);infinitytrace::CAP=160;
 auto start=std::chrono::steady_clock::now();std::vector<std::pair<int,int>> fs{{0,0},{1,0},{2,0},{3,0},{0,1},{4,0},{1,1}};auto out=inverseetashort::profiles_many(h,w,fs);
 auto d=criticaltrace::data(h,w);int checked=0;
 for(exact::F ell=1;ell<390625&&checked<7;ell++){
  try{
   auto f=criticaltrace::fibre(d,ell);
   auto Eell=exact::cadd(d.ds[1],exact::cscale(d.ds[2],exact::mul(2,ell)));
   auto etainv=criticaltrace::times(criticaltrace::evaluate_curve(d.B,f.Y,f.R),criticaltrace::inverse_mod(criticaltrace::evaluate_curve(Eell,f.Y,f.R),f.R),f.R);
   auto v=criticaltrace::times(criticaltrace::times(f.v,criticaltrace::times(etainv,etainv,f.R),f.R),criticaltrace::T,f.R);
   for(int j=0;j<7;j++){auto z=criticaltrace::times(v,(fs[j].second?f.Y:exact::Poly{1}),f.R);z=criticaltrace::times(z,exact::ppow(exact::Poly{0,1},fs[j].first),f.R);auto actual=criticaltrace::trace(z,f.ts),pred=exact::eval(out[j],ell);if(actual!=pred){std::cerr<<"mismatch "<<ell<<' '<<j<<' '<<actual<<' '<<pred<<'\n';throw std::runtime_error("new seven-trace mismatch");}}
   checked++;
  }catch(const std::exception&e){if(std::string(e.what())!="bad projection fibre")throw;}
 }
 if(checked!=7)throw std::runtime_error("insufficient direct fibres");
 std::cout<<"{\"scope\":\"new short-coordinate inverse-eta formula at one ratio\",\"h\":"<<h<<",\"w\":"<<w<<",\"profiles\":[";
 for(int j=0;j<7;j++){if(j)std::cout<<',';exact::jsonpoly(std::cout,out[j]);}
 std::cout<<"],\"direct_checks\":"<<checked*7<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
