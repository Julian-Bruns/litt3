#pragma once
#include "field.hpp"
using kfield::F;
struct Poly {
 std::vector<F> c;
 Poly()=default;
 Poly(F a){if(a)c={a};}
 Poly(int a):Poly(F(a)){}
 Poly(std::vector<F> a):c(std::move(a)){trim();}
 static Poly codes(std::initializer_list<int> a){std::vector<F> c;for(int i:a)c.push_back(F::code(i));return Poly(c);}
 static Poly mon(int i,F a=F(1)){Poly p;p.c.resize(i+1);p.c[i]=a;p.trim();return p;}
 void trim(){while(!c.empty()&&!c.back())c.pop_back();}
 int deg()const{return int(c.size())-1;}
 F operator[](int i)const{return i>=0&&i<(int)c.size()?c[i]:F();}
 explicit operator bool()const{return !c.empty();}
 Poly operator-()const{Poly p=*this;for(auto &a:p.c)a=-a;return p;}
 Poly operator+(const Poly& b)const{Poly p=*this;p.c.resize(std::max(c.size(),b.c.size()));for(size_t i=0;i<b.c.size();i++)p.c[i]+=b.c[i];p.trim();return p;}
 Poly operator-(const Poly& b)const{return *this+-b;}
 Poly operator*(F b)const{if(!b)return Poly();Poly p=*this;for(auto &a:p.c)a*=b;return p;}
 Poly operator*(const Poly& b)const{if(!*this||!b)return Poly();Poly p;p.c.resize(c.size()+b.c.size()-1);for(size_t i=0;i<c.size();i++)if(c[i])for(size_t j=0;j<b.c.size();j++)p.c[i+j]+=c[i]*b.c[j];p.trim();return p;}
 Poly operator/(F b)const{return *this*b.inv();}
 Poly& operator+=(const Poly& b){return *this=*this+b;}
 Poly& operator-=(const Poly& b){return *this=*this-b;}
 Poly& operator*=(const Poly& b){return *this=*this*b;}
 Poly& operator*=(F b){return *this=*this*b;}
 std::pair<Poly,Poly> divrem(const Poly& b)const{if(!b)throw std::runtime_error("polynomial division by zero");Poly p=*this,q;int d=deg()-b.deg();if(d<0)return {q,p};q.c.resize(d+1);F inv=b.c.back().inv();for(int i=d;i>=0;i--){F a=p[i+b.deg()]*inv;q.c[i]=a;for(int j=0;j<=b.deg();j++)p.c[i+j]-=a*b.c[j];}p.trim();q.trim();return {q,p};}
 Poly operator%(const Poly& b)const{return divrem(b).second;}
 Poly exactdiv(const Poly& b)const{auto [q,r]=divrem(b);if(r)throw std::runtime_error("inexact polynomial division");return q;}
 bool operator==(const Poly& b)const{return c==b.c;}
 bool operator!=(const Poly& b)const{return !(*this==b);}
 Poly pow(int n)const{Poly a=*this,b(1);while(n){if(n&1)b=b*a;a=a*a;n>>=1;}return b;}
 Poly powmod(long long n,const Poly& m)const{Poly a=*this%m,b(1);while(n){if(n&1)b=b*a%m;a=a*a%m;n>>=1;}return b;}
 Poly deriv()const{Poly p;if(deg()<=0)return p;p.c.resize(deg());for(int i=1;i<=deg();i++)p.c[i-1]=c[i]*F(i);p.trim();return p;}
 F eval(F a)const{F r;for(int i=deg();i>=0;i--)r=r*a+c[i];return r;}
 Poly trunc(int n)const{Poly p=*this;if(p.deg()>=n)p.c.resize(n);p.trim();return p;}
 Poly shift(int n)const{if(!*this)return Poly();if(n<0){if(-n>deg())return Poly();return Poly(std::vector<F>(c.begin()-n,c.end()));}Poly p;p.c.resize(n);p.c.insert(p.c.end(),c.begin(),c.end());return p;}
};
inline Poly gcd(Poly a,Poly b){while(b){Poly t=a%b;a=b;b=t;}return a?a/a.c.back():a;}
inline Poly operator*(F a,const Poly& b){return b*a;}
inline Poly P;
struct Curve{
 std::array<Poly,3> c;
 Curve()=default;
 Curve(Poly a):c({a,Poly(),Poly()}){}
 Curve(F a):Curve(Poly(a)){}
 Curve(int a):Curve(Poly(a)){}
 static Curve mon(int i,int j,F a=F(1)){Curve f;f.c[j]=Poly::mon(i,a);return f;}
 bool operator==(const Curve& b)const{return c==b.c;}
 bool operator!=(const Curve& b)const{return !(*this==b);}
 explicit operator bool()const{return bool(c[0])||bool(c[1])||bool(c[2]);}
 Curve operator-()const{Curve a;for(int i=0;i<3;i++)a.c[i]=-c[i];return a;}
 Curve operator+(const Curve& b)const{Curve a;for(int i=0;i<3;i++)a.c[i]=c[i]+b.c[i];return a;}
 Curve operator-(const Curve& b)const{return *this+-b;}
 Curve operator*(const Curve& b)const{Curve a;for(int i=0;i<3;i++)for(int j=0;j<3;j++){auto v=c[i]*b.c[j];if(i+j>=3)v=v*P;a.c[(i+j)%3]+=v;}return a;}
 Curve operator*(F b)const{Curve a;for(int i=0;i<3;i++)a.c[i]=c[i]*b;return a;}
 Curve operator*(const Poly& b)const{Curve a;for(int i=0;i<3;i++)a.c[i]=c[i]*b;return a;}
 Curve operator/(F b)const{return *this*b.inv();}
 Curve& operator+=(const Curve& b){return *this=*this+b;}
 Curve& operator-=(const Curve& b){return *this=*this-b;}
 Curve pow(int n)const{Curve a=*this,b(1);while(n){if(n&1)b=b*a;a=a*a;n>>=1;}return b;}
 Curve divide_y(int n)const{
  Curve a;for(int j=0;j<3;j++){int e=((n-j)+2)/3;e=std::max(e,0);int out=j+3*e-n;
   if(out<0||out>2)throw std::runtime_error("bad y division");
   a.c[out]=c[j].exactdiv(P.pow(e));}
  return a;
 }
 Poly norm()const{return c[0].pow(3)+P*c[1].pow(3)+P.pow(2)*c[2].pow(3)-F(3)*c[0]*c[1]*c[2]*P;}
 int pole()const{int d=-100000;for(int j=0;j<3;j++)if(c[j])d=std::max(d,3*c[j].deg()+10*j);return d;}
};
inline Curve operator*(F a,const Curve& b){return b*a;}
inline Curve operator*(const Poly& a,const Curve& b){return b*a;}
inline std::vector<std::pair<int,int>> monomials(int d){std::vector<std::pair<int,int>> v;for(int j=0;j<3;j++)for(int i=0;3*i+10*j<=d;i++)v.push_back({i,j});return v;}
