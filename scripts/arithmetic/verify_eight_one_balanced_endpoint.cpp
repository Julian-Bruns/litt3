// Independent relative-F25 verification; producer uses absolute F5 degree14.
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
#include <set>
#include <vector>
#include "sextic_paired_data.hpp"
using V=std::array<int,7>;
constexpr uint64_t order=6103515625ULL;
const int modulus[7]={4,22,7,20,21,7,24};
V add(V a,const V&b){for(int i=0;i<7;++i)a[i]=add25[a[i]][b[i]];return a;}
V scale(V a,int c){for(int&i:a)i=mul25[i][c];return a;}
V sub(const V&a,const V&b){return add(a,scale(b,4));}
V mul(const V&a,const V&b){int p[13]={};
 for(int i=0;i<7;++i)for(int j=0;j<7;++j)p[i+j]=add25[p[i+j]][mul25[a[i]][b[j]]];
 for(int i=12;i>=7;--i)for(int j=0;j<7;++j)p[i-7+j]=add25[p[i-7+j]][neg25[mul25[p[i]][modulus[j]]]];
 V r;for(int i=0;i<7;++i)r[i]=p[i];return r;}
V power(V a,uint64_t n){V r{};r[0]=1;while(n){if(n&1)r=mul(r,a);n>>=1;if(n)a=mul(a,a);}return r;}
bool nz(const V&a){for(int c:a)if(c)return true;return false;}
uint64_t encode(const V&a){uint64_t k=0;for(int i=6;i>=0;--i)k=25*k+a[i];return k;}
V ph(int j){V r;for(int i=0;i<7;++i)r[i]=phase[j%29][i];return r;}
using E=std::array<int,4>;
E eadd(E a,const E&b){for(int i=0;i<4;++i)a[i]=add25[a[i]][b[i]];return a;}
E escale(E a,int c){for(int&i:a)i=mul25[i][c];return a;}
E emul(const E&a,const E&b){int p[7]={};int mod[4]={5,2,6,7};
 for(int i=0;i<4;++i)for(int j=0;j<4;++j)p[i+j]=add25[p[i+j]][mul25[a[i]][b[j]]];
 for(int i=6;i>=4;--i)for(int j=0;j<4;++j)p[i-4+j]=add25[p[i-4+j]][neg25[mul25[p[i]][mod[j]]]];
 return {p[0],p[1],p[2],p[3]};}
E epower(E a,int n){E r{1,0,0,0};while(n){if(n&1)r=emul(r,a);n>>=1;if(n)a=emul(a,a);}return r;}
void fixed_fourier(){
 const int rows[4][4]={{22,7,9,23},{1,3,8,15},{20,12,13,8},{21,21,20,2}};
 E roots[4];roots[0]={0,1,0,0};for(int i=1;i<4;++i)roots[i]=epower(roots[i-1],25);
 assert(epower(roots[3],25)==roots[0]);
 E coef[4][4]{};
 for(int p=0;p<4;++p)for(int l=0;l<4;++l)for(int i=0;i<4;++i){
  E val{};for(int j=3;j>=0;--j)val=eadd(emul(val,roots[i]),E{rows[p][j],0,0,0});
  int w=1;for(int j=0;j<((4-l)*i)%4;++j)w=w*2%5;
  coef[p][l]=eadd(coef[p][l],escale(val,4*w%5));}
 E zero{};for(int l=1;l<4;++l){assert(coef[0][l]!=zero&&coef[2][l]!=zero);}
 assert(coef[1][1]!=zero&&coef[1][2]!=zero&&coef[3][1]!=zero&&coef[3][2]!=zero);
 assert(coef[1][3]==zero&&coef[3][3]==zero);
 assert(coef[1][2]==escale(coef[0][2],12));
 assert(escale(emul(coef[0][2],coef[3][1]),4)==escale(emul(coef[0][1],coef[3][2]),11));
 const int constants[4]={20,8,12,4};for(int i=0;i<4;++i)assert((coef[i][0]==E{constants[i],0,0,0}));
 assert(mul25[mul25[11][11]][11]==1&&11!=1);
 std::cout<<"PASS independent quartic Fourier identities; norm constant [11]"<<std::endl;
}
int main(){
 fixed_fourier();
 int inveta=0;while(mul25[22][inveta]!=1)++inveta;
 std::vector<std::array<V,4>> sums;
 for(int i=0;i<29;++i)for(int j=i;j<29;++j){std::array<V,4>s;
  int ex[4]={4,5,8,17};for(int k=0;k<4;++k)s[k]=add(ph(ex[k]*i),ph(ex[k]*j));sums.push_back(s);}
 assert(sums.size()==435);std::set<uint64_t> targets;
 for(auto&s:sums){V C=scale(s[1],mul25[4][20]),E=scale(s[2],mul25[4][8]);
  V U=scale(s[3],mul25[4][12]),W=scale(s[0],1);
  V X=power(scale(U,inveta),9765625ULL); // 5^10
  V Y=power(scale(W,mul25[4][inveta]),15625ULL); // 5^6
  assert(power(X,625)==scale(U,inveta));assert(power(Y,390625)==scale(W,mul25[4][inveta]));
  V A=sub(E,scale(power(X,78125),22)),B=sub(C,scale(Y,22));assert(nz(A)&&nz(B));
  targets.insert(encode(mul(B,power(A,order-2))));}
 assert(targets.size()==435);uint64_t tested=0,hits=0;
 for(size_t i=0;i<sums.size();++i)for(size_t j=0;j<sums.size();++j){++tested;if(i==j)continue;
  V C=sub(sums[i][1],sums[j][1]),E=scale(sub(sums[i][2],sums[j][2]),12);assert(nz(C));
  hits+=targets.count(encode(mul(E,power(C,order-2))));}
 assert(tested==189225&&hits==0);
 std::cout<<"PASS balanced_pairs 435 target_classes 435 halfturn_pairs "<<tested<<" ratio_hits "<<hits<<std::endl;
}
