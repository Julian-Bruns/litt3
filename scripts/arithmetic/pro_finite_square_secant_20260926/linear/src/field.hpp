#pragma once
#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <map>
#include <numeric>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <tuple>
#include <utility>
#include <vector>
namespace exact {
using F=uint32_t;
constexpr unsigned CARD=390625, ORDER=CARD-1;
inline std::vector<F> expt, logs, invt;
inline std::vector<uint16_t> adds, subs;
inline F add(F a,F b){return adds[(a%625)*625+(b%625)]+625u*adds[(a/625)*625+b/625];}
inline F sub(F a,F b){return subs[(a%625)*625+(b%625)]+625u*subs[(a/625)*625+b/625];}
inline F neg(F a){return sub(0,a);}
inline F mul(F a,F b){if(!a||!b)return 0;return expt[logs[a]+logs[b]];}
inline F inv(F a){if(!a)throw std::runtime_error("inverse of zero");return invt[a];}
inline F divi(F a,F b){return mul(a,inv(b));}
inline F fpow(F a,long long n){if(n<0)return fpow(inv(a),-n);if(!n)return 1;if(!a)return 0;return expt[(uint64_t(logs[a])*(n%ORDER))%ORDER];}
inline F add25(F a,F b){return (a%5+b%5)%5+5*((a/5+b/5)%5);}
inline F neg25(F a){return (5-a%5)%5+5*((5-a/5)%5);}
inline F mul25(F a,F b){unsigned a0=a%5,a1=a/5,b0=b%5,b1=b/5;return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5);}
inline F slowmul(F a,F b){
 F A[4],B[4],C[7]={};for(int i=0;i<4;i++){A[i]=a%25;a/=25;B[i]=b%25;b/=25;}
 for(int i=0;i<4;i++)for(int j=0;j<4;j++)C[i+j]=add25(C[i+j],mul25(A[i],B[j]));
 const F coeff[4]={5,2,6,7};
 for(int n=6;n>=4;n--)for(int j=0;j<4;j++)C[n-4+j]=add25(C[n-4+j],neg25(mul25(C[n],coeff[j])));
 F out=0;for(int j=3;j>=0;j--)out=out*25+C[j];return out;
}
inline F slowpow(F a,unsigned n){F b=1;while(n){if(n&1)b=slowmul(b,a);a=slowmul(a,a);n>>=1;}return b;}
inline F primitive=0;
inline void init(){
 if(!expt.empty())return;
 adds.resize(625*625);subs.resize(625*625);
 for(unsigned i=0;i<625;i++)for(unsigned j=0;j<625;j++){
  unsigned a=i,b=j,s=0,d=0,scale=1;
  for(int z=0;z<4;z++){s+=((a%5+b%5)%5)*scale;d+=((a%5+5-b%5)%5)*scale;a/=5;b/=5;scale*=5;}
  adds[i*625+j]=s;subs[i*625+j]=d;
 }
 unsigned n=ORDER;std::vector<unsigned> primes;
 for(unsigned p=2;p*p<=n;p++)if(n%p==0){primes.push_back(p);while(n%p==0)n/=p;}if(n>1)primes.push_back(n);
 for(F g=25;g<CARD;g++){
  bool ok=slowpow(g,ORDER)==1;
  for(auto p:primes)if(slowpow(g,ORDER/p)==1)ok=false;
  if(ok){primitive=g;break;}
 }
 if(!primitive)throw std::runtime_error("could not find primitive element");
 expt.resize(2*ORDER+1);logs.resize(CARD);invt.resize(CARD);
 F a=1;std::vector<bool> seen(CARD);
 for(unsigned i=0;i<ORDER;i++){assert(a&&!seen[a]);seen[a]=true;expt[i]=a;logs[a]=i;a=slowmul(a,primitive);}
 assert(a==1);for(unsigned i=ORDER;i<expt.size();i++)expt[i]=expt[i-ORDER];
 for(unsigned i=1;i<CARD;i++)invt[i]=expt[ORDER-logs[i]];
}
using Poly=std::vector<F>;
inline void trim(Poly &a){while(!a.empty()&&!a.back())a.pop_back();}
inline int deg(const Poly&a){return int(a.size())-1;}
inline F coeff(const Poly&a,int i){return i>=0&&i<int(a.size())?a[i]:0;}
inline Poly operator+(Poly a,const Poly&b){a.resize(std::max(a.size(),b.size()));for(unsigned i=0;i<b.size();i++)a[i]=add(a[i],b[i]);trim(a);return a;}
inline Poly operator-(Poly a,const Poly&b){a.resize(std::max(a.size(),b.size()));for(unsigned i=0;i<b.size();i++)a[i]=sub(a[i],b[i]);trim(a);return a;}
inline Poly scale(Poly a,F k){for(auto&c:a)c=mul(c,k);trim(a);return a;}
inline Poly operator*(const Poly&a,const Poly&b){if(a.empty()||b.empty())return {};Poly c(a.size()+b.size()-1);for(unsigned i=0;i<a.size();i++)if(a[i])for(unsigned j=0;j<b.size();j++)if(b[j])c[i+j]=add(c[i+j],mul(a[i],b[j]));trim(c);return c;}
inline Poly shift(Poly a,int n){if(n>=0){if(!a.empty())a.insert(a.begin(),n,0);}else{if(-n>=int(a.size()))return {};a.erase(a.begin(),a.begin()-n);}return a;}
inline Poly power(Poly a,unsigned n){Poly b={1};while(n){if(n&1)b=b*a;a=a*a;n>>=1;}return b;}
inline Poly frob(Poly a){if(a.empty())return a;Poly b(5*a.size()-4);for(unsigned i=0;i<a.size();i++)b[5*i]=fpow(a[i],5);trim(b);return b;}
inline std::pair<Poly,Poly> divrem(Poly a,const Poly&b){if(b.empty())throw std::runtime_error("poly divide zero");Poly q(std::max(0,deg(a)-deg(b)+1));F ib=inv(b.back());for(int i=deg(a)-deg(b);i>=0;i--){F c=mul(coeff(a,i+deg(b)),ib);q[i]=c;if(c)for(unsigned j=0;j<b.size();j++)a[i+j]=sub(a[i+j],mul(c,b[j]));}trim(a);trim(q);return {q,a};}
inline Poly mod(const Poly&a,const Poly&b){return divrem(a,b).second;}
inline Poly quo(const Poly&a,const Poly&b){auto z=divrem(a,b);if(!z.second.empty())throw std::runtime_error("inexact polynomial quotient");return z.first;}
inline F eval(const Poly&a,F t){F u=0;for(int i=deg(a);i>=0;i--)u=add(mul(u,t),a[i]);return u;}
inline Poly diff(Poly a){if(a.empty())return {};for(unsigned i=1;i<a.size();i++)a[i-1]=mul(i%5,a[i]);a.pop_back();trim(a);return a;}
inline Poly gcd(Poly a,Poly b){while(!b.empty()){auto c=mod(a,b);a=b;b=c;}return a.empty()?a:scale(a,inv(a.back()));}
inline std::tuple<Poly,Poly,Poly> xgcd(Poly a,Poly b){Poly u={1},v={},s={},t={1};while(!b.empty()){auto[q,r]=divrem(a,b);a=b;b=r;auto nu=u-q*s;auto nv=v-q*t;u=s;v=t;s=nu;t=nv;}if(a.empty())return {a,u,v};F k=inv(a.back());return {scale(a,k),scale(u,k),scale(v,k)};}
inline Poly trunc(Poly a,unsigned n){if(a.size()>n)a.resize(n);trim(a);return a;}
inline Poly multrunc(const Poly&a,const Poly&b,unsigned n){if(a.empty()||b.empty())return {};Poly c(std::min<unsigned>(a.size()+b.size()-1,n));for(unsigned i=0;i<a.size()&&i<n;i++)if(a[i])for(unsigned j=0;j<b.size()&&i+j<n;j++)if(b[j])c[i+j]=add(c[i+j],mul(a[i],b[j]));trim(c);return c;}
inline Poly powtrunc(Poly a,unsigned k,unsigned n){Poly b={1};while(k){if(k&1)b=multrunc(b,a,n);a=multrunc(a,a,n);k>>=1;}return b;}
inline Poly invseries(const Poly&a,unsigned n){if(!coeff(a,0))throw std::runtime_error("nonunit series");Poly b(n);b[0]=inv(a[0]);for(unsigned j=1;j<n;j++){F s=0;for(unsigned i=1;i<=j&&i<a.size();i++)s=add(s,mul(a[i],b[j-i]));b[j]=neg(mul(b[0],s));}trim(b);return b;}
inline void printpoly(std::ostream&o,const Poly&a){o<<'[';for(unsigned i=0;i<a.size();i++){if(i)o<<',';o<<a[i];}o<<']';}
inline const Poly P={11,22,18,5,19,20,15,16,9,22,1}, A={1,21,14,22,13},Q={0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24};
inline const Poly B0={8,14,19,2,10,19,3,24,18,16},L0={18,20,20,15};
inline Poly tpoly(){return scale(quo(A,{neg(25),1}),inv(13));}
inline Poly CP=P; // Cubic relation; default y^3=P, optionally Y^3=P/q.
struct Fun {
 std::array<Poly,3> a;
 Fun()=default;
 Fun(F v){if(v)a[0]={v};}
 Fun(Poly p){a[0]=std::move(p);}
 bool operator==(const Fun&b)const{return a==b.a;}
 bool operator!=(const Fun&b)const{return a!=b.a;}
 bool zero()const{return a[0].empty()&&a[1].empty()&&a[2].empty();}
};
inline Fun operator+(Fun a,const Fun&b){for(int i=0;i<3;i++)a.a[i]=a.a[i]+b.a[i];return a;}
inline Fun operator-(Fun a,const Fun&b){for(int i=0;i<3;i++)a.a[i]=a.a[i]-b.a[i];return a;}
inline Fun scale(Fun a,F k){for(auto&c:a.a)c=scale(c,k);return a;}
inline Fun operator*(const Fun&a,const Fun&b){Fun c;for(int i=0;i<3;i++)for(int j=0;j<3;j++){auto p=a.a[i]*b.a[j];if(i+j>=3)p=p*CP;c.a[(i+j)%3]=c.a[(i+j)%3]+p;}return c;}
inline Fun power(Fun a,unsigned n){Fun b(1);while(n){if(n&1)b=b*a;a=a*a;n>>=1;}return b;}
inline Fun monom(int i,int j,F val=1){Fun a;Poly p(i+1);p[i]=val;for(int z=0;z<j/3;z++)p=p*CP;a.a[j%3]=p;return a;}
inline Fun fmod(Fun a,const Poly&m){for(auto&p:a.a)p=mod(p,m);return a;}
inline Fun divide_y(Fun a,unsigned n){Fun b;for(int j=0;j<3;j++){int l=(j-int(n)%3+3)%3;int k=(int(n)+l-j)/3;b.a[l]=quo(a.a[j],power(CP,k));}return b;}
inline Poly norm(const Fun&a){return power(a.a[0],3)+power(a.a[1],3)*CP+power(a.a[2],3)*power(CP,2)-scale(a.a[0]*a.a[1]*a.a[2]*CP,3);}
inline int pole(const Fun&a){int d=-1;for(int j=0;j<3;j++)if(!a.a[j].empty())d=std::max(d,3*deg(a.a[j])+10*j);return d;}
inline void printfun(std::ostream&o,const Fun&a){o<<'[';for(int j=0;j<3;j++){if(j)o<<',';printpoly(o,a.a[j]);}o<<']';}
struct Rref {std::vector<std::vector<F>> m;std::vector<int> piv;unsigned ncols;};
inline Rref rref(std::vector<std::vector<F>> m,unsigned ncols){unsigned row=0;std::vector<int> piv;for(unsigned j=0;j<ncols&&row<m.size();j++){
 unsigned p=row;while(p<m.size()&&!m[p][j])p++;if(p==m.size())continue;std::swap(m[p],m[row]);F s=inv(m[row][j]);for(unsigned k=j;k<m[row].size();k++)m[row][k]=mul(m[row][k],s);
 for(unsigned i=0;i<m.size();i++)if(i!=row&&m[i][j]){F c=m[i][j];m[i][j]=0;for(unsigned k=j+1;k<m[i].size();k++)if(m[row][k])m[i][k]=sub(m[i][k],mul(c,m[row][k]));}
 piv.push_back(j);row++;
 }
 return {std::move(m),std::move(piv),ncols};}
}
