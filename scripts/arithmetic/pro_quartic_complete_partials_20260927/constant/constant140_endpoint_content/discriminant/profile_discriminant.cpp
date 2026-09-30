#include "../forward/resultant_engine.hpp"
std::vector<std::pair<int,Poly>> sqf(Poly f){
 if(f.zero())throw std::runtime_error("zero polynomial");f=scale(f,ff::inv(f.v.back()));
 std::vector<std::pair<int,Poly>> out;if(f.deg()==0)return out;
 Poly c=gcd(f,derivative(f)),w=exactdiv(f,c);int i=1;
 while(w.deg()>0){Poly y=gcd(w,c),z=exactdiv(w,y);if(z.deg()>0)out.push_back({i,z});w=y;c=exactdiv(c,y);i++;}
 if(c.deg()>0){Poly root;root.v.resize(c.deg()/5+1);for(int j=0;j<=c.deg();j++){if(j%5 && c.at(j))throw std::runtime_error("not fifth power");if(j%5==0)root.v[j/5]=ff::pow(c.at(j),78125);}root.trim();for(auto [m,z]:sqf(root))out.push_back({5*m,z});}
 Poly chk(1);for(auto [m,z]:out)chk=chk*ppow(z,m);if(!(chk==f))throw std::runtime_error("sqf reconstruction");return out;
}
int main(int argc,char**argv){try{ff::init();init_source();for(int k=1;k<argc;k++){std::ifstream in(argv[k]);F c;Poly a;while(in>>c)a.v.push_back(c);a.trim();auto s=sqf(a);std::cout<<argv[k]<<" degree "<<a.deg();
 for(size_t i=0;i<s.size();i++){
 auto [m,z]=s[i];if(gcd(z,derivative(z)).deg()!=0)throw std::runtime_error("factor not squarefree");
 for(size_t j=0;j<i;j++)if(gcd(z,s[j].second).deg()!=0)throw std::runtime_error("factors not coprime");
 std::cout<<" [multiplicity "<<m<<" degree "<<z.deg()<<"]";
 if(z.deg()==1)std::cout<<" [linear_root "<<ff::neg(z.at(0))<<"]";
 std::string path=std::string(argv[k])+".sqf"+std::to_string(m);writepoly(path,z);
 }
 Poly bound(1);for(auto [m,z]:s)bound=bound*ppow(z,m/70);
 writepoly(std::string(argv[k])+".seventieth_power_part",bound);
 std::cout<<" seventieth_power_part_degree "<<bound.deg()<<" VERIFIED\n";}}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
