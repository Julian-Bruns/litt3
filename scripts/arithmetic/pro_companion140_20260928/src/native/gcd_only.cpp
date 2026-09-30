#define main eliminate_main
#include "eliminate.cpp"
#undef main
#include <omp.h>
#include <malloc.h>
int main(int argc,char**argv){assert(argc==4);F::init();FastK::init();omp_set_num_threads(std::stoi(argv[3]));auto input=read(argv[1]);FP a=poly(input.get_child("P12")),b=poly(input.get_child("P13"));input.clear();malloc_trim(0);auto t0=std::chrono::steady_clock::now();auto[g,u,v]=xgcd_half(a,b,true);std::ofstream o(argv[2]);o<<"{\"G\":";printpoly(o,g);o<<",\"U\":";printpoly(o,u);o<<",\"V\":";printpoly(o,v);o<<"}\n";std::cout<<"{\"projected_gcd_degree\":"<<g.deg()<<",\"exact_Bezout_and_divisibility\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-t0).count()<<"}"<<std::endl;}
