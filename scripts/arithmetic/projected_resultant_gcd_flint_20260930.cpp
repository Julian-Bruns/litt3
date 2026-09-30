// Fast exact gcd/Bezout over the same explicitly embedded F_(5^8).
// Only factors of the original nonzero q-chart are removed afterwards.
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
int main(int argc,char**argv){try{
 if(argc!=4&&argc!=5)throw std::runtime_error("usage: gcd_flint FIELD INPUT_PREFIX OUTPUT_PREFIX [resume]");
 loadfield(argv[1]);flint_set_num_threads(1);std::vector<int>cv(390625),rev(390625);for(int i=1;i<390625;i++)cv[i]=add(i%5,mul(25,cv[i/5]));for(int i=0;i<390625;i++)rev[cv[i]]=i;
 nmod_poly_t modulus,tmp;nmod_poly_init(modulus,5);nmod_poly_init(tmp,5);int mc[9]={2,2,4,2,0,0,1,0,1};for(int i=0;i<9;i++)nmod_poly_set_coeff_ui(modulus,i,mc[i]);
 fq_nmod_ctx_t ctx;fq_nmod_ctx_init_modulus(ctx,modulus,"a");fq_nmod_t elt;fq_nmod_init(elt,ctx);
 auto setelt=[&](F v){int n=rev[v];nmod_poly_zero(tmp);for(int i=0;i<8;i++){nmod_poly_set_coeff_ui(tmp,i,n%5);n/=5;}fq_nmod_set_nmod_poly(elt,tmp,ctx);};
 auto getelt=[&](){fq_nmod_get_nmod_poly(tmp,elt,ctx);int n=0;for(int i=7;i>=0;i--)n=5*n+nmod_poly_get_coeff_ui(tmp,i);return cv.at(n);};
 auto setpoly=[&](fq_nmod_poly_t p,const Poly&v){fq_nmod_poly_zero(p,ctx);for(size_t i=0;i<v.size();i++)if(v[i]){setelt(v[i]);fq_nmod_poly_set_coeff(p,i,elt,ctx);}};
 auto getpoly=[&](const fq_nmod_poly_t p){Poly v(fq_nmod_poly_length(p,ctx));for(size_t i=0;i<v.size();i++){fq_nmod_poly_get_coeff(elt,p,i,ctx);v[i]=getelt();}v.trim();return v;};
 auto savepoly=[&](const fq_nmod_poly_t p,const std::string&path){auto v=getpoly(p);std::ofstream f(path,std::ios::binary);int n=v.size();f.write((char*)&n,4);f.write((char*)v.data(),4*v.size());};
 fq_nmod_poly_t a,b,g,s,t,check,u,chart,factor,gg;for(auto*p:{a,b,g,s,t,check,u,chart,factor,gg})fq_nmod_poly_init(p,ctx);
 auto start=std::chrono::steady_clock::now();std::string in=argv[2],out=argv[3];
 for(int k=0;k<2;k++){std::ifstream f(in+"_resultant_"+std::to_string(k)+".bin",std::ios::binary);int n;f.read((char*)&n,4);if(!f||n<1||n>390624)throw std::runtime_error("bad resultant header");Poly v(n);f.read((char*)v.data(),4*n);if(!f)throw std::runtime_error("truncated resultant");setpoly(k?b:a,v);}
 std::cerr<<"xgcd degrees "<<fq_nmod_poly_degree(a,ctx)<<','<<fq_nmod_poly_degree(b,ctx)<<"; one FLINT thread\n";
 if(argc==5){
  int k=0;for(auto*p:{g,s,t}){std::string suffix=k==0?"_gcd.bin":(k==1?"_bezout0.bin":"_bezout1.bin");std::ifstream f(out+suffix,std::ios::binary);int n;f.read((char*)&n,4);if(!f||n<1||n>390624)throw std::runtime_error("bad saved Bezout header");Poly v(n);f.read((char*)v.data(),4*n);if(!f)throw std::runtime_error("truncated saved Bezout");setpoly(p,v);k++;}
 }else fq_nmod_poly_xgcd(g,s,t,a,b,ctx);
 std::cerr<<"gcd degree "<<fq_nmod_poly_degree(g,ctx)<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 savepoly(g,out+"_gcd.bin");savepoly(s,out+"_bezout0.bin");savepoly(t,out+"_bezout1.bin");
 // Both Bezout products have degree below5^8-1. Verify their identity
 // at all multiplicative-group values by fast transforms; no expanded
 // extension-field products or statistical spot check is used.
 const int N=390624;F omega=EX[1];
 if(std::max(fq_nmod_poly_degree(s,ctx)+fq_nmod_poly_degree(a,ctx),fq_nmod_poly_degree(t,ctx)+fq_nmod_poly_degree(b,ctx))>=N)throw std::runtime_error("Bezout bound exceeds DFT");
 auto transform=[&](const fq_nmod_poly_t p){auto v=getpoly(p);v.resize(N);return dft(v,omega);};
 auto av=transform(a),bv=transform(b),sv=transform(s),tv=transform(t),gv=transform(g);
 for(int i=0;i<N;i++)if(add(mul(av[i],sv[i]),mul(bv[i],tv[i]))!=gv[i])throw std::runtime_error("exact DFT Bezout identity failed");
 std::cerr<<"exact DFT Bezout checked seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 Poly cp=Poly{0,1}*Poly{4,1}*Poly{neg(15383),1}*Poly{89654,311173,214299,163299,315361,33043,356725,245794};setpoly(chart,cp);
 fq_nmod_poly_factor_t factors,squarefree;fq_nmod_poly_factor_init(factors,ctx);fq_nmod_poly_factor_init(squarefree,ctx);fq_nmod_poly_factor(factors,elt,chart,ctx);
 fq_nmod_poly_set(gg,g,ctx);std::vector<Poly>units;std::vector<unsigned long>powers;
 for(slong i=0;i<factors->num;i++){fq_nmod_poly_factor_get_poly(factor,factors,i,ctx);units.push_back(getpoly(factor));powers.push_back(fq_nmod_poly_remove(gg,factor,ctx));std::cerr<<"chart factor "<<i<<" power "<<powers.back()<<" remaining degree "<<fq_nmod_poly_degree(gg,ctx)<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';}
 savepoly(gg,out+"_allowed_with_multiplicities.bin");
 fq_nmod_poly_factor_squarefree(squarefree,gg,ctx);fq_nmod_poly_one(gg,ctx);
 std::vector<std::array<long,2>>sfdegrees;
 for(slong i=0;i<squarefree->num;i++){fq_nmod_poly_factor_get_poly(factor,squarefree,i,ctx);sfdegrees.push_back({fq_nmod_poly_degree(factor,ctx),squarefree->exp[i]});savepoly(factor,out+"_squarefree_"+std::to_string(i)+".bin");fq_nmod_poly_mul(u,gg,factor,ctx);fq_nmod_poly_swap(u,gg,ctx);}
 std::cerr<<"squarefree support degree "<<fq_nmod_poly_degree(gg,ctx)<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 savepoly(gg,out+"_allowed_gcd.bin");
 std::ofstream js(out+".json");js<<"{\"status\":\"exact_gcd_and_verified_Bezout\",\"scope\":\"necessary projected support only\",\"input_degrees\":["<<fq_nmod_poly_degree(a,ctx)<<','<<fq_nmod_poly_degree(b,ctx)<<"],\"gcd_degree\":"<<fq_nmod_poly_degree(g,ctx)<<",\"allowed_gcd_degree\":"<<fq_nmod_poly_degree(gg,ctx)<<",\"removed_units\":[";
 for(size_t i=0;i<units.size();i++){if(i)js<<',';js<<"{\"factor\":";jsonpoly(js,units[i]);js<<",\"power\":"<<powers[i]<<'}';}
 js<<"],\"squarefree_degree_multiplicity\":[";for(size_t i=0;i<sfdegrees.size();i++){if(i)js<<',';js<<'['<<sfdegrees[i][0]<<','<<sfdegrees[i][1]<<']';}
 js<<"],\"allowed_gcd_is_radical\":true,\"exact_Bezout_DFT_size\":390624,\"absolute_field_modulus\":[2,2,4,2,0,0,1,0,1],\"flint_version\":\""<<FLINT_VERSION<<"\",\"calculation_cores\":1,\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
 std::cerr<<"allowed gcd degree "<<fq_nmod_poly_degree(gg,ctx)<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 for(auto*p:{a,b,g,s,t,check,u,chart,factor,gg})fq_nmod_poly_clear(p,ctx);fq_nmod_poly_factor_clear(factors,ctx);fq_nmod_poly_factor_clear(squarefree,ctx);fq_nmod_clear(elt,ctx);fq_nmod_ctx_clear(ctx);nmod_poly_clear(tmp);nmod_poly_clear(modulus);
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
