#pragma once
#include "field.hpp"
namespace exact {
// Laurent polynomial in h,w (or, after conversion, ordinary H,q).
struct Bi {
 std::map<std::pair<int,int>,F> t;
 Bi()=default;
 Bi(F a){if(a)t[{0,0}]=a;}
 bool zero()const{return t.empty();}
 bool operator==(const Bi&b)const{return t==b.t;}
 bool operator!=(const Bi&b)const{return t!=b.t;}
};
inline Bi term(F c,int h,int w){Bi b;if(c)b.t[{h,w}]=c;return b;}
inline void accum(Bi&a,std::pair<int,int>e,F c){if(!c)return;auto i=a.t.find(e);if(i==a.t.end())a.t[e]=c;else{F s=add(i->second,c);if(s)i->second=s;else a.t.erase(i);}}
inline Bi operator+(Bi a,const Bi&b){for(auto[e,c]:b.t)accum(a,e,c);return a;}
inline Bi operator-(Bi a,const Bi&b){for(auto[e,c]:b.t)accum(a,e,neg(c));return a;}
inline Bi scale(Bi a,F c){if(!c)return {};for(auto&[e,k]:a.t)k=mul(k,c);return a;}
inline Bi operator*(const Bi&a,const Bi&b){Bi r;for(auto[e,c]:a.t)for(auto[f,d]:b.t)accum(r,{e.first+f.first,e.second+f.second},mul(c,d));return r;}
inline Bi power(Bi a,unsigned n){Bi b(1);while(n){if(n&1)b=b*a;a=a*a;n>>=1;}return b;}
inline Bi shift(Bi a,int h,int w){Bi b;for(auto[e,c]:a.t)b.t[{e.first+h,e.second+w}]=c;return b;}
inline Bi frob(const Bi&a){Bi b;for(auto[e,c]:a.t)b.t[{5*e.first,5*e.second}]=fpow(c,5);return b;}
inline F eval(const Bi&a,F h,F w){F c=0;for(auto[e,s]:a.t)c=add(c,mul(s,mul(fpow(h,e.first),fpow(w,e.second))));return c;}
inline Bi exactdivide(Bi a,const Bi&b){if(b.zero())throw std::runtime_error("Bi zero divisor");
 // Division is performed after shifting both Laurent polynomials into the nonnegative quadrant.
 auto minimum=[](const Bi&x){int h=1000000,w=1000000;for(auto[e,c]:x.t){h=std::min(h,e.first);w=std::min(w,e.second);}return std::pair<int,int>{h,w};};
 if(a.zero())return a;auto am=minimum(a),bm=minimum(b);a=shift(a,-am.first,-am.second);Bi bb=shift(b,-bm.first,-bm.second),q;
 auto [be,bc]=*bb.t.rbegin();F ib=inv(bc);
 while(!a.zero()){
  auto[ae,ac]=*a.t.rbegin();if(ae.first<be.first||ae.second<be.second)throw std::runtime_error("inexact Bi division");
  Bi u=term(mul(ac,ib),ae.first-be.first,ae.second-be.second);q=q+u;a=a-u*bb;
 }
 return shift(q,am.first-bm.first,am.second-bm.second);
}
inline Bi toHq(const Bi&a,int woffset=0){Bi b;for(auto[e,c]:a.t){int wh=e.first+e.second+woffset;if(wh%3)throw std::runtime_error("non-invariant cube-root expression");accum(b,{e.first,wh/3},c);}return b;}
inline void printbi(std::ostream&o,const Bi&a){o<<'[';bool first=true;for(auto[e,c]:a.t){if(!first)o<<',';first=false;o<<'['<<e.first<<','<<e.second<<','<<c<<']';}o<<']';}
using Jet=std::vector<Bi>;
inline Jet jadd(Jet a,const Jet&b,int n){a.resize(n);for(int i=0;i<std::min<int>(n,b.size());i++)a[i]=a[i]+b[i];return a;}
inline Jet jscale(Jet a,F c){for(auto&b:a)b=scale(b,c);return a;}
inline Jet jmul(const Jet&a,const Jet&b,int n){Jet c(n);for(int i=0;i<std::min<int>(n,a.size());i++)if(!a[i].zero())for(int j=0;j<std::min<int>(n-i,b.size());j++)if(!b[j].zero())c[i+j]=c[i+j]+a[i]*b[j];return c;}
inline Jet jpow(Jet a,unsigned n,int len){Jet b(len);b[0]=Bi(1);while(n){if(n&1)b=jmul(b,a,len);a=jmul(a,a,len);n>>=1;}return b;}
inline Jet jshift(Jet a,int s,int n){Jet b(n);for(int i=0;i<int(a.size());i++)if(i+s>=0&&i+s<n)b[i+s]=a[i];return b;}
}
