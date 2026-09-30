// Exact resultant by interpolation over F_(25^3).
// Base encoding and extension are documented in data/field.json.
#include <algorithm>
#include <array>
#include <cassert>
#include <chrono>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>
using namespace std;
using Poly=vector<int>;
int a25[25][25],m25[25][25],ng25[25];
const int Q=15625;
vector<int> lg(Q,-1),ex(2*(Q-1)),iv(Q),ng(Q);
int add(int a,int b){return a25[a%25][b%25]+25*a25[(a/25)%25][(b/25)%25]+625*a25[a/625][b/625];}
int neg(int a){return ng[a];}
int sub(int a,int b){return add(a,ng[b]);}
int rawmul(int a,int b){
 int x[3]={a%25,(a/25)%25,a/625},y[3]={b%25,(b/25)%25,b/625},z[5]={};
 for(int i=0;i<3;i++)for(int j=0;j<3;j++)z[i+j]=a25[z[i+j]][m25[x[i]][y[j]]];
 // theta^3+theta^2+1=0.
 for(int j=4;j>=3;j--){z[j-3]=a25[z[j-3]][ng25[z[j]]];z[j-1]=a25[z[j-1]][ng25[z[j]]];}
 return z[0]+25*z[1]+625*z[2];
}
int rawpow(int a,int n){int z=1;for(;n;n>>=1,a=rawmul(a,a))if(n&1)z=rawmul(z,a);return z;}
int mul(int a,int b){return a&&b?ex[lg[a]+lg[b]]:0;}
int powf(int a,long long n){if(!a)return n?0:1;long long k=(long long)lg[a]*(n%(Q-1))%(Q-1);if(k<0)k+=Q-1;return ex[k];}
void init(){
 for(int a=0;a<25;a++){
  ng25[a]=(5-a%5)%5+5*((5-a/5)%5);
  for(int b=0;b<25;b++){
   a25[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
   m25[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
  }
 }
 for(int a=0;a<Q;a++)ng[a]=ng25[a%25]+25*ng25[(a/25)%25]+625*ng25[a/625];
 int g=2;
 while(rawpow(g,(Q-1)/2)==1||rawpow(g,(Q-1)/3)==1||rawpow(g,(Q-1)/7)==1||rawpow(g,(Q-1)/31)==1)g++;
 int z=1;for(int i=0;i<Q-1;i++){assert(lg[z]<0);ex[i]=z;lg[z]=i;z=rawmul(z,g);}assert(z==1);
 for(int i=Q-1;i<(int)ex.size();i++)ex[i]=ex[i-(Q-1)];
 for(int a=1;a<Q;a++)iv[a]=ex[(Q-1-lg[a])%(Q-1)];
 cerr<<"F15625 generator="<<g<<"; all "<<Q-1<<" nonzero elements enumerated\n";
}
void trim(Poly &a){while(!a.empty()&&!a.back())a.pop_back();}
int ev(const Poly&a,int x){int z=0;for(int i=(int)a.size()-1;i>=0;i--)z=add(mul(z,x),a[i]);return z;}
Poly rem(Poly a,const Poly&b){assert(!b.empty());int n=b.size()-1;
 while(a.size()>=b.size()){
  int d=a.size()-b.size(),q=mul(a.back(),iv[b.back()]);
  for(int i=0;i<=n;i++){a[i+d]=sub(a[i+d],mul(q,b[i]));}trim(a);
 }return a;
}
int resultant(Poly a,Poly b){
 int ans=1;
 while(true){
  if(a.empty()||b.empty())return 0;
  int m=a.size()-1,n=b.size()-1;
  if(n==0)return mul(ans,powf(b[0],m));
  if(m<n){if((m*n)%2)ans=neg(ans);swap(a,b);continue;}
  Poly r=rem(a,b);if(r.empty())return 0;
  int k=r.size()-1;
  ans=mul(ans,powf(b.back(),m-k));if((m*n)%2)ans=neg(ans);
  a=move(b);b=move(r);
 }
}
Poly readpoly(istream&in){
 int n;
 if(!(in>>n)||n< -1||n>1000000)throw runtime_error("invalid polynomial degree");
 Poly a(n+1);
 for(int &v:a){if(!(in>>v)||v<0||v>=25)throw runtime_error("invalid F25 coefficient");}
 trim(a);return a;
}
Poly pairpoly(const Poly&N,const Poly&D,int x){
 int nx=ev(N,x),dx=ev(D,x);int n=max(N.size(),D.size())-1;
 Poly h(n+1);for(int i=0;i<=n;i++)h[i]=sub(i<(int)D.size()?mul(nx,D[i]):0,i<(int)N.size()?mul(dx,N[i]):0);
 // Exact division by y-x, retaining generic degree n-1.
 Poly f(n);f[n-1]=h[n];for(int i=n-1;i>=1;i--)f[i-1]=add(h[i],mul(x,f[i]));
 assert(add(h[0],mul(x,f[0]))==0);trim(f);return f;
}
int fixedres(Poly a,Poly b,int m,int n){
 if(a.empty()||b.empty())return 0;
 int ma=a.size()-1,nb=b.size()-1;
 if(ma<m&&nb<n)return 0;
 int ans=resultant(a,b);
 if(ma<m){ans=mul(ans,powf(b.back(),m-ma));if(((m-ma)*n)%2)ans=neg(ans);}
 if(nb<n)ans=mul(ans,powf(a.back(),n-nb));
 return ans;
}
int main(int argc,char**argv){
 try{
  if(argc!=3){throw runtime_error("usage: resultant INPUT_POLYS OUTPUT_POLY");}init();
  ifstream in(argv[1]);if(!in)throw runtime_error("input unavailable");
  Poly N=readpoly(in),D=readpoly(in),U=readpoly(in),V=readpoly(in);
  int m=max(N.size(),D.size())-2,n=max(U.size(),V.size())-2,degree_bound=2*m*n;
  assert(degree_bound+30<Q);
  Poly vals(degree_bound+1),dd;
  cerr<<"bidegrees "<<m<<','<<n<<" resultant degree bound "<<degree_bound<<"\n";
  for(int x=0;x<=degree_bound;x++){
   vals[x]=fixedres(pairpoly(N,D,x),pairpoly(U,V,x),m,n);
   if(x%100==0)cerr<<"resultants "<<x<<'/'<<degree_bound<<'\n';
  }
  dd=vals;
  // Divided differences for distinct nodes 0,...,degree_bound in field encoding.
  for(int j=1;j<=degree_bound;j++)for(int i=degree_bound;i>=j;i--)dd[i]=mul(sub(dd[i],dd[i-1]),iv[sub(i,i-j)]);
  Poly res(1,dd[degree_bound]);
  for(int i=degree_bound-1;i>=0;i--){
   Poly r(res.size()+1);
   for(int j=0;j<(int)res.size();j++){r[j]=sub(r[j],mul(i,res[j]));r[j+1]=add(r[j+1],res[j]);}
   r[0]=add(r[0],dd[i]);res=move(r);
  }
  trim(res);
  for(int c:res)if(c>=25)throw runtime_error("resultant failed descent to F25");
  for(int x=0;x<=degree_bound;x++)assert(ev(res,x)==vals[x]);
  for(int x=degree_bound+1;x<=degree_bound+20;x++)assert(ev(res,x)==fixedres(pairpoly(N,D,x),pairpoly(U,V,x),m,n));
  ofstream out(argv[2]);out<<res.size()-1<<'\n';for(int c:res)out<<c<<' ';out<<'\n';
  cerr<<"RESULT degree="<<res.size()-1<<"; interpolation checks="<<degree_bound+1<<"; extra checks=20; PASS\n";
 }catch(const exception&e){cerr<<e.what()<<'\n';return 1;}
}
