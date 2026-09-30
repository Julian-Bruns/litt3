#ifndef COMPANION_WEIGHTED_HPP
#define COMPANION_WEIGHTED_HPP
#include "algebra.hpp"
namespace comp {
// Keep all terms of weight >= cap-150, where wt(x)=3, wt(Y)=10.
// cap is an UPPER BOUND, never lowered after cancellation. This is essential.
// The unrecorded terms therefore cannot affect a later kept coefficient.
template<class T> struct WCurve {
 std::array<Poly<T>,3> c;
 int cap;
 static constexpr int KEEP=150,ZERO=-100000000;
 static inline Poly<T> PQ;
 WCurve(int a=0):cap(a%5?0:ZERO){c[0]=Poly<T>(a);}
 explicit WCurve(Poly<T> a):cap(a?3*a.deg():ZERO){c[0]=a;}
 explicit WCurve(const Curve<T>&a):c(a.c),cap(ZERO){for(int j=0;j<3;j++)if(c[j])cap=std::max(cap,3*c[j].deg()+10*j);prune();}
 void prune(){for(int j=0;j<3;j++){int k=std::min((int)c[j].c.size(),std::max(0,(cap-KEEP-10*j+2)/3));for(int i=0;i<k;i++)c[j].c[i]=T(0);c[j].trim();}}
 friend WCurve operator+(const WCurve&a,const WCurve&b){if(a.cap==ZERO)return b;if(b.cap==ZERO)return a;WCurve z;z.cap=std::max(a.cap,b.cap);for(int j=0;j<3;j++)z.c[j]=a.c[j]+b.c[j];z.prune();return z;}
 friend WCurve operator-(const WCurve&a){WCurve z=a;for(auto&p:z.c)p=-p;return z;}
 friend WCurve operator-(const WCurve&a,const WCurve&b){return a+-b;}
 friend WCurve operator*(const WCurve&a,const WCurve&b){WCurve z;if(a.cap==ZERO||b.cap==ZERO)return z;z.cap=a.cap+b.cap;
  for(int i=0;i<3;i++)for(int j=0;j<3;j++){auto p=a.c[i]*b.c[j];if(i+j>=3)p*=PQ;z.c[(i+j)%3]+=p;}z.prune();return z;
 }
 WCurve&operator*=(const WCurve&b){return *this=*this*b;}
 WCurve fifth()const{WCurve z;if(cap==ZERO)return z;z.cap=5*cap;for(int j=0;j<3;j++)z.c[5*j%3]=c[j].fifth()*PQ.pow(5*j/3);z.prune();return z;}
 WCurve pow(int n)const{if(n>=5)return pow(n%5)*fifth().pow(n/5);WCurve z(1),a=*this;while(n){if(n&1)z*=a;n>>=1;if(n)a*=a;}return z;}
};
template<class T> Poly<T> high_quotient(const Poly<T>&a,const FP&d){
 if(a.deg()<d.deg())return Poly<T>();int n=a.deg()-d.deg();std::vector<T>v(n+1);F il=d.c.back().inverse();
 for(int j=0;j<=n;j++){T z=a[a.deg()-j];for(int k=1;k<=j;k++)z-=T(d[d.deg()-k])*v[j-k];v[j]=z*T(il);}
 std::reverse(v.begin(),v.end());return Poly<T>(v);
}
}
#endif
