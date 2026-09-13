// One exact original-atlas direction. Shared field context; no scalar CAS objects.
#include <flint/flint.h>
#include <flint/fq_nmod.h>
#include <flint/fq_nmod_mat.h>
#include <flint/fq_nmod_poly.h>
#include <flint/nmod_poly.h>
#include <array>
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <sys/resource.h>
#include <vector>
using namespace std;
template<class T>T get(ifstream&f){T v;f.read((char*)&v,sizeof(v));if(!f)throw runtime_error("truncated input");return v;}
template<class T>void put(ofstream&f,T v){f.write((char*)&v,sizeof(v));}
void element(ifstream&f,fq_nmod_t v,uint32_t degree){
 uint32_t n=get<uint32_t>(f);if(n>degree)throw runtime_error("noncanonical coefficient");
 for(uint32_t i=0;i<n;i++){uint8_t c=get<uint8_t>(f);if(c>4)throw runtime_error("not F5");nmod_poly_set_coeff_ui(v,i,c);}
}
void matrix_in(ifstream&f,fq_nmod_mat_t M,uint32_t d){
 for(slong i=0;i<M->r;i++){uint32_t n=get<uint32_t>(f),last=0;if(n>M->c)throw runtime_error("bad row");
  for(uint32_t h=0;h<n;h++){uint32_t j=get<uint32_t>(f);if(j>=M->c||(h&&j<=last))throw runtime_error("bad column");last=j;element(f,fq_nmod_mat_entry(M,i,j),d);}}
}
struct Term{uint32_t column;uint8_t c0,c1;};
struct BaseMatrix{uint32_t rows,cols;vector<vector<Term>> terms;};
BaseMatrix base_in(ifstream&f,uint32_t rows,uint32_t cols){
 BaseMatrix A{rows,cols,vector<vector<Term>>(rows)};
 for(uint32_t i=0;i<rows;i++)for(uint32_t j=0;j<cols;j++){
  uint8_t a=get<uint8_t>(f),b=get<uint8_t>(f);if(a>4||b>4)throw runtime_error("bad F25 coefficient");
  if(a||b)A.terms[i].push_back({j,a,b});}return A;
}
void base_mul(fq_nmod_mat_t C,const BaseMatrix&A,const fq_nmod_mat_t B,
              const fq_nmod_t a,const fq_nmod_ctx_t k){
 if(C->r!=A.rows||C->c!=B->c||B->r!=A.cols)throw runtime_error("base product dimensions");
 fq_nmod_t t0,t1;fq_nmod_init(t0,k);fq_nmod_init(t1,k);
 for(uint32_t i=0;i<A.rows;i++)for(slong j=0;j<B->c;j++){
  fq_nmod_zero(t0,k);fq_nmod_zero(t1,k);
  for(auto t:A.terms[i]){auto v=fq_nmod_mat_entry(B,t.column,j);
   if(t.c0)nmod_poly_scalar_addmul_nmod(t0,v,t.c0);
   if(t.c1)nmod_poly_scalar_addmul_nmod(t1,v,t.c1);}
  fq_nmod_mul(fq_nmod_mat_entry(C,i,j),a,t1,k);fq_nmod_add(fq_nmod_mat_entry(C,i,j),fq_nmod_mat_entry(C,i,j),t0,k);}
 fq_nmod_clear(t0,k);fq_nmod_clear(t1,k);
}
vector<pair<int,int>> monomials(int pole){
 vector<pair<int,int>> v;for(int j=0;j<3;j++)for(int i=0;3*i+10*j<=pole;i++)v.push_back({i,j});
 sort(v.begin(),v.end(),[](auto x,auto y){return 3*x.first+10*x.second<3*y.first+10*y.second;});return v;
}
using Triple=array<fq_nmod_poly_struct,3>;
void init(Triple&T,const fq_nmod_ctx_t k){for(auto&p:T)fq_nmod_poly_init(&p,k);}
void clear(Triple&T,const fq_nmod_ctx_t k){for(auto&p:T)fq_nmod_poly_clear(&p,k);}
void poly_row(Triple&T,const fq_nmod_mat_t M,int row,const vector<pair<int,int>>&mons,const fq_nmod_ctx_t k){
 if(mons.size()!=M->c)throw runtime_error("monomial dimensions");
 for(size_t h=0;h<mons.size();h++)fq_nmod_poly_set_coeff(&T[mons[h].second],mons[h].first,fq_nmod_mat_entry(M,row,h),k);
}
void derivative(Triple&C,const Triple&A,const fq_nmod_poly_t F,const fq_nmod_poly_t Fp,const fq_nmod_ctx_t k){
 fq_nmod_poly_t t,u;fq_nmod_poly_init(t,k);fq_nmod_poly_init(u,k);fq_nmod_t s;fq_nmod_init(s,k);
 for(auto&p:C)fq_nmod_poly_zero(&p,k);
 for(int j=0;j<3;j++){
  fq_nmod_poly_derivative(t,&A[j],k);
  if(j)fq_nmod_poly_mul(t,t,F,k);
  fq_nmod_poly_add(&C[(j+2)%3],&C[(j+2)%3],t,k);
  if(j){fq_nmod_poly_mul(u,&A[j],Fp,k);fq_nmod_set_ui(s,2*j,k);fq_nmod_poly_scalar_mul_fq_nmod(u,u,s,k);
   fq_nmod_poly_add(&C[j-1],&C[j-1],u,k);}}
 fq_nmod_clear(s,k);fq_nmod_poly_clear(t,k);fq_nmod_poly_clear(u,k);
}
void product(Triple&C,const Triple&A,const Triple&B,const fq_nmod_poly_t F,const fq_nmod_ctx_t k){
 fq_nmod_poly_t t;fq_nmod_poly_init(t,k);for(auto&p:C)fq_nmod_poly_zero(&p,k);
 for(int i=0;i<3;i++)for(int j=0;j<3;j++){
  fq_nmod_poly_mul(t,&A[i],&B[j],k);if(i+j>=3)fq_nmod_poly_mul(t,t,F,k);
  fq_nmod_poly_add(&C[(i+j)%3],&C[(i+j)%3],t,k);}
 fq_nmod_poly_clear(t,k);
}
void fifth(fq_nmod_mat_t A,const fq_nmod_ctx_t k){
 for(slong i=0;i<A->r;i++)for(slong j=0;j<A->c;j++)fq_nmod_pow_ui(fq_nmod_mat_entry(A,i,j),fq_nmod_mat_entry(A,i,j),5,k);
}
void window_product(fq_nmod_mat_t C,const BaseMatrix&A,const fq_nmod_mat_t U,
 const vector<int>&exponents,const fq_nmod_t a,const fq_nmod_ctx_t k){
 fq_nmod_t s0,s1;fq_nmod_init(s0,k);fq_nmod_init(s1,k);
 for(uint32_t i=0;i<A.rows;i++)for(size_t j=0;j<exponents.size();j++){
  fq_nmod_zero(s0,k);fq_nmod_zero(s1,k);
  for(auto term:A.terms[i]){
   int at=int(term.column)-197-5*exponents[j]+112;
   if(at<0||at>=330)continue;auto value=fq_nmod_mat_entry(U,at,0);
   if(term.c0)nmod_poly_scalar_addmul_nmod(s0,value,term.c0);
   if(term.c1)nmod_poly_scalar_addmul_nmod(s1,value,term.c1);}
  fq_nmod_mul(fq_nmod_mat_entry(C,i,j),a,s1,k);fq_nmod_add(fq_nmod_mat_entry(C,i,j),fq_nmod_mat_entry(C,i,j),s0,k);}
 fq_nmod_clear(s0,k);fq_nmod_clear(s1,k);
}
void matrix_out(ofstream&f,const fq_nmod_mat_t A){
 put(f,uint32_t(A->r));put(f,uint32_t(A->c));
 for(slong i=0;i<A->r;i++)for(slong j=0;j<A->c;j++){
  auto v=fq_nmod_mat_entry(A,i,j);uint32_t n=nmod_poly_length(v);put(f,n);
  for(uint32_t h=0;h<n;h++)put(f,uint8_t(nmod_poly_get_coeff_ui(v,h)));}
}
int main(int argc,char**argv){try{
 if(argc!=4)throw runtime_error("input, direction, output required");int direction=stoi(argv[2]);
 if(direction<0||direction>=32)throw runtime_error("invalid direction");flint_set_num_threads(1);
 auto started=chrono::steady_clock::now();auto seconds=[&](){return chrono::duration<double>(chrono::steady_clock::now()-started).count();};
 ifstream input(argv[1],ios::binary);
 if(get<uint64_t>(input)!=0x41544c4449523031ULL)throw runtime_error("wrong direction format");
 uint32_t d=get<uint32_t>(input);if(d<1||d>100000)throw runtime_error("invalid field degree");
 nmod_poly_t modulus;nmod_poly_init(modulus,5);for(uint32_t i=0;i<=d;i++){auto c=get<uint8_t>(input);if(c>4)throw runtime_error("invalid modulus");nmod_poly_set_coeff_ui(modulus,i,c);}
 if(nmod_poly_degree(modulus)!=d||nmod_poly_get_coeff_ui(modulus,d)!=1)throw runtime_error("nonmonic modulus");
 fq_nmod_ctx_t k;fq_nmod_ctx_init_modulus(k,modulus,"z");fq_nmod_t a,t,u;fq_nmod_init(a,k);fq_nmod_init(t,k);fq_nmod_init(u,k);element(input,a,d);
 fq_nmod_mul(t,a,a,k);nmod_poly_scalar_addmul_nmod(t,a,4);fq_nmod_set_ui(u,2,k);fq_nmod_add(t,t,u,k);if(!fq_nmod_is_zero(t,k))throw runtime_error("bad F25 embedding");
 fq_nmod_poly_t F,Fp;fq_nmod_poly_init(F,k);fq_nmod_poly_init(Fp,k);
 int f0[]={1,2,3,0,4,0,0,1,4,2,1},f1[]={2,4,3,1,3,4,3,3,1,4,0};
 for(int i=0;i<11;i++){fq_nmod_set_ui(t,f0[i],k);nmod_poly_scalar_addmul_nmod(t,a,f1[i]);fq_nmod_poly_set_coeff(F,i,t,k);}fq_nmod_poly_derivative(Fp,F,k);
 fq_nmod_mat_t KU,K40,Qc,Bc,Iproj,DB;
 fq_nmod_mat_init(KU,32,104,k);fq_nmod_mat_init(K40,64,184,k);fq_nmod_mat_init(Qc,56,32,k);
 fq_nmod_mat_init(Bc,56,32,k);fq_nmod_mat_init(Iproj,32,56,k);fq_nmod_mat_init(DB,40,32,k);
 matrix_in(input,KU,d);matrix_in(input,K40,d);matrix_in(input,Qc,d);matrix_in(input,Bc,d);matrix_in(input,Iproj,d);
 auto D=base_in(input,40,56),Power=base_in(input,312,56),Inverse=base_in(input,56,56),CurveU=base_in(input,330,104),Rho=base_in(input,56,330),Twice=base_in(input,56,330);
 vector<uint32_t>pivots(56);for(auto&i:pivots){i=get<uint32_t>(input);if(i>=312)throw runtime_error("bad fifth-power pivot");}
 if(input.peek()!=EOF)throw runtime_error("extra direction input");
 base_mul(DB,D,Bc,a,k);fifth(DB,k);fifth(Bc,k);fifth(Qc,k);double setup=seconds();
 Triple U,dU,T,dT,left,right;for(auto*p:{&U,&dU,&T,&dT,&left,&right})init(*p,k);
 auto mU=monomials(112),m40=monomials(192),m320=monomials(320);
 poly_row(U,KU,direction,mU,k);derivative(dU,U,F,Fp,k);
 fq_nmod_mat_t W,selected,coordinates,expanded,ct,N;
 fq_nmod_mat_init(W,312,64,k);fq_nmod_mat_init(selected,56,64,k);fq_nmod_mat_init(coordinates,56,64,k);
 fq_nmod_mat_init(expanded,312,64,k);fq_nmod_mat_init(ct,64,56,k);fq_nmod_mat_init(N,64,32,k);
 for(int h=0;h<64;h++){
  for(auto&p:T)fq_nmod_poly_zero(&p,k);poly_row(T,K40,h,m40,k);derivative(dT,T,F,Fp,k);
  product(left,U,dT,F,k);product(right,T,dU,F,k);for(int j=0;j<3;j++)fq_nmod_poly_sub(&left[j],&left[j],&right[j],k);
  for(size_t r=0;r<m320.size();r++)fq_nmod_poly_get_coeff(fq_nmod_mat_entry(W,r,h),&left[m320[r].second],m320[r].first,k);
  for(int j=0;j<3;j++)for(slong r=(320-10*j)/3+1;r<=fq_nmod_poly_degree(&left[j],k);r++){
   fq_nmod_poly_get_coeff(t,&left[j],r,k);if(!fq_nmod_is_zero(t,k))throw runtime_error("Wronskian outside certified pole bound");}
 }
 for(int i=0;i<56;i++)for(int h=0;h<64;h++)fq_nmod_set(fq_nmod_mat_entry(selected,i,h),fq_nmod_mat_entry(W,pivots[i],h),k);
 base_mul(coordinates,Inverse,selected,a,k);base_mul(expanded,Power,coordinates,a,k);
 if(!fq_nmod_mat_equal(expanded,W,k))throw runtime_error("full Wronskian fifth-power identity failed");
 fq_nmod_mat_transpose(ct,coordinates,k);fq_nmod_mat_mul(N,ct,Qc,k);double n_time=seconds();
 fq_nmod_mat_clear(W,k);fq_nmod_mat_clear(selected,k);fq_nmod_mat_clear(coordinates,k);fq_nmod_mat_clear(expanded,k);fq_nmod_mat_clear(ct,k);
 fq_nmod_mat_t uv,Uwindow,Rleft,Rright,raw,tmp,compact;
 fq_nmod_mat_init(uv,104,1,k);fq_nmod_mat_init(Uwindow,330,1,k);fq_nmod_mat_init(Rleft,56,56,k);fq_nmod_mat_init(Rright,56,40,k);
 fq_nmod_mat_init(raw,56,32,k);fq_nmod_mat_init(tmp,56,32,k);fq_nmod_mat_init(compact,32,32,k);
 for(int i=0;i<104;i++)fq_nmod_set(fq_nmod_mat_entry(uv,i,0),fq_nmod_mat_entry(KU,direction,i),k);base_mul(Uwindow,CurveU,uv,a,k);
 vector<int>target={-1,-2,-4,-5,-7,-8,-11,-14,-17},domain=target;
 for(int i=1;i<48;i++)target.push_back(i);for(int i=1;i<32;i++)domain.push_back(i);
 window_product(Rleft,Twice,Uwindow,target,a,k);window_product(Rright,Rho,Uwindow,domain,a,k);
 fq_nmod_mat_mul(raw,Rleft,Bc,k);fq_nmod_mat_mul(tmp,Rright,DB,k);fq_nmod_mat_sub(raw,raw,tmp,k);fq_nmod_mat_mul(compact,Iproj,raw,k);
 ofstream output(argv[3],ios::binary);put(output,uint64_t(0x41544c4449524f31ULL));put(output,d);matrix_out(output,N);matrix_out(output,compact);matrix_out(output,raw);output.close();if(!output)throw runtime_error("output write failed");
 struct rusage usage;getrusage(RUSAGE_SELF,&usage);uint64_t peak=usage.ru_maxrss;
#ifndef __APPLE__
 peak*=1024;
#endif
 cout<<"{\"backend\":\"FLINT_complete_original_direction\",\"direction\":"<<direction<<",\"degree_F5\":"<<d<<",\"setup_seconds\":"<<setup<<",\"N_seconds\":"<<n_time-setup<<",\"R_and_output_seconds\":"<<seconds()-n_time<<",\"total_seconds\":"<<seconds()<<",\"peak_resident_rss_bytes\":"<<peak<<",\"full_Wronskian_fifth_power_identity_verified\":true,\"raw_R_rows\":56}"<<endl;
 for(auto*p:{&U,&dU,&T,&dT,&left,&right})clear(*p,k);
 fq_nmod_mat_clear(uv,k);fq_nmod_mat_clear(Uwindow,k);fq_nmod_mat_clear(Rleft,k);fq_nmod_mat_clear(Rright,k);fq_nmod_mat_clear(raw,k);fq_nmod_mat_clear(tmp,k);fq_nmod_mat_clear(compact,k);fq_nmod_mat_clear(N,k);
 fq_nmod_mat_clear(KU,k);fq_nmod_mat_clear(K40,k);fq_nmod_mat_clear(Qc,k);fq_nmod_mat_clear(Bc,k);fq_nmod_mat_clear(Iproj,k);fq_nmod_mat_clear(DB,k);
 fq_nmod_poly_clear(F,k);fq_nmod_poly_clear(Fp,k);fq_nmod_clear(a,k);fq_nmod_clear(t,k);fq_nmod_clear(u,k);fq_nmod_ctx_clear(k);nmod_poly_clear(modulus);flint_cleanup();return 0;
}catch(const exception&e){cerr<<e.what()<<endl;return 1;}}
