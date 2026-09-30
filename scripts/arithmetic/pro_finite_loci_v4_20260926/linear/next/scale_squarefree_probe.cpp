#include "../src/residual.hpp"
#include "io_dft.hpp"
int main(){try{input::init();for(int r:{9,14}){auto cr=cramer(reconstruct(F::code(r)));auto S=evaluate_source(cr,F::code(31),F::code(101));auto R=residual(S,F::code(r));auto E=complete_square_equations(R);for(int n=0;n<7;n++){auto g=gcd(E[n],E[n].deriv());std::cout<<r<<" E"<<71+n<<" mu degree="<<E[n].deg()<<" derivgcd="<<g.deg()<<"\n";} }return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
