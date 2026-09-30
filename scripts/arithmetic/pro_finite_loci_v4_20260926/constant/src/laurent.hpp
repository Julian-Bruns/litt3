#pragma once
#include "exact.hpp"
// Sparse Laurent polynomials over K. Variables h,w,r,s; only w may be negative.
using Ex=std::array<int,4>;
struct LP:std::map<Ex,F>{using std::map<Ex,F>::map;LP(){};explicit LP(F a){if(a)(*this)[Ex{}]=a;}};
inline void accumulate(LP&a,const Ex&e,F c){if(!c)return;auto it=a.find(e);if(it==a.end())a[e]=c;else{it->second=FF::add(it->second,c);if(!it->second)a.erase(it);}}
inline LP lm(int h,int w=0,int r=0,int s=0,F c=1){LP a;if(c)a[Ex{h,w,r,s}]=c;return a;}
inline LP operator+(LP a,const LP&b){for(auto[e,c]:b)accumulate(a,e,c);return a;}
inline LP operator-(LP a){for(auto&[e,c]:a)c=FF::neg(c);return a;}
inline LP operator-(const LP&a,const LP&b){return a+(-b);}
inline LP scale(LP a,F c){if(!c)return LP{};for(auto&[e,b]:a)b=FF::mul(b,c);return a;}
inline LP operator*(const LP&a,const LP&b){LP c;for(auto[e,v]:a)for(auto[f,z]:b){Ex g;for(int j=0;j<4;j++)g[j]=e[j]+f[j];accumulate(c,g,FF::mul(v,z));}return c;}
inline LP power(LP a,unsigned n){LP b(1);while(n){if(n&1)b=b*a;n>>=1;if(n)a=a*a;}return b;}
inline LP frob5(const LP&a){LP b;for(auto[k,v]:a){Ex e=k;for(auto&x:e)x*=5;b[e]=FF::pow(v,5);}return b;}
inline LP div_mono(const LP&a,const LP&b){if(b.size()!=1)throw std::runtime_error("not monomial divisor");auto[f,v]=*b.begin();LP c;for(auto[k,u]:a){Ex e=k;for(int j=0;j<4;j++)e[j]-=f[j];c[e]=FF::div(u,v);}return c;}
inline LP subrs(const LP&a,const LP&r,const LP&s){LP b;for(auto[e,c]:a){if(e[2]<0||e[3]<0)throw std::runtime_error("bad r,s exponent");b=b+lm(e[0],e[1],0,0,c)*power(r,e[2])*power(s,e[3]);}return b;}
inline F evaluate(const LP&a,F h,F w,F r=0,F s=0){F b=0;F v[4]={h,w,r,s};for(auto[e,c]:a){for(int i=0;i<4;i++)c=FF::mul(c,e[i]<0?FF::pow(FF::inv(v[i]),-e[i]):FF::pow(v[i],e[i]));b=FF::add(b,c);}return b;}
inline void json_lp(std::ostream&o,const LP&a){o<<"[";bool first=true;for(auto[e,c]:a){if(!first)o<<",";first=false;o<<"["<<e[0]<<","<<e[1]<<","<<e[2]<<","<<e[3]<<","<<c<<"]";}o<<"]";}
constexpr int JET=7;
using Jet=std::array<LP,JET>;
inline Jet jc(F a){Jet j;j[0]=LP(a);return j;}
inline Jet operator+(Jet a,const Jet&b){for(int i=0;i<JET;i++)a[i]=a[i]+b[i];return a;}
inline Jet operator-(Jet a){for(auto&x:a)x=-x;return a;}
inline Jet operator-(const Jet&a,const Jet&b){return a+(-b);}
inline Jet scale(Jet a,F b){for(auto&x:a)x=scale(x,b);return a;}
inline Jet operator*(const Jet&a,const Jet&b){Jet c;for(int i=0;i<JET;i++)for(int j=0;i+j<JET;j++)c[i+j]=c[i+j]+a[i]*b[j];return c;}
inline Jet power(Jet a,unsigned n){Jet b=jc(1);while(n){if(n&1)b=b*a;n>>=1;if(n)a=a*a;}return b;}
inline Jet shift(Jet a,int n){Jet b;for(int i=0;i+n<JET;i++)b[i+n]=a[i];return b;}
inline Jet yjet(){Jet y=jc(1),p=jc(1);for(int i=0;i<10;i++){int e=30-3*i;if(e<JET)p[e]=LP(P[i]);}for(int i=1;i<JET;i++){auto c=power(y,3);y[i]=scale(p[i]-c[i],2);}return y;}
inline Jet monjet(int i,int j,int shift_n){Jet y=power(yjet(),j),a;int n=shift_n-3*i-10*j;if(n<0)throw std::runtime_error("Laurent series bad pole bound");for(int k=0;k+n<JET;k++)a[k+n]=y[k];return a;}
inline Jet series(const Curve&a,int n){Jet b;for(int j=0;j<3;j++)for(int i=0;i<=a[j].deg();i++)if(a[j][i])b=b+scale(monjet(i,j,n),a[j][i]);return b;}
using PCurve=std::array<std::vector<LP>,3>;
using PSource=std::array<PCurve,4>;
inline PCurve pcurve(const Curve&c){PCurve a;for(int j=0;j<3;j++)for(F v:c[j])a[j].push_back(LP(v));return a;}
inline void add_scaled(PCurve&a,const Curve&b,const LP&c){for(int j=0;j<3;j++){a[j].resize(std::max(a[j].size(),b[j].size()));for(size_t i=0;i<b[j].size();i++)a[j][i]=a[j][i]+scale(c,b[j][i]);}}
inline Jet series(const PCurve&a,int n){Jet b;for(int j=0;j<3;j++)for(size_t i=0;i<a[j].size();i++)if(!a[j][i].empty()){auto m=monjet(i,j,n);for(int k=0;k<JET;k++)b[k]=b[k]+m[k]*a[j][i];}return b;}
inline std::pair<Jet,Jet> fjets(const PSource&G){
Jet a=scale(series(G[0],35),3),b=scale(series(G[1],46),2),c=series(G[2],57),rho;
if(b[0].size()!=1||b[0].begin()->first!=Ex{})throw std::runtime_error("nonconstant rho pivot");F bi=FF::inv(b[0].begin()->second);for(int i=0;i<JET;i++){auto r=a*power(rho,2)+b*rho+c;rho[i]=scale(-r[i],bi);}
if(a*power(rho,2)+b*rho+c!=Jet{})throw std::runtime_error("rho solution failed");
Jet out=(series(Curve(Q),57)+shift(power(rho,5),2))*(series(G[3],70)+shift(a*power(rho,3)+scale(b*power(rho,2),2),2))+series(Curve(power(t,3))*cm(0,10),127);
return {out,rho};}
inline Source evaluate(const PSource&G,F h,F w){Source a;for(int s=0;s<4;s++)for(int j=0;j<3;j++){for(auto&v:G[s][j])a[s][j].push_back(evaluate(v,h,w));a[s][j].trim();}return a;}
inline std::vector<Source> load_basis(){std::ifstream in("evidence/source_basis.txt");if(!in)throw std::runtime_error("missing source basis");size_t n;in>>n;std::vector<Source>b(n);for(auto&s:b)for(auto&c:s)for(auto&p:c.c){size_t z;in>>z;p.resize(z);for(auto&v:p)in>>v;}return b;}
