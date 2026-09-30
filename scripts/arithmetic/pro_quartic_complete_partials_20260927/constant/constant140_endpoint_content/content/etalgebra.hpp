#pragma once
#include "../forward/square_engine.hpp"
struct SplitNeeded:std::runtime_error {Poly factor;SplitNeeded(Poly f):std::runtime_error("nonunit: split modulus"),factor(f){}};
struct AE {
 Poly p; inline static Poly modulus;
 AE(){} explicit AE(F v):p(v){} explicit AE(Poly a):p(rem(a,modulus)){}
 bool zero()const{return p.zero();}
 friend bool operator==(const AE&a,const AE&b){return a.p==b.p;}
 friend AE operator+(const AE&a,const AE&b){AE c;c.p=a.p+b.p;return c;}
 friend AE operator-(const AE&a){AE c;c.p=-a.p;return c;}
 friend AE operator-(const AE&a,const AE&b){return a+(-b);}
 friend AE operator*(const AE&a,const AE&b){return AE(a.p*b.p);}
 friend AE scale(const AE&a,F c){AE b;b.p=scale(a.p,c);return b;}
 AE inverse()const{Poly r0=modulus,r1=p,s0,s1(1);while(!r1.zero()){auto qr=divmod(r0,r1);Poly ss=s0-qr.first*s1;r0=r1;r1=qr.second;s0=s1;s1=ss;}if(r0.deg()!=0)throw SplitNeeded(r0);return AE(scale(s0,ff::inv(r0.at(0))));}
 AE pow(int n)const{if(n<0)return inverse().pow(-n);AE a=*this,r(1);while(n){if(n&1)r=r*a;n>>=1;if(n)a=a*a;}return r;}
 friend AE operator/(const AE&a,const AE&b){return a*b.inverse();}
};
using EP=std::vector<AE>;
void atrim(EP&a){while(!a.empty()&&a.back().zero())a.pop_back();}
AE ac(const EP&a,int j){return j>=0&&j<int(a.size())?a[j]:AE();}
EP aplus(const EP&a,const EP&b){EP r(std::max(a.size(),b.size()));for(int j=0;j<int(r.size());j++)r[j]=ac(a,j)+ac(b,j);atrim(r);return r;}
EP ascale(EP a,AE s){for(auto &r:a)r=r*s;atrim(a);return a;}
EP amul(const EP&a,const EP&b,int n=10000){if(a.empty()||b.empty())return{};EP r(std::min(n,int(a.size()+b.size()-1)));for(int i=0;i<int(a.size());i++)if(!a[i].zero())for(int j=0;j<int(b.size())&&i+j<n;j++)if(!b[j].zero())r[i+j]=r[i+j]+a[i]*b[j];atrim(r);return r;}
EP apow(EP a,int n,int limit=10000){EP r{AE(1)};while(n){if(n&1)r=amul(r,a,limit);n>>=1;if(n)a=amul(a,a,limit);}return r;}
EP afrob(const EP&a,int n,int limit){EP r(std::min(limit,n*int(a.size())));for(int i=0;i<int(a.size())&&i*n<limit;i++)r[i*n]=a[i].pow(n);atrim(r);return r;}
EP afrom(const Poly&a){EP b;for(F c:a.v)b.emplace_back(c);atrim(b);return b;}
AE aeval(const EP&a,AE v){AE r;for(int j=int(a.size())-1;j>=0;j--)r=r*v+a[j];return r;}
AE peval(const Poly&a,AE v){return aeval(afrom(a),v);}
// j, mu, x exponent.
using AEtable=std::array<std::array<EP,3>,3>;
AEtable evalE(const std::vector<Record>&rs,const AE&H,const AE&q){std::array<AE,13>hp;std::array<AE,61>qp;hp[0]=qp[0]=AE(1);for(int j=1;j<13;j++)hp[j]=hp[j-1]*H;for(int j=1;j<61;j++)qp[j]=qp[j-1]*q;std::array<std::array<AE,61>,13>hq;for(int h=0;h<13;h++)for(int n=0;n<61;n++)hq[h][n]=hp[h]*qp[n];AEtable E;for(auto&jj:E)for(auto &p:jj)p.resize(47);for(auto s:rs)E[s.j][s.m][s.x]=E[s.j][s.m][s.x]+scale(hq[s.h][s.q],s.c);for(auto&jj:E)for(auto&p:jj)atrim(p);return E;}
EP normE(const std::array<EP,3>&a,const AE&q){EP pp=afrom(P);return aplus(aplus(ascale(apow(a[0],3),q*q),ascale(amul(pp,apow(a[1],3)),q)),aplus(amul(amul(pp,pp),apow(a[2],3)),ascale(amul(pp,amul(amul(a[0],a[1]),a[2])),scale(q,2))));}
EP evalW(const AEtable&E,const AE&mu,const AE&q){std::array<EP,3> e;for(int j=0;j<3;j++)e[j]=aplus(aplus(E[j][0],ascale(E[j][1],mu)),ascale(E[j][2],mu*mu));return normE(e,q);}
std::vector<AE> errorsA(const EP&W,int early_stop=140){if(W.size()!=141)throw std::runtime_error("W degree not 140");EP A(141);for(int j=0;j<=140;j++)A[j]=W[140-j];A=ascale(A,A[0].inverse());EP A2=amul(A,A,125),A3=amul(A2,A,125),C=amul(amul(A3,afrob(A2,5,125),125),afrob(A2,25,125),125);std::vector<AE>out;for(int j=71;j<=std::min(124,early_stop);j++)out.push_back(ac(C,j));if(early_stop>=125){EP B(C.begin(),C.begin()+71),B2=amul(B,B,141);for(int j=125;j<=std::min(140,early_stop);j++)out.push_back(ac(B2,j)-ac(A,j));}return out;}
Poly apGCD(const std::vector<AE>&a){Poly g=AE::modulus;for(auto&v:a){g=gcd(g,v.p);if(g.deg()<=0)break;}return g;}
void writeA(std::ostream&out,const AE&a){writepoly(out,a.p);}
void writeEP(std::ostream&out,const EP&a){out<<a.size()<<"\n";for(auto &c:a)writeA(out,c);}
int binomMod(int n,int k){int r=1;while(n||k){int a=n%5,b=k%5;if(b>a)return 0;int z=1;for(int j=1;j<=b;j++)z=z*(a-j+1)/j;r=r*z%5;n/=5;k/=5;}return r;}
EP ajet(const EP&a,F r,int n){EP s(n);for(int i=0;i<int(a.size());i++)for(int k=0;k<=i&&k<n;k++)if(int bc=binomMod(i,k))s[k]=s[k]+scale(a[i],ff::mul(bc,ff::pow(r,i-k)));atrim(s);return s;}
Poly fieldjet(const Poly&a,F r,int n){Poly s;s.v.resize(n);for(int i=0;i<=a.deg();i++)for(int k=0;k<=i&&k<n;k++)if(int bc=binomMod(i,k))s.v[k]=ff::add(s.v[k],ff::mul(a.at(i),ff::mul(bc,ff::pow(r,i-k))));s.trim();return s;}
Poly endpointY(F r,int n){Poly target=scale(fieldjet(P,r,n),ff::inv(eval(P,r))),Y(1);for(int i=1;i<n;i++)Y=Y+Poly::mon(i,ff::mul(2,ff::sub(target.at(i),seriespow(Y,3,i+1).at(i))));if(!(seriespow(Y,3,n)==target))throw std::runtime_error("bad Y jet");return Y;}
std::array<EP,3> endpointJets(const AEtable&E,F r,const AE&v,int n){Poly Y=endpointY(r,n);std::array<EP,3>o;for(int m=0;m<3;m++)for(int j=0;j<3;j++)o[m]=aplus(o[m],ascale(amul(ajet(E[j][m],r,n),afrom(seriespow(Y,j,n)),n),v.pow(j)));return o;}
int valJets(const std::array<EP,3>&a){for(int k=0;k<100;k++){std::vector<AE>cs;for(int m=0;m<3;m++)cs.push_back(ac(a[m],k));Poly g=apGCD(cs);if(g.deg()<AE::modulus.deg()){if(g.deg()>0)throw SplitNeeded(g);return k;}}throw std::runtime_error("jets all zero");}
EP jetLead(const std::array<EP,3>&a,int n){EP p;for(int m=0;m<3;m++)p.push_back(ac(a[m],n));atrim(p);return p;}
