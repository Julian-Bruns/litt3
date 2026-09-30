#pragma once
#include <bits/stdc++.h>
using namespace std;
struct F {
 int v;
 F(long long a=0):v((a%5+5)%5){}
 static F raw(int a){F z;z.v=a;return z;}
 static inline vector<int> ex,lg;
 static inline vector<int> ad;
 static inline int negs[390625];
 static int add25(int a,int b){return ((a%5+b%5)%5)+5*((a/5+b/5)%5);}
 static int neg25(int a){return ((5-a%5)%5)+5*((5-a/5)%5);}
 static int mul25(int a,int b){int x=a%5,y=a/5,z=b%5,w=b/5;return (x*z+3*y*w)%5+5*((x*w+y*z+y*w)%5);}
 static int slowmul(int a,int b){int av[4],bv[4],c[7]={};for(int i=0;i<4;i++){av[i]=a%25;a/=25;bv[i]=b%25;b/=25;}for(int i=0;i<4;i++)for(int j=0;j<4;j++)c[i+j]=add25(c[i+j],mul25(av[i],bv[j]));int m[4]={5,2,6,7};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)c[i-4+j]=add25(c[i-4+j],neg25(mul25(c[i],m[j])));return c[0]+25*c[1]+625*c[2]+15625*c[3];}
 static int slowpow(int a,int n){int r=1;for(;n;n>>=1,a=slowmul(a,a))if(n&1)r=slowmul(r,a);return r;}
 static void init(){
  ad.resize(625*625);for(int a=0;a<625;a++)for(int b=0;b<625;b++)ad[a*625+b]=add25(a%25,b%25)+25*add25(a/25,b/25);
  for(int i=0;i<390625;i++){int t=i,z=0,m=1;for(int j=0;j<4;j++){z+=m*neg25(t%25);t/=25;m*=25;}negs[i]=z;}
  int gen=0;for(int a=25;a<10000;a++){bool good=true;for(int d: {2,3,13,313})if(slowpow(a,390624/d)==1)good=false;if(good&&slowpow(a,390624)==1){gen=a;break;}}
  if(!gen)throw runtime_error("No generator");ex.resize(2*390624);lg.assign(390625,-1);int a=1;for(int i=0;i<390624;i++){if(lg[a]!=-1)throw runtime_error("generator collision");ex[i]=a;lg[a]=i;a=slowmul(a,gen);}if(a!=1)throw runtime_error("generator failure");copy(ex.begin(),ex.begin()+390624,ex.begin()+390624);cerr<<"Field K: 390625 elements; primitive code "<<gen<<" verified\n";
 }
 explicit operator bool()const{return v!=0;}
 friend F operator+(F a,F b){return raw(ad[(a.v%625)*625+b.v%625]+625*ad[(a.v/625)*625+b.v/625]);}
 F operator-()const{return raw(negs[v]);}
 friend F operator-(F a,F b){return a+(-b);}
 friend F operator*(F a,F b){if(!a.v||!b.v)return F();return raw(ex[lg[a.v]+lg[b.v]]);}
 F inverse()const{if(!v)throw runtime_error("F zero inverse");return raw(ex[390624-lg[v]]);}
 friend F operator/(F a,F b){return a*b.inverse();}
 F& operator+=(F b){return *this=*this+b;}F& operator-=(F b){return *this=*this-b;}F& operator*=(F b){return *this=*this*b;}
 friend bool operator==(F a,F b){return a.v==b.v;}friend bool operator!=(F a,F b){return a.v!=b.v;}
};
F fpow(F a,long long n){if(n<0)return fpow(a.inverse(),-n);if(!a)return n?F():F(1);return F::raw(F::ex[(long long)F::lg[a.v]*(n%390624)%390624]);}
ostream&operator<<(ostream&o,F a){return o<<a.v;}

