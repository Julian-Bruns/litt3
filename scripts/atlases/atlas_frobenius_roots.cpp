// Checked inverse Frobenius for one ORIGINAL atlas direction, shared precomputation.
#include <flint/flint.h>
#include <flint/fq_nmod.h>
#include <flint/nmod_mat.h>
#include <flint/nmod_poly.h>
#include <chrono>
#include <cmath>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <sys/resource.h>
using namespace std;
template<class T>T get(ifstream&f){T v;f.read((char*)&v,sizeof(v));if(!f)throw runtime_error("truncated root input");return v;}
template<class T>void put(ofstream&f,T v){f.write((char*)&v,sizeof(v));if(!f)throw runtime_error("root output write failed");}
void element(ifstream&f,nmod_poly_t v,uint32_t degree){
 nmod_poly_zero(v);uint32_t n=get<uint32_t>(f);if(n>degree)throw runtime_error("noncanonical root coefficient");
 for(uint32_t i=0;i<n;i++){uint8_t c=get<uint8_t>(f);if(c>4)throw runtime_error("not F5");nmod_poly_set_coeff_ui(v,i,c);}}
void output(ofstream&f,const nmod_poly_t v){uint32_t n=nmod_poly_length(v);put(f,n);
 for(uint32_t i=0;i<n;i++)put<uint8_t>(f,nmod_poly_get_coeff_ui(v,i));}
int main(int argc,char**argv){try{
 if(argc!=4)throw runtime_error("root-map input, original direction, output required");
 flint_set_num_threads(1);auto start=chrono::steady_clock::now();
 ifstream input(argv[1],ios::binary);
 if(get<uint64_t>(input)!=0x41544c524f4f4931ULL)throw runtime_error("wrong root-map format");
 uint32_t d=get<uint32_t>(input);if(d<2||d>100000)throw runtime_error("invalid degree");
 nmod_poly_t modulus,reverse,inverse,gamma,source,root,check,x;
 for(auto p:{modulus,reverse,inverse,gamma,source,root,check,x})nmod_poly_init(p,5);
 for(uint32_t i=0;i<=d;i++){auto c=get<uint8_t>(input);if(c>4)throw runtime_error("invalid modulus");nmod_poly_set_coeff_ui(modulus,i,c);}
 if(nmod_poly_degree(modulus)!=d||nmod_poly_get_coeff_ui(modulus,d)!=1)throw runtime_error("nonmonic modulus");
 element(input,gamma,d);if(input.peek()!=EOF)throw runtime_error("extra root-map bytes");
 fq_nmod_ctx_t field;fq_nmod_ctx_init_modulus(field,modulus,"z");
 nmod_poly_set_coeff_ui(x,1,1);fq_nmod_pow_ui(check,gamma,5,field);
 if(!nmod_poly_equal(check,x))throw runtime_error("generator fifth-root identity failed");
 nmod_poly_reverse(reverse,modulus,d+1);nmod_poly_inv_series(inverse,reverse,d+1);
 slong m=(slong)sqrt((double)d)+1;nmod_mat_t powers;nmod_mat_init(powers,m,d,5);
 nmod_poly_precompute_matrix(powers,gamma,modulus,inverse);
 double setup=chrono::duration<double>(chrono::steady_clock::now()-start).count();
 ifstream block(argv[2],ios::binary);ofstream out(argv[3],ios::binary|ios::trunc);
 if(get<uint64_t>(block)!=0x41544c4449524f31ULL||get<uint32_t>(block)!=d)throw runtime_error("wrong original direction format");
 put<uint64_t>(out,0x41544c524f4f5431ULL);put<uint32_t>(out,d);uint32_t count=0;
 for(uint32_t rows:{64,32,56}){
  if(get<uint32_t>(block)!=rows||get<uint32_t>(block)!=32)throw runtime_error("wrong original direction shape");
  if(rows!=56){put<uint32_t>(out,rows);put<uint32_t>(out,32);}
  for(uint32_t i=0;i<rows*32;i++){
   element(block,source,d);if(rows==56)continue;
   nmod_poly_compose_mod_brent_kung_precomp_preinv(root,source,powers,modulus,inverse);
   fq_nmod_pow_ui(check,root,5,field);
   if(!nmod_poly_equal(check,source))throw runtime_error("coefficient fifth-root identity failed");
   output(out,root);count++;
  }
 }
 if(block.peek()!=EOF)throw runtime_error("extra original direction bytes");out.close();
 if(!out)throw runtime_error("root output flush failed");
 struct rusage usage;getrusage(RUSAGE_SELF,&usage);uint64_t peak=usage.ru_maxrss;
#ifndef __APPLE__
 peak*=1024;
#endif
 cout<<"{\"backend\":\"FLINT_precomputed_inverse_Frobenius\",\"degree_F5\":"<<d
     <<",\"all_coefficient_fifth_power_identities_verified\":true,\"coefficients\":"<<count
     <<",\"setup_seconds\":"<<setup<<",\"seconds\":"
     <<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<",\"peak_resident_rss_bytes\":"<<peak<<"}"<<endl;
 nmod_mat_clear(powers);fq_nmod_ctx_clear(field);
 for(auto p:{modulus,reverse,inverse,gamma,source,root,check,x})nmod_poly_clear(p);
 flint_cleanup();return 0;
}catch(const exception&e){cerr<<e.what()<<endl;return 1;}}
