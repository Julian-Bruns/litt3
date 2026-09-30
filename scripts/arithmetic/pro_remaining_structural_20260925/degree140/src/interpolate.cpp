#include "fast.hpp"
#include "dft.hpp"
#include <chrono>
using namespace exact;
Poly shiftout(const Poly&p,int v){return Poly(std::vector<F>(p.begin()+v,p.end()));}
int main(int argc,char**argv){try{
 if(argc!=6){std::cerr<<"interpolate FIELD_DATA VALUES.bin N OMEGA OUTPUT.json\n";return 2;}
 loadfield(argv[1]);int N=std::stoi(argv[3]);F omega=std::stoi(argv[4]);std::vector<F>vals(3*N);std::ifstream f(argv[2],std::ios::binary);f.read((char*)vals.data(),4*vals.size());if(f.gcount()!=4*(int64_t)vals.size())throw std::runtime_error("wrong input length");
 if(power(omega,N)!=1)throw std::runtime_error("bad root of unity");for(int q:{2,3,13,313})if(N%q==0&&power(omega,N/q)==1)throw std::runtime_error("nonprimitive root of unity");
 std::array<int,3>bounds{45900,46218,46980};std::vector<Poly> polys,cofactors;std::vector<int>vs;
 for(int j=0;j<3;j++){
  std::vector<F>v(vals.begin()+j*N,vals.begin()+(j+1)*N);Poly p=scale(Poly(dft(v,inv(omega))),inv(N%5));p.trim();
  if(p.deg()>bounds[j])throw std::runtime_error("interpolated degree exceeds proven bound");
  std::vector<F>pad=p;pad.resize(N);auto back=dft(pad,omega);if(back!=v)throw std::runtime_error("DFT round trip failed");
  int va=0;while(va<(int)p.size()&&!p[va])va++;if(va==(int)p.size())throw std::runtime_error("zero resultant");
  polys.push_back(p);vs.push_back(va);cofactors.push_back(shiftout(p,va));
  std::cerr<<"resultant "<<j<<": degree="<<p.deg()<<", r-valuation="<<va<<", cofactor degree="<<cofactors.back().deg()<<'\n';
 }
 std::vector<Poly> u{Poly{1}};Poly g=cofactors[0];
 for(int j=1;j<3;j++){auto eg=xgcd(g,cofactors[j]);for(auto&v:u)v=v*eg[1];u.push_back(eg[2]);g=eg[0];std::cerr<<"after cofactor "<<j<<": common gcd degree="<<g.deg()<<'\n';}
 Poly chk;for(int j=0;j<3;j++)chk=chk+u[j]*cofactors[j];if(chk!=g)throw std::runtime_error("Bezout verification failed");
 std::ofstream o(argv[5]);o<<"{\"N\":"<<N<<",\"omega\":"<<omega<<",\"resultants\":[";for(int j=0;j<3;j++){if(j)o<<',';jsonpoly(o,polys[j]);}o<<"],\"r_valuations\":["<<vs[0]<<','<<vs[1]<<','<<vs[2]<<"],\"cofactor_bezout_coefficients\":[";for(int j=0;j<3;j++){if(j)o<<',';jsonpoly(o,u[j]);}o<<"],\"cofactor_gcd\":";jsonpoly(o,g);o<<",\"all_nonzero_r_excluded\":"<<(g.deg()==0?"true":"false")<<"}\n";
 std::cerr<<"INTERPOLATION AND BEZOUT CHECKS PASSED; all_nonzero_r_excluded="<<(g.deg()==0)<<'\n';
 }catch(const std::exception&e){std::cerr<<"ERROR "<<e.what()<<'\n';return 1;}}
