// Exact monomials and rank factorization over the recorded GF(5^24).
// Field and cubic multiplication follow atlas_direction_kernel.cpp;
// augmented RREF and original-row verification follow atlas_native_rref.cpp.
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
#include <map>
#include <stdexcept>
#include <vector>
using namespace std;
template<class T>T readv(ifstream&f){T v;f.read((char*)&v,sizeof(v));if(!f)throw runtime_error("truncated input");return v;}
template<class T>void writev(ofstream&f,T v){f.write((char*)&v,sizeof(v));}
void readelt(ifstream&f,fq_nmod_t a,uint32_t d){auto n=readv<uint32_t>(f);if(n>d)throw runtime_error("bad element length");for(uint32_t i=0;i<n;i++){auto c=readv<uint8_t>(f);if(c>4)throw runtime_error("bad F5 coefficient");nmod_poly_set_coeff_ui(a,i,c);}}
void writeelt(ofstream&f,const fq_nmod_t a){uint32_t n=nmod_poly_length(a);writev(f,n);for(uint32_t i=0;i<n;i++)writev(f,uint8_t(nmod_poly_get_coeff_ui(a,i)));}
using Triple=array<fq_nmod_poly_struct,3>;
using Key=array<int,5>;
void init(Triple&t,const fq_nmod_ctx_t k){for(auto&p:t)fq_nmod_poly_init(&p,k);}
void clear(Triple&t,const fq_nmod_ctx_t k){for(auto&p:t)fq_nmod_poly_clear(&p,k);}
void product(Triple&c,const Triple&a,const Triple&b,const fq_nmod_poly_t P,const fq_nmod_ctx_t k){
 fq_nmod_poly_t t;fq_nmod_poly_init(t,k);for(auto&p:c)fq_nmod_poly_zero(&p,k);
 for(int i=0;i<3;i++)for(int j=0;j<3;j++){
  fq_nmod_poly_mul(t,&a[i],&b[j],k);if(i+j>=3)fq_nmod_poly_mul(t,t,P,k);
  fq_nmod_poly_add(&c[(i+j)%3],&c[(i+j)%3],t,k);}
 fq_nmod_poly_clear(t,k);
}
void exponents(vector<Key>&out,Key&key,int at,int remaining){if(at==4){key[at]=remaining;out.push_back(key);return;}for(int a=0;a<=remaining;a++){key[at]=a;exponents(out,key,at+1,remaining-a);}}
vector<Key> exponents(int degree){vector<Key>out;Key key{};exponents(out,key,0,degree);return out;}
int main(int argc,char**argv){try{
 if(argc!=3&&argc!=4)throw runtime_error("input output-prefix [samples-only]");
 flint_set_num_threads(1);auto begin=chrono::steady_clock::now();auto seconds=[&](){return chrono::duration<double>(chrono::steady_clock::now()-begin).count();};
 ifstream input(argv[1],ios::binary);if(readv<uint64_t>(input)!=0x4d39564552373031ULL)throw runtime_error("wrong input magic");
 auto d=readv<uint32_t>(input);if(!d||d>128)throw runtime_error("bad field degree");
 nmod_poly_t mod;nmod_poly_init(mod,5);vector<uint8_t>modcoeff(d+1);
 for(uint32_t i=0;i<=d;i++){modcoeff[i]=readv<uint8_t>(input);if(modcoeff[i]>4)throw runtime_error("bad modulus");nmod_poly_set_coeff_ui(mod,i,modcoeff[i]);}
 if(nmod_poly_degree(mod)!=d||modcoeff[d]!=1)throw runtime_error("nonmonic modulus");
 fq_nmod_ctx_t k;fq_nmod_ctx_init_modulus(k,mod,"e");fq_nmod_t elt;fq_nmod_init(elt,k);
 fq_nmod_poly_t P;fq_nmod_poly_init(P,k);auto plen=readv<uint32_t>(input);
 for(uint32_t i=0;i<plen;i++){fq_nmod_zero(elt,k);readelt(input,elt,d);fq_nmod_poly_set_coeff(P,i,elt,k);}
 array<Triple,5>f;for(auto&t:f){init(t,k);for(auto&p:t){auto n=readv<uint32_t>(input);for(uint32_t i=0;i<n;i++){fq_nmod_zero(elt,k);readelt(input,elt,d);fq_nmod_poly_set_coeff(&p,i,elt,k);}}}
 if(input.peek()!=EOF)throw runtime_error("trailing input");
 map<Key,Triple>cache;Key zero{};init(cache[zero],k);fq_nmod_poly_one(&cache[zero][0],k);
 for(int n=1;n<=4;n++)for(auto tag:exponents(n)){int i=0;while(!tag[i])i++;auto parent=tag;parent[i]--;init(cache[tag],k);product(cache[tag],cache.at(parent),f[i],P,k);}
 auto tags=exponents(7);vector<Triple>columns(tags.size());slong maxdeg=0;
 for(size_t j=0;j<tags.size();j++){auto left=tags[j];Key right{};int remaining=3;for(int i=0;i<5;i++){int moved=min(left[i],remaining);left[i]-=moved;right[i]+=moved;remaining-=moved;}init(columns[j],k);product(columns[j],cache.at(left),cache.at(right),P,k);for(auto&p:columns[j])maxdeg=max(maxdeg,fq_nmod_poly_degree(&p,k));}
 slong rows=3*(maxdeg+1),cols=tags.size();fq_nmod_mat_t M;fq_nmod_mat_init(M,rows,cols,k);
 for(slong j=0;j<cols;j++)for(int c=0;c<3;c++)for(slong n=0;n<=maxdeg;n++)fq_nmod_poly_get_coeff(fq_nmod_mat_entry(M,c*(maxdeg+1)+n,j),&columns[j][c],n,k);
 string prefix=argv[2];vector<uint32_t>samplecols{0,1,2,7,41,329};ofstream sample(prefix+".samples.bin",ios::binary);
 writev(sample,uint32_t(rows));writev(sample,uint32_t(samplecols.size()));for(auto j:samplecols){writev(sample,j);for(slong i=0;i<rows;i++)writeelt(sample,fq_nmod_mat_entry(M,i,j));}sample.close();
 double generated=seconds();if(argc==4){cout<<"{\"samples_only\":true,\"rows\":"<<rows<<",\"columns\":"<<cols<<",\"seconds\":"<<seconds()<<"}"<<endl;return 0;}
 fq_nmod_mat_t aug,reduced;fq_nmod_mat_init(aug,rows,cols+rows,k);fq_nmod_mat_init(reduced,rows,cols+rows,k);
 for(slong i=0;i<rows;i++){for(slong j=0;j<cols;j++)fq_nmod_set(fq_nmod_mat_entry(aug,i,j),fq_nmod_mat_entry(M,i,j),k);fq_nmod_one(fq_nmod_mat_entry(aug,i,cols+i),k);}
 if(fq_nmod_mat_rref(reduced,aug,k)!=rows)throw runtime_error("augmented rank lost");
 slong rank=0;vector<uint32_t>pivots;
 for(slong i=0;i<rows;i++){slong j=0;while(j<cols&&fq_nmod_is_zero(fq_nmod_mat_entry(reduced,i,j),k))j++;if(j<cols){if(i!=rank)throw runtime_error("noncanonical rows");rank++;pivots.push_back(j);}}
 double eliminated=seconds();fq_nmod_mat_t C,A,check;fq_nmod_mat_init(C,rank,rows,k);fq_nmod_mat_init(A,rank,cols,k);fq_nmod_mat_init(check,rank,cols,k);
 for(slong i=0;i<rank;i++){for(slong j=0;j<rows;j++)fq_nmod_set(fq_nmod_mat_entry(C,i,j),fq_nmod_mat_entry(reduced,i,cols+j),k);for(slong j=0;j<cols;j++)fq_nmod_set(fq_nmod_mat_entry(A,i,j),fq_nmod_mat_entry(reduced,i,j),k);}
 fq_nmod_mat_mul(check,C,M,k);if(!fq_nmod_mat_equal(check,A,k))throw runtime_error("C*M != R");
 for(slong i=0;i<rank;i++)for(slong j=0;j<rank;j++){auto v=fq_nmod_mat_entry(A,i,pivots[j]);if(i==j?!fq_nmod_is_one(v,k):!fq_nmod_is_zero(v,k))throw runtime_error("pivot identity lost");}
 double verified=seconds();ofstream cert(prefix+".factor.bin",ios::binary);writev(cert,d);writev(cert,uint32_t(rows));writev(cert,uint32_t(cols));writev(cert,uint32_t(rank));for(auto c:modcoeff)writev(cert,c);for(auto j:pivots)writev(cert,j);for(slong i=0;i<rank;i++)for(slong j=0;j<rows;j++)writeelt(cert,fq_nmod_mat_entry(C,i,j));cert.close();if(!cert)throw runtime_error("certificate write failed");
 cout<<"{\"backend\":\"FLINT_fq_nmod_native_monomials\",\"rows\":"<<rows<<",\"columns\":"<<cols<<",\"rank\":"<<rank<<",\"generation_seconds\":"<<generated<<",\"rref_seconds\":"<<eliminated-generated<<",\"row_identity_seconds\":"<<verified-eliminated<<",\"seconds\":"<<seconds()<<",\"original_row_identity_verified\":true,\"pivot_identity_verified\":true}"<<endl;
 fq_nmod_mat_clear(check,k);fq_nmod_mat_clear(A,k);fq_nmod_mat_clear(C,k);fq_nmod_mat_clear(reduced,k);fq_nmod_mat_clear(aug,k);fq_nmod_mat_clear(M,k);for(auto&t:columns)clear(t,k);for(auto&t:cache)clear(t.second,k);for(auto&t:f)clear(t,k);fq_nmod_poly_clear(P,k);fq_nmod_clear(elt,k);fq_nmod_ctx_clear(k);nmod_poly_clear(mod);flint_cleanup();return 0;
 }catch(const exception&e){cerr<<e.what()<<endl;return 1;}}
