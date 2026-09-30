// Fixed-endpoint residue calculation over K[b]/(b^3-P(alpha)).
// Only short local jets are retained; no degree140 algebra inversion.
#pragma once
#include "degree140_trace_engine_20260929.hpp"
namespace endpointtrace {
using namespace exact;
inline thread_local F EP=0;
struct E {
 std::array<F,3> c{};
 E()=default; E(F x){c[0]=x;} E(F a,F b,F d):c{a,b,d}{}
 explicit operator bool()const{return c[0]||c[1]||c[2];}
 friend E operator+(const E&a,const E&b){return {add(a.c[0],b.c[0]),add(a.c[1],b.c[1]),add(a.c[2],b.c[2])};}
 friend E operator-(const E&a,const E&b){return {sub(a.c[0],b.c[0]),sub(a.c[1],b.c[1]),sub(a.c[2],b.c[2])};}
 friend E operator*(const E&a,const E&b){
  E o;for(int i=0;i<3;i++)if(a.c[i])for(int j=0;j<3;j++)if(b.c[j]){
   F v=mul(a.c[i],b.c[j]);if(i+j>=3)v=mul(v,EP);o.c[(i+j)%3]=add(o.c[(i+j)%3],v);
  }return o;
 }
};
inline E ei(const E&a){
 E adj(sub(mul(a.c[0],a.c[0]),mul(EP,mul(a.c[1],a.c[2]))),
       sub(mul(EP,mul(a.c[2],a.c[2])),mul(a.c[0],a.c[1])),
       sub(mul(a.c[1],a.c[1]),mul(a.c[0],a.c[2])));
 E z=a*adj;if(z.c[1]||z.c[2]||!z.c[0])throw std::runtime_error("bad cubic inverse");
 return adj*E(inv(z.c[0]));
}
inline E ep(E a,int n){if(n<0)return ep(ei(a),-n);E b(1);while(n){if(n&1)b=b*a;n>>=1;if(n)a=a*a;}return b;}
constexpr int INF=1000000;
inline thread_local int CAP=40;
struct J {
 int lo=0,prec=INF;std::vector<E> c;
 J()=default;J(int l,std::vector<E> v,int p=INF):lo(l),prec(p),c(std::move(v)){trim();}
 void trim(){if(prec!=INF&&lo+(int)c.size()>prec)c.resize(std::max(0,prec-lo));while(!c.empty()&&!c.back())c.pop_back();int j=0;while(j<(int)c.size()&&!c[j])j++;if(j){c.erase(c.begin(),c.begin()+j);lo+=j;}if(c.empty())lo=prec;}
 int val()const{return c.empty()?prec:lo;}
 E at(int n)const{if(n>=prec)throw std::runtime_error("endpoint jet precision exhausted");return n>=lo&&n<lo+(int)c.size()?c[n-lo]:E();}
};
inline J jc(E a){return J(0,{a});}
inline J js(J a,E b){for(auto&x:a.c)x=x*b;a.trim();return a;}
inline J ja(const J&a,const J&b){int p=std::min(a.prec,b.prec),lo=std::min(a.val(),b.val());if(lo>=p)return J(0,{},p);int hi=std::min(p,std::max(a.c.empty()?lo:a.lo+(int)a.c.size(),b.c.empty()?lo:b.lo+(int)b.c.size()));std::vector<E>c(std::max(0,hi-lo));for(int n=lo;n<hi;n++)c[n-lo]=a.at(n)+b.at(n);return J(lo,std::move(c),p);}
inline J jsub(const J&a,const J&b){return ja(a,js(b,E(4)));}
inline J jm(const J&a,const J&b){int p=std::min({INF,a.prec==INF?INF:a.prec+b.val(),b.prec==INF?INF:b.prec+a.val()});if(a.c.empty()||b.c.empty())return J(0,{},p);int lo=a.lo+b.lo,hi=std::min({p,CAP,a.lo+(int)a.c.size()+b.lo+(int)b.c.size()-1});if(hi==CAP)p=std::min(p,CAP);std::vector<E>c(std::max(0,hi-lo));for(int i=0;i<(int)a.c.size();i++)if(a.c[i])for(int j=0;j<(int)b.c.size()&&i+j<(int)c.size();j++)if(b.c[j])c[i+j]=c[i+j]+a.c[i]*b.c[j];return J(lo,std::move(c),p);}
inline J ji(const J&a){if(a.c.empty())throw std::runtime_error("zero endpoint series inverse");int lo=-a.lo,p=std::min(CAP,a.prec==INF?CAP:a.prec-2*a.lo),n=p-lo;if(n<=0)throw std::runtime_error("endpoint inverse precision");std::vector<E>c(n);c[0]=ei(a.c[0]);for(int i=1;i<n;i++){E s;for(int j=1;j<=i&&j<(int)a.c.size();j++)if(a.c[j]&&c[i-j])s=s+a.c[j]*c[i-j];c[i]=E(4)*s*c[0];}return J(lo,std::move(c),p);}
inline J jd(const J&a,const J&b){return jm(a,ji(b));}
inline J jp(J a,int n){if(n<0)return jp(ji(a),-n);J b=jc(E(1));while(n){if(n&1)b=jm(b,a);n>>=1;if(n)a=jm(a,a);}return b;}
inline J jf(const J&a){if(a.c.empty())return J(0,{},a.prec==INF?INF:5*a.prec);int p=a.prec==INF?INF:5*a.prec,lo=5*a.lo,hi=std::min(CAP,5*(a.lo+(int)a.c.size()-1)+1);if(hi==CAP)p=std::min(p,CAP);std::vector<E>c(std::max(0,hi-lo));for(int i=0;5*i<(int)c.size();i++)c[5*i]=ep(a.c[i],5);return J(lo,std::move(c),p);}
inline J jder(J a){int old=a.lo;if(a.lo!=INF)a.lo--;if(a.prec!=INF)a.prec--;for(int i=0;i<(int)a.c.size();i++){int e=(old+i)%5;if(e<0)e+=5;a.c[i]=E(e)*a.c[i];}a.trim();return a;}
inline J jeval(const Poly&a,const J&x){J o;for(int i=a.deg();i>=0;i--)o=ja(jm(o,x),jc(E(a[i])));return o;}
using WP=std::vector<J>;
inline WP pa(WP a,const WP&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=ja(a[i],b[i]);return a;}
inline WP ps(WP a,const J&b){for(auto&x:a)x=jm(x,b);return a;}
inline WP pm(const WP&a,const WP&b){if(a.empty()||b.empty())return {};WP c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=ja(c[i+j],jm(a[i],b[j]));return c;}
inline WP pp(WP a,int n){WP b{jc(E(1))};while(n){if(n&1)b=pm(b,a);n>>=1;if(n)a=pm(a,a);}return b;}
inline J pe(const WP&a,const J&x){J o;for(int i=(int)a.size()-1;i>=0;i--)o=ja(jm(o,x),a[i]);return o;}
inline WP pq(WP a,const WP&b){if(a.size()<b.size())return {};WP q(a.size()-b.size()+1);for(int i=(int)q.size()-1;i>=0;i--){q[i]=a[i+b.size()-1];for(size_t j=0;j+1<b.size();j++)a[i+j]=jsub(a[i+j],jm(q[i],b[j]));}return q;}
inline int binom(int n,int k){int64_t b=1;for(int j=1;j<=k;j++)b=b*(n-j+1)/j;int r=b%5;return r<0?r+5:r;}
using Result=std::array<std::array<std::array<F,3>,6>,2>;
inline std::array<F,3> closed_t_constant(F h,F w){
 using namespace criticaltrace;EP=eval(baseP,25);auto gs=evaluate(h,w);Poly l{18,20,20,15},q0=Q-frob5(l);std::array<F,3> out{};
 for(int point=1;point<=3;point++){
  int fr=point==1?25:point==2?625:15625;F rt=power(25,fr);E y0=ep(E(0,1,0),fr);std::array<E,2> g;
  for(int k=0;k<2;k++)for(int j=0;j<3;j++)g[k]=g[k]+E(eval(gs[k][j],rt))*ep(y0,j);
  E b=g[1]-E(mul(3,eval(l,rt)))*g[0];F q3=0;
  for(int i=3;i<=q0.deg();i++)q3=add(q3,mul(q0[i],mul((i*(i-1)*(i-2)/6)%5,power(rt,i-3))));
  E r=E(mul(4,q3))*g[0]*ep(b,2)*ei(ep(y0,11)*E(power(eval(derivative(T),rt),2)));
  for(int j=0;j<3;j++)out[j]=add(out[j],mul(mul(3,r.c[0]),power(rt,j)));
 }return out;
}
// The same correction, reduced to the fixed rank-three algebra K[x]/(t).
inline std::array<std::array<F,3>,2> closed_constants(F h,F w){
 using namespace criticaltrace;auto gs=evaluate(h,w);Poly l{18,20,20,15};
 auto red=[](const Poly&p){return divmod(p,T).second;};
 for(auto&g:gs)for(auto&p:g)p=red(p);
 Curve b=gs[1];for(int j=0;j<3;j++)b[j]=red(b[j]-scale(l*gs[0][j],3));
 auto r=cmul(gs[0],cpow(b,2));for(auto&p:r)p=red(p);
 Poly pinv=xgcd(baseP,T)[1],tt=derivative(T),uu=pdivide(Q-frob5(l),ppow(T,3));
 std::array<Poly,2> val{red(tt*uu*r[2]*ppow(pinv,3)),red(tt*r[0]*ppow(pinv,2))};
 F s0=3,s1=neg(T[2]),s2=sub(mul(T[2],T[2]),mul(2,T[1]));std::array<std::array<F,3>,2> out{};
 for(int k=0;k<2;k++)for(int j=0;j<3;j++){
  out[k][j]=mul(2,add(add(mul(s0,val[k].coef(0)),mul(s1,val[k].coef(1))),mul(s2,val[k].coef(2))));
  val[k]=red(val[k]*Poly{0,1});
 }return out;
}
inline Result correction(F h,F w,const Poly&factor=Poly{1},bool proper=true,int eta_power=1,int y_power=0){
 using namespace criticaltrace;Result out{};EP=eval(baseP,25);auto gs=evaluate(h,w);Poly ll{18,20,20,15};
 for(int point=1;point<=3;point++){
  int fr=point==1?25:point==2?625:15625;J xx(0,{E(power(25,fr)),E(1)}),yy=jc(ep(E(0,1,0),fr)),pser=jeval(baseP,xx);
  for(int step=0;step<6;step++)yy=jsub(yy,jd(jsub(jp(yy,3),pser),js(jp(yy,2),E(3))));
  std::array<J,4> g;for(int k=0;k<4;k++)for(int j=0;j<3;j++)g[k]=ja(g[k],jm(jeval(gs[k][j],xx),jp(yy,j)));
  J l=jeval(ll,xx),q0=jeval(Q-frob5(ll),xx),s2=jsub(g[1],js(jm(g[0],l),E(3))),s1=ja(jsub(g[2],js(jm(g[1],l),E(2))),js(jm(g[0],jp(l,2)),E(3)));
  J vv=jc(E(0));for(int step=0;step<6;step++)vv=jsub(vv,jd(ja(ja(js(jm(g[0],jp(vv,2)),E(3)),js(jm(s2,vv),E(2))),s1),ja(jm(g[0],vv),js(s2,E(2)))));
  J z=jsub(vv,l),zb=jsub(jd(g[1],g[0]),z),y5=jf(yy),phi=jd(ja(jf(vv),q0),y5),tt=jp(jeval(T,xx),3),omega=ji(js(jp(yy,2),E(3))),df=ji(omega);
  J ss=jd(ja(ja(jm(g[0],jp(z,3)),jm(g[1],jp(z,2))),ja(jm(g[2],z),g[3])),y5),lam=js(ja(jd(ss,phi),jd(tt,jp(phi,2))),E(4));
  J bo=jeval(B0,xx),ay=jd(g[0],jp(yy,2)),by=jd(jsub(g[1],js(jm(bo,g[0]),E(3))),jp(yy,3));
  J cy=jd(ja(jsub(g[2],js(jm(bo,g[1]),E(2))),js(jm(jp(bo,2),g[0]),E(3))),jp(yy,4));
  J ey=jd(jsub(ja(jsub(g[3],jm(bo,g[2])),jm(jp(bo,2),g[1])),jm(jp(bo,3),g[0])),y5),qb=jd(jeval(Q-frob5(B0),xx),y5);
  WP sp{ey,cy,by,ay},ph(6);ph[0]=qb;ph[5]=jc(E(1));WP ds;for(auto&s:sp)ds.push_back(jm(jder(s),df));
  J B=jm(jder(qb),df),dt=jm(jder(tt),df);WP nn=pa(WP{dt},ps(sp,js(B,E(4))));
  std::array<WP,5> dd{WP{js(jm(jp(tt,2),jp(B,2)),E(4))},ps(nn,jm(tt,B)),pa(pp(nn,2),ps(ds,jm(tt,B))),ps(pm(nn,ds),jc(E(2))),pp(ds,2)};
  std::array<J,2> ws{jd(ja(z,bo),yy),jd(ja(zb,bo),yy)},etas{jd(jsub(js(g[1],E(3)),jm(g[0],z)),js(jp(yy,3),E(2))),jd(jsub(js(g[1],E(3)),jm(g[0],zb)),js(jp(yy,3),E(2)))},phis{phi,jd(ja(jf(zb),jeval(Q,xx)),y5)};
  for(int mt=0;mt<2;mt++)for(int n=0;n<(mt?6:3);n++){
   int m=-mt,k=4-m-2*n;WP hp;std::vector<std::pair<WP,int>> pieces;
   for(int j=0;j<k;j++){
    WP cj;for(int i=0;i<=std::min(j,4);i++){int b=binom(-n-1,j-i);if(!b)continue;if((n+1)%2)b=(4*b)%5;cj=pa(cj,ps(pm(dd[i],pp(sp,j-i)),js(jp(tt,-n-1-j+i),E(b))));}
    hp=pa(hp,pq(cj,pp(ph,k-j)));pieces.push_back({cj,k-j});
   }
   J val;for(int branch=0;branch<2;branch++){J p=proper?js(pe(hp,ws[branch]),E(4)):J();for(auto&[c,d]:pieces)p=ja(p,jd(pe(c,ws[branch]),jp(phis[branch],d)));val=ja(val,jm(jm(p,jp(etas[branch],eta_power)),omega));}
   J om=jm(jm(jm(jp(etas[0],eta_power),jp(phi,m)),jp(jder(lam),2)),jm(df,jp(lam,-n-1)));val=jsub(val,om);
   val=jm(jm(val,jeval(factor,xx)),jp(yy,y_power));
   for(int j=0;j<3;j++){E r=jm(jp(xx,j),val).at(-1);out[mt][n][j]=add(out[mt][n][j],mul(3,r.c[0]));}
  }
 }
 return out;
}
}
