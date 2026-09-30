#include "degree140_companion_multiplied_traces_20260930.hpp"
#include <chrono>
int main(int argc,char**argv){try{
 if(argc<5){std::cerr<<"usage: companion_trace FIELD FAMILY H W [PRECISION]\n";return 2;}
 loadfield(argv[1]);criticaltrace::load(argv[2]);
 exact::F h=std::stoi(argv[3]),w=std::stoi(argv[4]);
 if(argc>5)infinitytrace::CAP=std::stoi(argv[5]);
 auto start=std::chrono::steady_clock::now();
 auto v=companionmultiplied::profiles(h,w);
 std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"precision\":"<<infinitytrace::CAP<<",\"polynomials\":[";
 for(int j=0;j<3;j++){if(j)std::cout<<',';exact::jsonpoly(std::cout,v[j]);}
 auto cc=companionmultiplied::coordinate_constants(h,w);
 std::cout<<"],\"coordinate_constants\":["<<cc[0]<<','<<cc[1]<<','<<cc[2]<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();
#ifdef CHECK_NEW_FORMULA
 auto d=criticaltrace::data(h,w);int checked=0;
 for(exact::F ell=0;checked<16;ell++){
  try{
   auto f=criticaltrace::fibre(d,ell);
   auto val=criticaltrace::times(f.v,criticaltrace::inverse_mod(f.phi,f.R),f.R);
   val=criticaltrace::times(val,exact::ppow(criticaltrace::T,4),f.R);
   for(int j=0;j<3;j++)if(criticaltrace::trace(val,f.ts,j)!=exact::eval(v[j],ell)){
    auto pred=exact::eval(v[j],ell),actual=criticaltrace::trace(val,f.ts,j);
    std::cerr<<"mismatch ell="<<ell<<" j="<<j<<" predicted="<<pred<<" actual="<<actual<<" coordinate="<<cc[j]<<" actual correction ratio="<<(cc[j]?exact::divide(exact::sub(exact::add(pred,cc[j]),actual),cc[j]):0)<<'\n';return 3;
   }
   checked++;
  }catch(const std::exception&e){if(std::string(e.what())!="bad projection fibre")throw;}
 }
 std::cout<<",\"independent_scale_evaluations\":"<<checked;
#endif
 std::cout<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
