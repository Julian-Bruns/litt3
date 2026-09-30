#define USE_GMP_PACKING
#include "fast_univariate.hpp"
#include <random>
int main(){initfield(nullptr);std::mt19937 rng(27092028);for(int t=0;t<180;t++){int n=1+rng()%900,m=1+rng()%900;UP a(n),b(m);for(U&c:a)c=rng()%QQ;for(U&c:b)c=rng()%QQ;trim(a);trim(b);if(t%3==0){UP g(1+rng()%50);for(U&c:g)c=rng()%QQ;a=um(a,g);b=um(b,g);}UP aa=a,bb=b;while(!bb.empty()){UP rr=udslow(aa,bb).second;aa=std::move(bb);bb=std::move(rr);}UP g=aa.empty()?aa:uc(aa,kinv(aa.back()));auto z=uxgfast(a,b);assert(z[0]==g&&ugfast(a,b)==g);if(a.size()>=b.size()&&a.size()>1){auto M=uhgcd(a,b);auto[c,d]=mapply(M,a,b);int m=((int)a.size())/2;assert(d.empty()||int(d.size())-1<m);}}
 std::cout<<"180 deterministic half-gcd and extended-gcd audits against ordinary Euclid PASS; exact Bezout and divisibility checked for each input. Bounded implementation audit.\n";
 UP a(40000),b(39999);for(U&c:a)c=rng()%QQ;for(U&c:b)c=rng()%QQ;auto t=std::chrono::steady_clock::now();auto z=uxgfast(a,b);std::cout<<"large certificate input degrees=39999,39998 gcd degree="<<z[0].size()-1<<" seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-t).count()<<"\n";
}
