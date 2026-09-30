#ifndef COMPANION_RATIONAL_HPP
#define COMPANION_RATIONAL_HPP
#include "algebra.hpp"
#include <map>
#include <atomic>
namespace comp {
// K(q)[xi]/(xi^2-C), with denominators supported on five PROVED unit factors.
// This type never silently introduces an arbitrary norm denominator.
struct Rat {
 FP a,b;
 std::array<int,5> den{};
 static inline FP CC;
 static inline std::array<FP,5> factors;
#ifdef ROOT9_THREAD_RATIONAL
 static inline thread_local std::array<std::vector<FP>,5> powers;
#else
 static inline std::array<std::vector<FP>,5> powers;
#endif
 static inline std::atomic<uint64_t> multiplications=0,normalizations=0;
 static inline bool frozen_powers=false;
#ifdef ROOT9_FAST_RAT_NORMALIZE
 // Exact rejection tests only: a nonzero value at a known root proves
 // that division by this denominator factor cannot succeed.
 static inline std::array<std::vector<F>,5> root_tests;
#endif
 Rat(int k=0):a(k){}
 Rat(F k):a(k){}
 explicit Rat(FP p):a(std::move(p)){}
 explicit operator bool()const{return bool(a)||bool(b);}
 static void setup(FP C,std::array<FP,5> fs){CC=C;for(int i=0;i<5;i++){factors[i]=fs[i].monic();powers[i]={FP(1)};
#ifdef ROOT9_FAST_RAT_NORMALIZE
  root_tests[i].clear();if(factors[i].deg()==1)root_tests[i].push_back(-factors[i][0]);
  else if(factors[i].deg()>1)for(int v=0;v<F::N && root_tests[i].size()<3;v++){F z=0;for(int j=factors[i].deg();j>=0;j--)z=z*F(v)+factors[i][j];if(!z)root_tests[i].push_back(F(v));}
#endif
 }}
 static const FP& fpow(int k,int n){assert(n>=0);auto&v=powers[k];if(v.empty())v.push_back(FP(1));if(frozen_powers && (int)v.size()<=n)throw std::runtime_error("frozen denominator-power bound exceeded");while((int)v.size()<=n)v.push_back(v.back()*factors[k]);return v[n];}
 void multiply_factors(const std::array<int,5>&ns){for(int k=0;k<5;k++)if(ns[k]){a*=fpow(k,ns[k]);b*=fpow(k,ns[k]);}}
 void normalize(){
  normalizations++;
  if(!*this){den.fill(0);return;}
  for(int k=0;k<5;k++)while(den[k]>0){
#ifdef ROOT9_FAST_RAT_NORMALIZE
   bool reject=false;for(F root:root_tests[k]){F za=0,zb=0;if(!root){za=a[0];zb=b[0];}else{for(int j=a.deg();j>=0;j--)za=za*root+a[j];for(int j=b.deg();j>=0;j--)zb=zb*root+b[j];}if(za||zb){reject=true;break;}}
   if(reject)break;
#endif
   auto [qa,ra]=a.divmod(factors[k]);if(ra)break;
   auto [qb,rb]=b.divmod(factors[k]);if(rb)break;
   a=std::move(qa);b=std::move(qb);den[k]--;
  }
 }
 Rat normalized()const{Rat z=*this;z.normalize();return z;}
 friend Rat operator+(const Rat&x,const Rat&y){
  if(!x)return y;if(!y)return x;
  if(x.den==y.den){Rat z;z.den=x.den;z.a=x.a+y.a;z.b=x.b+y.b;if(!z)z.den.fill(0);return z;}
  Rat u=x,v=y;std::array<int,5>dx,dy;
  for(int k=0;k<5;k++){int d=std::max(x.den[k],y.den[k]);u.den[k]=d;dx[k]=d-x.den[k];dy[k]=d-y.den[k];}
  u.multiply_factors(dx);v.multiply_factors(dy);u.a+=v.a;u.b+=v.b;if(!u)u.den.fill(0);return u;
 }
 friend Rat operator-(const Rat&x){Rat z=x;z.a=-z.a;z.b=-z.b;return z;}
 friend Rat operator-(const Rat&x,const Rat&y){return x+-y;}
 friend Rat operator*(const Rat&x,const Rat&y){
  multiplications++;Rat z;if(!x||!y)return z;
  if(!x.b && x.a.deg()==0){z=y;for(auto&v:z.a.c)v*=x.a[0];for(auto&v:z.b.c)v*=x.a[0];for(int k=0;k<5;k++)z.den[k]+=x.den[k];return z;}
  if(!y.b && y.a.deg()==0){z=x;for(auto&v:z.a.c)v*=y.a[0];for(auto&v:z.b.c)v*=y.a[0];for(int k=0;k<5;k++)z.den[k]+=y.den[k];return z;}
  z.a=x.a*y.a+x.b*y.b*CC;z.b=x.a*y.b+x.b*y.a;for(int k=0;k<5;k++)z.den[k]=x.den[k]+y.den[k];return z;
 }
 Rat&operator+=(const Rat&v){return *this=*this+v;}
 Rat&operator-=(const Rat&v){return *this=*this-v;}
 Rat&operator*=(const Rat&v){return *this=*this*v;}
 friend bool operator==(const Rat&x,const Rat&y){return !bool(x-y);}
 Rat inverse()const{
  Rat v=normalized();if(!v)throw std::runtime_error("zero global inverse");
  FP norm=v.a*v.a-v.b*v.b*CC;std::array<int,5>exps{};
  for(int k=0;k<5;k++)while(norm.deg()>=factors[k].deg()){
   auto [q,r]=norm.divmod(factors[k]);if(r)break;norm=std::move(q);exps[k]++;
  }
  if(norm.deg()!=0)throw std::runtime_error("global inverse would add UNLICENSED factor of degree "+std::to_string(norm.deg()));
  Rat z;z.a=v.a.scale(norm[0].inverse());z.b=(-v.b).scale(norm[0].inverse());std::array<int,5>num{};
  for(int k=0;k<5;k++){z.den[k]=std::max(0,exps[k]-v.den[k]);num[k]=std::max(0,v.den[k]-exps[k]);}
  z.multiply_factors(num);z.normalize();return z;
 }
 friend Rat operator/(const Rat&x,const Rat&y){Rat z=x*y.inverse();z.normalize();return z;}
 Rat fifth()const{Rat z;z.a=a.fifth();z.b=b.fifth()*CC.pow(2);for(int k=0;k<5;k++)z.den[k]=5*den[k];return z;}
 Rat pow(int n)const{if(n>=5)return pow(n%5)*fifth().pow(n/5);Rat z(1),v=*this;while(n){if(n&1)z*=v;n>>=1;if(n)v*=v;}return z;}
 template<class T> T eval(T q,T xi)const{
  auto at=[&](const FP&p){T z=0;for(int i=p.deg();i>=0;i--)z=z*q+T(p.c[i]);return z;};
  T z=at(a)+at(b)*xi,d=1;for(int k=0;k<5;k++)if(den[k])d*=at(factors[k]).pow(den[k]);return z/d;
 }
};
}
#endif
