#define USE_GMP_PACKING
#include "function_algebra.hpp"
#include <random>
int main(){initfield(nullptr);std::mt19937 rng(27092031);for(int i=0;i<100;i++){int d=50+rng()%150,n=d*(5+rng()%9)+rng()%d;UP a(n),b(d+1);for(U&c:a)c=rng()%QQ;for(U&c:b)c=rng()%QQ;if(!b.back())b.back()=1;auto z=udblock(a,b);assert(z==udslow(a,b));assert(z==ud(a,b));}std::cout<<"100 block polynomial divisions agree with direct long division PASS; bounded implementation audit.\n";UP a(265267),b(245);for(U&c:a)c=rng()%QQ;for(U&c:b)c=rng()%QQ;b.back()=1;auto start=std::chrono::steady_clock::now();auto z=udblock(a,b);assert(ua(um(z.first,b),z.second)==a);std::cout<<"degree265266 / degree244 block division exact identity PASS seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"\n";}
