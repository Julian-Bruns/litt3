#include "../src/residual.hpp"
#include "io_dft.hpp"
#include "theta_all.hpp"
Poly loadlast(fs::path p){std::ifstream f(p,std::ios::binary);int nr=read32(f),nc=read32(f);f.close();auto rows=read_rows(p,nr,nc);Poly a;for(auto row:rows)a.c.push_back(row.back());a.trim();return a;}
int main(){try{input::init();auto a=loadlast("next/r9/E71.bin"),b=loadlast("next/r9/E72.bin");auto g=gcd(a,b);auto th=theta_for_root(9,F::code(64426));int vh=0,vt=0;while(!g[vh])vh++;g=g.shift(-vh);while(!g.divrem(th).second){g=g.exactdiv(th);vt++;}std::cout<<"leading mu gcd: H^"<<vh<<" Theta^"<<vt<<" remdeg="<<g.deg()<<" deriv="<<g.deriv().deg()<<"\n";write_rows("next/r9/leading_mu_gcd_stripped.bin",Rows{g.c});return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
