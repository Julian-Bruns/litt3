// Focused new-formula fixture: retain the full endpoint residue engine.
#include "degree140_endpoint_trace_native_20260929.hpp"
using namespace exact;
int main(int argc,char**argv){try{
 if(argc!=3)throw std::runtime_error("usage: endpoint_small_top_fixture FIELD FAMILY");
 loadfield(argv[1]);criticaltrace::load(argv[2]);endpointtrace::CAP=36;
 std::cout<<"{\"scope\":\"new endpoint top formula fixtures\",\"rows\":[";bool first=true;
 for(F h:std::array<F,3>{2,5,17})for(F w:std::array<F,3>{3,7,11}){
  auto a=endpointtrace::correction(h,w);
  auto b=endpointtrace::correction(h,w,criticaltrace::T);
  if(!first)std::cout<<',';first=false;
  std::cout<<"{\"h\":"<<h<<",\"w\":"<<w;
  const char* names[]={"Q_degree5_endpoint","tQ_degree4_endpoint","T_degree2_endpoint"};
  std::array<std::array<F,3>,3> values{a[1][5],b[1][4],a[0][2]};
  for(int k=0;k<3;k++){
   std::cout<<",\""<<names[k]<<"\":[";
   for(int j=0;j<3;j++){if(j)std::cout<<',';std::cout<<values[k][j];}std::cout<<']';
  }std::cout<<'}';
 }std::cout<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
