#define USE_GMP_PACKING
#include "fast_univariate.hpp"
int main(int argc,char**argv){try{initfield(nullptr);for(int z=1;z<argc;z++){std::ifstream i(argv[z]);QA a=loadq(i);UP g;for(auto&p:a.n)if(!p.empty()){g=g.empty()?uc(p,kinv(p.back())):ugfast(g,p);std::cout<<"partial content_degree="<<g.size()-1<<std::endl;}std::cout<<argv[z]<<" final_numerator_content_degree="<<g.size()-1<<std::endl;}return 0;}catch(std::exception&e){std::cerr<<e.what();return 1;}}
