#include "degree140_trace_engine_20260929.hpp"
using namespace criticaltrace;
int main(int argc,char**argv){try{
 if(argc!=6){std::cerr<<"usage: trace_profiles FIELD_DATA FAMILY_TEXT W H_START H_END\n";return 2;}
 loadfield(argv[1]);load(argv[2]);F w=std::stoi(argv[3]);int start=std::stoi(argv[4]),end=std::stoi(argv[5]);
 for(int h=start;h<end;h++){
  auto began=std::chrono::steady_clock::now();
  try{auto pols=profile(h,w);
   std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"polynomials\":[";
   for(int i=0;i<5;i++){if(i)std::cout<<',';jsonpoly(std::cout,pols[i]);}
   std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-began).count()<<"}\n";
  }catch(const std::exception&e){std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"not_computed\":\""<<e.what()<<"\"}\n";}
  std::cout.flush();
 }
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
