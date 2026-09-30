// Exact wide projected gcd. Sparse Frobenius powers remove original
// chart factors before the expensive gcd; Euler jets verify Bezout.
#include "degree140_trace_engine_20260929.hpp"
#include "dft.hpp"
extern "C" {
#include <flint/flint.h>
#include <flint/nmod_poly.h>
#include <flint/fq_nmod.h>
#include <flint/fq_nmod_poly.h>
#include <flint/fq_nmod_poly_factor.h>
}
#include <fstream>
#include <array>
using namespace exact;

unsigned remove_linear(Poly&f,F root){
 if(f.empty())throw std::runtime_error("zero polynomial in chart reduction");
 if(!root){unsigned n=0;while(n<f.size()&&!f[n])n++;f.erase(f.begin(),f.begin()+n);return n;}
 int step=1;while(step<=f.deg()/5)step*=5;unsigned removed=0;
 for(;step>=1;step/=5){F r=power(root,step);int count=0;
  while(f.deg()>=step&&count<5){Poly cur=f,q(f.size()-step);
   for(int i=f.deg();i>=step;i--){F c=cur[i];q[i-step]=c;cur[i-step]=add(cur[i-step],mul(r,c));}
   bool ok=true;for(int i=0;i<step;i++)if(cur[i]){ok=false;break;}
   if(!ok)break;q.trim();f=std::move(q);removed+=step;count++;
  }
  if(count==5)throw std::runtime_error("base-five removal overflow");
 }
 return removed;
}
int choose5(int n,int k){
 static const int C[5][5]={{1,0,0,0,0},{1,1,0,0,0},{1,2,1,0,0},{1,3,3,1,0},{1,4,1,4,1}};
 int r=1;while(k){int a=n%5,b=k%5;if(b>a)return 0;r=r*C[a][b]%5;n/=5;k/=5;}return r;
}
int verify_hermite_bezout(const Poly&a,const Poly&b,const Poly&s,const Poly&t,const Poly&g){
 const int N=390624;int bound=std::max({a.deg()+s.deg(),b.deg()+t.deg(),g.deg()});int J=bound/N+1;
 if(J>15)throw std::runtime_error("unexpected Bezout verification size");
 std::array<std::vector<Poly>,4> ev;const Poly*pp[4]={&a,&b,&s,&t};
 for(int k=0;k<4;k++)for(int j=0;j<J;j++){
  Poly fold(N);for(int i=0;i<int(pp[k]->size());i++){int c=choose5(i,j);if(c)fold[i%N]=add(fold[i%N],mul(c,(*pp[k])[i]));}
  ev[k].push_back(Poly(dft(fold,EX[1])));
 }
 for(int j=0;j<J;j++){
  Poly fold(N);for(int i=0;i<int(g.size());i++){int c=choose5(i,j);if(c)fold[i%N]=add(fold[i%N],mul(c,g[i]));}
  auto target=dft(fold,EX[1]);
  for(int node=0;node<N;node++){F z=0;for(int k=0;k<=j;k++)z=add(z,add(mul(ev[0][k][node],ev[2][j-k][node]),mul(ev[1][k][node],ev[3][j-k][node])));if(z!=target[node])throw std::runtime_error("exact Euler-Hermite Bezout failure");}
 }
 return J;
}

