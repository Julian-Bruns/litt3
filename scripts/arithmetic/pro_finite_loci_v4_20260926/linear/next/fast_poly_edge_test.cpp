#include "../src/residual.hpp"
#include "fast_poly.hpp"
int main(){try{input::init();std::vector<Poly> ps={Poly(),Poly(1),Poly(F::code(31)),Poly::mon(1)+Poly(3),Poly::mon(140)+Poly::mon(39,F::code(31))+Poly(1)};int n=0;for(auto a:ps)for(auto b:ps){auto[g,s,t]=fxgcd(a,b);if(g!=gcd(a,b)||fmul(s,a)+fmul(t,b)!=g)throw std::runtime_error("edge gcd");n++;}std::cout<<n<<" zero, constant, equal-degree, swapped-order and exact-division GCD edge cases PASS\n";return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
