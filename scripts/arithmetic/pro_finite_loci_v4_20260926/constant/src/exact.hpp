#pragma once
#include <algorithm>
#include <array>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <map>
#include <numeric>
#include <random>
#include <sstream>
#include <stdexcept>
#include <string>
#include <tuple>
#include <vector>
using F=uint32_t;
namespace FF {
constexpr unsigned N=390625, M=N-1;
inline F ad25[25][25], mu25[25][25], neg25[25];
inline std::vector<F> lg,ex;
inline F primitive=0;
inline F add(F a,F b){F c=0,p=1;for(int i=0;i<4;i++){c+=p*ad25[a%25][b%25];a/=25;b/=25;p*=25;}return c;}
inline F neg(F a){F c=0,p=1;for(int i=0;i<4;i++){c+=p*neg25[a%25];a/=25;p*=25;}return c;}
inline F sub(F a,F b){return add(a,neg(b));}
inline F rawmul(F a,F b){F aa[4],bb[4],c[7]={};for(int i=0;i<4;i++){aa[i]=a%25;bb[i]=b%25;a/=25;b/=25;}
for(int i=0;i<4;i++)for(int j=0;j<4;j++)c[i+j]=ad25[c[i+j]][mu25[aa[i]][bb[j]]];
const F m[4]={5,2,6,7};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)c[i-4+j]=ad25[c[i-4+j]][neg25[mu25[c[i]][m[j]]]];
return c[0]+25*c[1]+625*c[2]+15625*c[3];}
inline F rawpow(F a,uint64_t n){F b=1;while(n){if(n&1)b=rawmul(a,b);n>>=1;if(n)a=rawmul(a,a);}return b;}
inline void init(){
for(F a=0;a<25;a++){neg25[a]=(5-a%5)%5+5*((5-a/5)%5);for(F b=0;b<25;b++){
ad25[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
mu25[a][b]=((a%5)*(b%5)+3*(a/5)*(b/5))%5+5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}}
std::vector<unsigned> primes;unsigned n=M;for(unsigned p=2;p*p<=n;p++)if(n%p==0){primes.push_back(p);while(n%p==0)n/=p;}if(n>1)primes.push_back(n);
for(F a=25;a<N;a++){bool ok=rawpow(a,M)==1;for(auto p:primes)if(rawpow(a,M/p)==1)ok=false;if(ok){primitive=a;break;}}
if(!primitive)throw std::runtime_error("field generator failed");
lg.assign(N,M);ex.resize(2*M);F a=1;for(unsigned i=0;i<M;i++){if(lg[a]!=M)throw std::runtime_error("field cycle failed");lg[a]=i;ex[i]=a;a=rawmul(a,primitive);}if(a!=1)throw std::runtime_error("field closure failed");for(unsigned i=0;i<M;i++)ex[i+M]=ex[i];
}
inline F mul(F a,F b){return a&&b?ex[lg[a]+lg[b]]:0;}
inline F inv(F a){if(!a)throw std::runtime_error("division by zero");return ex[M-lg[a]];}
inline F div(F a,F b){return mul(a,inv(b));}
inline F pow(F a,uint64_t n){return n==0?1:(!a?0:ex[(uint64_t(lg[a])*n)%M]);}
}
struct Poly:std::vector<F>{
using std::vector<F>::vector;
Poly(){};Poly(const std::vector<F>&v):std::vector<F>(v){trim();}
void trim(){while(!empty()&&back()==0)pop_back();}
int deg()const{return int(size())-1;}
F coef(size_t i)const{return i<size()?(*this)[i]:0;}
};
inline Poly con(F a){return a?Poly{a}:Poly{};}
inline Poly mono(int i,F a=1){Poly v(i+1);v[i]=a;v.trim();return v;}
inline Poly operator+(const Poly&a,const Poly&b){Poly c(std::max(a.size(),b.size()));for(size_t i=0;i<c.size();i++)c[i]=FF::add(a.coef(i),b.coef(i));c.trim();return c;}
inline Poly operator-(const Poly&a){Poly c=a;for(auto&x:c)x=FF::neg(x);return c;}
inline Poly operator-(const Poly&a,const Poly&b){return a+(-b);}
inline Poly scale(Poly a,F b){for(auto&x:a)x=FF::mul(x,b);a.trim();return a;}
inline Poly operator*(const Poly&a,const Poly&b){if(a.empty()||b.empty())return {};Poly c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(a[i])for(size_t j=0;j<b.size();j++)if(b[j])c[i+j]=FF::add(c[i+j],FF::mul(a[i],b[j]));c.trim();return c;}
inline Poly power(Poly a,unsigned n){Poly b{1};while(n){if(n&1)b=b*a;n>>=1;if(n)a=a*a;}return b;}
inline std::pair<Poly,Poly> divrem(Poly a,const Poly&b){if(b.empty())throw std::runtime_error("polynomial division by zero");Poly q(std::max(0,a.deg()-b.deg()+1));F ib=FF::inv(b.back());while(a.deg()>=b.deg()){int i=a.deg()-b.deg();F v=FF::mul(a.back(),ib);q[i]=v;for(size_t j=0;j<b.size();j++)a[i+j]=FF::sub(a[i+j],FF::mul(v,b[j]));a.trim();}q.trim();return {q,a};}
inline Poly exactdiv(const Poly&a,const Poly&b){auto[q,r]=divrem(a,b);if(!r.empty())throw std::runtime_error("inexact division");return q;}
inline Poly rem(const Poly&a,const Poly&b){return divrem(a,b).second;}
inline Poly derivative(const Poly&a){Poly b(std::max(0,a.deg()));for(size_t i=1;i<a.size();i++)b[i-1]=FF::mul(a[i],i%5);b.trim();return b;}
inline Poly gcd(Poly a,Poly b){while(!b.empty()){auto r=rem(a,b);a=b;b=r;}return a.empty()?a:scale(a,FF::inv(a.back()));}
inline F eval(const Poly&a,F x){F b=0;for(int i=a.deg();i>=0;i--)b=FF::add(FF::mul(b,x),a[i]);return b;}
inline Poly P{11,22,18,5,19,20,15,16,9,22,1};
inline Poly A{1,21,14,22,13};
inline Poly Q{0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24};
inline Poly B0{8,14,19,2,10,19,3,24,18,16};
inline Poly L0{18,20,20,15};
inline Poly t;
inline void init_curve(){FF::init();t=scale(exactdiv(A,Poly{FF::neg(25),1}),FF::inv(13));}
struct Curve{
std::array<Poly,3> c;
Curve(){};Curve(Poly a){c[0]=a;};
Poly&operator[](size_t j){return c[j];}const Poly&operator[](size_t j)const{return c[j];}
bool operator==(const Curve&b)const{return c==b.c;}
bool zero()const{return c[0].empty()&&c[1].empty()&&c[2].empty();}
F coef(int i,int j)const{return c[j].coef(i);}
};
inline Curve cm(int i,int j,F a=1){Curve b;b[j%3]=mono(i,a)*power(P,j/3);return b;}
inline Curve operator+(const Curve&a,const Curve&b){Curve c;for(int i=0;i<3;i++)c[i]=a[i]+b[i];return c;}
inline Curve operator-(const Curve&a){Curve c;for(int i=0;i<3;i++)c[i]=-a[i];return c;}
inline Curve operator-(const Curve&a,const Curve&b){return a+(-b);}
inline Curve scale(Curve a,F b){for(auto&c:a.c)c=scale(c,b);return a;}
inline Curve operator*(const Curve&a,const Curve&b){Curve c;for(int i=0;i<3;i++)for(int j=0;j<3;j++){Poly p=a[i]*b[j];if(i+j>=3)p=p*P;c[(i+j)%3]=c[(i+j)%3]+p;}return c;}
inline Curve power(Curve a,unsigned n){Curve b(Poly{1});while(n){if(n&1)b=b*a;n>>=1;if(n)a=a*a;}return b;}
inline Curve div_y(const Curve&a,unsigned n){Curve b;for(int j=0;j<3;j++){int k=((j-int(n))%3+3)%3;int e=(n+k-j)/3;b[k]=exactdiv(a[j],power(P,e));}return b;}
inline Curve rem_y(const Curve&a,unsigned n){Curve b;for(int j=0;j<3;j++)if(int(n)>j)b[j]=rem(a[j],power(P,(n-j+2)/3));return b;}
inline Curve rem_poly(const Curve&a,const Poly&b){Curve c;for(int j=0;j<3;j++)c[j]=rem(a[j],b);return c;}
inline int pole(const Curve&a){int d=-1;for(int j=0;j<3;j++)if(!a[j].empty())d=std::max(d,3*a[j].deg()+10*j);return d;}
inline Poly norm(const Curve&a){return power(a[0],3)+power(a[1],3)*P+power(a[2],3)*power(P,2)-scale(a[0]*a[1]*a[2]*P,3);}
inline F binom(int n,int k){if(k<0||k>n)return 0;int v=1;for(int i=0;i<k;i++)v=v*(n-i)/(i+1);return v%5;}
using Source=std::array<Curve,4>; // G2,G3,G4,G5
inline std::vector<std::tuple<int,int,int>> source_monomials(){std::vector<std::tuple<int,int,int>>v;
for(int i=0;i<=4;i++)v.emplace_back(0,i,2);v.emplace_back(0,0,3); // D2=x^i or y
int d[3]={46,57,70};for(int s=1;s<4;s++)for(int j=0;j<3;j++)for(int i=0;3*i+10*j<=d[s-1];i++)v.emplace_back(s,i,j);return v;}
inline std::map<std::tuple<int,int,int>,F> equations(const Source&G,bool constant){
std::map<std::tuple<int,int,int>,F> eq;int n=0;auto append=[&](const Curve&r){for(int j=0;j<3;j++)for(size_t i=0;i<r[j].size();i++)if(r[j][i])eq[{n,int(i),j}]=r[j][i];n++;};
std::array<Curve,6>N;N[0]=constant?Curve(Poly{1}):Curve();for(int i=2;i<6;i++)N[i]=G[i-2];if(constant)N[5]=N[5]+Curve(Q);
for(int j=1;j<=5;j++){Curve r;for(int i=0;i<=j;i++)r=r+scale(Curve(power(-B0,j-i))*N[i],binom(5-i,j-i));append(rem_y(r,j));}
Poly ql=Q-power(L0,5);
for(int j=0;j<=4;j++){Curve r;for(int i=0;i<=5;i++)if(5-i>=j)r=r+scale(Curve(power(-L0,5-i-j))*N[i],binom(5-i,j));r=Curve(ql)*r;if(constant&&j==0)r=r+Curve(power(t,3))*cm(0,10);append(rem_poly(r,power(t,5-j)));}
for(int j=0;j<=10;j++){Curve r;if(j<=5)r=N[j];if(j>=5)r=r+Curve(Q)*N[j-5];if(constant&&j==10)r=r+Curve(power(t,3))*cm(0,10);int bound=10+12*j-std::max(0,j-5);Curve rr;for(int k=0;k<3;k++)for(size_t i=0;i<r[k].size();i++)if(3*int(i)+10*k>bound){if(rr[k].size()<=i)rr[k].resize(i+1);rr[k][i]=r[k][i];}append(rr);}
return eq;}
inline std::vector<int> rref(std::vector<std::vector<F>>&a,int n,std::vector<int>*prows=nullptr){size_t r=0;std::vector<int>p;std::vector<int>perm(a.size());std::iota(perm.begin(),perm.end(),0);if(prows)prows->clear();
for(int c=0;c<n&&r<a.size();c++){size_t i=r;while(i<a.size()&&!a[i][c])i++;if(i==a.size())continue;std::swap(a[i],a[r]);std::swap(perm[i],perm[r]);F iv=FF::inv(a[r][c]);for(int j=c;j<=n;j++)a[r][j]=FF::mul(a[r][j],iv);for(size_t k=0;k<a.size();k++)if(k!=r&&a[k][c]){F b=a[k][c];a[k][c]=0;for(int j=c+1;j<=n;j++)a[k][j]=FF::sub(a[k][j],FF::mul(b,a[r][j]));}p.push_back(c);if(prows)prows->push_back(perm[r]);r++;}
for(size_t i=r;i<a.size();i++)if(a[i][n])throw std::runtime_error("inconsistent affine system");return p;}
inline void json_poly(std::ostream&o,const Poly&p){o<<"[";for(size_t i=0;i<p.size();i++){if(i)o<<",";o<<p[i];}o<<"]";}
inline void json_curve(std::ostream&o,const Curve&a){o<<"[";for(int j=0;j<3;j++){if(j)o<<",";json_poly(o,a[j]);}o<<"]";}
