// Exact resultants over K[epsilon]/epsilon^3, including degree jumps.
// Weierstrass preparation replaces a nonunit leading coefficient;
// the unit factor is retained by its determinant norm.
#pragma once
#include "degree140_trace_engine_20260929.hpp"
#include <array>
namespace jetresultant {
using namespace exact;
struct J {
 std::array<F,3>c{};J(F a=0){c[0]=a;}
 explicit operator bool()const{return c[0]||c[1]||c[2];}
 friend J operator+(J a,const J&b){for(int i=0;i<3;i++)a.c[i]=add(a.c[i],b.c[i]);return a;}
 friend J operator-(J a){for(auto&v:a.c)v=neg(v);return a;}
 friend J operator-(const J&a,const J&b){return a+-b;}
 friend J operator*(const J&a,const J&b){J z;z.c[0]=mul(a.c[0],b.c[0]);z.c[1]=add(mul(a.c[0],b.c[1]),mul(a.c[1],b.c[0]));z.c[2]=add(add(mul(a.c[0],b.c[2]),mul(a.c[1],b.c[1])),mul(a.c[2],b.c[0]));return z;}
 J&operator+=(const J&b){return *this=*this+b;}J&operator-=(const J&b){return *this=*this-b;}J&operator*=(const J&b){return *this=*this*b;}
 friend bool operator==(const J&a,const J&b){return a.c==b.c;}
 J inverse()const{if(!c[0])throw std::runtime_error("nonunit jet inverse");J b(inv(c[0]));b.c[1]=neg(mul(mul(b.c[0],c[1]),b.c[0]));b.c[2]=neg(mul(b.c[0],add(mul(c[1],b.c[1]),mul(c[2],b.c[0]))));return b;}
 J pow(unsigned n)const{J a=*this,b(1);while(n){if(n&1)b*=a;n>>=1;if(n)a*=a;}return b;}
};
using JP=std::vector<J>;
inline void trim(JP&a){while(!a.empty()&&!a.back())a.pop_back();}
inline J coef(const JP&a,int i){return i<0||i>=int(a.size())?J():a[i];}
inline JP times(const JP&a,const JP&b){if(a.empty()||b.empty())return {};JP r(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)r[i+j]+=a[i]*b[j];trim(r);return r;}
inline JP remainder(JP a,const JP&b){if(b.empty()||!b.back().c[0])throw std::runtime_error("nonmonic jet division");J iv=b.back().inverse();for(int i=int(a.size())-int(b.size());i>=0;i--){J z=a[i+b.size()-1]*iv;if(!z)continue;for(size_t j=0;j<b.size();j++)a[i+j]-=z*b[j];}trim(a);return a;}
inline Poly component(const JP&a,int j){Poly p(a.size());for(size_t i=0;i<a.size();i++)p[i]=a[i].c[j];p.trim();return p;}
inline J schur(std::vector<std::vector<J>> a){
 int n=a.size();J d(1);for(int k=0;k<n;k++){
  int r=-1,s=-1;for(int i=k;i<n&&r<0;i++)for(int j=k;j<n;j++)if(a[i][j].c[0]){r=i;s=j;break;}
  if(r<0){if(n-k>=3)return J();if(n-k==1)return d*a[k][k];return d*(a[k][k]*a[k+1][k+1]-a[k][k+1]*a[k+1][k]);}
  if(r!=k){std::swap(a[r],a[k]);d=-d;}if(s!=k){for(auto&row:a)std::swap(row[s],row[k]);d=-d;}
  J pivot=a[k][k],iv=pivot.inverse();d*=pivot;for(int i=k+1;i<n;i++){J z=a[i][k]*iv;for(int j=k+1;j<n;j++)a[i][j]-=z*a[k][j];}
 }return d;
}
inline J sylvester(const JP&a,const JP&b,int m,int n){
 std::vector<std::vector<J>>M(m+n,std::vector<J>(m+n));
 for(int r=0;r<n;r++)for(int j=0;j<=m;j++)M[r][r+j]=coef(a,m-j);
 for(int r=0;r<m;r++)for(int j=0;j<=n;j++)M[n+r][r+j]=coef(b,n-j);
 return schur(M);
}
inline std::vector<J> newton(const JP&a,int count){
 int m=a.size()-1;J iv=a.back().inverse();std::vector<J>s(count+1);s[0]=J(m%5);
 for(int k=1;k<=count;k++){
  J z;if(k<=m)z=J(k%5)*a[m-k]*iv;
  for(int i=1;i<k&&i<=m;i++)z+=a[m-i]*iv*s[k-i];s[k]=-z;
 }return s;
}
inline J unit_norm(const JP&a,F c,const Poly&u1,const Poly&u2){
 Poly p=scale(u1,inv(c)),q=scale(u2,inv(c)),pp=p*p;int n=std::max({p.deg(),q.deg(),pp.deg(),0});auto s=newton(a,n);
 J trp,trq,trpp;for(size_t i=0;i<p.size();i++)trp+=J(p[i])*s[i];for(size_t i=0;i<q.size();i++)trq+=J(q[i])*s[i];for(size_t i=0;i<pp.size();i++)trpp+=J(pp[i])*s[i];
 J e;e.c[1]=1;J ee;ee.c[2]=1;J tr=e*trp+ee*trq;
 return J(power(c,a.size()-1))*(J(1)+tr+J(3)*(tr*tr-ee*trpp));
}
struct Prepared {JP p;Poly u1,u2;F c;};
inline Prepared prepare(const JP&b){
 Poly b0=component(b,0),b1=component(b,1),b2=component(b,2);if(b0.empty())throw std::runtime_error("zero constant polynomial in preparation");
 F c=b0.back();Poly p0=scale(b0,inv(c));auto d1=divmod(b1,p0);Poly p1=scale(d1.second,inv(c));auto d2=divmod(b2-d1.first*p1,p0);Poly p2=scale(d2.second,inv(c));
 JP p(p0.size());for(size_t i=0;i<p.size();i++){p[i].c={p0.coef(i),p1.coef(i),p2.coef(i)};}return {p,d1.first,d2.first,c};
}
inline JP reciprocal_shift(const JP&a,F t){
 // z^m*a(t+1/z); the fractional-linear determinant is -1.
 int m=a.size()-1;JP p;for(int j=m;j>=0;j--){JP next(p.size()+1);for(size_t k=0;k<p.size();k++){next[k]+=p[k]*J(t);next[k+1]+=p[k];}next[0]+=a[j];trim(next);p=std::move(next);}p.resize(m+1);std::reverse(p.begin(),p.end());trim(p);return p;
}
struct Counters {unsigned preparations=0,coordinate_changes=0,nilpotent_zero=0;};
inline J resultant(JP a,JP b,int fullm,int fulln,Counters*counts=nullptr){
 trim(a);trim(b);if(a.empty()||b.empty())return J();int m=a.size()-1,n=b.size()-1;J out(1);
 if(m>fullm||n>fulln)throw std::runtime_error("jet resultant degree overflow");
 if(m<fullm&&n<fulln)return J();
 if(m<fullm){out*=b.back().pow(fullm-m);if(((fullm-m)*n)&1)out=-out;}
 if(n<fulln)out*=a.back().pow(fulln-n);
 if(!out)return J();
 if(!a.back().c[0]){
  if(b.back().c[0]){if((m*n)&1)out=-out;std::swap(a,b);std::swap(m,n);}
  else{
   Poly aa=component(a,0),bb=component(b,0);
   if((aa.empty()&&n>=3)||(bb.empty()&&m>=3)){if(counts)counts->nilpotent_zero++;return J();}
   if(aa.empty()&&bb.empty())return out*sylvester(a,b,m,n);
   F t=0;for(;t<390625;t++)if((aa.empty()||eval(aa,t))&&(bb.empty()||eval(bb,t)))break;if(t==390625)throw std::runtime_error("no coordinate change");
   a=reciprocal_shift(a,t);b=reciprocal_shift(b,t);if((m*n)&1)out=-out;if(counts)counts->coordinate_changes++;
   if(!a.back().c[0]){std::swap(a,b);std::swap(m,n);if((m*n)&1)out=-out;}
  }
 }
 while(true){
  if(a.empty()||b.empty())return J();m=a.size()-1;n=b.size()-1;
  if(!a.back().c[0])throw std::runtime_error("first leading coefficient lost its unit");
  if(!b.back().c[0]){
   Poly bc=component(b,0);
   if(bc.empty()){
    if(m>=3){if(counts)counts->nilpotent_zero++;return J();}
    JP r=remainder(b,a);J norm;
    if(m==0)return out*a[0].pow(n);
    if(m==1)norm=coef(r,0);
    else {J c=coef(r,0),d=coef(r,1),iv=a[2].inverse();norm=c*c-c*d*a[1]*iv+d*d*a[0]*iv;}
    return out*a.back().pow(n)*norm;
   }
   Prepared w=prepare(b);int k=w.p.size()-1;out*=a.back().pow(n-k)*unit_norm(a,w.c,w.u1,w.u2);b=std::move(w.p);if(counts)counts->preparations++;continue;
  }
  if(n==0)return out*b[0].pow(m);
  if(m<n){if((m*n)&1)out=-out;std::swap(a,b);continue;}
  JP r=remainder(a,b);if(r.empty())return J();int k=r.size()-1;out*=b.back().pow(m-k);if((m*n)&1)out=-out;a=std::move(b);b=std::move(r);
 }
}
inline void controls(){
 for(int m=1;m<=8;m++)for(int n=1;n<=8;n++)for(int shared=0;shared<=3;shared++){
  JP a{J(1)},b{J(1)};std::vector<J>ar,br;
  for(int i=0;i<m;i++){J r;r.c={power(EX[1],i+1),F((i+1)%5),F((i+2)%5)};ar.push_back(r);a=times(a,JP{-r,J(1)});}
  for(int i=0;i<n;i++){J r;r.c={i<std::min(shared,m)?ar[i].c[0]:power(EX[1],2*i+31),F((i+3)%5),F((i+4)%5)};br.push_back(r);b=times(b,JP{-r,J(1)});}
  J expected(1);for(auto r:ar)for(auto s:br)expected*=r-s;
  if(!(resultant(a,b,m,n)==expected))throw std::runtime_error("split-root jet control failed");
 }
 for(int m=1;m<=8;m++)for(int n=1;n<=8;n++)for(int mode=0;mode<6;mode++){
  JP a(m+1),b(n+1);for(int i=0;i<=m;i++)for(int j=0;j<3;j++)a[i].c[j]=power(EX[1],17+13*i+31*j+mode);
  for(int i=0;i<=n;i++)for(int j=0;j<3;j++)b[i].c[j]=power(EX[1],43+19*i+23*j+mode);
  if(mode==1)a[m].c[0]=0;if(mode==2)b[n].c[0]=0;if(mode==3){a[m].c[0]=0;b[n].c[0]=0;}
  if(mode==4){for(int i=0;i<=m;i++)a[i].c[0]=0;}
  if(mode==5){for(int i=0;i<=n;i++)b[i].c[0]=0;b[n].c[1]=0;}
  auto wanted=sylvester(a,b,m,n),got=resultant(a,b,m,n);if(!(got==wanted))throw std::runtime_error("jet resultant control mismatch");
 }
 for(int k=1;k<7;k++){
  JP p(k+1);for(int i=0;i<=k;i++){p[i].c={power(EX[1],7*i+1),power(EX[1],9*i+2),power(EX[1],3*i+3)};}p.back()=J(1);
  JP u(4);u[0]=J(2);u[1].c[1]=3;u[2].c[2]=4;u[3].c[2]=1;auto b=times(p,u);auto w=prepare(b);JP uu(4);for(size_t i=0;i<uu.size();i++)uu[i].c={i==0?w.c:0,w.u1.coef(i),w.u2.coef(i)};
  if(times(w.p,uu)!=b)throw std::runtime_error("Weierstrass preparation control failed");
 }
}
}
