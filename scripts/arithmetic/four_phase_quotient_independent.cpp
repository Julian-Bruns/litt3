// Exhaust all prime-field weighted sums on at most four distinct phases.
// Test the quotient of exponent4 and exponent17 sums in TWO arithmetic
// models: seven F25 coordinates, and fourteen F5 coordinates.
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
#include "sextic_paired_data.hpp"
using V=std::array<int,14>;using W=std::array<int,7>;
V absph[29],beta_abs[29];int poly[14]={1,2,4,0,4,4,3,1,3,4,4,0,4,2};
int neg(int v){return v?5-v:0;}
V multiply(const V&a,const V&b){std::array<int,27> c{};
 for(int i=0;i<14;++i)for(int j=0;j<14;++j)c[i+j]=(c[i+j]+a[i]*b[j])%5;
 for(int i=26;i>=14;--i)for(int j=0;j<14;++j)c[i-14+j]=(c[i-14+j]+25-c[i]*poly[j])%5;
 V r;for(int i=0;i<14;++i)r[i]=c[i];return r;
}
uint64_t tested[5]={},accepted[5]={};int support[4],coeff[4];
void check(int n){
 W X{},Y{};V xa{},ya{},za{};
 for(int i=0;i<n;++i){int j=support[i],c=coeff[i];
  for(int k=0;k<7;++k){X[k]=add25[X[k]][mul25[c][phase[17*j%29][k]]];Y[k]=add25[Y[k]][mul25[c][phase[4*j%29][k]]];}
  for(int k=0;k<14;++k){xa[k]=(xa[k]+c*absph[17*j%29][k])%5;ya[k]=(ya[k]+c*absph[4*j%29][k])%5;za[k]=(za[k]+c*beta_abs[17*j%29][k])%5;}
 }
 ++tested[n];int p=0;while(p<7&&!X[p])++p;assert(p<7);
 int inv=1;while(mul25[inv][X[p]]!=1)++inv;int lambda=mul25[Y[p]][inv];bool rel=true;
 for(int k=0;k<7;++k)rel=rel&&mul25[lambda][X[k]]==Y[k];
 const int inv5[5]={0,1,3,2,4};int a=0;while(a<14&&!xa[a])++a;assert(a<14);
 int b=0,det=0;for(;b<14;++b){det=(xa[a]*za[b]+25-xa[b]*za[a])%5;if(det)break;}assert(b<14);
 int u=(ya[a]*za[b]+25-ya[b]*za[a])*inv5[det]%5;
 int v=(xa[a]*ya[b]+25-xa[b]*ya[a])*inv5[det]%5;bool absolute=true;
 for(int k=0;k<14;++k)absolute=absolute&&((u*xa[k]+v*za[k])%5==ya[k]);
 assert(rel==absolute);if(rel){assert(lambda==u+5*v);++accepted[n];assert(n==1&&support[0]==0&&lambda==1);}
}
void weights(int n,int i){if(i==n){check(n);return;}for(int c=1;c<5;++c){coeff[i]=c;weights(n,i+1);}}
void sets(int n,int i,int first){if(i==n){coeff[0]=1;weights(n,1);return;}for(int j=first;j<=29-(n-i);++j){support[i]=j;sets(n,i+1,j+1);}}
int main(){
 absph[0][0]=1;for(int i=1;i<29;++i)for(int j=0;j<14;++j)absph[i][j]=((j?absph[i-1][j-1]:0)+25-absph[i-1][13]*poly[j])%5;
 V beta={1,1,0,0,4,3,3,1,1,3,1,2,1,1};for(int i=0;i<29;++i)beta_abs[i]=multiply(beta,absph[i]);
 for(int n=1;n<=4;++n){sets(n,0,0);std::cout<<"PASS support "<<n<<" weighted_sums "<<tested[n]<<" quotient_in_F25 "<<accepted[n]<<'\n';}
 assert(tested[1]==29&&tested[2]==1624&&tested[3]==58464&&tested[4]==1520064);
}
