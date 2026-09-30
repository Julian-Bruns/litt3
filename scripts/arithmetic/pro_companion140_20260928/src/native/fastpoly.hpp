#ifndef COMPANION_FASTPOLY_HPP
#define COMPANION_FASTPOLY_HPP
// Included after F is defined, within namespace comp. GMP is included outside.
// Exact Kronecker multiplication over the degree-eight prime-field model of K.
struct FastK {
 static inline bool ready=false;
 static inline std::vector<uint32_t> packed;
 static inline std::array<F,625> lo,hi,tail8;
 static inline std::array<F,125> tail12;
 static inline std::array<unsigned,9> minimal;
 static void init(){
  if(ready)return;
  std::array<F,8> pow;pow[0]=1;for(int i=1;i<8;i++)pow[i]=pow[i-1]*F(25);
  for(int n=0;n<625;n++){
   int v=n;F a=0,b=0;for(int j=0;j<4;j++){a+=F(v%5)*pow[j];b+=F(v%5)*pow[j+4];v/=5;}lo[n]=a;hi[n]=b;
  }
  for(int n=0;n<625;n++){int v=n;F z=0,w=F(25).pow(8);for(int j=0;j<4;j++){z+=F(v%5)*w;w*=F(25);v/=5;}tail8[n]=z;}
  for(int n=0;n<125;n++){int v=n;F z=0,w=F(25).pow(12);for(int j=0;j<3;j++){z+=F(v%5)*w;w*=F(25);v/=5;}tail12[n]=z;}
  packed.resize(F::N);std::vector<bool>used(F::N);
  for(unsigned n=0;n<F::N;n++){
   unsigned v=n,p=0;for(int j=0;j<8;j++){p|=(v%5)<<(3*j);v/=5;}
   unsigned code=(lo[n%625]+hi[n/625]).v;assert(!used[code]);used[code]=true;packed[code]=p;
  }
  // beta=-(a^4+2a^3+a^2+2a)/(a^3+a^2+1).
  // The monic prime-field modulus is A^2+A*D+2D^2.
  unsigned a[5]={0,2,1,2,1},d[4]={1,0,1,1};minimal.fill(0);
  for(int i=0;i<5;i++)for(int j=0;j<5;j++)minimal[i+j]+=a[i]*a[j];
  for(int i=0;i<5;i++)for(int j=0;j<4;j++)minimal[i+j]+=a[i]*d[j];
  for(int i=0;i<4;i++)for(int j=0;j<4;j++)minimal[i+j]+=2*d[i]*d[j];
  for(auto&v:minimal)v%=5;assert(minimal[8]==1);
  F z=0;for(int j=8;j>=0;j--)z=z*F(25)+F(minimal[j]);assert(z==F(0));ready=true;
 }
 template<class Word> static std::vector<F> multiply_words(const std::vector<F>&a,const std::vector<F>&b){
  std::vector<Word> aa(a.size()*16),bb(b.size()*16);
  for(size_t i=0;i<a.size();i++){uint32_t v=packed[a[i].v];for(int j=0;j<8;j++){aa[16*i+j]=v&7;v>>=3;}}
  for(size_t i=0;i<b.size();i++){uint32_t v=packed[b[i].v];for(int j=0;j<8;j++){bb[16*i+j]=v&7;v>>=3;}}
  mpz_t A,B,C;mpz_inits(A,B,C,nullptr);
  mpz_import(A,aa.size(),-1,sizeof(Word),0,0,aa.data());mpz_import(B,bb.size(),-1,sizeof(Word),0,0,bb.data());mpz_mul(C,A,B);
  size_t n=a.size()+b.size()-1,count=0;std::vector<Word> cc((n+1)*16);
  mpz_export(cc.data(),&count,-1,sizeof(Word),0,0,C);assert(count<=cc.size());mpz_clears(A,B,C,nullptr);
  std::vector<F> out(n);
  for(size_t i=0;i<n;i++){
   auto* v=cc.data()+16*i;
   unsigned l=(v[0]%5)+5*(v[1]%5)+25*(v[2]%5)+125*(v[3]%5);
   unsigned h=(v[4]%5)+5*(v[5]%5)+25*(v[6]%5)+125*(v[7]%5);
   unsigned t=(v[8]%5)+5*(v[9]%5)+25*(v[10]%5)+125*(v[11]%5);
   unsigned tt=(v[12]%5)+5*(v[13]%5)+25*(v[14]%5);
   out[i]=lo[l]+hi[h]+tail8[t]+tail12[tt];
  }return out;
 }
 static std::vector<F> multiply(const std::vector<F>&a,const std::vector<F>&b){
  init();if(std::min(a.size(),b.size())<=511)return multiply_words<uint16_t>(a,b);
  if(std::min(a.size(),b.size())>(UINT32_MAX/128))throw std::runtime_error("Kronecker carry bound exceeded");return multiply_words<uint32_t>(a,b);
 }
};
#endif
