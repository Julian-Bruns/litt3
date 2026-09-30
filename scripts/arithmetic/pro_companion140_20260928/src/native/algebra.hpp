#ifndef COMPANION_ALGEBRA_HPP
#define COMPANION_ALGEBRA_HPP
#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
#include <stdexcept>
#include <tuple>
#include <vector>
#include <type_traits>
#include <gmp.h>
namespace comp {
struct F {
 uint32_t v;
 static inline std::vector<uint32_t> adds,exps,logs;
 static inline std::array<uint32_t,625> negs;
 static constexpr uint32_t N=390625, NN=N-1;
 F(uint32_t z=0):v(z) { assert(z<N); }
 explicit operator bool()const{return v!=0;}
 static uint32_t slowmul(uint32_t a,uint32_t b) {
  int aa[4],bb[4],cc[7]={};
  for(int i=0;i<4;i++){aa[i]=a%25;a/=25;bb[i]=b%25;b/=25;}
  auto add25=[](int x,int y){return (x%5+y%5)%5+5*((x/5+y/5)%5);};
  auto mul25=[](int x,int y){return (x%5*(y%5)+3*(x/5)*(y/5))%5+5*((x%5*(y/5)+x/5*(y%5)+x/5*(y/5))%5);};
  auto neg25=[](int x){return (5-x%5)%5+5*((5-x/5)%5);};
  for(int i=0;i<4;i++)for(int j=0;j<4;j++)cc[i+j]=add25(cc[i+j],mul25(aa[i],bb[j]));
  int mm[]={5,2,6,7};
  for(int i=6;i>=4;i--)for(int j=0;j<4;j++)cc[i-4+j]=add25(cc[i-4+j],neg25(mul25(cc[i],mm[j])));
  return cc[0]+25*cc[1]+625*cc[2]+15625*cc[3];
 }
 static void init(){
  adds.resize(625*625);exps.resize(2*NN);logs.assign(N,NN);
  for(uint32_t a=0;a<625;a++){
   uint32_t aa=a,nn=0,p=1;
   for(int k=0;k<4;k++){nn+=((5-aa%5)%5)*p;aa/=5;p*=5;}
   negs[a]=nn;
   for(uint32_t b=0;b<625;b++){
    uint32_t x=a,y=b,z=0,p=1;
    for(int k=0;k<4;k++){z+=((x%5+y%5)%5)*p;x/=5;y/=5;p*=5;}
    adds[a*625+b]=z;
   }
  }
  uint32_t gm[4][25];
  for(int i=0,p=1;i<4;i++,p*=25)for(int a=0;a<25;a++)gm[i][a]=slowmul(25,a*p);
  F z=1;
  for(uint32_t i=0;i<NN;i++){
   if(logs[z.v]!=NN)throw std::runtime_error("alpha not primitive");
   logs[z.v]=i;exps[i]=exps[i+NN]=z.v;
   z=F(gm[0][z.v%25])+F(gm[1][z.v/25%25])+F(gm[2][z.v/625%25])+F(gm[3][z.v/15625]);
  }
  assert(z==F(1));
 }
 friend F operator+(F a,F b){return F(adds[(a.v%625)*625+b.v%625]+625*adds[(a.v/625)*625+b.v/625]);}
 friend F operator-(F a){return F(negs[a.v%625]+625*negs[a.v/625]);}
 friend F operator-(F a,F b){return a+-b;}
 friend F operator*(F a,F b){return a.v&&b.v?F(exps[logs[a.v]+logs[b.v]]):F(0);}
 F inverse()const {if(!v)throw std::runtime_error("inverse of zero in K");return F(exps[NN-logs[v]]);}
 friend F operator/(F a,F b){return a*b.inverse();}
 F& operator+=(F b){return *this=*this+b;}
 F& operator-=(F b){return *this=*this-b;}
 F& operator*=(F b){return *this=*this*b;}
 friend bool operator==(F a,F b){return a.v==b.v;}
 F pow(uint64_t n)const {return v?F(exps[(uint64_t(logs[v])*n)%NN]):F(n==0);}
 F fifth()const{return pow(5);}
};

#include "fastpoly.hpp"

template<class T> struct Poly {
 std::vector<T> c;
 Poly()=default;
 Poly(int k){if(k%5)c.push_back(T(k%5));}
 explicit Poly(T k){if(bool(k))c.push_back(k);}
 explicit Poly(std::vector<T> a):c(std::move(a)){trim();}
 void trim(){while(!c.empty()&&!bool(c.back()))c.pop_back();}
 explicit operator bool()const{return !c.empty();}
 int deg()const{return (int)c.size()-1;}
 T operator[](int i)const{return i>=0&&i<(int)c.size()?c[i]:T(0);}
 friend bool operator==(const Poly&a,const Poly&b){return a.c==b.c;}
 friend Poly operator+(const Poly&a,const Poly&b){
  Poly z=a;z.c.resize(std::max(a.c.size(),b.c.size()));
  for(size_t i=0;i<b.c.size();i++)z.c[i]+=b.c[i];z.trim();return z;
 }
 friend Poly operator-(const Poly&a){Poly z=a;for(auto &v:z.c)v=-v;return z;}
 friend Poly operator-(const Poly&a,const Poly&b){return a+-b;}
 friend Poly operator*(const Poly&a,const Poly&b){
  if(!a||!b)return Poly();
  if constexpr(std::is_same_v<T,F>){if(a.c.size()>=40&&b.c.size()>=40)return Poly(FastK::multiply(a.c,b.c));}
  Poly z;z.c.resize(a.c.size()+b.c.size()-1);
  for(size_t i=0;i<a.c.size();i++)if(bool(a.c[i]))for(size_t j=0;j<b.c.size();j++)if(bool(b.c[j]))z.c[i+j]+=a.c[i]*b.c[j];
  z.trim();return z;
 }
 Poly scale(T a)const{if(!bool(a))return Poly();Poly z=*this;for(auto &v:z.c)v*=a;z.trim();return z;}
 Poly& operator+=(const Poly&b){return *this=*this+b;}
 Poly& operator-=(const Poly&b){return *this=*this-b;}
 Poly& operator*=(const Poly&b){return *this=*this*b;}
 Poly shift(int n)const{assert(n>=0);if(!*this)return *this;Poly z;z.c.resize(n);z.c.insert(z.c.end(),c.begin(),c.end());return z;}
 Poly fifth()const{Poly z;if(!*this)return z;z.c.resize(5*deg()+1);for(size_t i=0;i<c.size();i++)z.c[5*i]=c[i].fifth();z.trim();return z;}
 Poly pow(int n)const {assert(n>=0);if(n>=5)return pow(n%5)*fifth().pow(n/5);Poly z(1),a=*this;while(n){if(n&1)z*=a;n>>=1;if(n)a*=a;}return z;}
 std::pair<Poly,Poly> divmod(const Poly&b)const {
  if(!b)throw std::runtime_error("polynomial division by zero");
  Poly r=*this,q;if(deg()<b.deg())return{q,r};q.c.resize(deg()-b.deg()+1);
  T inv=b.c.back().inverse();
  while(r&&r.deg()>=b.deg()){
   int j=r.deg()-b.deg();T v=r.c.back()*inv;q.c[j]=v;
   for(size_t i=0;i<b.c.size();i++)r.c[i+j]-=v*b.c[i];r.trim();
  }q.trim();return{q,r};
 }
 Poly exactdiv(const Poly&b)const{auto [q,r]=divmod(b);if(bool(r))throw std::runtime_error("inexact polynomial division");return q;}
 Poly mod(const Poly&b)const{return divmod(b).second;}
 Poly monic()const {if(!*this)return *this;return scale(c.back().inverse());}
 T eval(T x)const{T z=0;for(int i=deg();i>=0;i--)z=z*x+c[i];return z;}
};
using FP=Poly<F>;

template<class T> std::tuple<Poly<T>,Poly<T>,Poly<T>> xgcd(Poly<T> a,Poly<T> b){
 Poly<T> u(1),v,s,t(1);
 while(b){auto [q,r]=a.divmod(b);a=std::move(b);b=std::move(r);auto un=u-q*s,vn=v-q*t;u=std::move(s);s=std::move(un);v=std::move(t);t=std::move(vn);}
 if(!a)return {a,u,v};T z=a.c.back().inverse();return {a.scale(z),u.scale(z),v.scale(z)};
}
struct Nonunit:std::runtime_error{FP factor;explicit Nonunit(FP f):std::runtime_error("nonunit in finite algebra"),factor(std::move(f)){} };
struct E {
 FP p;
 static inline FP modulus;
 static inline std::vector<FP> frob;
 E(int a=0):p(a){}
 E(F a):p(a){}
 explicit E(FP a):p(std::move(a)) {if(p.deg()>=modulus.deg())p=p.mod(modulus);}
 static void setmod(FP m){modulus=m.monic();frob.clear();FP xx(std::vector<F>{0,1}),q5=xx.pow(5).mod(modulus),z(1);for(int i=0;i<modulus.deg();i++){frob.push_back(z);z=(z*q5).mod(modulus);}}
 explicit operator bool()const{return bool(p);}
 friend E operator+(const E&a,const E&b){E z;z.p=a.p+b.p;return z;}
 friend E operator-(const E&a){E z;z.p=-a.p;return z;}
 friend E operator-(const E&a,const E&b){return a+-b;}
 friend E operator*(const E&a,const E&b){
  E z;if(a.p.deg()<=0){z.p=b.p.scale(a.p[0]);return z;}if(b.p.deg()<=0){z.p=a.p.scale(b.p[0]);return z;}
  z.p=(a.p*b.p).mod(modulus);return z;
 }
 E& operator+=(const E&b){p+=b.p;return *this;}
 E& operator-=(const E&b){p-=b.p;return *this;}
 E& operator*=(const E&b){return *this=*this*b;}
 friend bool operator==(const E&a,const E&b){return a.p==b.p;}
 E inverse()const{auto [g,u,v]=xgcd(p,modulus);if(g.deg()!=0)throw Nonunit(g);return E(u);}
 friend E operator/(const E&a,const E&b){return a*b.inverse();}
 E fifth()const{E z;for(size_t i=0;i<p.c.size();i++)if(bool(p.c[i]))z.p+=frob[i].scale(p.c[i].fifth());return z;}
 E pow(int n)const{if(n>=5)return pow(n%5)*fifth().pow(n/5);E z(1),a=*this;while(n){if(n&1)z*=a;n>>=1;if(n)a*=a;}return z;}
};

template<class T> struct Curve {
 std::array<Poly<T>,3> c;
 static inline Poly<T> PQ;
 Curve(int a=0){c[0]=Poly<T>(a);}
 explicit Curve(Poly<T> a){c[0]=a;}
 explicit Curve(std::array<Poly<T>,3> a):c(std::move(a)){}
 explicit operator bool()const{return bool(c[0])||bool(c[1])||bool(c[2]);}
 friend Curve operator+(const Curve&a,const Curve&b){return Curve(std::array<Poly<T>,3>{a.c[0]+b.c[0],a.c[1]+b.c[1],a.c[2]+b.c[2]});}
 friend Curve operator-(const Curve&a){return Curve(std::array<Poly<T>,3>{-a.c[0],-a.c[1],-a.c[2]});}
 friend Curve operator-(const Curve&a,const Curve&b){return a+-b;}
 friend Curve operator*(const Curve&a,const Curve&b){Curve z;for(int i=0;i<3;i++)for(int j=0;j<3;j++){auto p=a.c[i]*b.c[j];if(i+j>=3)p*=PQ;z.c[(i+j)%3]+=p;}return z;}
 Curve& operator+=(const Curve&b){return *this=*this+b;}
 Curve& operator*=(const Curve&b){return *this=*this*b;}
 Curve fifth()const{Curve z;for(int j=0;j<3;j++)z.c[5*j%3]=c[j].fifth()*PQ.pow(5*j/3);return z;}
 Curve pow(int n)const{if(n>=5)return pow(n%5)*fifth().pow(n/5);Curve z(1),a=*this;while(n){if(n&1)z*=a;n>>=1;if(n)a*=a;}return z;}
};

template<class C> std::array<C,3> critical_ring(const std::array<C,4>&g,const C&EV,const C&QV,const C&V){
 C A=C(3)*g[0],B=C(2)*g[1],Cc=g[2],D=g[3];
 std::vector<C> U{C(2),-B};for(int n=2;n<8;n++)U.push_back(-B*U[n-1]-A*Cc*U[n-2]);
 C A2=A.pow(2),A3=A2*A,A4=A3*A,A5=A.fifth(),A8=A5*A3,A9=A5*A4,A10=A5.pow(2);
 C B2=B.pow(2),B3=B2*B,B5=B.fifth(),C2=Cc.pow(2),C3=C2*Cc;
 C K0=Cc.fifth()-QV*B5+A5*QV.pow(2);
 C Nv=A2*D.pow(2)+A*(C3-B*Cc*D)+B3*D+C(2)*B2*C2;
 C TrV=B3-A*B*Cc+C(2)*A2*D;
 C X=C2*(B*U[3]-U[4])+D*U[5]+QV*A3*TrV;
 C TT=B5.pow(2)-C(2)*A5*Cc.fifth()-C(2)*A5*B5*QV+C(2)*A10*QV.pow(2);
 C YY=A3*B*U[7]-A4*Cc*U[6]+A5*D*U[5]+A8*QV*B*U[2]-A9*QV*Cc*U[1]+C(2)*A10*QV*D;
 return {A3*K0*Nv+EV*YY+EV.pow(2)*A10,V*(K0*X+EV*TT),V.pow(2)*K0.pow(2)};
}
template<class T> std::array<Curve<T>,3> critical(const std::array<Curve<T>,4>&g,const Curve<T>&E,const Curve<T>&Q,const Curve<T>&v){return critical_ring(g,E,Q,v);}
} //namespace comp
#endif
