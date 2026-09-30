#pragma once
#include "io.hpp"
#include "fastpoly.hpp"
PF readPF(istream&in){int n;in>>n;if(!in||n<0)throw runtime_error("truncated PF");vector<F>a;for(int i=0;i<n;i++){int c;in>>c;if(!in)throw runtime_error("truncated PF coefficient");a.push_back(F::raw(c));}return PF(a);}
void writePF(ostream&o,const PF&p){o<<p.a.size();for(F c:p.a)o<<" "<<c.v;o<<"\n";}
struct XG{PF g,s,t;};
XG xgcd(PF a,PF b){PF s(F(1)),ss,t,tt(F(1));while(b){auto [q,r]=a.divrem(b);a=b;b=r;PF temp=s-q*ss;s=ss;ss=temp;temp=t-q*tt;t=tt;tt=temp;}if(a){F c=a.a.back().inverse();a=a*c;s=s*c;t=t*c;}return{a,s,t};}
PF inversemod(const PF&a,const PF&m){auto z=xgcd(m,a%m);if(z.g.deg()!=0)throw runtime_error("nonunit inversemod gcd degree "+to_string(z.g.deg()));return z.t%m;}
PF power_mod(PF a,long long n,const PF&m){if(n<0){a=inversemod(a,m);n=-n;}PF r(F(1));for(;n;){if(n&1)r=(r*a)%m;n>>=1;if(n)a=(a*a)%m;}return r;}
// Split m into coprime primary-support factors: good is prime to p,
// bad contains ALL multiplicities supported on p. Does not take radicals.
pair<PF,PF> split_support(PF m,const PF&p){m=m*m.a.back().inverse();PF good=m;for(;;){PF g=pgcd(good,p);if(g.deg()<=0)break;good=good.exact(g);}return {good,m.exact(good)};}
struct QE {
 PF a;static inline PF mod, rev_inv;
 static void setmod(const PF&m){mod=m*m.a.back().inverse();int n=mod.deg();vector<F>r(n);r[0]=F(1);for(int i=1;i<n;i++){F c;for(int j=1;j<=i;j++)c+=mod[n-j]*r[i-j];r[i]=-c;}rev_inv=PF(r);}
 static PF reduce(PF p){int n=mod.deg();if(p.deg()<n)return p;if(n<32||p.deg()>2*n-2)return p%mod;int k=p.deg()-n+1;vector<F>ra;for(int i=0;i<k;i++)ra.push_back(p[p.deg()-i]);PF qr=fastmul(PF(ra),rev_inv.trunc(k)).trunc(k);vector<F>qa(k);for(int i=0;i<k;i++)qa[i]=qr[k-1-i];PF result=p-fastmul(PF(qa),mod);assert(result.deg()<n);return result;}

 QE(long long n=0):a(F(n)){}QE(F x):a(x){}QE(PF p):a(reduce(p)){}
 explicit operator bool()const{return bool(a);}
 friend QE operator+(const QE&a,const QE&b){QE r;r.a=a.a+b.a;return r;}
 QE operator-()const{QE r;r.a=-a;return r;}
 friend QE operator-(const QE&a,const QE&b){QE r;r.a=a.a-b.a;return r;}
 friend QE operator*(const QE&a,const QE&b){return QE(fastmul(a.a,b.a));}
 QE inverse()const{return QE(inversemod(a,mod));}
 friend QE operator/(const QE&a,const QE&b){return a*b.inverse();}
 QE&operator+=(const QE&b){return *this=*this+b;}QE&operator-=(const QE&b){return *this=*this-b;}QE&operator*=(const QE&b){return *this=*this*b;}
 friend bool operator==(const QE&a,const QE&b){return a.a==b.a;}friend bool operator!=(const QE&a,const QE&b){return !(a==b);}
};
QE qpow(QE a,int n){if(n<0){a=a.inverse();n=-n;}QE r(1);for(;n;){if(n&1)r=r*a;n>>=1;if(n)a=a*a;}return r;}
QE evaluateLP(const LP&p,QE H,QE v){QE r;map<int,QE>hp,vp;for(auto[e,c]:p.a){assert(!e[2]&&!e[3]);if(!hp.count(e[0]))hp[e[0]]=qpow(H,e[0]);if(!vp.count(e[1]))vp[e[1]]=qpow(v,e[1]);r+=hp[e[0]]*vp[e[1]]*QE(c);}return r;}
using PQ=Pol<QE>;
PQ evaluate_v(const LP&p,QE v){PQ r;map<int,QE>cache;for(auto[e,c]:p.a){assert(e[0]>=0&&!e[2]&&!e[3]);if(!cache.count(e[1]))cache[e[1]]=qpow(v,e[1]);r+=PQ::mon(e[0],cache[e[1]]*QE(c));}return r;}