template<class C> struct Pol {
 vector<C> a;
 Pol(){} Pol(C c){if(bool(c))a.push_back(c);} Pol(initializer_list<C> l):a(l){trim();} Pol(vector<C> l):a(move(l)){trim();}
 static Pol mon(int n,C c=C(1)){Pol z;z.a.resize(n+1);z.a[n]=c;z.trim();return z;}
 void trim(){while(!a.empty()&&!bool(a.back()))a.pop_back();}
 int deg()const{return (int)a.size()-1;}explicit operator bool()const{return !a.empty();}C operator[](int i)const{return i>=0&&i<(int)a.size()?a[i]:C();}
 friend Pol operator+(const Pol&p,const Pol&q){Pol r;r.a.resize(max(p.a.size(),q.a.size()));for(int i=0;i<(int)r.a.size();i++)r.a[i]=p[i]+q[i];r.trim();return r;}
 Pol operator-()const{Pol r=*this;for(C&c:r.a)c=-c;return r;}
 friend Pol operator-(const Pol&p,const Pol&q){return p+(-q);}
 friend Pol operator*(const Pol&p,const Pol&q){Pol r;if(!p||!q)return r;r.a.resize(p.deg()+q.deg()+1);for(int i=0;i<=p.deg();i++)if(bool(p.a[i]))for(int j=0;j<=q.deg();j++)if(bool(q.a[j]))r.a[i+j]+=p.a[i]*q.a[j];r.trim();return r;}
 Pol& operator+=(const Pol&q){return *this=*this+q;}Pol& operator-=(const Pol&q){return *this=*this-q;}
 friend Pol operator*(const Pol&p,C c){if(!bool(c))return {};Pol r=p;for(C&x:r.a)x=x*c;r.trim();return r;}
 friend Pol operator*(C c,const Pol&p){return p*c;}
 friend bool operator==(const Pol&p,const Pol&q){return p.a==q.a;}
 pair<Pol,Pol> divrem(const Pol&q)const{if(!q)throw runtime_error("poly division by zero");Pol r=*this,s;if(r.deg()>=q.deg())s.a.resize(r.deg()-q.deg()+1);C inv=q.a.back().inverse();while(r&&r.deg()>=q.deg()){int d=r.deg()-q.deg();C c=r.a.back()*inv;s.a[d]+=c;for(int i=0;i<=q.deg();i++)r.a[i+d]-=q.a[i]*c;r.trim();}s.trim();return {s,r};}
 Pol exact(const Pol&q)const{auto [a,b]=divrem(q);if(b)throw runtime_error("inexact poly division");return a;}
 Pol operator%(const Pol&q)const{return divrem(q).second;}
 C eval(C x)const{C z;for(int i=deg();i>=0;i--)z=z*x+a[i];return z;}
 Pol deriv()const{Pol r;for(int i=1;i<=deg();i++)r.a.push_back(a[i]*C(i));r.trim();return r;}
 Pol trunc(int n)const{Pol r=*this;if((int)r.a.size()>n)r.a.resize(n);r.trim();return r;}
 Pol shift(int n)const{Pol r;if(n>=0){r.a.resize(n);r.a.insert(r.a.end(),a.begin(),a.end());}else if(-n<(int)a.size())r.a.assign(a.begin()-n,a.end());r.trim();return r;}
};
template<class C> Pol<C> ppow(Pol<C> a,int n){Pol<C>r(C(1));for(;n;){if(n&1)r=r*a;n>>=1;if(n)a=a*a;}return r;}
template<class C> Pol<C> pgcd(Pol<C>a,Pol<C>b){while(b){Pol<C>r=a%b;a=b;b=r;}return a?a*a.a.back().inverse():a;}
using PF=Pol<F>;
PF coded(initializer_list<int> l){vector<F>a;for(int c:l)a.push_back(F::raw(c));return PF(a);}

