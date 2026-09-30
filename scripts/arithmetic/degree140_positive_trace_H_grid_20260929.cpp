#include "degree140_trace_engine_20260929.hpp"
using namespace criticaltrace;
int main(int argc,char**argv){try{
 if(argc!=6){std::cerr<<"usage: H_grid FIELD_DATA FAMILY_TEXT H W_START W_END\n";return 2;}
 loadfield(argv[1]);load(argv[2]);F H=std::stoi(argv[3]);
 for(int w=std::stoi(argv[4]);w<std::stoi(argv[5]);w++){
  if(!w)continue;F h=divide(H,w),q=power(w,3);
  auto start=std::chrono::steady_clock::now();
  try{
   auto ps=positive_profile(h,w,1);
   for(auto&p:ps)for(int i=0;i<=p.deg();i++)p[i]=mul(p[i],power(w,i));
   std::cout<<"{\"H\":"<<H<<",\"w\":"<<w<<",\"q\":"<<q<<",\"polynomials\":[";
   for(int j=0;j<3;j++){if(j)std::cout<<',';jsonpoly(std::cout,ps[j]);}
   std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
  }catch(const std::exception&e){std::cout<<"{\"H\":"<<H<<",\"w\":"<<w<<",\"q\":"<<q<<",\"not_computed\":\""<<e.what()<<"\"}\n";}
  std::cout.flush();
 }
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
