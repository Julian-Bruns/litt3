// Six smallest regular multipliers: 1,x,x^2,x^3,y,x^4.
#include "degree140_low_trace_infinity_20260929.hpp"
#include "degree140_endpoint_trace_native_20260929.hpp"
int main(int argc,char**argv){try{
 if(argc!=5)throw std::runtime_error("usage: actual_six FIELD FAMILY H W");
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);
 exact::F h=std::stoi(argv[3]),w=std::stoi(argv[4]);
 infinitytrace::CAP=480;endpointtrace::CAP=40;
 auto start=std::chrono::steady_clock::now();
 std::vector<std::pair<int,int>> fs{{0,0},{1,0},{2,0},{3,0},{0,1},{4,0}};
 auto out=lowtrace::profiles(h,w,fs,false);
 auto e0=endpointtrace::correction(h,w,exact::Poly{1},true,false);
 auto e2=endpointtrace::correction(h,w,exact::Poly{0,0,1},true,false);
 auto ey=endpointtrace::correction(h,w,exact::Poly{1},true,false,1);
 for(int t=0;t<2;t++)for(int j=0;j<6;j++){
  out[t][j].resize(std::max(out[t][j].size(),size_t(t?6:3)));
  for(int n=0;n<(t?6:3);n++){
   exact::F z=j<3?e0[t][n][j]:j==3?e2[t][n][1]:j==4?ey[t][n][0]:e2[t][n][2];
   out[t][j][n]=exact::add(out[t][j][n],z);
  }
  out[t][j].trim();
 }
 if(out[0][5].deg()>7)throw std::runtime_error("predicted degree-eight cancellation failed");
 auto d=criticaltrace::data(h,w);int checked=0;
 for(exact::F ell=1;ell<390625&&checked<2;ell++){
  try{
   auto f=criticaltrace::fibre(d,ell);
   auto E=exact::cadd(exact::cadd(d.ds[0],exact::cscale(d.ds[1],ell)),exact::cscale(d.ds[2],exact::power(ell,2)));
   auto Eell=exact::cadd(d.ds[1],exact::cscale(d.ds[2],exact::mul(2,ell)));
   auto v=exact::scale(criticaltrace::times(criticaltrace::evaluate_curve(criticaltrace::delta(E),f.Y,f.R),criticaltrace::inverse_mod(criticaltrace::evaluate_curve(Eell,f.Y,f.R),f.R),f.R),4);
   auto q=criticaltrace::times(v,criticaltrace::inverse_mod(f.phi,f.R),f.R);
   for(int t=0;t<2;t++)for(int j=0;j<6;j++){
    auto [ix,iy]=fs[j];auto mult=iy?f.Y:exact::ppow(exact::Poly{0,1},ix);
    auto actual=criticaltrace::trace(criticaltrace::times(t?q:v,mult,f.R),f.ts);
    auto prediction=exact::eval(out[t][j],ell);
    if(actual!=prediction){std::cerr<<"mismatch "<<ell<<' '<<t<<' '<<j<<' '<<actual<<' '<<prediction<<'\n';return 2;}
   }
   checked++;
  }catch(const std::exception&e){if(std::string(e.what())!="bad projection fibre")throw;}
 }
 if(checked!=2)throw std::runtime_error("insufficient direct fibres");
 std::cout<<"{\"scope\":\"six new actual-splitting traces at one ratio\",\"h\":"<<h<<",\"w\":"<<w<<",\"multipliers\":[\"1\",\"x\",\"x^2\",\"x^3\",\"y\",\"x^4\"],\"profiles\":[";
 for(int t=0;t<2;t++){if(t)std::cout<<',';std::cout<<'[';for(int j=0;j<6;j++){if(j)std::cout<<',';exact::jsonpoly(std::cout,out[t][j]);}std::cout<<']';}
 std::cout<<"],\"direct_checks\":"<<checked*12<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
