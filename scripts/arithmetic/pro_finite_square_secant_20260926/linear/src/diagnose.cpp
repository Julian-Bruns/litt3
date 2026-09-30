#define RESIDUAL_LIBRARY
#include "residual.cpp"
int main(){initdata();for(F r:ROOTS){auto c=parametrize(r);auto s=evaluate_source(c,2,3);auto R=residual(r,s);Poly fixed;for(auto&p:R)fixed=gcd(fixed,p);auto rr=evaluate_lambda(R,1);auto d=diff(rr);std::cout<<"DIAGNOSTIC r="<<r<<" degR="<<deg(rr)<<" gcd(R,R')="<<deg(gcd(rr,d))<<" common_lambda_factor="<<deg(fixed)<<" gcdR_P="<<deg(gcd(rr,P))<<" gcdR_t="<<deg(gcd(rr,tp))<<'\n';}}
