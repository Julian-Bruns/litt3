// Exact certificate for the Weierstrass-supported residual subcase.
// Compile: g++ -std=c++17 -O2 certificate.cpp -o certificate
// Run: ./certificate
#include <array>
#include <vector>
#include <iostream>
#include <stdexcept>
#include <algorithm>
#include <cstdint>
using namespace std;
int ad[25][25],su[25][25],mu[25][25],iv[25];
void req(bool b,const char* m){if(!b)throw runtime_error(m);}
int mod5(int a){a%=5;return a<0?a+5:a;}
void init(){
 for(int i=0;i<25;i++)for(int j=0;j<25;j++){
  int a=i%5,b=i/5,c=j%5,d=j/5;
  ad[i][j]=mod5(a+c)+5*mod5(b+d);
  su[i][j]=mod5(a-c)+5*mod5(b-d);
  mu[i][j]=mod5(a*c-2*b*d)+5*mod5(a*d+b*c+b*d);
 }
 for(int i=1;i<25;i++)for(int j=1;j<25;j++)if(mu[i][j]==1)iv[i]=j;
}
using P=vector<int>;
P tr(P a){while(!a.empty()&&!a.back())a.pop_back();return a;}
P add(P a,const P&b){a.resize(max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=ad[a[i]][b[i]];return tr(a);}
P sub(P a,const P&b){a.resize(max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=su[a[i]][b[i]];return tr(a);}
P scl(P a,int b){for(auto&c:a)c=mu[c][b];return tr(a);}
P mul(const P&a,const P&b){
 if(a.empty()||b.empty())return {};
 P c(a.size()+b.size()-1);
 for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=ad[c[i+j]][mu[a[i]][b[j]]];
 return tr(c);
}
pair<P,P> divrem(P a,const P&b){
 req(!b.empty(),"polynomial division by zero");P q(a.size()>=b.size()?a.size()-b.size()+1:0);
 while(!a.empty()&&a.size()>=b.size()){
  size_t k=a.size()-b.size();int c=mu[a.back()][iv[b.back()]];q[k]=c;
  for(size_t j=0;j<b.size();j++)a[j+k]=su[a[j+k]][mu[c][b[j]]];
  a=tr(a);
 }return {tr(q),a};
}
P rem(const P&a,const P&b){return divrem(a,b).second;}
P monic(P a){return a.empty()?a:scl(a,iv[a.back()]);}
P gcd(P a,P b){while(!b.empty()){P r=rem(a,b);a=b;b=r;}return monic(a);}
P powpoly(P a,uint64_t n,const P&m={}){
 P b={1};while(n){if(n&1){b=mul(b,a);if(!m.empty())b=rem(b,m);}n>>=1;if(n){a=mul(a,a);if(!m.empty())a=rem(a,m);}}return b;
}
int binom(int n,int k){if(k<0||k>n)return 0;uint64_t b=1;for(int j=1;j<=k;j++)b=b*(n-j+1)/j;return int(b%5);}
P hasse(const P&a,int n){if(n>=int(a.size()))return {};P b(a.size()-n);for(int i=n;i<int(a.size());i++)b[i-n]=mu[binom(i,n)][a[i]];return tr(b);}
void printpoly(const P&a){for(size_t i=0;i<a.size();i++){if(i)cout<<",";cout<<a[i]%5<<"+"<<a[i]/5<<"a";}cout<<"\n";}
const P F={11,22,18,5,19,20,15,16,9,22,1};
P W6;
struct E{array<int,6>c{}; E(int b=0){c[0]=b;} bool operator==(const E&o)const{return c==o.c;} bool operator!=(const E&o)const{return !(*this==o);} bool zero()const{return all_of(c.begin(),c.end(),[](int a){return a==0;});}};
E operator+(const E&a,const E&b){E c;for(int i=0;i<6;i++)c.c[i]=ad[a.c[i]][b.c[i]];return c;}
E operator-(const E&a,const E&b){E c;for(int i=0;i<6;i++)c.c[i]=su[a.c[i]][b.c[i]];return c;}
E operator*(const E&a,const E&b){
 int c[11]={};for(int i=0;i<6;i++)for(int j=0;j<6;j++)c[i+j]=ad[c[i+j]][mu[a.c[i]][b.c[j]]];
 for(int n=10;n>=6;n--)if(c[n]){int t=c[n];for(int j=0;j<6;j++)c[n-6+j]=su[c[n-6+j]][mu[t][W6[j]]];}
 E e;for(int i=0;i<6;i++)e.c[i]=c[i];return e;
}
E power(E a,uint64_t n){E b(1);while(n){if(n&1)b=b*a;n>>=1;if(n)a=a*a;}return b;}
const uint64_t Q=244140625; // 25^6
E inverse(E a){req(!a.zero(),"field division by zero");E b=power(a,Q-2);req(a*b==E(1),"field inverse failure");return b;}
E eval(const P&p,E x){E a;for(int i=int(p.size())-1;i>=0;i--)a=a*x+E(p[i]);return a;}
E cuberoot(E b,E alpha){
 req(power(b,(Q-1)/3)==E(1),"F(alpha) is not a cube");
 uint64_t m=(Q-1)/9;req(m%3!=0,"bad 3-adic valuation");
 uint64_t e=(m%3==1?(2*m+1)/3:(m+1)/3);req((3*e)%m==1,"inverse exponent failure");
 E c=power(b,e),eta;bool found=false;
 for(int j=0;j<25;j++){E t=power(alpha+E(j),m);if(!t.zero()&&power(t,3)!=E(1)){eta=t;found=true;break;}}
 req(found&&power(eta,9)==E(1),"primitive ninth root not found");
 for(int j=0;j<3;j++){E t=c*power(eta,j);if(power(t,3)==b)return t;}
 throw runtime_error("cube root correction failed");
}
using Row=array<E,19>;
using Block=array<Row,9>;
Block jets(E u,E y){
 array<E,11> up;up[0]=E(1);for(int j=1;j<=10;j++)up[j]=up[j-1]*u;
 array<E,9> ft,ys,y2;
 for(int n=0;n<9;n++)for(int i=n;i<=10;i++)ft[n]=ft[n]+E(mu[F[i]][binom(i,n)])*up[i-n];
 ys[0]=y;E denom_inv=inverse(E(3)*y*y);
 for(int n=1;n<9;n++){
  E known;
  for(int i=0;i<n;i++)for(int j=0;j<n;j++){int k=n-i-j;if(k>=0&&k<n)known=known+ys[i]*ys[j]*ys[k];}
  ys[n]=(ft[n]-known)*denom_inv;
 }
 for(int n=0;n<9;n++)for(int i=0;i<=n;i++)y2[n]=y2[n]+ys[i]*ys[n-i];
 // Independently replay y(t)^3 = F(u+t) to order t^9.
 for(int n=0;n<9;n++){E t;for(int i=0;i<=n;i++)for(int j=0;j<=n-i;j++)t=t+ys[i]*ys[j]*ys[n-i-j];req(t==ft[n],"Hasse lift failure");}
 Block M;
 for(int n=0;n<9;n++){
  for(int i=0;i<=9;i++)if(n<=i)M[n][i]=E(binom(i,n))*up[i-n];
  for(int i=0;i<=5;i++)for(int j=0;j<=min(i,n);j++)M[n][10+i]=M[n][10+i]+E(binom(i,j))*up[i-j]*ys[n-j];
  for(int i=0;i<=2;i++)for(int j=0;j<=min(i,n);j++)M[n][16+i]=M[n][16+i]+E(binom(i,j))*up[i-j]*y2[n-j];
 }return M;
}
int rankmat(vector<Row> a){
 int r=0;
 for(int col=0;col<19;col++){
  int pivot=r;while(pivot<int(a.size())&&a[pivot][col].zero())pivot++;
  if(pivot==int(a.size()))continue;
  swap(a[pivot],a[r]);E invp=inverse(a[r][col]);for(int j=col;j<19;j++)a[r][j]=a[r][j]*invp;
  for(int i=r+1;i<int(a.size());i++)if(!a[i][col].zero()){E c=a[i][col];for(int j=col+1;j<19;j++)a[i][j]=a[i][j]-c*a[r][j];a[i][col]=E();}
  r++;if(r==int(a.size()))break;
 }return r;
}

using EP=vector<E>;
EP etrim(EP a){while(!a.empty()&&a.back().zero())a.pop_back();return a;}
EP eadd(EP a,const EP&b){a.resize(max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=a[i]+b[i];return etrim(a);}
EP esub(EP a,const EP&b){a.resize(max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=a[i]-b[i];return etrim(a);}
EP escale(EP a,E b){for(auto&c:a)c=c*b;return etrim(a);}
EP emul(const EP&a,const EP&b){if(a.empty()||b.empty())return {};EP c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=c[i+j]+a[i]*b[j];return etrim(c);}
EP epow(EP a,int n){EP b={E(1)};while(n){if(n&1)b=emul(b,a);n>>=1;if(n)a=emul(a,a);}return b;}
pair<EP,EP> edivrem(EP a,const EP&b){req(!b.empty(),"extension polynomial division by zero");EP q(a.size()>=b.size()?a.size()-b.size()+1:0);E bi=inverse(b.back());while(!a.empty()&&a.size()>=b.size()){size_t k=a.size()-b.size();E c=a.back()*bi;q[k]=c;for(size_t j=0;j<b.size();j++)a[k+j]=a[k+j]-c*b[j];a=etrim(a);}return {etrim(q),a};}
pair<int,Row> kernel18(vector<Row> a){
 vector<int> piv;int r=0;
 for(int col=0;col<19;col++){
  int p=r;while(p<int(a.size())&&a[p][col].zero())p++;
  if(p==int(a.size()))continue;
  swap(a[p],a[r]);E invp=inverse(a[r][col]);for(int j=col;j<19;j++)a[r][j]=a[r][j]*invp;
  for(int i=r+1;i<int(a.size());i++)if(!a[i][col].zero()){E c=a[i][col];for(int j=col+1;j<19;j++)a[i][j]=a[i][j]-c*a[r][j];a[i][col]=E();}
  piv.push_back(col);r++;if(r==int(a.size()))break;
 }
 Row v; if(r!=18)return {r,v};
 int freecol=0;while(find(piv.begin(),piv.end(),freecol)!=piv.end())freecol++;
 v[freecol]=E(1);
 for(int i=17;i>=0;i--){E t;for(int j=piv[i]+1;j<19;j++)t=t+a[i][j]*v[j];v[piv[i]]=E()-t;}
 return {r,v};
}
EP enorm(const Row&v){
 EP A(v.begin(),v.begin()+10),B(v.begin()+10,v.begin()+16),C(v.begin()+16,v.end()),FF;
 for(int c:F)FF.push_back(E(c));
 return esub(eadd(eadd(epow(A,3),emul(epow(B,3),FF)),emul(epow(C,3),epow(FF,2))),escale(emul(emul(emul(A,B),C),FF),E(3)));
}
int main(){try{
 init();P f2=mul(F,F),f5=powpoly(F,5),fp5=powpoly(hasse(F,1),5);array<P,9> h;
 for(int n=4;n<=8;n++){h[n]=mul(f5,hasse(f2,n));if(n>=5)h[n]=add(h[n],scl(mul(fp5,hasse(f2,n-5)),3));}
 P W;array<int,3> perm={0,1,2};
 do{int invs=0;for(int i=0;i<3;i++)for(int j=i+1;j<3;j++)invs+=(perm[i]>perm[j]);P t={invs%2?4:1};for(int i=0;i<3;i++)t=mul(t,h[6+i-perm[i]]);W=add(W,t);}while(next_permutation(perm.begin(),perm.end()));
 req(W.size()==192,"wrong raw Wronskian degree");
 for(int i=0;i<3;i++){auto qr=divrem(W,F);req(qr.second.empty(),"Wronskian F^3 division failure");W=qr.first;}
 req(W.size()==162,"wrong reduced Wronskian degree");
 req(gcd(W,F)==P{1},"Wronskian meets branch locus");
 req(gcd(W,hasse(W,1))==P{1},"Wronskian is not squarefree");
 cout<<"Wronskian: degree 161, squarefree, coprime to F.\n";
 P xp={0,1},xpq=xp;vector<P> gd(37);
 for(int d=1;d<=36;d++){xpq=powpoly(xpq,25,W);gd[d]=gcd(W,sub(xpq,xp));}
 W6=gd[12];req(W6==P({24,20,1,12,17,9,1}),"unexpected sextic");
 req(gd[24]==W6&&gd[36]==W6,"torsion field filters differ");
 req(gd[1]==P{1}&&gd[2]==P{1}&&gd[3]==P{1}&&gd[6]==W6,"sextic irreducibility check failed");
 cout<<"gcd(W,x^(25^d)-x) equals the same irreducible sextic for d=12,24,36.\n";
 cout<<"Sextic coefficients, constant term first: ";printpoly(W6);
 E alpha;alpha.c[1]=1;req(eval(W6,alpha).zero(),"extension relation failed");
 E b=eval(F,alpha);req(!b.zero(),"branch point in sextic");
 req(power(b,(Q-1)/3)==E(1),"noncube value");E beta=cuberoot(b,alpha);req(power(beta,3)==b,"cube root failed");
 cout<<"F(alpha)^((25^6-1)/3) = 1. All 18 lifts are in F_(25^6).\n";
 int zeta=0;for(int i=2;i<25;i++)if(mu[mu[i][i]][i]==1){zeta=i;break;}req(zeta,"cube root of unity missing");
 array<E,6> us,ys;us[0]=alpha;ys[0]=beta;
 for(int i=1;i<6;i++){us[i]=power(us[i-1],25);ys[i]=power(ys[i-1],25);}
 req(power(us[5],25)==us[0]&&power(ys[5],25)==ys[0],"Frobenius orbit failed");
 array<Block,18> blocks;
 for(int i=0;i<6;i++)for(int j=0;j<3;j++)blocks[3*i+j]=jets(us[i],ys[i]*power(E(zeta),j));
 int count=0;array<int,20> hist{};
 for(int i=0;i<6;i++)for(int j=i+1;j<6;j++)for(int k=j+1;k<6;k++)
 for(int a=0;a<3;a++)for(int b=0;b<3;b++)for(int c=0;c<3;c++){
  vector<Row> M;for(int id:{3*i+a,3*j+b,3*k+c})for(auto row:blocks[id])M.push_back(row);
  int r=rankmat(M);hist[r]++;count++;
  if(r!=19){cout<<"LOW RANK triple "<<i<<","<<a<<" ; "<<j<<","<<b<<" ; "<<k<<","<<c<<" rank="<<r<<"\n";}
 }
 cout<<"Triples checked: "<<count<<". Rank histogram:";for(int i=0;i<20;i++)if(hist[i])cout<<" rank "<<i<<": "<<hist[i];cout<<"\n";
 req(count==540&&hist[19]==540,"Weierstrass triple exclusion FAILED");
 cout<<"PASS: no target divisor is supported entirely at Weierstrass points.\n";
 int paircount=0,lowpairs=0,lowerpole=0,firstfailure=0,laterfailure=0,success=0;
 for(int i=0;i<6;i++)for(int j=i+1;j<6;j++)for(int a=0;a<3;a++)for(int b=0;b<3;b++){
  vector<Row>M;for(int id:{3*i+a,3*j+b})for(auto row:blocks[id])M.push_back(row);
  auto kv=kernel18(M);paircount++;
  if(kv.first!=18){lowpairs++;continue;}
  Row v=kv.second;
  // Independently check that the returned kernel satisfies every Hasse row.
  for(auto row:M){E val;for(int h=0;h<19;h++)val=val+row[h]*v[h];req(val.zero(),"pair kernel replay failed");}
  if(v[9].zero()){lowerpole++;continue;}
  E norm=inverse(v[9]);for(auto&c:v)c=c*norm;
  EP N=enorm(v),Rp=emul(EP{E()-us[i],E(1)},EP{E()-us[j],E(1)});
  auto qr=edivrem(N,epow(Rp,9));req(qr.second.empty(),"pair norm division failure");
  EP h=qr.first;req(h.size()==10&&h[9]==E(1),"pair residual norm degree failure");
  if(h[7]!=h[8]*h[8]){firstfailure++;continue;}
  EP target=epow(EP{E()-h[8],E(1)},9);
  if(h!=target){laterfailure++;continue;}
  success++;
 }
 cout<<"Pairs checked: "<<paircount<<"; rank<18: "<<lowpairs<<"; smaller pole: "<<lowerpole<<"; first ninth-power condition fails: "<<firstfailure<<"; later conditions fail: "<<laterfailure<<"; norm candidates: "<<success<<".\n";
 req(paircount==135&&lowpairs==0&&lowerpole==0&&firstfailure==135&&laterfailure==0&&success==0,"two-Weierstrass reduction FAILED");
 cout<<"PASS: every target divisor would contain at most ONE Weierstrass point.\n";

 }catch(const exception&e){cerr<<"FAIL: "<<e.what()<<"\n";return 1;}
}
