// One complete original56-row coupled-R identity, in one native field context.
#include <flint/flint.h>
#include <flint/fq_nmod.h>
#include <flint/fq_nmod_mat.h>
#include <flint/nmod_poly.h>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <sys/resource.h>
using namespace std;
template<class T>T get(ifstream&f){T v;f.read((char*)&v,sizeof(v));if(!f)throw runtime_error("truncated R-check input");return v;}
void element(ifstream&f,fq_nmod_t v,uint32_t degree){
 uint32_t n=get<uint32_t>(f);if(n>degree)throw runtime_error("noncanonical R-check coefficient");
 for(uint32_t i=0;i<n;i++){uint8_t c=get<uint8_t>(f);if(c>4)throw runtime_error("not F5");nmod_poly_set_coeff_ui(v,i,c);}}
void sparse(ifstream&f,fq_nmod_mat_t M,uint32_t d){
 for(slong i=0;i<M->r;i++){uint32_t n=get<uint32_t>(f),last=0;if(n>M->c)throw runtime_error("bad R-check row");
  for(uint32_t h=0;h<n;h++){uint32_t j=get<uint32_t>(f);if(j>=M->c||(h&&j<=last))throw runtime_error("bad R-check column");last=j;element(f,fq_nmod_mat_entry(M,i,j),d);}}}
void dense(ifstream&f,fq_nmod_mat_t M,uint32_t d){
 if(get<uint32_t>(f)!=M->r||get<uint32_t>(f)!=M->c)throw runtime_error("wrong original block shape");
 for(slong i=0;i<M->r;i++)for(slong j=0;j<M->c;j++)element(f,fq_nmod_mat_entry(M,i,j),d);}
int main(int argc,char**argv){try{
 if(argc!=3)throw runtime_error("witness input and direction block required");flint_set_num_threads(1);
 auto start=chrono::steady_clock::now();ifstream input(argv[1],ios::binary);
 if(get<uint64_t>(input)!=0x41544c5257493031ULL)throw runtime_error("wrong R-check witness format");
 uint32_t d=get<uint32_t>(input);if(d<1||d>100000)throw runtime_error("invalid field degree");
 nmod_poly_t modulus;nmod_poly_init(modulus,5);
 for(uint32_t i=0;i<=d;i++){auto c=get<uint8_t>(input);if(c>4)throw runtime_error("invalid modulus");nmod_poly_set_coeff_ui(modulus,i,c);}
 if(nmod_poly_degree(modulus)!=d||nmod_poly_get_coeff_ui(modulus,d)!=1)throw runtime_error("nonmonic modulus");
 fq_nmod_ctx_t k;fq_nmod_ctx_init_modulus(k,modulus,"z");
 fq_nmod_mat_t H,B,I,N,C,R,projected,left,right;
 fq_nmod_mat_init(H,56,64,k);fq_nmod_mat_init(B,56,32,k);fq_nmod_mat_init(I,32,56,k);
 sparse(input,H,d);sparse(input,B,d);sparse(input,I,d);if(input.peek()!=EOF)throw runtime_error("extra witness bytes");
 ifstream block(argv[2],ios::binary);
 if(get<uint64_t>(block)!=0x41544c4449524f31ULL||get<uint32_t>(block)!=d)throw runtime_error("wrong original direction format");
 fq_nmod_mat_init(N,64,32,k);fq_nmod_mat_init(C,32,32,k);fq_nmod_mat_init(R,56,32,k);
 dense(block,N,d);dense(block,C,d);dense(block,R,d);if(block.peek()!=EOF)throw runtime_error("extra original direction bytes");
 fq_nmod_mat_init(projected,32,32,k);fq_nmod_mat_init(left,56,32,k);fq_nmod_mat_init(right,56,32,k);
 fq_nmod_mat_mul(projected,I,R,k);
 if(!fq_nmod_mat_equal(projected,C,k))throw runtime_error("original compact-projection identity failed");
 fq_nmod_mat_mul(left,H,N,k);fq_nmod_mat_mul(right,B,C,k);fq_nmod_mat_add(left,left,right,k);
 bool valid=fq_nmod_mat_equal(left,R,k);
 struct rusage usage;getrusage(RUSAGE_SELF,&usage);uint64_t peak=usage.ru_maxrss;
#ifndef __APPLE__
 peak*=1024;
#endif
 cout<<"{\"backend\":\"FLINT_complete_original_R_identity\",\"degree_F5\":"<<d
     <<",\"valid\":"<<(valid?"true":"false")<<",\"raw_R_rows\":56,\"compact_projection_identity_verified\":true,\"seconds\":"
     <<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<",\"peak_resident_rss_bytes\":"<<peak<<"}"<<endl;
 fq_nmod_mat_clear(H,k);fq_nmod_mat_clear(B,k);fq_nmod_mat_clear(I,k);fq_nmod_mat_clear(N,k);fq_nmod_mat_clear(C,k);fq_nmod_mat_clear(R,k);
 fq_nmod_mat_clear(projected,k);fq_nmod_mat_clear(left,k);fq_nmod_mat_clear(right,k);fq_nmod_ctx_clear(k);nmod_poly_clear(modulus);flint_cleanup();return 0;
}catch(const exception&e){cerr<<e.what()<<endl;return 1;}}