// Sparse Laurent polynomials in h,w,k1,k2. Exponents are exact integers.
struct LP {
 using Exp=array<int,4>;map<Exp,F> a;
 LP(long long n=0){F c(n);if(c)a[{0,0,0,0}]=c;}
 LP(F c){if(c)a[{0,0,0,0}]=c;}
 static LP mon(Exp e,F c=F(1)){LP z;if(c)z.a[e]=c;return z;}
 static LP var(int i){Exp e={};e[i]=1;return mon(e);}
 void put(Exp e,F c){if(!c)return;F d=a[e]+c;if(d)a[e]=d;else a.erase(e);}
 explicit operator bool()const{return !a.empty();}
 friend LP operator+(LP p,const LP&q){for(auto[e,c]:q.a)p.put(e,c);return p;}
 LP operator-()const{LP r;for(auto[e,c]:a)r.a[e]=-c;return r;}
 friend LP operator-(LP p,const LP&q){for(auto[e,c]:q.a)p.put(e,-c);return p;}
 friend LP operator*(const LP&p,const LP&q){LP r;for(auto[e,c]:p.a)for(auto[f,d]:q.a){Exp g;for(int i=0;i<4;i++)g[i]=e[i]+f[i];r.put(g,c*d);}return r;}
 LP&operator+=(const LP&q){return *this=*this+q;}LP&operator-=(const LP&q){return *this=*this-q;}
 LP inverse()const{if(a.size()!=1)throw runtime_error("LP nonmonomial inverse");auto e=a.begin()->first;auto c=a.begin()->second;for(int&i:e)i=-i;return mon(e,c.inverse());}
 friend LP operator/(const LP&p,const LP&q){return p*q.inverse();}
 friend bool operator==(const LP&p,const LP&q){return p.a==q.a;}
 friend bool operator!=(const LP&p,const LP&q){return !(p==q);}
};
LP lpow(LP a,int n){if(n<0)return lpow(a.inverse(),-n);LP r(1);for(;n;){if(n&1)r=r*a;n>>=1;if(n)a=a*a;}return r;}
LP subst(const LP&p,int i,const LP&z){LP r;map<int,LP> cache;for(auto [ee,c]:p.a){auto e=ee;int n=e[i];e[i]=0;if(!cache.count(n))cache[n]=lpow(z,n);r+=LP::mon(e,c)*cache[n];}return r;}
LP frob(const LP&p,int n=5){LP r;for(auto[ee,c]:p.a){auto e=ee;for(int&i:e)i*=n;r.put(e,fpow(c,n));}return r;}
using PL=Pol<LP>;

template<class C> struct Curve {
 array<Pol<C>,3> a;
 static inline Pol<C> P;
 Curve(){}Curve(C c){a[0]=Pol<C>(c);}Curve(Pol<C>p){a[0]=p;}
 static Curve mon(int i,int j,C c=C(1)){Curve z;z.a[j%3]=Pol<C>::mon(i,c)*ppow(P,j/3);return z;}
 explicit operator bool()const{return bool(a[0])||bool(a[1])||bool(a[2]);}
 friend Curve operator+(Curve p,const Curve&q){for(int i=0;i<3;i++)p.a[i]+=q.a[i];return p;}
 Curve operator-()const{Curve r;for(int i=0;i<3;i++)r.a[i]=-a[i];return r;}
 friend Curve operator-(Curve p,const Curve&q){for(int i=0;i<3;i++)p.a[i]-=q.a[i];return p;}
 friend Curve operator*(const Curve&p,const Curve&q){Curve r;for(int i=0;i<3;i++)for(int j=0;j<3;j++)r.a[(i+j)%3]+=p.a[i]*q.a[j]*(i+j>=3?P:Pol<C>(C(1)));return r;}
 friend Curve operator*(Curve p,C c){for(int i=0;i<3;i++)p.a[i]=p.a[i]*c;return p;}
 friend Curve operator*(C c,Curve p){return p*c;}
 Curve&operator+=(const Curve&q){return *this=*this+q;}
 friend bool operator==(const Curve&p,const Curve&q){return p.a==q.a;}
};
using CF=Curve<F>;using CL=Curve<LP>;
template<class C>Curve<C> cpow(Curve<C>a,int n){Curve<C>r(C(1));for(;n;){if(n&1)r=r*a;n>>=1;if(n)a=a*a;}return r;}
CL lift(const CF&p){CL r;for(int j=0;j<3;j++)for(F c:p.a[j].a)r.a[j].a.push_back(LP(c));return r;}
PL lift(const PF&p){PL r;for(F c:p.a)r.a.push_back(LP(c));return r;}

template<class C>vector<pair<int,int>> basis(int bound){vector<pair<int,int>>r;for(int j=0;j<3;j++)for(int i=0;3*i+10*j<=bound;i++)r.push_back({i,j});return r;}

template<class C> Pol<C> spow(Pol<C> a,int n,int prec){Pol<C> r(C(1));for(;n;){if(n&1)r=(r*a).trunc(prec);n>>=1;if(n)a=(a*a).trunc(prec);}return r;}
