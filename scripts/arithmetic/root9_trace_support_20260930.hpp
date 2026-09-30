#pragma once
#include "root9_actual_trace_engine_20260930.hpp"
using namespace infinitytrace;
// Rectangular Laurent support in h,w,Psi,D0; cancellation only shrinks it.
namespace root9bound {
struct B{bool zero=true;int lo[4]={},hi[4]={};};
B mon(int h=0,int w=0,int p=0,int d=0){B z;z.zero=false;z.lo[0]=z.hi[0]=h;z.lo[1]=z.hi[1]=w;z.lo[2]=z.hi[2]=p;z.lo[3]=z.hi[3]=d;return z;}
B add(B a,const B&b){if(a.zero)return b;if(b.zero)return a;for(int i=0;i<4;i++){a.lo[i]=std::min(a.lo[i],b.lo[i]);a.hi[i]=std::max(a.hi[i],b.hi[i]);}return a;}
B mul(B a,const B&b){if(a.zero||b.zero)return {};for(int i=0;i<4;i++){a.lo[i]+=b.lo[i];a.hi[i]+=b.hi[i];}return a;}
B inv(B a){if(a.zero)throw std::runtime_error("zero bound inverse");for(int i=0;i<4;i++){if(a.lo[i]!=a.hi[i])throw std::runtime_error("nonmonomial bound inverse");a.lo[i]=a.hi[i]=-a.lo[i];}return a;}
struct BS{int lo=0,prec=INF;std::vector<B> c;BS()=default;BS(int l,std::vector<B> v,int p=INF):lo(l),prec(p),c(std::move(v)){trim();}
void trim(){if(prec!=INF&&lo+(int)c.size()>prec)c.resize(std::max(0,prec-lo));while(!c.empty()&&c.back().zero)c.pop_back();int j=0;while(j<(int)c.size()&&c[j].zero)j++;if(j){c.erase(c.begin(),c.begin()+j);lo+=j;}if(c.empty())lo=prec;}
int val()const{return c.empty()?prec:lo;}B at(int n)const{if(n>=prec)throw std::runtime_error("bound precision exhausted");return n>=lo&&n<lo+(int)c.size()?c[n-lo]:B{};}};
BS mono(int e,B b=mon()){return BS(e,{b});}
BS shift(BS a,int n){if(a.lo!=INF)a.lo+=n;if(a.prec!=INF)a.prec+=n;return a;}
BS cut(BS a,int n,bool ep=false){a.prec=std::min(a.prec,n);a.trim();if(ep)a.prec=INF;return a;}
BS plus(const BS&a,const BS&b){int p=std::min(a.prec,b.prec),lo=std::min(a.val(),b.val());if(lo>=p)return BS(0,{},p);int hi=std::min(p,std::max(a.c.empty()?lo:a.lo+(int)a.c.size(),b.c.empty()?lo:b.lo+(int)b.c.size()));std::vector<B> c(hi-lo);for(int i=lo;i<hi;i++)c[i-lo]=add(a.at(i),b.at(i));return BS(lo,std::move(c),p);}
BS times(const BS&a,const BS&b){int p=std::min({INF,a.prec==INF?INF:a.prec+b.val(),b.prec==INF?INF:b.prec+a.val()});if(a.c.empty()||b.c.empty())return BS(0,{},p);int lo=a.lo+b.lo,hi=std::min(p,a.lo+(int)a.c.size()+b.lo+(int)b.c.size()-1);if(hi>CAP){hi=CAP;p=std::min(p,CAP);}std::vector<B> c(std::max(0,hi-lo));for(int i=0;i<(int)a.c.size();i++)if(!a.c[i].zero)for(int j=0;j<(int)b.c.size()&&i+j<(int)c.size();j++)if(!b.c[j].zero)c[i+j]=add(c[i+j],mul(a.c[i],b.c[j]));return BS(lo,std::move(c),p);}
BS inverse(const BS&a){if(a.c.empty())throw std::runtime_error("zero bound series");int lo=-a.lo,p=std::min(CAP,a.prec==INF?CAP:a.prec-2*a.lo),n=p-lo;std::vector<B> c(n);c[0]=inv(a.c[0]);for(int i=1;i<n;i++){B t;for(int j=1;j<=i&&j<(int)a.c.size();j++)t=add(t,mul(a.c[j],c[i-j]));c[i]=mul(t,c[0]);}return BS(lo,std::move(c),p);}
BS quotient(const BS&a,const BS&b){return times(a,inverse(b));}
BS pow(BS a,int n){BS o=mono(0);while(n){if(n&1)o=times(o,a);n>>=1;if(n)a=times(a,a);}return o;}
BS fifth(const BS&a){if(a.c.empty())return BS(0,{},a.prec==INF?INF:5*a.prec);int p=a.prec==INF?INF:5*a.prec,lo=5*a.lo,hi=5*(a.lo+(int)a.c.size()-1)+1;if(hi>CAP){hi=CAP;p=std::min(p,CAP);}std::vector<B> c(std::max(0,hi-lo));for(int i=0;5*i<(int)c.size();i++){B b=a.c[i];for(int j=0;j<4;j++){b.lo[j]*=5;b.hi[j]*=5;}c[5*i]=b;}return BS(lo,std::move(c),p);}
BS deriv(const BS&a){BS o=a;if(o.lo!=INF)o.lo--;if(o.prec!=INF)o.prec--;for(int i=0;i<(int)o.c.size();i++)if((a.lo+i)%5==0)o.c[i]=B{};o.trim();return o;}
BS constant_series(const S&a){std::vector<B> c;for(auto z:a.c)c.push_back(z?mon():B{});return BS(a.lo,std::move(c),a.prec);}
BS polynomial(const Poly&p){return constant_series(infinitytrace::polynomial(p));}
BS force(BS a,int lo,B leading){if(a.lo<lo){a.c.erase(a.c.begin(),a.c.begin()+std::min(int(a.c.size()),lo-a.lo));a.lo=lo;}if(a.lo>lo)throw std::runtime_error("bound omitted prescribed leading term");if(a.c.empty())a.c.resize(1);a.c[0]=leading;a.trim();return a;}
}
