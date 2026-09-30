#ifndef DEGREE10_ALGEBRA_HPP
#define DEGREE10_ALGEBRA_HPP
#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <map>
#include <numeric>
#include <random>
#include <stdexcept>
#include <tuple>
#include <string>
#include <sstream>
#include <vector>
using namespace std;
namespace alg {
using F=uint32_t;
constexpr int q=390625, qm=q-1;
inline int add25[25][25],mul25[25][25],neg25[25];
inline vector<int> add625,logs,exps;
inline F primitive=0;
inline F add(F a,F b){return add625[(a%625)*625+b%625]+625*add625[(a/625)*625+b/625];}
inline F neg(F a){F r=0,p=1; for(int i=0;i<4;i++,p*=25,a/=25)r+=p*neg25[a%25];return r;}
inline F sub(F a,F b){return add(a,neg(b));}
inline F rawmul(F a,F b){
 int aa[4],bb[4],cc[7]={};
 for(int i=0;i<4;i++){aa[i]=a%25;a/=25;bb[i]=b%25;b/=25;}
 for(int i=0;i<4;i++)for(int j=0;j<4;j++)cc[i+j]=add25[cc[i+j]][mul25[aa[i]][bb[j]]];
 const int rel[4]={5,2,6,7};
 for(int i=6;i>=4;i--)for(int j=0;j<4;j++)cc[i-4+j]=add25[cc[i-4+j]][neg25[mul25[cc[i]][rel[j]]]];
 F r=0,p=1;for(int i=0;i<4;i++,p*=25)r+=p*cc[i];return r;
}
inline F rawpow(F a,int n){F r=1;while(n){if(n&1)r=rawmul(r,a);n>>=1;if(n)a=rawmul(a,a);}return r;}
inline void init(){
 if(primitive)return;
 for(int a=0;a<25;a++){
  neg25[a]=(5-a%5)%5+5*((5-a/5)%5);
  for(int b=0;b<25;b++){
   add25[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
   int u=a%5,v=a/5,w=b%5,z=b/5;
   mul25[a][b]=(u*w+3*v*z)%5+5*((u*z+v*w+v*z)%5);
  }
 }
 add625.resize(625*625);
 for(int a=0;a<625;a++)for(int b=0;b<625;b++)add625[a*625+b]=add25[a%25][b%25]+25*add25[a/25][b/25];
 for(F g=25;g<q;g++)if(rawpow(g,qm/2)!=1&&rawpow(g,qm/3)!=1&&rawpow(g,qm/13)!=1&&rawpow(g,qm/313)!=1){primitive=g;break;}
 if(!primitive)throw runtime_error("no primitive field element");
 logs.assign(q,-1);exps.resize(2*qm);F a=1;
 for(int i=0;i<qm;i++){if(logs[a]!=-1)throw runtime_error("field log cycle");logs[a]=i;exps[i]=a;a=rawmul(a,primitive);}
 if(a!=1)throw runtime_error("field log closure");
 for(int i=0;i<qm;i++)exps[qm+i]=exps[i];
}
inline F mul(F a,F b){return (a&&b)?exps[logs[a]+logs[b]]:0;}
inline F inv(F a){if(!a)throw runtime_error("inverse zero");return exps[qm-logs[a]];}
inline F div(F a,F b){return mul(a,inv(b));}
inline F pow(F a,uint64_t n){if(!n)return 1;if(!a)return 0;return exps[(uint64_t(logs[a])*n)%qm];}
using Poly=vector<F>;
inline void trim(Poly &a){while(!a.empty()&&!a.back())a.pop_back();}
inline int deg(const Poly&a){return int(a.size())-1;}
inline F coeff(const Poly&a,int i){return i>=0&&i<int(a.size())?a[i]:0;}
inline Poly pa(Poly a,const Poly&b){a.resize(max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=add(a[i],b[i]);trim(a);return a;}
inline Poly ps(Poly a,const Poly&b){a.resize(max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=sub(a[i],b[i]);trim(a);return a;}
inline Poly scale(Poly a,F c){for(F&v:a)v=mul(v,c);trim(a);return a;}
inline Poly pm(const Poly&a,const Poly&b){if(a.empty()||b.empty())return {};Poly c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(a[i])for(size_t j=0;j<b.size();j++)if(b[j])c[i+j]=add(c[i+j],mul(a[i],b[j]));trim(c);return c;}
inline Poly pp(Poly a,int n){Poly c{1};while(n){if(n&1)c=pm(c,a);n>>=1;if(n)a=pm(a,a);}return c;}
inline pair<Poly,Poly> qr(Poly a,const Poly&b){if(b.empty())throw runtime_error("poly division zero");Poly z(max(0,deg(a)-deg(b)+1));F bi=inv(b.back());while(a.size()>=b.size()&&!a.empty()){int d=deg(a)-deg(b);F c=mul(a.back(),bi);z[d]=c;for(size_t j=0;j<b.size();j++)a[d+j]=sub(a[d+j],mul(c,b[j]));trim(a);}trim(z);return {z,a};}
inline Poly rem(const Poly&a,const Poly&b){return qr(a,b).second;}
inline Poly exact(const Poly&a,const Poly&b){auto z=qr(a,b);if(!z.second.empty())throw runtime_error("nonexact poly division");return z.first;}
inline F eval(const Poly&a,F x){F z=0;for(int i=deg(a);i>=0;i--)z=add(mul(z,x),a[i]);return z;}
inline Poly derivative(const Poly&a){Poly r(max(0,deg(a)));for(size_t i=1;i<a.size();i++)r[i-1]=mul(a[i],i%5);trim(r);return r;}
inline Poly monic(const Poly&a){return a.empty()?a:scale(a,inv(a.back()));}
inline Poly gcd(Poly a,Poly b){while(!b.empty()){Poly r=rem(a,b);a=b;b=r;}return monic(a);}
inline tuple<Poly,Poly,Poly> xgcd(Poly a,Poly b){
 Poly s0{1},s1,t0,t1{1};
 while(!b.empty()){
  auto [quot,r]=qr(a,b);a=b;b=r;
  Poly ns=ps(s0,pm(quot,s1)),nt=ps(t0,pm(quot,t1));
  s0=s1;s1=ns;t0=t1;t1=nt;
 }
 if(a.empty())return {a,s0,t0};F c=inv(a.back());return {scale(a,c),scale(s0,c),scale(t0,c)};
}
inline Poly P={11,22,18,5,19,20,15,16,9,22,1};
inline Poly A={1,21,14,22,13};
inline Poly Q={0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24};
inline Poly B={8,14,19,2,10,19,3,24,18,16};
inline Poly L={18,20,20,15};
using Ar=array<Poly,3>;
inline Ar aa(Ar a,const Ar&b){for(int i=0;i<3;i++)a[i]=pa(a[i],b[i]);return a;}
inline Ar as(Ar a,const Ar&b){for(int i=0;i<3;i++)a[i]=ps(a[i],b[i]);return a;}
inline Ar ac(Ar a,F c){for(auto&v:a)v=scale(v,c);return a;}
inline Ar ap(Ar a,const Poly&p){for(auto&v:a)v=pm(v,p);return a;}
inline Ar am(const Ar&a,const Ar&b){Ar c;for(int i=0;i<3;i++)for(int j=0;j<3;j++){Poly z=pm(a[i],b[j]);if(i+j>=3)z=pm(z,P);c[(i+j)%3]=pa(c[(i+j)%3],z);}return c;}
inline Ar ax(int a,int b,F c=1){Ar r;Poly z(a+1);z[a]=c;r[b%3]=pm(z,pp(P,b/3));return r;}
inline Ar power(Ar a,int n){Ar c=ax(0,0);while(n){if(n&1)c=am(c,a);n>>=1;if(n)a=am(a,a);}return c;}
inline bool az(const Ar&a){return a[0].empty()&&a[1].empty()&&a[2].empty();}
inline Ar ar(Ar a,const Poly&p){for(auto&v:a)v=rem(v,p);return a;}
inline Ar adiv(Ar a,const Poly&p){for(auto&v:a)v=exact(v,p);return a;}
inline Poly norm(const Ar&a){return ps(pa(pa(pp(a[0],3),pm(pp(a[1],3),P)),pm(pp(a[2],3),pp(P,2))),scale(pm(pm(pm(a[0],a[1]),a[2]),P),3));}
inline int pole(const Ar&a){int r=-10000;for(int b=0;b<3;b++)if(!a[b].empty())r=max(r,3*deg(a[b])+10*b);return r;}
inline void jpoly(ostream&o,const Poly&a){o<<"[";for(size_t i=0;i<a.size();i++){if(i)o<<",";o<<a[i];}o<<"]";}
inline void jar(ostream&o,const Ar&a){o<<"[";for(int i=0;i<3;i++){if(i)o<<",";jpoly(o,a[i]);}o<<"]";}
inline vector<pair<int,int>> basis(int d){vector<pair<int,int>>r;for(int b=0;b<3;b++)for(int a=0;3*a+10*b<=d;a++)r.push_back({a,b});return r;}
inline int binom(int n,int r){if(r<0||r>n)return 0;int z=1;for(int j=1;j<=r;j++)z=z*(n+1-j)/j;return z%5;}
inline vector<F> roots(const Poly&a){vector<F>r;for(F x=0;x<q;x++)if(!eval(a,x))r.push_back(x);return r;}
}
#endif