int main(int argc,char**argv){try{
 if(argc!=4&&argc!=5)throw std::runtime_error("usage: wide_gcd FIELD INPUT_PREFIX OUTPUT_PREFIX [resume]");
 loadfield(argv[1]);flint_set_num_threads(1);std::vector<int>cv(390625),rev(390625);for(int i=1;i<390625;i++)cv[i]=add(i%5,mul(25,cv[i/5]));for(int i=0;i<390625;i++)rev[cv[i]]=i;
 nmod_poly_t modulus,tmp;nmod_poly_init(modulus,5);nmod_poly_init(tmp,5);int mc[9]={2,2,4,2,0,0,1,0,1};for(int i=0;i<9;i++)nmod_poly_set_coeff_ui(modulus,i,mc[i]);
 fq_nmod_ctx_t ctx;fq_nmod_ctx_init_modulus(ctx,modulus,"a");fq_nmod_t elt;fq_nmod_init(elt,ctx);
 auto setelt=[&](F v){int n=rev[v];nmod_poly_zero(tmp);for(int i=0;i<8;i++){nmod_poly_set_coeff_ui(tmp,i,n%5);n/=5;}fq_nmod_set_nmod_poly(elt,tmp,ctx);};
 auto getelt=[&](){fq_nmod_get_nmod_poly(tmp,elt,ctx);int n=0;for(int i=7;i>=0;i--)n=5*n+nmod_poly_get_coeff_ui(tmp,i);return cv.at(n);};
 auto setpoly=[&](fq_nmod_poly_t p,const Poly&v){fq_nmod_poly_zero(p,ctx);for(size_t i=0;i<v.size();i++)if(v[i]){setelt(v[i]);fq_nmod_poly_set_coeff(p,i,elt,ctx);}};
 auto getpoly=[&](const fq_nmod_poly_t p){Poly v(fq_nmod_poly_length(p,ctx));for(size_t i=0;i<v.size();i++){fq_nmod_poly_get_coeff(elt,p,i,ctx);v[i]=getelt();}v.trim();return v;};
 auto savepoly=[&](const fq_nmod_poly_t p,const std::string&path){auto v=getpoly(p);std::ofstream f(path,std::ios::binary);int n=v.size();f.write((char*)&n,4);f.write((char*)v.data(),4*v.size());};

 fq_nmod_poly_t a,b,g,s,t,u,radic,factor;for(auto*p:{a,b,g,s,t,u,radic,factor})fq_nmod_poly_init(p,ctx);
 auto start=std::chrono::steady_clock::now();std::string in=argv[2],out=argv[3];
 auto readpoly=[&](const std::string&path){std::ifstream f(path,std::ios::binary);int n;f.read((char*)&n,4);if(!f||n<1||n>4000000)throw std::runtime_error("invalid wide polynomial header");Poly v(n);f.read((char*)v.data(),4*n);if(!f)throw std::runtime_error("truncated polynomial");v.trim();return v;};
 // Small exact controls of the new sparse high-multiplicity division.
 for(F root:{F(17),F(31)}){Poly p=ppow(Poly{neg(root),1},117)*ppow(Poly{neg(add(root,1)),1},6),expected=ppow(Poly{neg(add(root,1)),1},6);if(remove_linear(p,root)!=117||p!=expected)throw std::runtime_error("sparse Frobenius division control failed");}
 std::array<int,2>original_degrees;std::array<std::array<unsigned,4>,2>powers;std::array<F,4>roots{0,118020,10149,64426};std::array<Poly,2>inputs;
 for(int k=0;k<2;k++){
  inputs[k]=readpoly(in+"_resultant_"+std::to_string(k)+".bin");original_degrees[k]=inputs[k].deg();
  for(int j=0;j<4;j++)powers[k][j]=remove_linear(inputs[k],roots[j]);
  setpoly(k?b:a,inputs[k]);savepoly(k?b:a,out+"_input_"+std::to_string(k)+".bin");
  std::cerr<<"normalized input "<<k<<" degree "<<inputs[k].deg()<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 }
 std::cerr<<"xgcd degrees "<<fq_nmod_poly_degree(a,ctx)<<','<<fq_nmod_poly_degree(b,ctx)<<"; one FLINT thread\n";
 if(argc==5){int k=0;for(auto*p:{g,s,t}){setpoly(p,readpoly(out+(k==0?"_gcd.bin":(k==1?"_bezout0.bin":"_bezout1.bin"))));k++;}}
 else fq_nmod_poly_xgcd(g,s,t,a,b,ctx);
 std::cerr<<"gcd degree "<<fq_nmod_poly_degree(g,ctx)<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 savepoly(g,out+"_gcd.bin");savepoly(s,out+"_bezout0.bin");savepoly(t,out+"_bezout1.bin");
 Poly gp=getpoly(g),sp=getpoly(s),tp=getpoly(t);int jets=verify_hermite_bezout(inputs[0],inputs[1],sp,tp,gp);
 std::cerr<<"exact Euler-Hermite Bezout passed with "<<jets<<" jets; seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 fq_nmod_poly_factor_t squarefree;fq_nmod_poly_factor_init(squarefree,ctx);fq_nmod_poly_factor_squarefree(squarefree,g,ctx);fq_nmod_poly_one(radic,ctx);
 std::vector<std::array<long,2>>sfdegrees;
 for(slong i=0;i<squarefree->num;i++){
  fq_nmod_poly_factor_get_poly(factor,squarefree,i,ctx);sfdegrees.push_back({fq_nmod_poly_degree(factor,ctx),squarefree->exp[i]});savepoly(factor,out+"_squarefree_"+std::to_string(i)+".bin");
  fq_nmod_poly_mul(u,radic,factor,ctx);fq_nmod_poly_swap(u,radic,ctx);
 }
 savepoly(radic,out+"_allowed_gcd.bin");
 std::ofstream js(out+".json");js<<"{\"status\":\"exact_gcd_and_verified_Bezout\",\"scope\":\"necessary projected support only\",\"original_input_degrees\":["<<original_degrees[0]<<','<<original_degrees[1]<<"],\"normalized_input_degrees\":["<<fq_nmod_poly_degree(a,ctx)<<','<<fq_nmod_poly_degree(b,ctx)<<"],\"gcd_degree\":"<<fq_nmod_poly_degree(g,ctx)<<",\"allowed_gcd_degree\":"<<fq_nmod_poly_degree(radic,ctx)<<",\"removed_chart_factors\":[";
 for(int j=0;j<4;j++){if(j)js<<',';js<<"{\"root\":"<<roots[j]<<",\"input_powers\":["<<powers[0][j]<<','<<powers[1][j]<<"]}";}
 js<<"],\"squarefree_degree_multiplicity\":[";for(size_t i=0;i<sfdegrees.size();i++){if(i)js<<',';js<<'['<<sfdegrees[i][0]<<','<<sfdegrees[i][1]<<']';}
 js<<"],\"allowed_gcd_is_radical\":true,\"exact_Bezout_nodes\":390624,\"exact_Bezout_Euler_jets\":"<<jets<<",\"flint_version\":\""<<FLINT_VERSION<<"\",\"calculation_cores\":1,\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
 std::cerr<<"squarefree allowed projection degree "<<fq_nmod_poly_degree(radic,ctx)<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 for(auto*p:{a,b,g,s,t,u,radic,factor})fq_nmod_poly_clear(p,ctx);fq_nmod_poly_factor_clear(squarefree,ctx);fq_nmod_clear(elt,ctx);fq_nmod_ctx_clear(ctx);nmod_poly_clear(tmp);nmod_poly_clear(modulus);
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}

