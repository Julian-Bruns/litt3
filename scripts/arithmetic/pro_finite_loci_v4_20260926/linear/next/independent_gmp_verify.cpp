// Independent certificate verification in the absolute alpha basis.
// No inclusion of field.hpp, Poly, FFT or GCD implementation from the generator.
// The large identity is checked by integer Kronecker substitution with GMP.
#include <gmp.h>
#include <algorithm>
#include <array>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>
namespace fs=std::filesystem;
constexpr int ORDER=390625,N=390624;
constexpr std::array<int,9> MOD={2,2,4,2,0,0,1,0,1};
constexpr std::array<int,8> BETA={2,2,4,1,2,1,3,3};
std::vector<int> logs,exps,code_to_abs,addtab,negatives;
int slowadd(int a,int b){int z=0,t=1;for(int i=0;i<8;i++){z+=((a%5+b%5)%5)*t;t*=5;a/=5;b/=5;}return z;}
int slown(int a){int z=0,t=1;for(int i=0;i<8;i++){z+=((5-a%5)%5)*t;t*=5;a/=5;}return z;}
int timesalpha(int a){int top=a/78125,z=(a%78125)*5;for(int j=0,p=1;j<8;j++,p*=5){int old=(z/p)%5,nw=(old+5-(top*MOD[j])%5)%5;z+=(nw-old)*p;}return z;}
int add(int a,int b){return addtab[(a%625)*625+b%625]+625*addtab[(a/625)*625+b/625];}
int mul(int a,int b){return a&&b?exps[logs[a]+logs[b]]:0;}
struct K{int v=0;K()=default;K(int a){v=(a%5+5)%5;}static K raw(int a){K z;z.v=a;return z;}static K code(int a){if(a<0||a>=ORDER)throw std::runtime_error("bad K code");return raw(code_to_abs[a]);}explicit operator bool()const{return v!=0;}
 K operator+(K b)const{return raw(add(v,b.v));}K operator-()const{return raw(negatives[v]);}K operator-(K b)const{return *this+-b;}K operator*(K b)const{return raw(mul(v,b.v));}K inv()const{if(!v)throw std::runtime_error("inverse zero");return raw(exps[N-logs[v]]);}K operator/(K b)const{return *this*b.inv();}K& operator+=(K b){return *this=*this+b;}K& operator-=(K b){return *this=*this-b;}bool operator==(K b)const{return v==b.v;}bool operator!=(K b)const{return v!=b.v;}K pow(int n)const{if(!n)return K(1);if(!v)return K();return raw(exps[(int64_t(logs[v])*n)%N]);}};
void init(){logs.assign(ORDER,-1);exps.resize(2*N);int a=1;for(int i=0;i<N;i++){if(!a||logs[a]>=0)throw std::runtime_error("absolute alpha not primitive");logs[a]=i;exps[i]=a;a=timesalpha(a);}if(a!=1)throw std::runtime_error("absolute primitive period");for(int i=0;i<N;i++)exps[i+N]=exps[i];addtab.resize(625*625);for(int a=0;a<625;a++)for(int b=0;b<625;b++)addtab[625*a+b]=slowadd(a,b);negatives.resize(ORDER);for(int i=0;i<ORDER;i++)negatives[i]=slown(i);
 int bv=0,p=1;for(int b:BETA){bv+=p*b;p*=5;}K beta=K::raw(bv),alpha=K::raw(5);if(beta*beta!=beta+K(3))throw std::runtime_error("beta equation");std::array<K,4> ai,bi;ai[0]=K(1);bi[0]=beta;for(int j=1;j<4;j++){ai[j]=ai[j-1]*alpha;bi[j]=bi[j-1]*alpha;}code_to_abs.resize(ORDER);std::vector<bool> seen(ORDER);
 for(int c=0;c<ORDER;c++){int n=c;K z;for(int j=0;j<4;j++){int d=n%25;n/=25;z+=ai[j]*K(d%5)+bi[j]*K(d/5);}if(seen[z.v])throw std::runtime_error("coding not bijective");seen[z.v]=true;code_to_abs[c]=z.v;}
 if(alpha.pow(4)+K::code(7)*alpha.pow(3)+K::code(6)*alpha.pow(2)+K::code(2)*alpha+K::code(5)!=K())throw std::runtime_error("fixed alpha equation");}
