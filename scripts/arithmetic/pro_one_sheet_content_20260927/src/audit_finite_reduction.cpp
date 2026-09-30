#define USE_GMP_PACKING
#include "finite_generic.hpp"
#include <random>
int main(){initfield(nullptr);std::mt19937 rng(27092030);for(int i=0;i<100;i++){int n=50+rng()%240;VF.resize(n+1);for(U&c:VF)c=rng()%QQ;VF.back()=1;for(int j=0;j<5;j++){UP a(1+rng()%(4*n));for(U&c:a)c=rng()%QQ;trim(a);assert(br(a)==udslow(a,VF).second);}}std::cout<<"500 cached fixed-modulus reductions against direct long division PASS. Bounded arithmetic implementation audit.\n";}
