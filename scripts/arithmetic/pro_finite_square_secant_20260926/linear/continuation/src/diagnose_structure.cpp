#define RESIDUAL_LIBRARY
#include "../../src/residual.cpp"
int main(){initdata();auto c=parametrize(9);auto s=evaluate_source(c,2,3);auto R=residual(9,s);Poly gg;for(int l=0;l<=6;l++){gg=gcd(gg,R[l]);std::cout<<"l="<<l<<" degree="<<deg(R[l])<<" derivative="<<deg(diff(R[l]))<<" gcdself="<<deg(gcd(R[l],diff(R[l])))<<'\n';}std::cout<<"common R coefficient factor degree "<<deg(gg)<<'\n';for(F l:std::vector<F>{0,1,2,3,4,25}){auto v=evaluate_lambda(R,l);std::cout<<"lambda="<<l<<" gcd R,R'="<<deg(gcd(v,diff(v)))<<'\n';}}