uint32_t get32(std::istream& f){unsigned char b[4];f.read((char*)b,4);if(!f)throw std::runtime_error("truncated binary");return uint32_t(b[0])+(uint32_t(b[1])<<8)+(uint32_t(b[2])<<16)+(uint32_t(b[3])<<24);}
using Codes=std::vector<uint32_t>;struct Matrix{int rows,cols;Codes data;};
Matrix load(fs::path p){std::ifstream f(p,std::ios::binary);if(!f)throw std::runtime_error("missing "+p.string());Matrix m;m.rows=get32(f);m.cols=get32(f);m.data.resize(size_t(m.rows)*m.cols);for(auto& c:m.data){c=get32(f);if(c>=ORDER)throw std::runtime_error("bad coded coefficient");}if(f.peek()!=EOF)throw std::runtime_error("trailing data");return m;}
Codes polycodes(fs::path p){auto m=load(p);if(m.rows!=1)throw std::runtime_error("not coefficient vector");while(!m.data.empty()&&!m.data.back())m.data.pop_back();return m.data;}
void packed(mpz_t z,const Codes& a,size_t stride){if(a.size()>stride)throw std::runtime_error("Kronecker stride too small");std::vector<uint32_t> words(stride*7+a.size());for(size_t i=0;i<a.size();i++){int c=code_to_abs[a[i]];for(int j=0;j<8;j++){words[j*stride+i]=c%5;c/=5;}}mpz_import(z,words.size(),-1,sizeof(uint32_t),0,0,words.data());}
void verify_large(const Codes&S,const Codes&A,const Codes&T,const Codes&B,const Codes&G){size_t stride=std::max(S.size()+A.size(),T.size()+B.size())-1;uint64_t bound=16ULL*8*(std::min(S.size(),A.size())+std::min(T.size(),B.size()));if(bound>=(1ULL<<32))throw std::runtime_error("integer digit carry bound exceeded");mpz_t s,a,t,b,z,tmp;mpz_inits(s,a,t,b,z,tmp,nullptr);packed(s,S,stride);packed(a,A,stride);packed(t,T,stride);packed(b,B,stride);mpz_mul(z,s,a);mpz_mul(tmp,t,b);mpz_add(z,z,tmp);size_t need=(mpz_sizeinbase(z,2)+31)/32;if(need>15*stride)throw std::runtime_error("unexpected packed degree");std::vector<uint32_t> words(15*stride);size_t actual;mpz_export(words.data(),&actual,-1,sizeof(uint32_t),0,0,z);mpz_clears(s,a,t,b,z,tmp,nullptr);
 for(size_t i=0;i<stride;i++){int c[15];for(int j=0;j<15;j++)c[j]=words[j*stride+i]%5;for(int j=14;j>=8;j--)for(int k=0;k<8;k++)c[j-8+k]=(c[j-8+k]+5-(c[j]*MOD[k])%5)%5;int v=0,p=1;for(int j=0;j<8;j++){v+=c[j]*p;p*=5;}int expected=i<G.size()?code_to_abs[G[i]]:0;if(v!=expected)throw std::runtime_error("independent integer-product Bezout failure");}
}
using Poly=std::vector<K>;void trim(Poly&a){while(!a.empty()&&!a.back())a.pop_back();}
Poly pc(const Codes&v){Poly p;for(auto c:v)p.push_back(K::code(c));trim(p);return p;}
Poly ppadd(Poly a,const Poly&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]+=b[i];trim(a);return a;}
Poly ppmul(const Poly&a,const Poly&b){if(a.empty()||b.empty())return {};Poly c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(a[i])for(size_t j=0;j<b.size();j++)c[i+j]+=a[i]*b[j];trim(c);return c;}
Poly rem(Poly a,const Poly&m){if(m.empty())throw std::runtime_error("poly zero modulus");K inv=m.back().inv();for(int i=int(a.size())-int(m.size());i>=0;i--){K c=a[i+m.size()-1]*inv;for(size_t j=0;j<m.size();j++)a[i+j]-=c*m[j];}trim(a);return a;}
using MP=std::vector<Poly>;
MP load_eq(fs::path f,const Poly&m){auto v=load(f);MP e(v.cols);for(int j=0;j<v.cols;j++){Poly p(v.rows);for(int i=0;i<v.rows;i++)p[i]=K::code(v.data[i*v.cols+j]);trim(p);e[j]=rem(p,m);}return e;}
MP load_u(fs::path f,const Poly&m){auto v=load(f);MP u(v.rows);for(int i=0;i<v.rows;i++){Poly p(v.cols);for(int j=0;j<v.cols;j++)p[j]=K::code(v.data[i*v.cols+j]);trim(p);u[i]=rem(p,m);}return u;}
void verify_small(fs::path dir,fs::path data,const Codes&P,const Codes&G){Poly p=pc(P);Poly g=pc(G),power(5*(p.size()-1)+1);for(size_t i=0;i<p.size();i++)power[5*i]=p[i].pow(5);if(power!=g)throw std::runtime_error("independent fifth power");MP sum;
 for(int n=71;n<=73;n++){auto e=load_eq(data/("E"+std::to_string(n)+".bin"),p),u=load_u(dir/"quotient_0"/("U"+std::to_string(n)+".bin"),p);sum.resize(std::max(sum.size(),e.size()+u.size()-1));for(size_t i=0;i<e.size();i++)if(!e[i].empty())for(size_t j=0;j<u.size();j++)if(!u[j].empty())sum[i+j]=rem(ppadd(sum[i+j],ppmul(e[i],u[j])),p);}
 while(!sum.empty()&&sum.back().empty())sum.pop_back();if(sum.size()!=1||sum[0]!=Poly{K(1)})throw std::runtime_error("independent small quotient Bezout");}
int main(int argc,char**argv){try{if(argc<2)throw std::runtime_error("usage: independent_gmp_verify CERT_DIR [REGENERATED_DATA_DIR]");init();fs::path dir=argv[1],data=argc>2?fs::path(argv[2]):dir;auto S=polycodes(dir/"bezout_72_73_s.bin"),T=polycodes(dir/"bezout_72_73_t.bin"),A=polycodes(data/"Res71_72_stripped.bin"),B=polycodes(data/"Res71_73_stripped.bin"),G=polycodes(dir/"gcd_72_73.bin"),P=polycodes(dir/"gcd_radical_candidate.bin");verify_large(S,A,T,B,G);verify_small(dir,data,P,G);std::cout<<dir.string()<<": independent absolute-field construction, full GMP integer-product Bezout, fifth power and small quotient Bezout PASS; GMP="<<gmp_version<<"\n";return 0;}catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
