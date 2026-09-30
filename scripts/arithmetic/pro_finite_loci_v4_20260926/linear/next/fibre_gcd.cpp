#include "fast_poly.hpp"
Poly loadpoly(fs::path p){std::ifstream f(p,std::ios::binary);int n=read32(f),m=read32(f);if(n!=1)throw std::runtime_error("not vector");Poly a;a.c.resize(m);for(auto& c:a.c)c=F::code(read32(f));a.trim();return a;}
void savepoly(fs::path p,const Poly& a){write_rows(p,Rows{a.c});}
int main(int argc,char**argv){try{if(argc<2)throw std::runtime_error("usage fibre_gcd DIRECTORY");kfield::init();fs::path dir=argv[1];auto A=loadpoly(dir/"Res71_72_stripped.bin"),B=loadpoly(dir/"Res71_73_stripped.bin");auto start=std::chrono::steady_clock::now();std::cout<<"input degrees "<<A.deg()<<","<<B.deg()<<"\n"<<std::flush;
 auto[g,s,t]=fxgcd(A,B,true);savepoly(dir/"gcd_72_73.bin",g);savepoly(dir/"bezout_72_73_s.bin",s);savepoly(dir/"bezout_72_73_t.bin",t);std::cout<<"pair gcd degree="<<g.deg()<<" certificate verified\n"<<std::flush;
 std::ofstream f(dir/"gcd_summary.json");f<<"{\"pair_gcd_degree\":"<<g.deg()<<",\"bezout_identity_verified\":true,\"divisibilities_verified\":true}\n";
 std::cout<<"DONE wall="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"\n";

}catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
