#pragma once
#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <map>
#include <numeric>
#include <stdexcept>
#include <string>
#include <vector>
using F=int;
namespace ff {
constexpr int N=390625, ORD=N-1;
inline std::vector<int> adds(625*625), negs(N), logs(N,-1), exps(2*ORD);
inline int generator=0;
inline int add25(int a,int b){return ((a%5+b%5)%5)+5*((a/5+b/5)%5);}
inline int neg25(int a){return (5-a%5)%5+5*((5-a/5)%5);}
inline int mul25(int a,int b){int a0=a%5,a1=a/5,b0=b%5,b1=b/5;return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5);}
inline F add(F a,F b){return adds[(a%625)*625+b%625]+625*adds[(a/625)*625+b/625];}
inline F neg(F a){return negs[a];}
inline F sub(F a,F b){return add(a,neg(b));}
inline F slowmul(F a,F b){int av[4],bv[4],r[7]={};for(int i=0;i<4;i++){av[i]=a%25;bv[i]=b%25;a/=25;b/=25;}for(int i=0;i<4;i++)for(int j=0;j<4;j++)r[i+j]=add25(r[i+j],mul25(av[i],bv[j]));int m[4]={5,2,6,7};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)r[i-4+j]=add25(r[i-4+j],neg25(mul25(r[i],m[j])));return r[0]+25*r[1]+625*r[2]+15625*r[3];}
inline F slowpow(F a,int n){F r=1;while(n){if(n&1)r=slowmul(r,a);a=slowmul(a,a);n>>=1;}return r;}
inline void init(){for(int a=0;a<625;a++)for(int b=0;b<625;b++)adds[a*625+b]=add25(a%25,b%25)+25*add25(a/25,b/25);for(int a=0;a<N;a++){int z=a,r=0,p=1;for(int i=0;i<8;i++,p*=5){r+=((5-z%5)%5)*p;z/=5;}negs[a]=r;}for(int g=2;g<N;g++){if(slowpow(g,ORD)!=1)continue;bool ok=true;for(int p:{2,3,13,313})if(slowpow(g,ORD/p)==1)ok=false;if(ok){generator=g;break;}}if(!generator)throw std::runtime_error("K does not pass field test");F x=1;for(int i=0;i<ORD;i++){if(logs[x]!=-1)throw std::runtime_error("short generator orbit");logs[x]=i;exps[i]=exps[ORD+i]=x;x=slowmul(x,generator);}if(x!=1)throw std::runtime_error("generator order mismatch");}
inline F mul(F a,F b){return a&&b?exps[logs[a]+logs[b]]:0;}
inline F inv(F a){if(!a)throw std::runtime_error("division by zero");return exps[ORD-logs[a]];}
inline F div(F a,F b){return mul(a,inv(b));}
inline F pow(F a,long long n){if(!a){if(n<0)throw std::runtime_error("negative power zero");return n?0:1;}long long k=(logs[a]*(n%ORD))%ORD;if(k<0)k+=ORD;return exps[k];}
}
struct Poly {
 std::vector<F> v;
 Poly(){} explicit Poly(F a){if(a)v={a};} explicit Poly(std::vector<F>a):v(std::move(a)){trim();}
 void trim(){while(v.size()&&!v.back())v.pop_back();}
 int deg()const{return (int)v.size()-1;} F at(int i)const{return i>=0&&i<(int)v.size()?v[i]:0;}
 static Poly mon(int i,F a=1){Poly p;if(a){p.v.resize(i+1);p.v[i]=a;}return p;}
 bool zero()const{return v.empty();}
 void resize(int n){v.resize(n);}
};
inline bool operator==(const Poly&a,const Poly&b){return a.v==b.v;}
inline Poly operator+(const Poly&a,const Poly&b){Poly c;c.v.resize(std::max(a.v.size(),b.v.size()));for(int i=0;i<(int)c.v.size();i++)c.v[i]=ff::add(a.at(i),b.at(i));c.trim();return c;}
inline Poly operator-(const Poly&a){Poly c=a;for(auto &x:c.v)x=ff::neg(x);return c;}
inline Poly operator-(const Poly&a,const Poly&b){return a+(-b);}
inline Poly scale(const Poly&a,F b){Poly c=a;for(auto &x:c.v)x=ff::mul(x,b);c.trim();return c;}
inline Poly operator*(const Poly&a,const Poly&b){Poly c;if(a.zero()||b.zero())return c;c.v.resize(a.deg()+b.deg()+1);for(int i=0;i<=a.deg();i++)if(a.v[i])for(int j=0;j<=b.deg();j++)if(b.v[j])c.v[i+j]=ff::add(c.v[i+j],ff::mul(a.v[i],b.v[j]));c.trim();return c;}
inline Poly ppow(Poly a,int n){Poly r(1);while(n){if(n&1)r=r*a;n>>=1;if(n)a=a*a;}return r;}
inline std::pair<Poly,Poly> divmod(Poly a,const Poly&b){if(b.zero())throw std::runtime_error("polynomial zero divisor");Poly q;if(a.deg()<b.deg())return {q,a};q.v.resize(a.deg()-b.deg()+1);F iv=ff::inv(b.v.back());while(a.deg()>=b.deg()){int d=a.deg()-b.deg();F z=ff::mul(a.v.back(),iv);q.v[d]=z;for(int j=0;j<=b.deg();j++)a.v[j+d]=ff::sub(a.v[j+d],ff::mul(z,b.v[j]));a.trim();}q.trim();return {q,a};}
inline Poly exactdiv(const Poly&a,const Poly&b){auto qr=divmod(a,b);if(!qr.second.zero())throw std::runtime_error("nonexact polynomial division");return qr.first;}
inline Poly rem(const Poly&a,const Poly&b){return divmod(a,b).second;}
inline Poly gcd(Poly a,Poly b){while(!b.zero()){Poly r=rem(a,b);a=b;b=r;}return a.zero()?a:scale(a,ff::inv(a.v.back()));}
inline Poly derivative(const Poly&a){Poly c;if(a.deg()>0)c.v.resize(a.deg());for(int i=1;i<=a.deg();i++)c.v[i-1]=ff::mul(i%5,a.v[i]);c.trim();return c;}
inline F eval(const Poly&a,F x){F r=0;for(int i=a.deg();i>=0;i--)r=ff::add(ff::mul(r,x),a.v[i]);return r;}
inline Poly trunc(Poly a,int n){if(a.deg()>=n)a.v.resize(n);a.trim();return a;}
inline Poly shift(const Poly&a,int n){if(n<0)throw std::runtime_error("negative shift");if(a.zero())return a;Poly b;b.v.resize(n+a.v.size());std::copy(a.v.begin(),a.v.end(),b.v.begin()+n);return b;}
inline Poly seriesmul(const Poly&a,const Poly&b,int n){return trunc(a*b,n);}
inline Poly seriespow(Poly a,int r,int n){Poly p(1);while(r){if(r&1)p=seriesmul(p,a,n);r>>=1;if(r)a=seriesmul(a,a,n);}return p;}
inline Poly frob(const Poly&a,int n=5){Poly b;if(a.zero())return b;b.v.resize(a.deg()*n+1);for(int i=0;i<=a.deg();i++)b.v[n*i]=ff::pow(a.v[i],n);return b;}
inline Poly P(std::vector<F>{11,22,18,5,19,20,15,16,9,22,1});
struct Curve {
 std::array<Poly,3> a;
 Curve(){} explicit Curve(F x){a[0]=Poly(x);} explicit Curve(const Poly&p){a[0]=p;}
 static Curve mon(int i,int j,F c=1){Curve b;b.a[j%3]=Poly::mon(i,c)*ppow(P,j/3);return b;}
 bool zero()const{return a[0].zero()&&a[1].zero()&&a[2].zero();}
 int pole()const{int m=-100000;for(int j=0;j<3;j++)if(!a[j].zero())m=std::max(m,3*a[j].deg()+10*j);return m;}
};
inline bool operator==(const Curve&a,const Curve&b){return a.a==b.a;}
inline Curve operator+(const Curve&a,const Curve&b){Curve c;for(int j=0;j<3;j++)c.a[j]=a.a[j]+b.a[j];return c;}
inline Curve operator-(const Curve&a){Curve c;for(int j=0;j<3;j++)c.a[j]=-a.a[j];return c;}
inline Curve operator-(const Curve&a,const Curve&b){return a+(-b);}
inline Curve scale(const Curve&a,F b){Curve c;for(int j=0;j<3;j++)c.a[j]=scale(a.a[j],b);return c;}
inline Curve operator*(const Curve&a,const Curve&b){Curve c;for(int j=0;j<3;j++)for(int k=0;k<3;k++){Poly term=a.a[j]*b.a[k];if(j+k>=3)term=term*P;c.a[(j+k)%3]=c.a[(j+k)%3]+term;}return c;}
inline Curve cpow(Curve a,int n){Curve r(1);while(n){if(n&1)r=r*a;n>>=1;if(n)a=a*a;}return r;}
inline Curve cdiv(const Curve&a,const Poly&p){Curve c;for(int j=0;j<3;j++)c.a[j]=exactdiv(a.a[j],p);return c;}
inline Curve divy(const Curve&a,int n){Curve c;for(int j=0;j<3;j++){int r=(j-n)%3;if(r<0)r+=3;int k=(n+r-j)/3;c.a[r]=exactdiv(a.a[j],ppow(P,k));}return c;}
inline Curve crem(const Curve&a,const Poly&p){Curve c;for(int j=0;j<3;j++)c.a[j]=rem(a.a[j],p);return c;}
inline Poly norm(const Curve&a){return ppow(a.a[0],3)+ppow(a.a[1],3)*P+ppow(a.a[2],3)*P*P-scale(a.a[0]*a.a[1]*a.a[2]*P,3);}
inline std::vector<std::pair<int,int>> basisL(int n){std::vector<std::pair<int,int>>v;for(int j=0;j<3;j++)for(int i=0;3*i+10*j<=n;i++)v.push_back({i,j});return v;}
struct AffineSolution{std::vector<F> origin;std::vector<std::vector<F>> kernel;int rank;};
inline AffineSolution solve(std::vector<std::vector<F>> M,int n){int m=M.size(),r=0;std::vector<int>pv;for(int c=0;c<n;c++){int s=r;while(s<m&&!M[s][c])s++;if(s==m)continue;std::swap(M[s],M[r]);F z=ff::inv(M[r][c]);for(int j=c;j<=n;j++)M[r][j]=ff::mul(M[r][j],z);for(int i=0;i<m;i++)if(i!=r&&M[i][c]){F a=M[i][c];for(int j=c;j<=n;j++)M[i][j]=ff::sub(M[i][j],ff::mul(a,M[r][j]));}pv.push_back(c);r++;}for(int i=r;i<m;i++)if(M[i][n])throw std::runtime_error("inconsistent linear system");AffineSolution s;s.rank=r;s.origin.resize(n);for(int i=0;i<r;i++)s.origin[pv[i]]=M[i][n];for(int c=0;c<n;c++)if(!std::binary_search(pv.begin(),pv.end(),c)){std::vector<F>v(n);v[c]=1;for(int i=0;i<r;i++)v[pv[i]]=ff::neg(M[i][c]);s.kernel.push_back(v);}return s;}
inline void writepoly(std::ostream&o,const Poly&p){o<<p.v.size();for(auto x:p.v)o<<' '<<x;o<<'\n';}
inline Poly readpoly(std::istream&i){int n;if(!(i>>n))throw std::runtime_error("bad polynomial input");std::vector<F>v(n);for(auto &x:v)i>>x;return Poly(v);}
