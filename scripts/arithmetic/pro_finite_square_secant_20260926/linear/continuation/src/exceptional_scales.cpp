#define EXCEPTION_LIBRARY
#include "exceptional_ratios.cpp"
#include "finite_algebra.hpp"
#include <chrono>
#ifndef SCALES_LIBRARY
int main(int argc,char**argv){try{initdata();std::string dest=argc>1?argv[1]:"continuation/data";std::filesystem::create_directories(dest);int first=argc>2?std::stoi(argv[2]):0,last=argc>3?std::stoi(argv[3]):30;F zeta=fpow(primitive,ORDER/3);std::cout.setf(std::ios::unitbuf);
 for(int cas=first;cas<last;cas++){auto st=std::chrono::steady_clock::now();int ix=cas/3,j=cas%3;F r=ROOTS[ix],zz=fpow(zeta,j);auto c=parametrize(r);auto f6=fullF6(c,7),f7=fullF6(c,8);Rat ap(c.num[0][2][4],1);Rat betab=scale(Rat(scale(term(Ca,1,0)+term(Cd,0,1),inv(eps)))+Rat(shift(ap.n,-1,0),ap.d),3);F cc=divi(mul(2,mul(fpow(zz,2),fpow(24,2))),fpow(eps,2));auto u=f6-scale(Rat(term(1,3,0)),cc),v=f7-scale(Rat(term(1,3,0))*betab,mul(zz,cc));auto U=hpol(clearunits(toHq(u.n))),V=hpol(clearunits(toHq(v.n,-1)));auto red=remove_allowed_units(squarefree_radical(hresultant(U,V)),ix);std::vector<RatioComponent> parts;triangularize(red,U,V,parts);assert(parts.size()==1);auto part=parts[0];qa::modulus=part.qpoly;
  std::cout<<"START case="<<cas<<" r="<<r<<" zeta="<<zz<<" algebra degree="<<deg(qa::modulus)<<'\n';
  auto R=fa::residual(c,part.Hpoly);assert(R.size()==7);assert(R[0].size()==141);qa::inverse(R[0].back());
  Poly expected_lc=qa::times(qa::pow(Poly{0,1},19),qa::times(qa::pow(part.Hpoly,18),Poly{mul(fpow(eps,18),fpow(24,6))}));
  assert(R[0].back()==expected_lc);
  for(unsigned l=1;l<R.size();l++)assert(R[l].size()<141);
  std::cout<<"residual complete case="<<cas<<" seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-st).count()<<'\n';
  auto[e71,e72]=fa::errors71_72(R);assert(e71.size()==53&&e72.size()==54);std::cout<<"errors complete case="<<cas<<" degrees="<<e71.size()-1<<','<<e72.size()-1<<" seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-st).count()<<'\n';
  auto[g,b1,b2]=fa::xgcd(e71,e72);auto check=fa::plus(fa::times(b1,e71),fa::times(b2,e72));assert(check==g);if(g!=fa::scalar({1}))throw std::runtime_error("nontrivial surviving scale gcd; retain it");
  std::ofstream o(dest+"/scales_"+std::to_string(r)+"_"+std::to_string(zz)+".json");o<<"{\"r\":"<<r<<",\"zeta\":"<<zz<<",\"q_modulus\":";printpoly(o,part.qpoly);o<<",\"H_of_q\":";printpoly(o,part.Hpoly);o<<",\"leading_x_coefficient\":";printpoly(o,R[0].back());o<<",\"error_indices\":[71,72],\"errors\":[";fa::print(o,e71);o<<',';fa::print(o,e72);o<<"],\"bezout\":[";fa::print(o,b1);o<<',';fa::print(o,b2);o<<"],\"gcd\":[[1]]}\n";
  std::cout<<"PASS all geometric scales case="<<cas<<" r="<<r<<" zeta="<<zz<<" seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-st).count()<<'\n';
 }
 return 0;
 }catch(const qa::Split&e){std::cerr<<"UNRESOLVED nonunit; splitting required, factor=";printpoly(std::cerr,e.factor);std::cerr<<'\n';return 2;}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
#endif
