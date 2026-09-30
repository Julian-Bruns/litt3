#pragma once
#include "etalgebra.hpp"
struct QE{
 AE a,b;inline static AE S,T;
 QE(){} explicit QE(F c):a(c){} explicit QE(AE a0):a(a0){} QE(AE a0,AE b0):a(a0),b(b0){}
 bool zero()const{return a.zero()&&b.zero();}
 friend bool operator==(const QE&x,const QE&y){return x.a==y.a&&x.b==y.b;}
 friend QE operator+(const QE&x,const QE&y){return QE(x.a+y.a,x.b+y.b);}
 friend QE operator-(const QE&x){return QE(-x.a,-x.b);}
 friend QE operator-(const QE&x,const QE&y){return x+(-y);}
 friend QE operator*(const QE&x,const QE&y){AE bb=x.b*y.b;return QE(x.a*y.a+T*bb,x.a*y.b+x.b*y.a+S*bb);}
 QE pow(int n)const{QE x=*this,r(1);while(n){if(n&1)r=r*x;n>>=1;if(n)x=x*x;}return r;}
 AE norm()const{return a*a+S*a*b-T*b*b;}
 QE inverse()const{AE n=norm().inverse();return QE((a+S*b)*n,-b*n);}
};
template<class R>using GP=std::vector<R>;
template<class R>void gtrim(GP<R>&a){while(!a.empty()&&a.back().zero())a.pop_back();}
template<class R>R gc(const GP<R>&a,int j){return j>=0&&j<int(a.size())?a[j]:R();}
template<class R>GP<R> gplus(const GP<R>&a,const GP<R>&b){GP<R> r(std::max(a.size(),b.size()));for(int j=0;j<int(r.size());j++)r[j]=gc(a,j)+gc(b,j);gtrim(r);return r;}
template<class R>GP<R> gscale(GP<R> a,R s){for(auto &r:a)r=r*s;gtrim(a);return a;}
template<class R>GP<R> gmul(const GP<R>&a,const GP<R>&b,int n=10000){if(a.empty()||b.empty())return{};GP<R>r(std::min(n,int(a.size()+b.size()-1)));for(int i=0;i<int(a.size());i++)if(!a[i].zero())for(int j=0;j<int(b.size())&&i+j<n;j++)if(!b[j].zero())r[i+j]=r[i+j]+a[i]*b[j];gtrim(r);return r;}
template<class R>GP<R> gpow(GP<R>a,int n,int limit=10000){GP<R>r{R(1)};while(n){if(n&1)r=gmul(r,a,limit);n>>=1;if(n)a=gmul(a,a,limit);}return r;}
template<class R>GP<R> gfrob(const GP<R>&a,int n,int limit){GP<R>r(std::min(limit,n*int(a.size())));for(int i=0;i<int(a.size())&&i*n<limit;i++)r[i*n]=a[i].pow(n);gtrim(r);return r;}
template<class R>GP<R> gfrom(const Poly&a){GP<R>b;for(F c:a.v)b.emplace_back(c);gtrim(b);return b;}
GP<QE> qnormE(const std::array<GP<QE>,3>&a,const QE&q){GP<QE>pp=gfrom<QE>(P);return gplus(gplus(gscale(gpow(a[0],3),q*q),gscale(gmul(pp,gpow(a[1],3)),q)),gplus(gmul(gmul(pp,pp),gpow(a[2],3)),gscale(gmul(pp,gmul(gmul(a[0],a[1]),a[2])),QE(2)*q)));}
GP<QE> qevalW(const AEtable&E,const AE&q){std::array<GP<QE>,3>e;for(int j=0;j<3;j++){e[j].resize(47);for(int x=0;x<47;x++){AE c0=ac(E[j][0],x),c1=ac(E[j][1],x),c2=ac(E[j][2],x);e[j][x]=QE(c0+QE::T*c2,c1+QE::S*c2);}gtrim(e[j]);}return qnormE(e,QE(q));}
std::vector<QE> errorsQ(const GP<QE>&W,int early_stop=140){if(W.size()!=141||!W[140].b.zero())throw std::runtime_error("bad quadratic norm leading term");GP<QE>A(141);for(int j=0;j<=140;j++)A[j]=W[140-j];A=gscale(A,QE(A[0].a.inverse()));GP<QE>A2=gmul(A,A,125),A3=gmul(A2,A,125),C=gmul(gmul(A3,gfrob(A2,5,125),125),gfrob(A2,25,125),125);std::vector<QE>out;for(int j=71;j<=std::min(124,early_stop);j++)out.push_back(gc(C,j));if(early_stop>=125){GP<QE>B(C.begin(),C.begin()+71),B2=gmul(B,B,141);for(int j=125;j<=std::min(140,early_stop);j++)out.push_back(gc(B2,j)-gc(A,j));}return out;}
void writeQ(std::ostream&f,const QE&x){writeA(f,x.a);writeA(f,x.b);}
