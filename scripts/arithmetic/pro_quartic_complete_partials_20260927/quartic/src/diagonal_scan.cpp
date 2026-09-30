#include "fast_field.hpp"
#include <chrono>
#include <fstream>
#include <string>
using namespace exact;
int main(int argc,char**argv){
 init();init_labels();
 int start=0,stop=116;
 if(argc>1) start=std::stoi(argv[1]);
 if(argc>2) stop=std::stoi(argv[2]);
 uint64_t total=0,ad=0,zero=0;
 K d=K::code(20);
 auto begin=std::chrono::steady_clock::now();
 for(int i=start;i<stop;++i){
  for(int j=i;j<116;++j)for(int k=j;k<116;++k)for(int l=k;l<116;++l){
   std::array<int,4> ix={i,j,k,l};++total;if(!admissible(ix))continue;++ad;
   F C=labels[i][0]+labels[j][0]+labels[k][0]+labels[l][0];
   F E=labels[i][1]+labels[j][1]+labels[k][1]+labels[l][1];
   K e1=E.c[1],e2=E.c[2],c1=C.c[1],c2=C.c[2],c3=C.c[3];
   if(e1.zero()||c3.zero())throw std::runtime_error("Odd character vanished");
   K d1=-(d*c2*c3).times(2);
   K d2=e1*e1-c1*c1-d*c3*c3;
   K d3=(e1*e2-c1*c2).times(2);
   K det=e1*c3*d2-e1*c2*d3-e2*c3*d1+e2*c1*d3;
   if(det.zero()){
    ++zero;std::cout<<"{\"Q\":";print_ix(ix,std::cout);std::cout<<",\"status\":\"necessary_diagonal_determinant_zero\"}\n";
   }
  }
 }
 std::cerr<<"{\"start\":"<<start<<",\"stop\":"<<stop<<",\"total\":"<<total<<",\"admissible\":"<<ad<<",\"zero\":"<<zero<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count()<<",\"kplus_primitive_code\":"<<primitive<<"}\n";
}
