#include "degree140_trace_engine_20260929.hpp"
using namespace criticaltrace;
int main(int argc,char**argv){try{
 if(argc!=7){std::cerr<<"usage: positive_profiles FIELD_DATA FAMILY_TEXT M W H_START H_END\n";return 2;}
 loadfield(argv[1]);load(argv[2]);int m=std::stoi(argv[3]);F w=std::stoi(argv[4]);
 for(int h=std::stoi(argv[5]);h<std::stoi(argv[6]);h++){
  auto start=std::chrono::steady_clock::now();
  try{
   auto ps=positive_profile(h,w,m);
   std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"multiplier\":"<<m<<",\"polynomials\":[";
   for(int i=0;i<3;i++){if(i)std::cout<<',';jsonpoly(std::cout,ps[i]);}
   std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
  }catch(const std::exception&e){std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"not_computed\":\""<<e.what()<<"\"}\n";}
  std::cout.flush();
 }
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
