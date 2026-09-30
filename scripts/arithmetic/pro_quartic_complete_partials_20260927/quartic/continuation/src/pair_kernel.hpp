#pragma once
#include "../../src/fast_field.hpp"
#include <chrono>
#include <fstream>
#include <sstream>
#include <set>
#include <map>
using namespace exact;
using IX=std::array<int,4>;
using V4=std::array<int,4>;
struct Affine {bool consistent=true;int rank=0;V4 p{};std::vector<V4> null;};
inline int coord(const F& f,int i){return i%2?f.c[i/2].b:f.c[i/2].a;}
Affine solve(const std::array<F,4>&cols,const F&constant){
 int a[7][5];for(int i=0;i<7;++i){for(int j=0;j<4;++j)a[i][j]=coord(cols[j],i+1);a[i][4]=neg(coord(constant,i+1));}
 std::array<int,4> piv{};piv.fill(-1);int rank=0;
 for(int j=0;j<4;++j){
  int ii=rank;while(ii<7&&!a[ii][j])++ii;if(ii==7)continue;
  for(int k=0;k<5;++k)std::swap(a[rank][k],a[ii][k]);
  int v=inv(a[rank][j]);for(int k=j;k<5;++k)a[rank][k]=mul(a[rank][k],v);
  for(int i=0;i<7;++i)if(i!=rank&&a[i][j]){int v=a[i][j];for(int k=j;k<5;++k)a[i][k]=sub(a[i][k],mul(v,a[rank][k]));}
  piv[j]=rank++;
 }
 Affine out;out.rank=rank;
 for(int i=rank;i<7;++i)if(a[i][4]){out.consistent=false;return out;}
 for(int j=0;j<4;++j)if(piv[j]>=0)out.p[j]=a[piv[j]][4];
 for(int j=0;j<4;++j)if(piv[j]<0){V4 n{};n[j]=1;for(int k=0;k<4;++k)if(piv[k]>=0)n[k]=neg(a[piv[k]][j]);out.null.push_back(n);}
 return out;
}
int quadratic(V4 v,const std::array<F,4>&cols,const F&constant){
 int r=coord(constant,0);for(int i=0;i<4;++i)r=add(r,mul(coord(cols[i],0),v[i]));
 K x(v[0],v[1]),y(v[2],v[3]);return add(r,sub(x.norm(),y.norm()));
}
uint32_t pack(IX ix){uint32_t p=0;for(int i=0;i<4;++i)p|=uint32_t(ix[i])<<(7*i);return p;}
IX unpack(uint32_t p){IX r;for(int&i:r){i=p&127;p>>=7;}return r;}
IX canonical(IX ix){
 IX best={116,116,116,116};int frob=1;
 for(int t=0;t<7;++t){for(int anchor:ix){IX im;for(int v=0;v<4;++v){int phase=(frob*((ix[v]/4-anchor/4+29)%29))%29;int ty=(ix[v]%4-anchor%4+4)%4;im[v]=4*phase+ty;}std::sort(im.begin(),im.end());if(im<best)best=im;}frob=frob*25%29;}
 return best;
}
struct EP{F C,E;};
inline EP ep(IX ix){EP r;for(int v:ix){r.C=r.C+labels[v][0];r.E=r.E+labels[v][1];}return r;}
void pv(V4 v){std::cout<<'[';for(int i=0;i<4;++i){if(i)std::cout<<',';std::cout<<v[i];}std::cout<<']';}
