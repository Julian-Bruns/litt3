// New rational-interpolation discovery data for the unweighted endpoints.
// No geometric conclusion is inferred from a finite parameter sample.
#include "degree140_endpoint_trace_native_20260929.hpp"
#include <chrono>
int main(int argc,char**argv){try{
 if(argc!=5)throw std::runtime_error("usage: endpoint_probe FIELD FAMILY W COUNT");
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);
 int w=std::stoi(argv[3]),count=std::stoi(argv[4]);endpointtrace::CAP=36;
 auto start=std::chrono::steady_clock::now();
 std::cout<<"{\"scope\":\"new finite samples for rational-form discovery only\",\"w\":"<<w<<",\"rows\":[";
 int done=0;
 for(int h=1;done<count&&h<390625;h++){
  try{
   auto c=endpointtrace::correction(h,w);
   if(done)std::cout<<',';
   std::cout<<"{\"h\":"<<h<<",\"values\":[";bool first=true;
   for(int k=0;k<2;k++)for(int n=0;n<(k?6:3);n++)for(int j=0;j<3;j++){
    if(!first)std::cout<<',';first=false;std::cout<<c[k][n][j];
   }
   std::cout<<"]}";done++;
  }catch(const std::exception&e){std::cerr<<"skip h="<<h<<" "<<e.what()<<'\n';}
 }
 std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
 if(done<count)return 2;
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
