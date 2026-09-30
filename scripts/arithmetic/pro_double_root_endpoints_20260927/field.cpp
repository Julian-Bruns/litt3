#include <vector>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>
#include <stdexcept>
using namespace std;
static const int Q=390625, M=390624;
static vector<int> lg,ex;
static vector<uint16_t> ad;
static bool ready=false;
static int add25(int a,int b){return (a%5+b%5)%5+5*((a/5+b/5)%5);}
static int neg25(int a){return (5-a%5)%5+5*((5-a/5)%5);}
static int mul25(int a,int b){int a0=a%5,a1=a/5,b0=b%5,b1=b/5;return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5);}
static int slowmul(int a,int b){int aa[4],bb[4],c[7]={0};for(int i=0;i<4;i++){aa[i]=a%25;bb[i]=b%25;a/=25;b/=25;}for(int i=0;i<4;i++)for(int j=0;j<4;j++)c[i+j]=add25(c[i+j],mul25(aa[i],bb[j]));int mod[4]={5,2,6,7};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)c[i-4+j]=add25(c[i-4+j],neg25(mul25(c[i],mod[j])));int ans=0;for(int i=3;i>=0;i--)ans=25*ans+c[i];return ans;}
static int slowpow(int a,int n){int r=1;while(n){if(n&1)r=slowmul(r,a);a=slowmul(a,a);n>>=1;}return r;}
inline int add(int a,int b){return ad[(a%625)*625+b%625]+625*(int)ad[(a/625)*625+b/625];}
inline int neg(int a){return ad[(a%625)*625+0] == 0 && a==0?0: (a?ex[(lg[a]+M/2)%M]:0);}
inline int sub(int a,int b){return add(a,neg(b));}
inline int mul(int a,int b){return a&&b?ex[lg[a]+lg[b]]:0;}
inline int inv(int a){if(!a) throw runtime_error("division by zero");return ex[M-lg[a]];}
inline int pw(int a,int64_t n){if(!a)return n==0?1:0;int64_t z=(int64_t)lg[a]*(n%M)%M;if(z<0)z+=M;return ex[z];}
extern "C" {
int ff_init(){if(ready)return 0;lg.assign(Q,-1);ex.resize(2*M+1);ad.resize(625*625);for(int a=0;a<625;a++)for(int b=0;b<625;b++)ad[a*625+b]=add25(a%25,b%25)+25*add25(a/25,b/25);
int g=2;for(;;g++){bool ok=true;for(int p:{2,3,13,313})if(slowpow(g,M/p)==1){ok=false;break;}if(ok)break;}
int x=1;for(int i=0;i<M;i++){if(lg[x]>=0)abort();lg[x]=i;ex[i]=x;x=slowmul(x,g);}if(x!=1)abort();for(int i=M;i<=2*M;i++)ex[i]=ex[i-M];ready=true;return g;}
int ff_add(int a,int b){return add(a,b);}int ff_sub(int a,int b){return sub(a,b);}int ff_mul(int a,int b){return mul(a,b);}int ff_inv(int a){return inv(a);}int ff_pow(int a,int64_t n){return pw(a,n);}int ff_slowmul(int a,int b){return slowmul(a,b);}
int *ff_logs(){return lg.data();}int *ff_exps(){return ex.data();}uint16_t *ff_adds(){return ad.data();}
int ff_rref(int* a,int rows,int cols,int pivotcols,int *pivots){int r=0;for(int c=0;c<pivotcols && r<rows;c++){int s=r;while(s<rows && !a[s*cols+c])s++;if(s==rows)continue;if(s!=r)for(int j=0;j<cols;j++)swap(a[s*cols+j],a[r*cols+j]);int z=inv(a[r*cols+c]);for(int j=c;j<cols;j++)a[r*cols+j]=mul(a[r*cols+j],z);for(int i=0;i<rows;i++)if(i!=r && a[i*cols+c]){z=a[i*cols+c];a[i*cols+c]=0;for(int j=c+1;j<cols;j++)a[i*cols+j]=sub(a[i*cols+j],mul(z,a[r*cols+j]));}pivots[r++]=c;}return r;}
void ff_polymul(const int *a,int n,const int*b,int m,int*c){fill(c,c+n+m-1,0);for(int i=0;i<n;i++)if(a[i])for(int j=0;j<m;j++)if(b[j])c[i+j]=add(c[i+j],mul(a[i],b[j]));}
int ff_polydiv(const int *a,int n,const int*b,int m,int*q,int*r){if(m<=0||!b[m-1])return -1;copy(a,a+n,r);fill(q,q+max(1,n-m+1),0);int ib=inv(b[m-1]);for(int i=n-1;i>=m-1;i--){int z=mul(r[i],ib);q[i-m+1]=z;if(z)for(int j=0;j<m;j++)r[i-m+1+j]=sub(r[i-m+1+j],mul(z,b[j]));}return 0;}
}
// Extension-field polynomial arithmetic.  The extension modulus is monic over K.
using KP=vector<int>;
static void trim(KP&a){while(!a.empty()&&!a.back())a.pop_back();}
static KP padd(const KP&a,const KP&b){KP c(max(a.size(),b.size()),0);for(size_t i=0;i<c.size();i++)c[i]=add(i<a.size()?a[i]:0,i<b.size()?b[i]:0);trim(c);return c;}
static KP psub(const KP&a,const KP&b){KP c(max(a.size(),b.size()),0);for(size_t i=0;i<c.size();i++)c[i]=sub(i<a.size()?a[i]:0,i<b.size()?b[i]:0);trim(c);return c;}
static KP pscale(KP a,int z){for(int&v:a)v=mul(v,z);trim(a);return a;}
static KP pmul(const KP&a,const KP&b){
 if(a.empty()||b.empty())return {};
 int n=a.size(),m=b.size();
 if(min(n,m)<=24){KP c(n+m-1,0);for(int i=0;i<n;i++)if(a[i])for(int j=0;j<m;j++)if(b[j])c[i+j]=add(c[i+j],mul(a[i],b[j]));trim(c);return c;}
 int k=max(n,m)/2;
 KP a0(a.begin(),a.begin()+min(k,n)),a1(a.begin()+min(k,n),a.end());
 KP b0(b.begin(),b.begin()+min(k,m)),b1(b.begin()+min(k,m),b.end());
 trim(a0);trim(b0);KP z0=pmul(a0,b0),z2=pmul(a1,b1),z1=psub(psub(pmul(padd(a0,a1),padd(b0,b1)),z0),z2);
 KP c(n+m-1,0);for(size_t i=0;i<z0.size();i++)c[i]=add(c[i],z0[i]);for(size_t i=0;i<z1.size();i++)c[k+i]=add(c[k+i],z1[i]);for(size_t i=0;i<z2.size();i++)c[2*k+i]=add(c[2*k+i],z2[i]);trim(c);return c;
}
static pair<KP,KP> pdiv(const KP&a,const KP&b){if(b.empty())throw runtime_error("poly zero divisor");KP r=a;if(a.size()<b.size())return {{},r};KP q(a.size()-b.size()+1,0);int iv=inv(b.back());for(int i=(int)a.size()-1;i>=(int)b.size()-1;i--){int z=mul(r[i],iv);q[i-b.size()+1]=z;if(z)for(int j=0;j<(int)b.size();j++)r[i-b.size()+1+j]=sub(r[i-b.size()+1+j],mul(z,b[j]));}trim(q);trim(r);return{q,r};}
static int ED=1;static KP EM={0,1};
using E=KP;
static void enormalize(E&a){a.resize(ED,0);}
static bool ezero(const int*a){for(int i=0;i<ED;i++)if(a[i])return false;return true;}
static E eadd(const E&a,const E&b){E c(ED);for(int i=0;i<ED;i++)c[i]=add(a[i],b[i]);return c;}
static E esub(const E&a,const E&b){E c(ED);for(int i=0;i<ED;i++)c[i]=sub(a[i],b[i]);return c;}
static E eneg(const E&a){E c(ED);for(int i=0;i<ED;i++)c[i]=neg(a[i]);return c;}
static E eone(){E a(ED,0);a[0]=1;return a;}
static void emul_to(int*out,const int*a,const int*b){
 if(ED==1){out[0]=mul(a[0],b[0]);return;}
 int small[255]={0}; vector<int> large; int* tmp=small;
 if(2*ED-1>255){large.assign(2*ED-1,0);tmp=large.data();}
 for(int i=0;i<ED;i++)if(a[i])for(int j=0;j<ED;j++)if(b[j])tmp[i+j]=add(tmp[i+j],mul(a[i],b[j]));
 for(int i=2*ED-2;i>=ED;i--)if(tmp[i])for(int j=0;j<ED;j++)tmp[i-ED+j]=sub(tmp[i-ED+j],mul(tmp[i],EM[j]));
 copy(tmp,tmp+ED,out);
}
static E emul(const E&a,const E&b){E c(ED);emul_to(c.data(),a.data(),b.data());return c;}
static E einv(const E&a){
 KP b=a;trim(b);if(b.empty())throw runtime_error("extension inversion of zero");
 if(ED==1)return E{inv(b[0])};
 KP r0=EM,r1=b,t0={},t1={1};
 while(!r1.empty()){auto qr=pdiv(r0,r1);r0=r1;r1=qr.second;KP t=psub(t0,pmul(qr.first,t1));t0=t1;t1=t;}
 if(r0.size()!=1)throw runtime_error("nonunit in extension algebra");
 E ans=pdiv(pscale(t0,inv(r0[0])),EM).second;enormalize(ans);return ans;
}
static E epower(E a,uint64_t n){E b=eone();while(n){if(n&1)b=emul(b,a);a=emul(a,a);n>>=1;}return b;}
struct EP { // coefficient-major, with each coefficient in the chosen extension basis
 KP a;
 EP(){}EP(const KP&v):a(v){norm();}
 int len()const{return (int)a.size()/ED;}
 void norm(){while(!a.empty()&&ezero(a.data()+a.size()-ED))a.resize(a.size()-ED);}
 E coeff(int i)const{if(i<0||i>=len())return E(ED,0);return E(a.begin()+i*ED,a.begin()+(i+1)*ED);}
};
static EP epadd(const EP&a,const EP&b){EP c;c.a.resize(max(a.a.size(),b.a.size()),0);for(size_t i=0;i<c.a.size();i++)c.a[i]=add(i<a.a.size()?a.a[i]:0,i<b.a.size()?b.a[i]:0);c.norm();return c;}
static EP epsub(const EP&a,const EP&b){EP c;c.a.resize(max(a.a.size(),b.a.size()),0);for(size_t i=0;i<c.a.size();i++)c.a[i]=sub(i<a.a.size()?a.a[i]:0,i<b.a.size()?b.a[i]:0);c.norm();return c;}
static EP epscale(const EP&a,const E&z){EP c;c.a.resize(a.a.size(),0);for(int i=0;i<a.len();i++)emul_to(c.a.data()+i*ED,a.a.data()+i*ED,z.data());c.norm();return c;}
static EP epmul(const EP&a,const EP&b){
 if(a.a.empty()||b.a.empty())return EP();
 if(ED==1)return EP(pmul(a.a,b.a));
 int n=a.len(),m=b.len(),s=2*ED-1;
 KP aa((n-1)*s+ED,0),bb((m-1)*s+ED,0);
 for(int i=0;i<n;i++)copy(a.a.begin()+i*ED,a.a.begin()+(i+1)*ED,aa.begin()+i*s);
 for(int i=0;i<m;i++)copy(b.a.begin()+i*ED,b.a.begin()+(i+1)*ED,bb.begin()+i*s);
 KP c=pmul(aa,bb);c.resize((n+m-1)*s,0);EP z;z.a.resize((n+m-1)*ED,0);
 for(int i=0;i<n+m-1;i++){
  int*tmp=c.data()+i*s;
  for(int j=2*ED-2;j>=ED;j--)if(tmp[j])for(int k=0;k<ED;k++)tmp[j-ED+k]=sub(tmp[j-ED+k],mul(tmp[j],EM[k]));
  copy(tmp,tmp+ED,z.a.begin()+i*ED);
 }z.norm();return z;
}
static pair<EP,EP> epdiv(const EP&a,const EP&b){
 if(!b.len())throw runtime_error("EP division by zero");
 EP r=a,q;if(a.len()<b.len())return{q,r};
 q.a.resize((a.len()-b.len()+1)*ED,0);E iv=einv(b.coeff(b.len()-1)),z(ED),tmp(ED);
 for(int i=a.len()-1;i>=b.len()-1;i--){
  emul_to(z.data(),r.a.data()+i*ED,iv.data());copy(z.begin(),z.end(),q.a.begin()+(i-b.len()+1)*ED);
  if(!ezero(z.data()))for(int j=0;j<b.len();j++){
   emul_to(tmp.data(),z.data(),b.a.data()+j*ED);
   int k=(i-b.len()+1+j)*ED;for(int h=0;h<ED;h++)r.a[k+h]=sub(r.a[k+h],tmp[h]);
  }
 }r.norm();q.norm();return{q,r};
}
static EP epmonic(const EP&a){return a.len()?epscale(a,einv(a.coeff(a.len()-1))):a;}
static EP eppower(EP a,int n){EP z(eone());while(n){if(n&1)z=epmul(z,a);a=epmul(a,a);n>>=1;}return z;}
extern "C" {
int ef_init(const int*mod,int n){if(n<2||n>2049||mod[n-1]!=1)return -1;ED=n-1;EM.assign(mod,mod+n);return ED;}
void ef_add(const int*a,const int*b,int*c){for(int i=0;i<ED;i++)c[i]=add(a[i],b[i]);}
void ef_sub(const int*a,const int*b,int*c){for(int i=0;i<ED;i++)c[i]=sub(a[i],b[i]);}
void ef_mul(const int*a,const int*b,int*c){emul_to(c,a,b);}
int ef_inv(const int*a,int*c){try{E b=einv(E(a,a+ED));copy(b.begin(),b.end(),c);return 0;}catch(...){return -1;}}
void ef_pow(const int*a,uint64_t n,int*c){E b=epower(E(a,a+ED),n);copy(b.begin(),b.end(),c);}
void* ep_new(const int*a,int n){KP z;if(n)z.assign(a,a+n*ED);return new EP(z);}
void ep_free(void*a){delete (EP*)a;}
int ep_len(void*a){return ((EP*)a)->len();}
void ep_get(void*a,int*out){EP*p=(EP*)a;copy(p->a.begin(),p->a.end(),out);}
void ep_coeff(void*a,int i,int*out){E c=((EP*)a)->coeff(i);copy(c.begin(),c.end(),out);}
void* ep_add(void*a,void*b){return new EP(epadd(*(EP*)a,*(EP*)b));}
void* ep_sub(void*a,void*b){return new EP(epsub(*(EP*)a,*(EP*)b));}
void* ep_mul(void*a,void*b){return new EP(epmul(*(EP*)a,*(EP*)b));}
void* ep_scale(void*a,const int*z){return new EP(epscale(*(EP*)a,E(z,z+ED)));}
void* ep_pow(void*a,int n){return new EP(eppower(*(EP*)a,n));}
int ep_divrem(void*a,void*b,void**q,void**r){try{auto p=epdiv(*(EP*)a,*(EP*)b);*q=new EP(p.first);*r=new EP(p.second);return 0;}catch(...){return -1;}}
void* ep_gcd(void*a,void*b){EP A=*(EP*)a,B=*(EP*)b;while(B.len()){EP r=epdiv(A,B).second;A=B;B=r;}return new EP(epmonic(A));}
int ep_xgcd(void*a,void*b,void**g,void**s,void**t){
 try{EP A=*(EP*)a,B=*(EP*)b,S0(eone()),S1,T0,T1(eone());
 while(B.len()){auto qr=epdiv(A,B);A=B;B=qr.second;EP s=epsub(S0,epmul(qr.first,S1)),t=epsub(T0,epmul(qr.first,T1));S0=S1;S1=s;T0=T1;T1=t;}
 if(!A.len())return -1;E z=einv(A.coeff(A.len()-1));*g=new EP(epscale(A,z));*s=new EP(epscale(S0,z));*t=new EP(epscale(T0,z));return 0;}catch(...){return -1;}
}
void ep_eval(void*a,const int*x,int*out){EP*A=(EP*)a;E r(ED,0),v(x,x+ED);for(int i=A->len()-1;i>=0;i--)r=eadd(emul(r,v),A->coeff(i));copy(r.begin(),r.end(),out);}
void* ep_truncate(void*a,int n){EP z=*(EP*)a;if(z.len()>n)z.a.resize(n*ED);z.norm();return new EP(z);}
void* ep_frobenius(void*a,int j,int exponent_stride){EP&A=*(EP*)a;EP B;if(!A.len())return new EP(B);uint64_t p=1;for(int i=0;i<j;i++)p*=5;B.a.resize(((A.len()-1)*exponent_stride+1)*ED,0);for(int i=0;i<A.len();i++){E z=epower(A.coeff(i),p);copy(z.begin(),z.end(),B.a.begin()+i*exponent_stride*ED);}B.norm();return new EP(B);}
}
