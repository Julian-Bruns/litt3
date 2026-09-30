// Exact fast K[q] multiplication by binary Kronecker packing and GMP.
// Each radix digit bounds a nonnegative integer convolution coefficient;
// thus reduction modulo five is exact, not a modular-image heuristic.
#include "field.cpp"
#include <gmp.h>
#include <cstring>
static std::vector<F> pb_to_code,code_to_pb;
static F alpha8;
static void gp_init(){ff_init();if(!pb_to_code.empty())return;
 pb_to_code.resize(Q);code_to_pb.resize(Q);F ap[8];ap[0]=1;for(int j=1;j<8;++j)ap[j]=mul(ap[j-1],generator);alpha8=mul(ap[7],generator);
 F value=0;for(int i=0;i<Q;++i){pb_to_code[i]=value;code_to_pb[value]=i;int d=i;for(int j=0;j<8;++j){value=add(value,ap[j]);if(d%5!=4)break;d/=5;}}
 // All 5^8 power-basis words must give distinct original K codes.
 for(int i=0;i<Q;++i)if(pb_to_code[code_to_pb[i]]!=F(i))throw std::runtime_error("power basis is not bijective");
}
static void pack_gmp(mpz_t out,const F*a,int n,unsigned bits){size_t nbits=((size_t)(n-1)*15+8)*bits;std::vector<uint64_t>words((nbits+63)/64+1,0);
 for(int i=0;i<n;++i){F word=code_to_pb[a[i]];for(int j=0;j<8;++j){uint64_t d=word%5;word/=5;size_t pos=((size_t)i*15+j)*bits;unsigned sh=pos%64;words[pos/64]|=d<<sh;if(sh>61)words[pos/64+1]|=d>>(64-sh);}}
 mpz_import(out,words.size(),-1,sizeof(uint64_t),0,0,words.data());
}
static std::vector<F> gmul(const F*a,int na,const F*b,int nb){
 while(na>0&&!a[na-1])--na;while(nb>0&&!b[nb-1])--nb;if(!na||!nb)return {};
 if(std::min(na,nb)<64||std::max(na,nb)<256)return kmul(a,na,b,nb);
 gp_init();uint64_t bound=128ULL*std::min(na,nb);unsigned bits=1;while((1ULL<<bits)<=bound)++bits;if(bits>=63)throw std::runtime_error("packing coefficient bound too large");
 mpz_t aa,bb,cc;mpz_inits(aa,bb,cc,nullptr);pack_gmp(aa,a,na,bits);pack_gmp(bb,b,nb,bits);mpz_mul(cc,aa,bb);mpz_clears(aa,bb,nullptr);
 int nc=na+nb-1;size_t nbits=(size_t)nc*15*bits;std::vector<uint64_t>words((nbits+63)/64+1,0);size_t wrote=0;mpz_export(words.data(),&wrote,-1,sizeof(uint64_t),0,0,cc);mpz_clear(cc);if(wrote>=words.size())throw std::runtime_error("GMP export overflow");
 uint64_t mask=(1ULL<<bits)-1;std::vector<F>out(nc);
 for(int i=0;i<nc;++i){F low=0,high=0,p=1;for(int j=0;j<15;++j){size_t pos=((size_t)i*15+j)*bits;unsigned sh=pos%64;uint64_t d=words[pos/64]>>sh;if(sh+bits>64)d|=words[pos/64+1]<<(64-sh);d=(d&mask)%5;if(j==8)p=1;if(j<8)low+=p*d;else high+=p*d;p*=5;}out[i]=add(pb_to_code[low],mul(alpha8,pb_to_code[high]));}trim(out);return out;
}
static std::vector<F> gtrunc(const std::vector<F>&a,const std::vector<F>&b,int n){auto out=gmul(a.data(),a.size(),b.data(),b.size());if(int(out.size())>n)out.resize(n);trim(out);return out;}
static std::vector<F> gsinv(const std::vector<F>&a,int n){if(a.empty()||!a[0])throw std::runtime_error("nonunit series constant");std::vector<F>g={inv(a[0])};
 for(int m=1;m<n;m*=2){int len=std::min(2*m,n);std::vector<F>ap(a.begin(),a.begin()+std::min(int(a.size()),len));auto p=gtrunc(ap,g,len);p.resize(len,0);for(auto&x:p)x=neg(x);p[0]=add(p[0],2);g=gtrunc(g,p,len);g.resize(len,0);}return g;}
static std::pair<std::vector<F>,std::vector<F>> gdv(const std::vector<F>&a,const std::vector<F>&b){if(b.empty())throw std::runtime_error("zero divisor polynomial");int na=a.size(),nb=b.size(),nq=na-nb+1;if(nq<=0)return {{},a};std::vector<F>q(nq),r(na);
 if(nq<64||nb<64){ff_poly_divrem(a.data(),na,b.data(),nb,q.data(),r.data());r.resize(nb-1);trim(q);trim(r);return {q,r};}
 std::vector<F>ar(nq),br(std::min(nq,nb));for(int i=0;i<nq;++i)ar[i]=a[na-1-i];for(int i=0;i<int(br.size());++i)br[i]=b[nb-1-i];auto rq=gtrunc(ar,gsinv(br,nq),nq);rq.resize(nq,0);for(int i=0;i<nq;++i)q[i]=rq[nq-1-i];auto prod=gmul(q.data(),nq,b.data(),nb);for(int i=0;i<na;++i)r[i]=add(a[i],i<int(prod.size())?neg(prod[i]):0);for(int i=nb-1;i<na;++i)if(r[i])throw std::runtime_error("division reconstruction failed");r.resize(nb-1);trim(q);trim(r);return {q,r};}
extern "C" int gp_mul(const F*a,int na,const F*b,int nb,F*out,int nc){try{gp_init();auto r=gmul(a,na,b,nb);std::fill(out,out+nc,0);std::copy(r.begin(),r.begin()+std::min(int(r.size()),nc),out);return 1;}catch(...){return 0;}}
extern "C" int gp_divrem(const F*a,int na,const F*b,int nb,F*q,F*r){try{gp_init();auto qr=gdv(std::vector<F>(a,a+na),std::vector<F>(b,b+nb));std::fill(q,q+std::max(1,na-nb+1),0);std::fill(r,r+na,0);std::copy(qr.first.begin(),qr.first.end(),q);std::copy(qr.second.begin(),qr.second.end(),r);return 1;}catch(...){return 0;}}
extern "C" const char* gp_version(){return gmp_version;}
