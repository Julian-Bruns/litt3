// Full new actual-splitting traces, with a direct finite-algebra check.
// One thread; does not rerun any incoming verifier.
#include "degree140_low_trace_infinity_20260929.hpp"
#include "degree140_endpoint_trace_native_20260929.hpp"
int main(int argc,char**argv){try{
 if(argc!=6)throw std::runtime_error("usage: actual_profiles FIELD FAMILY H W CAP");
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);
 exact::F h=std::stoi(argv[3]),w=std::stoi(argv[4]);
 infinitytrace::CAP=std::stoi(argv[5]);endpointtrace::CAP=40;
 auto start=std::chrono::steady_clock::now();
 auto out=lowtrace::profiles(h,w,{{0,0},{1,0},{2,0}},false);
 auto ep=endpointtrace::correction(h,w,exact::Poly{1},true,false);
 for(int t=0;t<2;t++)for(int j=0;j<3;j++){
  out[t][j].resize(std::max(out[t][j].size(),size_t(t?6:3)));
  for(int n=0;n<(t?6:3);n++)out[t][j][n]=exact::add(out[t][j][n],ep[t][n][j]);
  out[t][j].trim();
 }
 auto d=criticaltrace::data(h,w);int checked=0;
 for(exact::F ell=1;ell<390625&&checked<3;ell++){
  try{
   auto f=criticaltrace::fibre(d,ell);
   auto E=exact::cadd(exact::cadd(d.ds[0],exact::cscale(d.ds[1],ell)),exact::cscale(d.ds[2],exact::power(ell,2)));
   auto Eell=exact::cadd(d.ds[1],exact::cscale(d.ds[2],exact::mul(2,ell)));
   auto v=exact::scale(criticaltrace::times(criticaltrace::evaluate_curve(criticaltrace::delta(E),f.Y,f.R),criticaltrace::inverse_mod(criticaltrace::evaluate_curve(Eell,f.Y,f.R),f.R),f.R),4);
   auto q=criticaltrace::times(v,criticaltrace::inverse_mod(f.phi,f.R),f.R);
   for(int t=0;t<2;t++)for(int j=0;j<3;j++){
    auto actual=criticaltrace::trace(t?q:v,f.ts,j);
    auto prediction=exact::eval(out[t][j],ell);
    if(actual!=prediction){std::cerr<<"mismatch "<<ell<<' '<<t<<' '<<j<<' '<<actual<<' '<<prediction<<'\n';return 2;}
   }
   checked++;
  }catch(const std::exception&e){if(std::string(e.what())!="bad projection fibre")throw;}
 }
 if(checked!=3)throw std::runtime_error("insufficient direct fibres");
 std::cout<<"{\"scope\":\"new actual-splitting traces at one ratio\",\"h\":"<<h<<",\"w\":"<<w<<",\"cap\":"<<infinitytrace::CAP<<",\"profiles\":[";
 for(int t=0;t<2;t++){if(t)std::cout<<',';std::cout<<'[';for(int j=0;j<3;j++){if(j)std::cout<<',';exact::jsonpoly(std::cout,out[t][j]);}std::cout<<']';}
 std::cout<<"],\"direct_checks\":"<<checked*6<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
