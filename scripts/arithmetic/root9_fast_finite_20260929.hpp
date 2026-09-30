#ifndef ROOT9_FAST_FINITE_20260929
#define ROOT9_FAST_FINITE_20260929
#include "pro_companion140_20260928/src/native/halfgcd.hpp"
// Exact finite coefficient algebra with cached reciprocal reduction.
// Original modulus and all coordinates are unchanged.
struct FE {
 comp::FP p;
 static inline comp::FP modulus,reciprocal;
 FE(int a=0):p(a){} FE(comp::F a):p(a){} explicit FE(comp::FP a):p(reduce(a)){}
 static void setmod(comp::FP m){
  modulus=m.monic();auto r=comp::rev(modulus,modulus.deg()+1);reciprocal=comp::FP(1);int goal=4*modulus.deg()+8;
  for(int n=1;n<goal;){int nn=std::min(2*n,goal);reciprocal=comp::trunc(reciprocal*(comp::FP(2)-comp::trunc(comp::trunc(r,nn)*reciprocal,nn)),nn);n=nn;}
 }
 static comp::FP reduce(const comp::FP&a){
  if(a.deg()<modulus.deg())return a;int n=a.deg()-modulus.deg()+1;
  if(n<32||modulus.deg()<64)return a.mod(modulus);
  if(n>(int)reciprocal.c.size())return comp::mod_fast(a,modulus);
  auto q=comp::rev(comp::trunc(comp::trunc(comp::rev(a,a.deg()+1),n)*comp::trunc(reciprocal,n),n),n);auto r=a-modulus*q;assert(r.deg()<modulus.deg());return r;
 }
 explicit operator bool()const{return bool(p);}
 friend FE operator+(const FE&a,const FE&b){FE z;z.p=a.p+b.p;return z;}
 friend FE operator-(const FE&a){FE z;z.p=-a.p;return z;}
 friend FE operator-(const FE&a,const FE&b){return a+-b;}
 friend FE operator*(const FE&a,const FE&b){if(a.p.deg()<=0){FE z;z.p=b.p.scale(a.p[0]);return z;}if(b.p.deg()<=0){FE z;z.p=a.p.scale(b.p[0]);return z;}return FE(a.p*b.p);}
 FE&operator+=(const FE&b){return *this=*this+b;}FE&operator-=(const FE&b){return *this=*this-b;}FE&operator*=(const FE&b){return *this=*this*b;}
 friend bool operator==(const FE&a,const FE&b){return a.p==b.p;}
 FE inverse()const{auto[g,u,v]=comp::xgcd_half(p,modulus);if(g.deg()!=0)throw comp::Nonunit(g);return FE(u);}
 friend FE operator/(const FE&a,const FE&b){return a*b.inverse();}
 FE fifth()const{return FE(p.fifth());}
 FE pow(int n)const{if(n>=5)return pow(n%5)*fifth().pow(n/5);FE z(1),a=*this;while(n){if(n&1)z*=a;n>>=1;if(n)a*=a;}return z;}
};
#endif
