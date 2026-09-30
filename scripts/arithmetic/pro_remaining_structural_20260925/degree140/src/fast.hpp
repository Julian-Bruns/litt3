#pragma once
#include <algorithm>
#include <array>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>
namespace exact {
using F=int32_t;
inline std::vector<F> LG,EX;
inline std::vector<uint16_t> AD;
inline void loadfield(const std::string&path){
 LG.resize(390625);EX.resize(781248);AD.resize(390625);
 std::ifstream a(path+"/field_log.bin",std::ios::binary),b(path+"/field_exp.bin",std::ios::binary),c(path+"/field_add.bin",std::ios::binary);
 if(!a||!b||!c)throw std::runtime_error("missing generated field tables");
 a.read((char*)LG.data(),4*LG.size());b.read((char*)EX.data(),4*EX.size());c.read((char*)AD.data(),2*AD.size());
}
inline F add(F a,F b){return AD[(a%625)*625+b%625]+625*AD[(a/625)*625+b/625];}
inline F mul(F a,F b){return a&&b?EX[LG[a]+LG[b]]:0;}
inline F neg(F a){return mul(4,a);}
inline F sub(F a,F b){return add(a,neg(b));}
inline F inv(F a){if(!a)throw std::runtime_error("division by zero");return EX[390624-LG[a]];}
inline F divide(F a,F b){return mul(a,inv(b));}
inline F power(F a,int64_t n){if(n==0)return 1;if(!a){if(n<0)throw std::runtime_error("negative power of zero");return 0;}int e=((int64_t)LG[a]*n)%390624;if(e<0)e+=390624;return EX[e];}
struct Poly:std::vector<F>{
 using std::vector<F>::vector;
 Poly(const std::vector<F>&v):std::vector<F>(v){}
 void trim(){while(!empty()&&back()==0)pop_back();}
 int deg()const{return (int)size()-1;}
 F coef(int i)const{return i>=0&&i<(int)size()?(*this)[i]:0;}
};
inline Poly scale(Poly a,F s){for(F&x:a)x=mul(x,s);a.trim();return a;}
inline Poly operator+(Poly a,const Poly&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=add(a[i],b[i]);a.trim();return a;}
inline Poly operator-(Poly a,const Poly&b){return a+scale(b,4);}
inline Poly operator*(const Poly&a,const Poly&b){if(a.empty()||b.empty())return {};Poly c(a.size()+b.size()-1);std::vector<std::pair<size_t,F>> nb;nb.reserve(b.size());for(size_t j=0;j<b.size();j++)if(b[j])nb.push_back({j,b[j]});for(size_t i=0;i<a.size();i++)if(a[i])for(auto [j,v]:nb)c[i+j]=add(c[i+j],mul(a[i],v));c.trim();return c;}
inline Poly ppow(Poly a,int n){Poly z{1};while(n){if(n&1)z=z*a;n>>=1;if(n)a=a*a;}return z;}
inline Poly frob5(const Poly&a){if(a.empty())return {};Poly b(5*a.deg()+1);for(int i=0;i<=a.deg();i++)b[5*i]=power(a[i],5);return b;}
inline std::pair<Poly,Poly> divmod(Poly a,const Poly&b){if(b.empty())throw std::runtime_error("zero polynomial divisor");Poly q(std::max(0,a.deg()-b.deg()+1));F bi=inv(b.back());while(a.deg()>=b.deg()){int d=a.deg()-b.deg();F s=mul(a.back(),bi);q[d]=s;for(int i=0;i<=b.deg();i++)a[d+i]=sub(a[d+i],mul(s,b[i]));a.trim();}q.trim();return {q,a};}
inline Poly pdivide(const Poly&a,const Poly&b){auto qr=divmod(a,b);if(!qr.second.empty())throw std::runtime_error("inexact polynomial division");return qr.first;}
inline F eval(const Poly&a,F x){F z=0;for(auto i=a.rbegin();i!=a.rend();i++)z=add(mul(z,x),*i);return z;}
inline Poly derivative(const Poly&a){Poly b(std::max(0,a.deg()));for(int i=1;i<=a.deg();i++)b[i-1]=mul(i%5,a[i]);b.trim();return b;}
inline Poly gcd(Poly a,Poly b){while(!b.empty()){Poly c=divmod(a,b).second;a=b;b=c;}return a.empty()?a:scale(a,inv(a.back()));}
inline std::array<Poly,3> xgcd(Poly a,Poly b){Poly s{1},t{},ss{},tt{1};while(!b.empty()){auto qr=divmod(a,b);Poly ns=s-qr.first*ss,nt=t-qr.first*tt;a=b;b=qr.second;s=ss;t=tt;ss=ns;tt=nt;}F ci=inv(a.back());return {scale(a,ci),scale(s,ci),scale(t,ci)};}
using Curve=std::array<Poly,3>;
inline Poly baseP;
inline Curve con(const Poly&a){return {a,{}, {}};}
inline Curve cadd(const Curve&a,const Curve&b){return {a[0]+b[0],a[1]+b[1],a[2]+b[2]};}
inline Curve cscale(Curve a,F s){for(auto&v:a)v=scale(v,s);return a;}
inline Curve csub(const Curve&a,const Curve&b){return cadd(a,cscale(b,4));}
inline Curve cmul(const Curve&a,const Curve&b){Curve c;for(int i=0;i<3;i++)for(int j=0;j<3;j++){int d=i+j;Poly p=a[i]*b[j];if(d>=3){p=p*baseP;d-=3;}c[d]=c[d]+p;}return c;}
inline Curve cxmul(Curve a,const Poly&p){for(auto&v:a)v=v*p;return a;}
inline Curve cpow(Curve a,int n){Curve z=con(Poly{1});while(n){if(n&1)z=cmul(z,a);n>>=1;if(n)a=cmul(a,a);}return z;}
inline Curve cfrob5(const Curve&a){Curve b;for(int j=0;j<3;j++){int d=5*j;b[d%3]=frob5(a[j])*ppow(baseP,d/3);}return b;}
// Dense in lambda, with coefficients polynomials in x.
using Bi=std::vector<Poly>;
inline void btrim(Bi&a){while(!a.empty()&&a.back().empty())a.pop_back();}
inline Bi badd(Bi a,const Bi&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=a[i]+b[i];btrim(a);return a;}
inline Bi bscale(Bi a,F c){for(auto&x:a)x=scale(x,c);btrim(a);return a;}
inline Bi bmul(const Bi&a,const Bi&b){if(a.empty()||b.empty())return {};Bi c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=c[i+j]+a[i]*b[j];btrim(c);return c;}
inline Bi bxmul(Bi a,const Poly&p){for(auto&x:a)x=x*p;btrim(a);return a;}
inline Poly norm(const Curve&a){return ppow(a[0],3)+ppow(a[1],3)*baseP+ppow(a[2],3)*ppow(baseP,2)-scale(a[0]*a[1]*a[2]*baseP,3);}
inline Bi normBi(const std::array<Curve,3>&a){Bi aa(3),bb(3),cc(3);for(int j=0;j<3;j++){aa[j]=a[j][0];bb[j]=a[j][1];cc[j]=a[j][2];}return badd(badd(badd(bmul(bmul(aa,aa),aa),bxmul(bmul(bmul(bb,bb),bb),baseP)),bxmul(bmul(bmul(cc,cc),cc),ppow(baseP,2))),bscale(bxmul(bmul(bmul(aa,bb),cc),baseP),2));}
inline void jsonpoly(std::ostream&o,const Poly&p){o<<'[';for(size_t i=0;i<p.size();i++){if(i)o<<',';o<<p[i];}o<<']';}
}
