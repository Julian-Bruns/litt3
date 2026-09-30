// Fast polynomial division, with the same exact K arithmetic as field.cpp.
#include "field.cpp"
static std::vector<F> truncmul(const std::vector<F>& a,const std::vector<F>& b,int n) {
  auto v=kmul(a.data(),a.size(),b.data(),b.size());if((int)v.size()>n)v.resize(n);trim(v);return v;
}
static std::vector<F> sinv(const std::vector<F>& a,int n) {
  if(a.empty()||!a[0])throw std::runtime_error("zero series constant");
  std::vector<F> g={inv(a[0])};
  for(int m=1;m<n;m*=2) {
    int len=std::min(2*m,n);std::vector<F> ap(a.begin(),a.begin()+std::min((int)a.size(),len));
    auto p=truncmul(ap,g,len);p.resize(len,0);
    for(auto& x:p)x=neg(x);p[0]=add(p[0],2);
    g=truncmul(g,p,len);g.resize(len,0);
  }
  return g;
}
extern "C" int ff_fast_divrem(const F* ap,int na,const F* bp,int nb,F* qp,F* rp) {
  ff_init();if(nb<1||!bp[nb-1])return 0;
  if(na<nb){std::copy(ap,ap+na,rp);qp[0]=0;return 1;}
  int nq=na-nb+1;
  if(nq<64 || nb<64){ff_poly_divrem(ap,na,bp,nb,qp,rp);return 1;}
  std::vector<F> ar(nq),br(std::min(nq,nb));
  for(int i=0;i<nq;++i)ar[i]=ap[na-1-i];
  for(size_t i=0;i<br.size();++i)br[i]=bp[nb-1-i];
  auto revq=truncmul(ar,sinv(br,nq),nq);revq.resize(nq,0);
  for(int i=0;i<nq;++i)qp[i]=revq[nq-1-i];
  auto prod=kmul(qp,nq,bp,nb);
  for(int i=0;i<na;++i)rp[i]=add(ap[i],i<(int)prod.size()?neg(prod[i]):0);
  for(int i=nb-1;i<na;++i)if(rp[i])return -1;
  return 1;
}
