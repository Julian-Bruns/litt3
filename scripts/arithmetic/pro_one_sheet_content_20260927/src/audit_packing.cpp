#define USE_GMP_PACKING
#include "function_algebra.hpp"
#include <random>
int main(){initfield(nullptr);std::mt19937 rng(27092026);for(int trial=0;trial<160;trial++){int n=trial<20?trial+1:1+rng()%800,m=trial<20?trial+3:1+rng()%800;UP a(n),b(m);for(U&c:a)c=rng()%QQ;for(U&c:b)c=rng()%QQ;UP direct(n+m-1);for(int i=0;i<n;i++)for(int j=0;j<m;j++)direct[i+j]=kadd(direct[i+j],kmul(a[i],b[j]));trim(direct);assert(packed_mul(a,b)==direct);assert(um(a,b)==direct);auto[q,r]=ud(direct,b);assert(q==a&&r.empty());}
 std::cout<<"160 deterministic packed products and exact divisions agree with direct tower arithmetic. Bounded implementation audit; packing validity follows from the carry bound.\n";
 UP a(10000),b(10000);for(U&c:a)c=rng()%QQ;for(U&c:b)c=rng()%QQ;auto start=std::chrono::steady_clock::now();auto c=um(a,b);double t=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();std::cout<<"degree-9999 product degree="<<c.size()-1<<" seconds="<<t<<" GMP="<<gmp_version<<"\n";
}
