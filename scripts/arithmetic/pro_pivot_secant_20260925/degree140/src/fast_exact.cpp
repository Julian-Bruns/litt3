#include <vector>
#include <array>
#include <fstream>
#include <iostream>
#include <cstring>
#include <stdexcept>
#include <algorithm>
#include <cstdint>
using namespace std;
static_assert(sizeof(int)==4, "The exact coefficient stream requires 32-bit int.");
namespace ff {
 const int N=390625, ORD=N-1;
 vector<int> lg,ex,ng,ad;
 inline int add(int a,int b){return ad[(a%625)*625+b%625]+625*ad[(a/625)*625+b/625];}
 inline int mul(int a,int b){if(!a||!b)return 0;int k=lg[a]+lg[b];return ex[k>=ORD?k-ORD:k];}
 inline int neg(int a){return ng[a];}
 inline int sub(int a,int b){return add(a,ng[b]);}
 inline int inv(int a){if(!a)throw runtime_error("division by zero");int k=lg[a];return ex[k?ORD-k:0];}
 inline int pow(int a,int64_t n){if(!n)return 1;if(!a){if(n<0)throw runtime_error("zero negative power");return 0;}int64_t k=int64_t(lg[a])*n%ORD;if(k<0)k+=ORD;return ex[k];}
 void init(const char* path){ifstream f(path,ios::binary);int h[3];f.read((char*)h,12);if(h[0]!=N)throw runtime_error("bad field cache");lg.resize(N);ex.resize(ORD);f.read((char*)lg.data(),N*4);f.read((char*)ex.data(),ORD*4);if(!f)throw runtime_error("field cache read failure");ad.resize(625*625);for(int i=0;i<625;i++)for(int j=0;j<625;j++){int z=0,p=1;for(int k=0;k<4;k++,p*=5)z+=((i/p+j/p)%5)*p;ad[i*625+j]=z;}ng.resize(N);for(int i=0;i<N;i++)ng[i]=mul(i,4);}
}
using Poly=vector<int>;
void trim(Poly &p){while(p.size()&&!p.back())p.pop_back();}
Poly cn(int c){return c?Poly{c}:Poly{};}
Poly add(const Poly&a,const Poly&b){Poly c(max(a.size(),b.size()));for(size_t i=0;i<c.size();i++)c[i]=ff::add(i<a.size()?a[i]:0,i<b.size()?b[i]:0);trim(c);return c;}
Poly neg(const Poly&a){Poly c=a;for(int&v:c)v=ff::neg(v);return c;}
Poly sub(const Poly&a,const Poly&b){return add(a,neg(b));}
Poly sc(const Poly&a,int b){if(!b)return {};Poly c=a;for(int&v:c)v=ff::mul(v,b);trim(c);return c;}
Poly mul(const Poly&a,const Poly&b){if(a.empty()||b.empty())return {};Poly c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(a[i]){int la=ff::lg[a[i]];for(size_t j=0;j<b.size();j++)if(b[j]){int k=la+ff::lg[b[j]];c[i+j]=ff::add(c[i+j],ff::ex[k>=ff::ORD?k-ff::ORD:k]);}}trim(c);return c;}
Poly power(Poly a,int n){Poly c{1};while(n){if(n&1)c=mul(c,a);n>>=1;if(n)a=mul(a,a);}return c;}
pair<Poly,Poly> divmod(Poly a,const Poly&b){if(b.empty())throw runtime_error("polynomial division by zero");if(a.size()<b.size())return {{},a};Poly q(a.size()-b.size()+1);int iv=ff::inv(b.back());for(int i=int(q.size())-1;i>=0;i--){int c=q[i]=ff::mul(a[i+b.size()-1],iv);if(c)for(size_t j=0;j<b.size();j++)a[i+j]=ff::sub(a[i+j],ff::mul(c,b[j]));}a.resize(b.size()-1);trim(a);trim(q);return {q,a};}
Poly exactdiv(const Poly&a,const Poly&b){auto qr=divmod(a,b);if(!qr.second.empty())throw runtime_error("inexact polynomial division");return qr.first;}
Poly gcd(Poly a,Poly b){while(b.size()){Poly r=divmod(a,b).second;a=move(b);b=move(r);}return a.empty()?a:sc(a,ff::inv(a.back()));}
int resultant(Poly a,Poly b,int mdecl=-1,int ndecl=-1){int m=a.size()-1,n=b.size()-1;if(m<0||n<0)return 0;
 if(mdecl>=0){if(m>mdecl||n>ndecl)throw runtime_error("resultant degree bound exceeded");if(m<mdecl&&n<ndecl)return 0;}
 int r=1;if(mdecl>=0){if(m<mdecl)r=ff::mul(ff::pow(b.back(),mdecl-m),((ndecl*(mdecl-m))%2)?4:1);if(n<ndecl)r=ff::mul(r,ff::pow(a.back(),ndecl-n));}
 while(n){if(m<n){swap(a,b);swap(m,n);if((m*n)%2)r=ff::neg(r);if(!n)break;}
 Poly c=divmod(a,b).second;int d=c.size()-1;if(d<0)return 0;r=ff::mul(r,ff::pow(b.back(),m-d));if((m*n)%2)r=ff::neg(r);a=move(b);b=move(c);m=n;n=d;}
 return ff::mul(r,ff::pow(b[0],m));}
