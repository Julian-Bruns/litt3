#define RESIDUAL_LIBRARY
#include "../../src/residual.cpp"
int main(){initdata();F r=9;auto c=parametrize(r);auto s=evaluate_source(c,2,3);auto R=residual(r,s);for(int i=0;i<7;i++)std::cout<<"lambda "<<i<<" xdeg="<<deg(R[i])<<"\n"; auto t=all_scales(R,74);for(auto [i,p]:t.generators){auto g=gcd(p,diff(p));std::cout<<i<<" deg="<<deg(p)<<" derivative_gcd="<<deg(g)<<"\n";}return 0;}
