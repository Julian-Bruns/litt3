// Exact Kronecker multiplication in K[x] via GMP integer multiplication.
// K = F5[beta,alpha], beta^2=beta+3, alpha^4+7 alpha^3+6 alpha^2+2 alpha+5=0.
// Each x coefficient occupies 21 radix digits: alpha-degree 0..6,
// beta-degree 0..2. A digit uses enough bits to prevent ALL integer carries.
#include <gmp.h>
static KP ks_pmul(const KP&a,const KP&b){
 if(a.empty()||b.empty())return {};
 uint64_t bound=128ULL*min(a.size(),b.size());unsigned bits=1;
 while((uint64_t(1)<<bits)<=bound)bits++;
 if(bits>=61)throw runtime_error("Kronecker input length exceeds exact packing bound");
 auto pack=[bits](const KP&v,mpz_t z){
  size_t total=v.size()*21ULL*bits;vector<uint64_t>w((total+63)/64+1,0);
  for(size_t i=0;i<v.size();i++){
   int c=v[i];for(int j=0;j<4;j++){
    int f=c%25;c/=25;int dd[2]={f%5,f/5};
    for(int k=0;k<2;k++)if(dd[k]){
     size_t bit=(i*21+3*j+k)*bits,at=bit/64;unsigned sh=bit%64;
     w[at]|=uint64_t(dd[k])<<sh;
     if(sh>61)w[at+1]|=uint64_t(dd[k])>>(64-sh);
    }
   }
  }
  mpz_import(z,w.size(),-1,sizeof(uint64_t),0,0,w.data());
 };
 mpz_t A,B,C;mpz_inits(A,B,C,nullptr);pack(a,A);pack(b,B);mpz_mul(C,A,B);
 size_t n=a.size()+b.size()-1;vector<uint64_t>w((n*21ULL*bits+63)/64+2,0);size_t nw=0;
 mpz_export(w.data(),&nw,-1,sizeof(uint64_t),0,0,C);mpz_clears(A,B,C,nullptr);
 if(nw>w.size())throw runtime_error("Kronecker export overflow");
 const uint64_t mask=(uint64_t(1)<<bits)-1;KP out(n,0);int mod[4]={5,2,6,7};
 for(size_t i=0;i<n;i++){
  int c[7];for(int j=0;j<7;j++){
   int d[3];for(int k=0;k<3;k++){
    size_t bit=(i*21+3*j+k)*bits,at=bit/64;unsigned sh=bit%64;
    uint64_t v=w[at]>>sh;if(sh&&sh+bits>64)v|=w[at+1]<<(64-sh);
    d[k]=int((v&mask)%5);
   }
   c[j]=(d[0]+3*d[2])%5+5*((d[1]+d[2])%5);
  }
  for(int j=6;j>=4;j--)for(int k=0;k<4;k++)c[j-4+k]=add25(c[j-4+k],neg25(mul25(c[j],mod[k])));
  for(int j=3;j>=0;j--)out[i]=25*out[i]+c[j];
 }
 while(!out.empty()&&!out.back())out.pop_back();return out;
}
