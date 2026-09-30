#include "degree140_low_trace_infinity_20260929.hpp"
int main(int argc,char**argv){try{
 if(argc!=5)throw std::runtime_error("usage: low_trace_infinity FIELD FAMILY H W");
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);infinitytrace::CAP=480;
 auto out=lowtrace::profiles(std::stoi(argv[3]),std::stoi(argv[4]),{{0,0},{1,0},{2,0}});
 std::cout<<"{\"h\":"<<argv[3]<<",\"w\":"<<argv[4]<<",\"infinity_contributions\":[";
 for(int i=0;i<2;i++){if(i)std::cout<<',';std::cout<<'[';for(int j=0;j<3;j++){if(j)std::cout<<',';exact::jsonpoly(std::cout,out[i][j]);}std::cout<<']';}std::cout<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
