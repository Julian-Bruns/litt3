#include "degree140_infinity_trace_20260929.hpp"
int main(int argc,char**argv){try{
 if(argc<7){std::cerr<<"usage: infinity_trace FIELD FAMILY W H_START H_END PRECISION\n";return 2;}
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);infinitytrace::CAP=std::stoi(argv[6]);int w=std::stoi(argv[3]);
 for(int h=std::stoi(argv[4]);h<std::stoi(argv[5]);h++){
  auto start=std::chrono::steady_clock::now();
  try{auto out=infinitytrace::profiles(h,w);std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"polynomials\":[";for(int i=0;i<3;i++){if(i)std::cout<<',';exact::jsonpoly(std::cout,out[i]);}std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";}
  catch(const std::exception&e){std::cout<<"{\"h\":"<<h<<",\"error\":\""<<e.what()<<"\"}\n";}
  std::cout.flush();
 }
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
