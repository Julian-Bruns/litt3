// Exact scale-tail certificates over finite extensions of the problem's K.
// Reads generated input from stdin; writes JSON, never floating point.
// This checks a prescribed finite ratio stratum, NOT the full square locus.
#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>
using std::vector;using std::array;using U32=uint32_t;using U128=__uint128_t;
constexpr U32 QK=390625, NK=390624;
static vector<U32> LG(QK),EX(NK);static array<U32,625*625> AD;static array<U32,625> NG;
U32 add25(U32 a,U32 b){return (a%5+b%5)%5+5*((a/5+b/5)%5);}
U32 neg25(U32 a){return ((5-a%5)%5)+5*((5-a/5)%5);}
U32 mul25(U32 a,U32 b){U32 x=a%5,y=a/5,u=b%5,v=b/5;return (x*u+3*y*v)%5+5*((x*v+y*u+y*v)%5);}
U32 ka(U32 a,U32 b){return AD[(a%625)*625+b%625]+625*AD[(a/625)*625+b/625];}
U32 kn(U32 a){return NG[a%625]+625*NG[a/625];}
U32 ks(U32 a,U32 b){return ka(a,kn(b));}
U32 km(U32 a,U32 b){if(!a||!b)return 0;return EX[(LG[a]+LG[b])%NK];}
U32 rawmul(U32 a,U32 b){array<U32,4> x{},y{};array<U32,7> z{};for(int i=0;i<4;i++){x[i]=a%25;y[i]=b%25;a/=25;b/=25;}for(int i=0;i<4;i++)for(int j=0;j<4;j++)z[i+j]=add25(z[i+j],mul25(x[i],y[j]));array<U32,4> mod={5,2,6,7};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)z[i-4+j]=add25(z[i-4+j],neg25(mul25(z[i],mod[j])));U32 r=0,k=1;for(int i=0;i<4;i++){r+=k*z[i];k*=25;}return r;}
void initK(){for(U32 a=0;a<625;a++){NG[a]=neg25(a%25)+25*neg25(a/25);for(U32 b=0;b<625;b++)AD[a*625+b]=add25(a%25,b%25)+25*add25(a/25,b/25);}std::fill(LG.begin(),LG.end(),QK);U32 a=1;for(U32 i=0;i<NK;i++){assert(LG[a]==QK);LG[a]=i;EX[i]=a;a=rawmul(a,25);}assert(a==1);assert(km(5,5)==ka(5,3));}
static int N;static array<U32,5> MOD{};static U128 FIELD_ORDER;
struct E{array<U32,4> v{};E()=default;E(U32 k){assert(k<QK);v[0]=k;}bool zero()const{for(int i=0;i<N;i++)if(v[i])return false;return true;}bool constant()const{for(int i=1;i<N;i++)if(v[i])return false;return true;}};
bool operator==(const E&a,const E&b){return a.v==b.v;}bool operator!=(const E&a,const E&b){return !(a==b);} 
E operator+(const E&a,const E&b){E r;for(int i=0;i<N;i++)r.v[i]=ka(a.v[i],b.v[i]);return r;}
E operator-(const E&a){E r;for(int i=0;i<N;i++)r.v[i]=kn(a.v[i]);return r;}
E operator-(const E&a,const E&b){return a+(-b);}
E operator*(const E&a,const E&b){E r;if(a.zero()||b.zero())return r;if(a.constant()){for(int i=0;i<N;i++)r.v[i]=km(a.v[0],b.v[i]);return r;}if(b.constant()){for(int i=0;i<N;i++)r.v[i]=km(b.v[0],a.v[i]);return r;}array<U32,7> z{};for(int i=0;i<N;i++)if(a.v[i])for(int j=0;j<N;j++)if(b.v[j])z[i+j]=ka(z[i+j],km(a.v[i],b.v[j]));for(int i=2*N-2;i>=N;i--)if(z[i])for(int j=0;j<N;j++)z[i-N+j]=ks(z[i-N+j],km(z[i],MOD[j]));for(int i=0;i<N;i++)r.v[i]=z[i];return r;}
E epow(E a,U128 n){E r(1);while(n){if(n&1)r=r*a;n>>=1;if(n)a=a*a;}return r;}
E inv(const E&a){if(a.zero())throw std::runtime_error("Zero inverse");E r=epow(a,FIELD_ORDER-2);assert(r*a==E(1));return r;}
E operator/(const E&a,const E&b){return a*inv(b);}
using P=vector<E>;
void trim(P&a){while(!a.empty()&&a.back().zero())a.pop_back();}
E coeff(const P&a,size_t i){return i<a.size()?a[i]:E();}
P pa(P a,const P&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=a[i]+b[i];trim(a);return a;}
P pn(P a){for(E&x:a)x=-x;return a;}
P ps(const P&a,const P&b){return pa(a,pn(b));}
P sc(P a,const E&s){for(E&x:a)x=x*s;trim(a);return a;}
P pm(const P&a,const P&b){if(a.empty()||b.empty())return {};P r(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(!a[i].zero())for(size_t j=0;j<b.size();j++)if(!b[j].zero())r[i+j]=r[i+j]+a[i]*b[j];trim(r);return r;}
P pp(P a,unsigned n){P r{E(1)};while(n){if(n&1)r=pm(r,a);n>>=1;if(n)a=pm(a,a);}return r;}
std::pair<P,P> pd(P a,const P&b){if(b.empty())throw std::runtime_error("Polynomial division by zero");P q(a.size()>=b.size()?a.size()-b.size()+1:0);E bi=inv(b.back());while(a.size()>=b.size()){size_t k=a.size()-b.size();E z=a.back()*bi;q[k]=z;for(size_t i=0;i<b.size();i++)a[i+k]=a[i+k]-z*b[i];trim(a);}trim(q);return {q,a};}
P exact(const P&a,const P&b){auto qr=pd(a,b);assert(qr.second.empty());return qr.first;}
E peval(const P&a,const E&x){E r;for(size_t i=a.size();i>0;i--)r=r*x+a[i-1];return r;}
P frob(const P&a,unsigned n){if(a.empty())return {};P r((a.size()-1)*n+1);for(size_t i=0;i<a.size();i++)r[i*n]=epow(a[i],n);trim(r);return r;}
struct Bez{P g,s,t;};
Bez xgcd(P a,P b){P origA=a,origB=b,s0{E(1)},s1,t0,t1{E(1)};while(!b.empty()){auto qr=pd(a,b);a=b;b=qr.second;P ss=ps(s0,pm(qr.first,s1)),tt=ps(t0,pm(qr.first,t1));s0=s1;s1=ss;t0=t1;t1=tt;}if(a.empty())return {{},{},{}};E k=inv(a.back());Bez z{sc(a,k),sc(s0,k),sc(t0,k)};assert(pa(pm(z.s,origA),pm(z.t,origB))==z.g);return z;}
static P PCURVE;
using C=array<P,3>;
C ca(C a,const C&b){for(int i=0;i<3;i++)a[i]=pa(a[i],b[i]);return a;}
C cn(C a){for(P&x:a)x=pn(x);return a;}
C cs(const C&a,const C&b){return ca(a,cn(b));}
C cc(C a,const E&v){for(P&x:a)x=sc(x,v);return a;}
C cp(const C&a,const P&v){C r;for(int i=0;i<3;i++)r[i]=pm(a[i],v);return r;}
C cm(const C&a,const C&b){C r;for(int i=0;i<3;i++)for(int j=0;j<3;j++){P t=pm(a[i],b[j]);if(i+j>=3)t=pm(t,PCURVE);r[(i+j)%3]=pa(r[(i+j)%3],t);}return r;}
C cw(C a,unsigned n){C r;r[0]={E(1)};while(n){if(n&1)r=cm(r,a);n>>=1;if(n)a=cm(a,a);}return r;}
C sumc(std::initializer_list<C> args){C r;for(const C&a:args)r=ca(r,a);return r;}
// Fixed-degree (10,2) polynomial identity, separated in the scale coefficient.
array<C,3> resScale(const C&a,const C&b,const C&c,const C&d,const C&q,const C&V,const C&l){
 C EE=cs(cm(a,d),cm(b,c)),DD=ca(cw(b,2),cm(a,c)),a5=cw(a,5),b5=cw(b,5);
 C T=sumc({cw(c,5),cc(cm(q,b5),E(4)),cm(cw(q,2),a5)});
 C U=cs(cc(cm(q,a5),E(2)),b5);
 C vv=sumc({cc(cm(d,b5),E(4)),cc(cm(cw(c,2),cw(b,4)),E(3)),cc(cm(cm(a,cw(b,2)),cw(c,3)),E(2)),cc(cm(cw(a,2),cw(c,4)),E(3)),cm(q,sumc({cc(cm(a5,d),E(2)),cc(cm(cm(cw(a,4),b),c),E(4)),cm(cw(a,3),cw(b,3))}))});
 C W=sumc({cm(cw(a,2),cw(d,2)),cc(cm(cm(cm(a,b),c),d),E(4)),cc(cm(cw(b,2),cw(c,2)),E(2)),cm(cw(b,3),d),cm(a,cw(c,3))});
 C M=cs(cm(U,ca(cc(cm(a,EE),E(2)),cm(b,DD))),cm(cw(a,2),vv));
 return {ca(cm(cw(a,3),ca(cm(T,W),cm(V,M))),cm(cw(V,2),cw(a,10))),cm(l,ca(cm(T,vv),cm(V,cs(cw(U,2),cc(cm(a5,T),E(2)))))),cm(cw(l,2),cw(T,2))};
}
// Bivariate polynomials: outer index is scale or reciprocal degree as documented.
using B=vector<P>;
void bt(B&a){while(!a.empty()&&a.back().empty())a.pop_back();}
B ba(B a,const B&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=pa(a[i],b[i]);bt(a);return a;}
B bn(B a){for(P&p:a)p=pn(p);return a;}
B bm(const B&a,const B&b,size_t cap){if(a.empty()||b.empty())return {};B r(std::min(cap,a.size()+b.size()-1));for(size_t i=0;i<a.size()&&i<cap;i++)if(!a[i].empty())for(size_t j=0;j<b.size()&&i+j<cap;j++)if(!b[j].empty())r[i+j]=pa(r[i+j],pm(a[i],b[j]));bt(r);return r;}
B bsc(B a,const E&e){for(P&p:a)p=sc(p,e);bt(a);return a;}
B bpm(B a,const P&p){for(P&v:a)v=pm(v,p);bt(a);return a;}
B bpow(B a,unsigned n,size_t cap){B r{P{E(1)}};while(n){if(n&1)r=bm(r,a,cap);n>>=1;if(n)a=bm(a,a,cap);}return r;}
B scaleNorm(const array<C,3>&th){B a(3),b(3),c(3);for(int k=0;k<3;k++){a[k]=th[k][0];b[k]=th[k][1];c[k]=th[k][2];}return ba(ba(bpow(a,3,7),bpm(bpow(b,3,7),PCURVE)),ba(bpm(bpow(c,3,7),pp(PCURVE,2)),bsc(bpm(bm(bm(a,b,7),c,7),PCURVE),E(2))));}
void printE(const E&e){std::cout<<'[';for(int i=0;i<N;i++){if(i)std::cout<<',';std::cout<<e.v[i];}std::cout<<']';}
void printP(const P&p){std::cout<<'[';for(size_t i=0;i<p.size();i++){if(i)std::cout<<',';printE(p[i]);}std::cout<<']';}
void printB(const B&p){std::cout<<'[';for(size_t i=0;i<p.size();i++){if(i)std::cout<<',';printP(p[i]);}std::cout<<']';}
P readP(){int n;std::cin>>n;assert(n>=0);P p(n);for(int i=0;i<n;i++){U32 k;std::cin>>k;p[i]=E(k);}trim(p);return p;}
int main(){try{
 initK();int magic;std::cin>>magic;assert(magic==914021);std::cin>>N;assert(1<=N&&N<=4);for(int i=0;i<=N;i++)std::cin>>MOD[i];assert(MOD[N]==1);FIELD_ORDER=1;for(int i=0;i<N;i++)FIELD_ORDER*=QK;
 E q;if(N==1)q=E(kn(MOD[0]));else q.v[1]=1;P minpoly;for(int i=0;i<=N;i++)minpoly.push_back(E(MOD[i]));assert(peval(minpoly,q).zero());
 P P0=readP(),t=readP(),Qbar=readP(),a0=readP(),ddp=readP(),bp=readP(),cp0=readP(),ep=readP();
 E dd=peval(ddp,q),bv=peval(bp,q),cv=peval(cp0,q),ev=peval(ep,q);E u=-cv/bv,H=u/q,s=(peval(a0,q)*cv-E(2)*bv*bv)/(dd*cv);assert(!q.zero()&&!dd.zero()&&!H.zero()&&!s.zero());
 assert(cv*cv==E(3)*bv*ev);assert(peval(a0,q)-s*dd==E(2)*bv*bv/cv);
 array<C,4> ng;for(int k=0;k<4;k++){int count;std::cin>>count;for(int z=0;z<count;z++){int hp,qp,x,y;U32 a;std::cin>>hp>>qp>>x>>y>>a;assert(hp>=0&&qp>=0&&x>=0&&0<=y&&y<3);E val=E(a)*epow(H,hp)*epow(q,qp);if(ng[k][y].size()<=size_t(x))ng[k][y].resize(x+1);ng[k][y][x]=ng[k][y][x]+val;}for(P&p:ng[k])trim(p);}
 if(!std::cin)throw std::runtime_error("Truncated input");
 PCURVE=sc(P0,inv(q));C Qs,Vs,ls;Qs[1]=sc(Qbar,epow(q,2));Vs[0]=sc(pp(t,3),dd*epow(q,4));ls[0]=sc(P{E(kn(9)),E(1)},dd*q);
 auto rr=resScale(cc(ng[0],E(3)),cc(ng[1],E(2)),ng[2],ng[3],Qs,Vs,ls);
 P den=pm(pp(t,5),P{E(kn(9)),E(1)});E scalar=inv(epow(q,5));array<C,3> th;
 for(int k=0;k<3;k++)for(int j=0;j<3;j++){th[k][j]=sc(exact(rr[k][j],den),scalar);assert(th[k][j].size()<=size_t(47-3*j));}
 B R=scaleNorm(th);assert(R.size()<=7);R.resize(7);E psi=s*dd*dd*epow(u,3)/q;
 E predicted=E(244991)*epow(q,49)*epow(dd,30)*epow(H,9)*epow(psi,3);
 assert(!predicted.zero()&&coeff(R[0],140)==predicted);for(int k=0;k<7;k++){assert(R[k].size()<=141);if(k)assert(coeff(R[k],140).zero());}
 const size_t cap=74;B Ar(cap);for(size_t i=0;i<cap;i++){P row(7);for(int k=0;k<7;k++)row[k]=coeff(R[k],140-i);trim(row);Ar[i]=row;}
 B A2=bm(Ar,Ar,cap),A3=bm(A2,Ar,cap),F5(cap),F25(cap);for(size_t i=0;i<cap;i++){if(i%5==0&&i/5<A2.size())F5[i]=frob(A2[i/5],5);if(i%25==0&&i/25<A2.size())F25[i]=frob(A2[i/25],25);}B CT=bm(bm(A3,F5,cap),F25,cap);CT.resize(cap);
 P T1=CT[71],T2=CT[72],T3=CT[73];Bez be=xgcd(T1,T2);B tails{T1,T2},multipliers{be.s,be.t};
 if(be.g!=P{E(1)}){Bez be3=xgcd(be.g,T3);multipliers={pm(be3.s,be.s),pm(be3.s,be.t),be3.t};tails.push_back(T3);be.g=be3.g;}
 P witness;for(size_t i=0;i<tails.size();i++)witness=pa(witness,pm(multipliers[i],tails[i]));assert(witness==be.g);bool empty=be.g==P{E(1)};
 std::cout<<"{\"field_degree_over_K\":"<<N<<",\"q_minpoly_K_codes\":[";for(int i=0;i<=N;i++){if(i)std::cout<<',';std::cout<<MOD[i];}std::cout<<"],\"q\":";printE(q);std::cout<<",\"H\":";printE(H);std::cout<<",\"s\":";printE(s);std::cout<<",\"source_degree_140_leading_check\":true,\"leading_coefficient\":";printE(predicted);
 std::cout<<",\"tail_indices\":[";for(size_t i=0;i<tails.size();i++){if(i)std::cout<<',';std::cout<<71+i;}std::cout<<"],\"tails_ascending_mu\":";printB(tails);std::cout<<",\"bezout_multipliers_ascending_mu\":";printB(multipliers);std::cout<<",\"monic_tail_gcd\":";printP(be.g);std::cout<<",\"all_geometric_scales_excluded\":"<<(empty?"true":"false")<<",\"regenerable_residual_scale_rows\":";printB(R);std::cout<<"}\n";
 return 0;
 }catch(const std::exception&e){std::cerr<<"ERROR: "<<e.what()<<'\n';return 1;}}