using Curve=array<Poly,3>;
Curve cz(){return {};}
Curve cc(int a){return {cn(a),{}, {}};}
Curve ca(const Curve&a,const Curve&b){return {add(a[0],b[0]),add(a[1],b[1]),add(a[2],b[2])};}
Curve cs(const Curve&a,const Curve&b){return {sub(a[0],b[0]),sub(a[1],b[1]),sub(a[2],b[2])};}
Curve csc(const Curve&a,int b){return {sc(a[0],b),sc(a[1],b),sc(a[2],b)};}
Curve cm(const Curve&a,const Curve&b,const Poly&P){Curve c{};for(int i=0;i<3;i++)for(int j=0;j<3;j++){auto t=mul(a[i],b[j]);int k=i+j;if(k>=3){k-=3;t=mul(t,P);}c[k]=add(c[k],t);}return c;}
Curve cp( Curve a,int n,const Poly&P){Curve c=cc(1);while(n){if(n&1)c=cm(c,a,P);n>>=1;if(n)a=cm(a,a,P);}return c;}
Curve cpm(const Curve&a,const Poly&p){return {mul(a[0],p),mul(a[1],p),mul(a[2],p)};}
Curve divy(const Curve&a,int n,const Poly&P){Curve c{};for(int k=0;k<3;k++){int l=(k-n)%3;if(l<0)l+=3;int z=(n+l-k)/3;c[l]=z>=0?exactdiv(a[k],power(P,z)):mul(a[k],power(P,-z));}return c;}
vector<Curve> rescoeff(const vector<Curve>&H,const Curve&Q,const Curve&T,const Poly&P,const Poly&v){
 auto m=[&](const Curve&a,const Curve&b){return cm(a,b,P);};auto p=[&](const Curve&a,int n){return cp(a,n,P);};
 Curve A=csc(H[0],3),B=csc(H[1],2),C=H[2],H5=H[3];
 auto A2=p(A,2),A3=m(A2,A),A4=p(A,4),A5=m(A4,A);
 auto B2=p(B,2),B3=m(B2,B),B4=p(B,4),B5=m(B4,B);
 auto C2=p(C,2),C3=m(C2,C),C4=p(C,4),C5=m(C4,C);
 auto D=ca(B2,m(A,C)),E=ca(cs(m(A5,p(Q,2)),m(B5,Q)),C5);
 auto K=cs(csc(m(A5,Q),2),B5),L=ca(cs(B3,m(m(A,B),C)),csc(m(A2,H5),2));
 auto W=ca(ca(ca(csc(m(B5,H5),3),m(B4,C2)),csc(m(m(A,B2),C3),4)),m(A2,C4));
 W=ca(W,ca(ca(csc(m(m(A3,B3),Q),2),csc(m(m(m(A4,B),C),Q),3)),csc(m(m(A5,H5),Q),4)));
 auto V=ca(ca(csc(m(B3,H5),4),csc(m(B2,C2),3)),ca(m(m(m(A,B),C),H5),ca(csc(m(A,C3),4),csc(m(A2,p(H5,2)),4))));
 auto r2=cpm(p(E,2),power(v,2));
 auto r1=cpm(ca(csc(m(E,W),3),m(T,ca(csc(m(A5,E),2),p(D,5)))),v);
 auto r0=ca(m(A3,ca(csc(m(E,V),4),csc(m(T,cs(m(K,L),p(D,4))),3))),m(p(A5,2),p(T,2)));
 return {r0,r1,r2};
}
vector<Poly> lm(const vector<Poly>&a,const vector<Poly>&b){vector<Poly> c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=add(c[i+j],mul(a[i],b[j]));return c;}
vector<Poly> normlam(const vector<Curve>&rs,const Poly&P){vector<Poly>a,b,c;for(auto&r:rs){a.push_back(r[0]);b.push_back(r[1]);c.push_back(r[2]);}auto a3=lm(lm(a,a),a),b3=lm(lm(b,b),b),c3=lm(lm(c,c),c),abc=lm(lm(a,b),c);auto P2=power(P,2);vector<Poly> out(7);for(int i=0;i<7;i++)out[i]=add(add(a3[i],mul(b3[i],P)),add(mul(c3[i],P2),sc(mul(abc[i],P),2)));return out;}
vector<Poly> residual(const vector<Curve>&H,const Poly&P,const Poly&Q,const Poly&B,const Poly&t,const Poly&v){
 vector<Curve>G{divy(H[0],2,P),divy(cs(H[1],cpm(H[0],sc(B,3))),3,P),divy(ca(cs(H[2],cpm(H[1],sc(B,2))),cpm(H[0],sc(power(B,2),3))),4,P),divy(cs(ca(cs(H[3],cpm(H[2],B)),cpm(H[1],power(B,2))),cpm(H[0],power(B,3))),5,P)};
 Curve qb{Poly{},exactdiv(sub(Q,power(B,5)),power(P,2)),Poly{}},T{power(t,3),Poly{},Poly{}};
 auto rs=rescoeff(G,qb,T,P,v);auto ns=normlam(rs,P);auto den=mul(power(t,15),power(v,3));for(auto&n:ns)n=exactdiv(n,den);return ns;
}
pair<vector<Poly>,vector<Poly>> errors(const vector<Poly>&R){if(R[0].size()!=141)throw runtime_error("not degree140");int iv=ff::inv(R[0][140]);vector<Poly>b(141),j(71),errs;for(int m=0;m<=140;m++){b[m].resize(7);for(int k=0;k<7;k++)b[m][k]=(R[k].size()>size_t(140-m))?ff::mul(R[k][140-m],iv):0;trim(b[m]);}j[0]={1};for(int m=1;m<=70;m++){Poly s;for(int i=1;i<m;i++)s=add(s,mul(j[i],j[m-i]));j[m]=sc(sub(b[m],s),3);}for(int m=71;m<=140;m++){Poly s;for(int i=max(0,m-70);i<=min(m,70);i++)s=add(s,mul(j[i],j[m-i]));errs.push_back(sub(b[m],s));}return {j,errs};}
extern "C" {
const char* fast_version(){return "fast_exact.cpp 1.0";}
int fast_init(const char* path){try{ff::init(path);return 0;}catch(exception&e){cerr<<e.what()<<endl;return -1;}}
int fast_residual(const int*Hin,const int*P0,const int*Q0,const int*B0,const int*t0,const int*v0,int* out){try{vector<Curve>H(4);for(int i=0;i<4;i++)for(int j=0;j<3;j++){H[i][j]=Poly(Hin+(i*3+j)*32,Hin+(i*3+j+1)*32);trim(H[i][j]);}Poly P(P0,P0+11),Q(Q0,Q0+20),B(B0,B0+10),t(t0,t0+4),v(v0,v0+2);trim(P);trim(Q);trim(B);trim(t);trim(v);auto R=residual(H,P,Q,B,t,v);memset(out,0,7*141*4);for(int k=0;k<7;k++){if(R[k].size()>141)throw runtime_error("degree exceeds140");copy(R[k].begin(),R[k].end(),out+k*141);}return 0;}catch(exception&e){cerr<<e.what()<<endl;return -1;}}
int fast_errors(const int*Rin,int*out){try{vector<Poly>R(7);for(int k=0;k<7;k++){R[k]=Poly(Rin+k*141,Rin+(k+1)*141);trim(R[k]);}auto es=errors(R).second;memset(out,0,70*105*4);for(int k=0;k<70;k++){if(es[k].size()>105)throw runtime_error("error degree exceeds104");copy(es[k].begin(),es[k].end(),out+k*105);}return 0;}catch(exception&e){cerr<<e.what()<<endl;return -1;}}
int fast_resultant(const int*pa,int na,const int*pb,int nb,int md,int nd){try{Poly a(pa,pa+na),b(pb,pb+nb);trim(a);trim(b);return resultant(a,b,md,nd);}catch(exception&e){cerr<<e.what()<<endl;return -1;}}
int fast_gcd(const int*pa,int na,const int*pb,int nb,int*out){try{Poly a(pa,pa+na),b(pb,pb+nb);trim(a);trim(b);auto g=gcd(a,b);copy(g.begin(),g.end(),out);return g.size();}catch(exception&e){cerr<<e.what()<<endl;return -1;}}
}
extern "C" int fast_formal74(const int*Rin,int*out){try{vector<Poly>R(7);for(int k=0;k<7;k++){R[k]=Poly(Rin+k*141,Rin+(k+1)*141);trim(R[k]);}if(R[0].size()!=141)throw runtime_error("not degree140");int iv=ff::inv(R[0][140]);vector<Poly>b(75),j(75);for(int m=0;m<=74;m++){b[m].resize(7);for(int k=0;k<7;k++)b[m][k]=(R[k].size()>size_t(140-m))?ff::mul(R[k][140-m],iv):0;trim(b[m]);}j[0]={1};for(int m=1;m<=74;m++){Poly s;for(int i=1;i<m;i++)s=add(s,mul(j[i],j[m-i]));j[m]=sc(sub(b[m],s),3);}memset(out,0,4*105*4);for(int k=0;k<4;k++){if(j[k+71].size()>105)throw runtime_error("bad degree");copy(j[k+71].begin(),j[k+71].end(),out+k*105);}return 0;}catch(exception&e){cerr<<e.what()<<endl;return -1;}}
extern "C" int fast_divrem(const int*pa,int na,const int*pb,int nb,int*qo,int*ro){try{Poly a(pa,pa+na),b(pb,pb+nb);trim(a);trim(b);auto qr=divmod(a,b);memset(qo,0,na*4);memset(ro,0,na*4);copy(qr.first.begin(),qr.first.end(),qo);copy(qr.second.begin(),qr.second.end(),ro);return qr.first.size();}catch(exception&e){cerr<<e.what()<<endl;return -1;}}
extern "C" int fast_valuation(const int*pa,int na,const int*pb,int nb){try{Poly a(pa,pa+na),b(pb,pb+nb);trim(a);trim(b);if(a.empty())return 100000000;if(b.size()<2)throw runtime_error("valuation factor constant");int v=0;while(true){auto qr=divmod(a,b);if(qr.second.size())return v;v++;a=move(qr.first);}}catch(exception&e){cerr<<e.what()<<endl;return -1;}}
