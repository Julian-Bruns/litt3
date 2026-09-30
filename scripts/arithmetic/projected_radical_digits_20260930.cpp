// Radical extraction by multiplicity digits in characteristic five.
// For f monic, g=gcd(f,f'), w=f/g, u=f'/g.  The factors
// gcd(w,u-j*w'), j=1,...,4, distinguish multiplicities modulo five.
// Their j-th powers divide f with a fifth-power quotient.
#include "degree140_trace_engine_20260929.hpp"
extern "C" {
#include <flint/flint.h>
#include <flint/nmod_poly.h>
#include <flint/fq_nmod.h>
#include <flint/fq_nmod_poly.h>
}
#include <fstream>
#include <functional>
using namespace exact;

int main(int argc,char**argv){try{
 if(argc!=4)throw std::runtime_error("usage: radical_digits FIELD INPUT_BIN OUTPUT_PREFIX");
 loadfield(argv[1]);flint_set_num_threads(1);
 std::vector<int>cv(390625),rev(390625);
 for(int i=1;i<390625;i++)cv[i]=add(i%5,mul(25,cv[i/5]));
 for(int i=0;i<390625;i++)rev[cv[i]]=i;
 nmod_poly_t modulus,tmp;nmod_poly_init(modulus,5);nmod_poly_init(tmp,5);
 int mc[9]={2,2,4,2,0,0,1,0,1};for(int i=0;i<9;i++)nmod_poly_set_coeff_ui(modulus,i,mc[i]);
 fq_nmod_ctx_t ctx;fq_nmod_ctx_init_modulus(ctx,modulus,"a");fq_nmod_t elt;fq_nmod_init(elt,ctx);
 auto setelt=[&](F v){int n=rev[v];nmod_poly_zero(tmp);for(int i=0;i<8;i++){nmod_poly_set_coeff_ui(tmp,i,n%5);n/=5;}fq_nmod_set_nmod_poly(elt,tmp,ctx);};
 auto getelt=[&](){fq_nmod_get_nmod_poly(tmp,elt,ctx);int n=0;for(int i=7;i>=0;i--)n=5*n+nmod_poly_get_coeff_ui(tmp,i);return cv.at(n);};
 auto setpoly=[&](fq_nmod_poly_t p,const Poly&v){fq_nmod_poly_zero(p,ctx);for(size_t i=0;i<v.size();i++)if(v[i]){setelt(v[i]);fq_nmod_poly_set_coeff(p,i,elt,ctx);}};
 auto getpoly=[&](const fq_nmod_poly_t p){Poly v(fq_nmod_poly_length(p,ctx));for(size_t i=0;i<v.size();i++){fq_nmod_poly_get_coeff(elt,p,i,ctx);v[i]=getelt();}v.trim();return v;};
 auto readpoly=[&](const std::string&path){std::ifstream f(path,std::ios::binary);int n;f.read((char*)&n,4);if(!f||n<1||n>4000000)throw std::runtime_error("invalid polynomial header");Poly v(n);f.read((char*)v.data(),4*n);if(!f)throw std::runtime_error("truncated polynomial");v.trim();return v;};
 auto savepoly=[&](const fq_nmod_poly_t p,const std::string&path){auto v=getpoly(p);std::ofstream f(path,std::ios::binary);int n=v.size();f.write((char*)&n,4);f.write((char*)v.data(),4*v.size());};
 const std::string out=argv[3];int calls=0;bool retain=false;
 auto start=std::chrono::steady_clock::now();
 std::function<void(fq_nmod_poly_struct*,const fq_nmod_poly_struct*,int)> radical;
 radical=[&](fq_nmod_poly_struct*result,const fq_nmod_poly_struct*f,int depth){
  const long degree=fq_nmod_poly_degree(f,ctx);
  if(degree<0)throw std::runtime_error("zero polynomial has no finite radical");
  if(degree==0){fq_nmod_poly_one(result,ctx);return;}
  int id=calls++;std::string pre=out+"_level_"+std::to_string(id);
  fq_nmod_poly_t df,g,w,u,wp,z,jwp,prod,pow,quot,rem,child,crad,join;
  for(auto*p:{df,g,w,u,wp,z,jwp,prod,pow,quot,rem,child,crad,join})fq_nmod_poly_init(p,ctx);
  fq_nmod_poly_derivative(df,f,ctx);fq_nmod_poly_gcd(g,f,df,ctx);
  fq_nmod_poly_divrem(w,rem,f,g,ctx);if(!fq_nmod_poly_is_zero(rem,ctx))throw std::runtime_error("gcd quotient failure");
  fq_nmod_poly_divrem(u,rem,df,g,ctx);if(!fq_nmod_poly_is_zero(rem,ctx))throw std::runtime_error("derivative quotient failure");
  fq_nmod_poly_derivative(wp,w,ctx);fq_nmod_poly_one(prod,ctx);fq_nmod_poly_one(join,ctx);
  std::vector<long>degrees;
  if(retain){savepoly(f,pre+"_f.bin");savepoly(g,pre+"_derivative_gcd.bin");savepoly(w,pre+"_w.bin");savepoly(u,pre+"_u.bin");}
  for(int j=1;j<5;j++){
   setelt(j);fq_nmod_poly_scalar_mul_fq_nmod(jwp,wp,elt,ctx);fq_nmod_poly_sub(z,u,jwp,ctx);fq_nmod_poly_gcd(z,w,z,ctx);
   degrees.push_back(fq_nmod_poly_degree(z,ctx));if(retain)savepoly(z,pre+"_digit_"+std::to_string(j)+".bin");
   fq_nmod_poly_mul(quot,join,z,ctx);fq_nmod_poly_swap(quot,join,ctx);
   fq_nmod_poly_pow(pow,z,j,ctx);fq_nmod_poly_mul(quot,prod,pow,ctx);fq_nmod_poly_swap(quot,prod,ctx);
  }
  if(!fq_nmod_poly_equal(join,w,ctx))throw std::runtime_error("multiplicity residue factors do not partition w");
  fq_nmod_poly_divrem(quot,rem,f,prod,ctx);if(!fq_nmod_poly_is_zero(rem,ctx))throw std::runtime_error("digit divisor is not exact");
  Poly residual=getpoly(quot),root((residual.deg()/5)+1);
  for(int i=0;i<int(residual.size());i++)if(residual[i]){
   if(i%5)throw std::runtime_error("digit quotient is not a fifth power");
   root[i/5]=power(residual[i],78125);if(power(root[i/5],5)!=residual[i])throw std::runtime_error("coefficient Frobenius root failure");
  }
  root.trim();setpoly(child,root);
  if(retain){savepoly(prod,pre+"_digit_product.bin");savepoly(child,pre+"_fifth_root.bin");std::cerr<<"radical level "<<depth<<" degree "<<degree<<" separable support "<<fq_nmod_poly_degree(w,ctx)<<" child "<<root.deg()<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';}
  radical(crad,child,depth+1);
  fq_nmod_poly_gcd(g,w,crad,ctx);fq_nmod_poly_divrem(quot,rem,w,g,ctx);if(!fq_nmod_poly_is_zero(rem,ctx))throw std::runtime_error("lcm quotient failure");
  fq_nmod_poly_mul(result,quot,crad,ctx);fq_nmod_poly_make_monic(result,result,ctx);
  if(retain){savepoly(result,pre+"_radical.bin");std::ofstream js(pre+".json");js<<"{\"degree\":"<<degree<<",\"depth\":"<<depth<<",\"separable_support_degree\":"<<fq_nmod_poly_degree(w,ctx)<<",\"digit_factor_degrees\":[";for(int j=0;j<4;j++){if(j)js<<',';js<<degrees[j];}js<<"],\"fifth_root_degree\":"<<root.deg()<<",\"radical_degree\":"<<fq_nmod_poly_degree(result,ctx)<<"}\n";}
  for(auto*p:{df,g,w,u,wp,z,jwp,prod,pow,quot,rem,child,crad,join})fq_nmod_poly_clear(p,ctx);
 };
 fq_nmod_poly_t f,r,dr,g;for(auto*p:{f,r,dr,g})fq_nmod_poly_init(p,ctx);
 for(int mode=0;mode<3;mode++){
  Poly a{neg(17),1},b{neg(31),1},c{neg(53),1};Poly input=mode==0?ppow(a,117)*ppow(b,6)*ppow(c,25):(mode==1?ppow(a,625)*ppow(b,125):Poly{1});
  Poly expected=mode==0?a*b*c:(mode==1?a*b:Poly{1});setpoly(f,input);radical(r,f,0);if(getpoly(r)!=expected)throw std::runtime_error("new radical control failed");
 }
 calls=0;retain=true;setpoly(f,readpoly(argv[2]));fq_nmod_poly_make_monic(f,f,ctx);radical(r,f,0);
 fq_nmod_poly_derivative(dr,r,ctx);fq_nmod_poly_gcd(g,r,dr,ctx);if(!fq_nmod_poly_is_one(g,ctx))throw std::runtime_error("final radical is not squarefree");
 savepoly(r,out+"_allowed_gcd.bin");std::ofstream js(out+"_radical_digits.json");js<<"{\"status\":\"exact_radical_by_multiplicity_digits\",\"input_degree\":"<<fq_nmod_poly_degree(f,ctx)<<",\"radical_degree\":"<<fq_nmod_poly_degree(r,ctx)<<",\"levels\":"<<calls<<",\"calculation_cores\":1,\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
 std::cerr<<"complete radical degree "<<fq_nmod_poly_degree(r,ctx)<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 for(auto*p:{f,r,dr,g})fq_nmod_poly_clear(p,ctx);fq_nmod_clear(elt,ctx);fq_nmod_ctx_clear(ctx);nmod_poly_clear(tmp);nmod_poly_clear(modulus);
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
