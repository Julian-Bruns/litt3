#include "degree140_inverse_eta_multiplied_20260930.hpp"
int main(int argc,char**argv){try{
 if(argc!=5)throw std::runtime_error("usage: inverse_eta_multiplied FIELD FAMILY H W");
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);
 exact::F h=std::stoi(argv[3]),w=std::stoi(argv[4]);
 infinitytrace::CAP=480;endpointtrace::CAP=40;
 auto start=std::chrono::steady_clock::now();
 auto out=inverseetamultiplied::profiles(h,w);
 auto d=criticaltrace::data(h,w);int checked=0;
 for(exact::F ell=1;ell<390625&&checked<3;ell++){
  try{
   auto f=criticaltrace::fibre(d,ell);
   auto Eell=exact::cadd(d.ds[1],exact::cscale(d.ds[2],exact::mul(2,ell)));
   auto etainv=criticaltrace::times(criticaltrace::evaluate_curve(d.B,f.Y,f.R),criticaltrace::inverse_mod(criticaltrace::evaluate_curve(Eell,f.Y,f.R),f.R),f.R);
   auto v=criticaltrace::times(criticaltrace::times(f.v,criticaltrace::times(etainv,etainv,f.R),f.R),criticaltrace::T,f.R);
   for(int j=0;j<3;j++){
    auto actual=criticaltrace::trace(v,f.ts,j);auto prediction=exact::eval(out[j],ell);
    if(actual!=prediction){std::cerr<<"mismatch "<<ell<<' '<<j<<' '<<actual<<' '<<prediction<<'\n';return 2;}
   }
   checked++;
  }catch(const std::exception&e){if(std::string(e.what())!="bad projection fibre")throw;}
 }
 if(checked!=3)throw std::runtime_error("insufficient direct fibres");
 std::cout<<"{\"scope\":\"new endpoint-cleared inverse-eta traces at one ratio\",\"h\":"<<h<<",\"w\":"<<w<<",\"profiles\":[";
 for(int j=0;j<3;j++){if(j)std::cout<<',';exact::jsonpoly(std::cout,out[j]);}
 std::cout<<"],\"direct_checks\":"<<checked*3<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
