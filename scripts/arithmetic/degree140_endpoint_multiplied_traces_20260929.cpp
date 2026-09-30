#include "degree140_endpoint_multiplied_traces_20260929.hpp"
int main(int argc,char**argv){try{
 if(argc<5||argc>7)throw std::runtime_error("usage: multiplied_traces FIELD FAMILY H W [CAP] [CHECK_NEW_FORMULA]");
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);infinitytrace::CAP=argc>=6?std::stoi(argv[5]):240;
 auto h=std::stoi(argv[3]),w=std::stoi(argv[4]);auto start=std::chrono::steady_clock::now();auto out=multipliedtrace::profiles(h,w);
 bool checked=false;if(argc==7&&std::stoi(argv[6])){
  auto d=criticaltrace::data(h,w);for(int ell=1;ell<=16;ell++){
   auto ff=criticaltrace::fibre(d,ell);auto tv=criticaltrace::times(criticaltrace::T,ff.v,ff.R);
   for(int j=0;j<3;j++)if(exact::eval(out[j],ell)!=criticaltrace::trace(tv,ff.ts,j))throw std::runtime_error("new multiplied trace formula disagrees with finite algebra");
  }checked=true;
 }
 std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"cap\":"<<infinitytrace::CAP<<",\"profiles\":[";
 for(int j=0;j<3;j++){if(j)std::cout<<',';exact::jsonpoly(std::cout,out[j]);}
 auto expected=exact::mul(criticaltrace::EPS,exact::power(exact::neg(exact::mul(246025,exact::power(h,3))),-12));
 if(out[2].deg()!=13||out[2].back()!=expected)throw std::runtime_error("degree13 leading unit mismatch");
 std::cout<<"],\"new_formula_checked\":"<<(checked?"true":"false")<<",\"degree13_leading_unit\":"<<expected<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
