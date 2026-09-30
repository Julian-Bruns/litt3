#include "degree140_infinity_trace_20260929.hpp"
using namespace infinitytrace;
int main(int argc,char**argv){try{
 if(argc<5)return 2;exact::loadfield(argv[1]);criticaltrace::load(argv[2]);CAP=160;F h=std::stoi(argv[3]),w=std::stoi(argv[4]);
 auto e=expand(h,w);
 std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"branches\":[";
 for(int i=0;i<2;i++){if(i)std::cout<<',';auto&b=e.branches[i];std::cout<<"{\"lambda_val\":"<<b.lambda.val()<<",\"lambda_lead\":"<<b.lambda.c[0]<<",\"phi_val\":"<<b.phi.val()<<",\"phi_lead\":"<<b.phi.c[0]<<",\"eta_val\":"<<b.eta.val()<<",\"eta_lead\":"<<b.eta.c[0]<<"}";}
 std::cout<<"],\"polynomials\":[";auto ps=all_profiles(h,w,{{0,0},{1,0},{2,0},{3,0},{0,1},{1,1},{0,2}});
 for(size_t i=0;i<ps.size();i++){if(i)std::cout<<',';exact::jsonpoly(std::cout,ps[i]);}std::cout<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
