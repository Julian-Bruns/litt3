// Exhaustive finite-etale triangularization of the double Newton-edge degeneracy.
#define NEWTON_LIBRARY
#include "newton_edge.cpp"
namespace qa {
Poly modulus;
struct Split :std::exception {Poly factor; explicit Split(Poly f):factor(std::move(f)){}const char* what()const noexcept override{return "finite-algebra nonunit requires exact split";}};
Poly red(Poly a){return mod(a,modulus);}Poly plus(Poly a,const Poly&b){return red(a+b);}Poly minus(Poly a,const Poly&b){return red(a-b);}Poly times(const Poly&a,const Poly&b){return red(a*b);}Poly inverse(const Poly&a){auto[g,u,v]=xgcd(a,modulus);if(deg(g)>0)throw Split(g);return red(u);}Poly pow(Poly a,int n){if(n<0){a=inverse(a);n=-n;}Poly b{1};while(n){if(n&1)b=times(b,a);a=times(a,a);n>>=1;}return b;}
HP hred(HP a){for(auto&x:a)x=red(x);htrim(a);return a;}
std::pair<HP,HP> divide(HP a,const HP&b){if(b.empty())throw std::runtime_error("zero H polynomial");Poly iv=inverse(b.back());HP q(std::max<int>(0,a.size()-b.size()+1));for(int i=int(a.size())-int(b.size());i>=0;i--){Poly s=times(a[i+b.size()-1],iv);q[i]=s;for(unsigned j=0;j<b.size();j++)a[i+j]=minus(a[i+j],times(s,b[j]));}htrim(a);htrim(q);return {q,a};}
HP gcdH(HP a,HP b){a=hred(a);b=hred(b);while(!b.empty()){auto rem=divide(a,b).second;a=b;b=rem;}if(a.empty())return a;Poly iv=inverse(a.back());for(auto&x:a)x=times(x,iv);return a;}
Poly evalH(const HP&a,const Poly&H){Poly out;for(int i=int(a.size())-1;i>=0;i--)out=plus(times(out,H),a[i]);return out;}
}
Poly squarefree_radical(Poly a){if(a.empty())return a;a=scale(a,inv(a.back()));if(deg(a)<=0)return a;Poly der=diff(a);if(der.empty()){Poly rt(deg(a)/5+1);for(unsigned i=0;i<a.size();i++){if(i%5)assert(a[i]==0);else rt[i/5]=fpow(a[i],78125);}return squarefree_radical(rt);}Poly g=gcd(a,der),sf=quo(a,g);Poly extra=squarefree_radical(g);return scale(sf*quo(extra,gcd(sf,extra)),inv((sf*quo(extra,gcd(sf,extra))).back()));}
Poly remove_allowed_units(Poly a,int ix){for(F q:std::vector<F>{0,QPIVOT[ix],QBOUND[ix]}){Poly f{neg(q),1};while(deg(a)>0&&eval(a,q)==0)a=quo(a,f);}return a.empty()?a:scale(a,inv(a.back()));}
struct RatioComponent {Poly qpoly,Hpoly;};
void triangularize(Poly p,const HP&u,const HP&v,std::vector<RatioComponent>&out){
 if(deg(p)<=0)return;qa::modulus=p;
 try {auto g=qa::gcdH(u,v);if(g.empty())throw std::runtime_error("both equations vanish identically");if(g.size()==1)return;if(g.size()!=2)throw std::runtime_error("nonlinear H fiber, must retain");Poly H=scale(g[0],4);assert(qa::evalH(u,H).empty());assert(qa::evalH(v,H).empty());qa::inverse(H);out.push_back({p,H});}
 catch(const qa::Split&e){if(deg(e.factor)<=0||deg(e.factor)==deg(p))throw std::runtime_error("unsplittable leading rank boundary");auto a=e.factor,b=quo(p,a);assert(gcd(a,b)==Poly{1});triangularize(a,u,v,out);triangularize(b,u,v,out);}
}
#ifndef EXCEPTION_LIBRARY
int main(int argc,char**argv){try {initdata();std::string dest=argc>1?argv[1]:"continuation/data";std::filesystem::create_directories(dest);F zeta=fpow(primitive,ORDER/3);
 for(int ix=0;ix<int(ROOTS.size());ix++){F r=ROOTS[ix];auto c=parametrize(r);auto f6=fullF6(c,7),f7=fullF6(c,8);Rat ap(c.num[0][2][4],1);Rat betab=scale(Rat(scale(term(Ca,1,0)+term(Cd,0,1),inv(eps)))+Rat(shift(ap.n,-1,0),ap.d),3);
  std::ofstream o(dest+"/ratios_"+std::to_string(r)+".json");o<<"{\"r\":"<<r<<",\"status\":\"complete geometric double-edge-degeneracy locus, NOT the square locus\",\"branches\":[";
  for(int j=0;j<3;j++){F zz=fpow(zeta,j),cc=divi(mul(2,mul(fpow(zz,2),fpow(24,2))),fpow(eps,2));auto u=f6-scale(Rat(term(1,3,0)),cc),v=f7-scale(Rat(term(1,3,0))*betab,mul(zz,cc));HP U=hpol(clearunits(toHq(u.n))),V=hpol(clearunits(toHq(v.n,-1)));auto res=hresultant(U,V);auto reduced=remove_allowed_units(squarefree_radical(res),ix);
   Poly exact_factor=power(Poly{0,1},10)*power(Poly{neg(QPIVOT[ix]),1},2)*reduced;
   F resultant_unit=res.back();assert(res==scale(exact_factor,resultant_unit));
   assert(gcd(reduced,diff(reduced))==Poly{1});assert(eval(reduced,0)&&eval(reduced,QPIVOT[ix])&&eval(reduced,QBOUND[ix]));
   std::vector<RatioComponent> parts;triangularize(reduced,U,V,parts);Poly product{1};for(auto&p:parts)product=product*p.qpoly;assert(product==reduced);
   if(j)o<<',';o<<"{\"zeta\":"<<zz<<",\"resultant_factorization\":{\"unit\":"<<resultant_unit<<",\"q_multiplicity\":10,\"pivot_multiplicity\":2},\"resultant_saturated_radical\":";printpoly(o,reduced);o<<",\"components\":[";int count=0;
   for(unsigned k=0;k<parts.size();k++){auto&p=parts[k];if(k)o<<',';o<<"{\"q_modulus\":";printpoly(o,p.qpoly);o<<",\"H_of_q\":";printpoly(o,p.Hpoly);o<<"}";count+=deg(p.qpoly);}
   o<<"],\"geometric_ratio_count\":"<<count<<"}";
   std::cout<<"PASS r="<<r<<" zeta="<<zz<<" saturated q degree="<<deg(reduced)<<" components="<<parts.size()<<" geometric ratios="<<count<<std::endl;
  }
  o<<"]}\n";
 }
 return 0;}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
#endif
