#pragma once
#include <array>
#include <vector>
#include <algorithm>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <chrono>
#include <string>
#include <functional>
#include <cassert>
#include <cstdint>
#include <cstring>
#include <random>
using namespace std;
static uint8_t ADD[25][25], SUB[25][25], MUL[25][25], NEG[25];
static constexpr int MOD[7]={4,21,6,5,9,8,20};
struct K {
 array<uint8_t,7> v{};
 K()=default; K(int a){v[0]=a;}
 bool zero()const {for(auto x:v)if(x)return false;return true;}
 bool operator==(const K&b)const{return v==b.v;}
 bool operator!=(const K&b)const{return v!=b.v;}
 K operator+(const K&b)const {K c;for(int i=0;i<7;i++)c.v[i]=ADD[v[i]][b.v[i]];return c;}
 K operator-(const K&b)const {K c;for(int i=0;i<7;i++)c.v[i]=SUB[v[i]][b.v[i]];return c;}
 K operator-()const {K c;for(int i=0;i<7;i++)c.v[i]=NEG[v[i]];return c;}
 K operator*(const K&b)const {
  uint8_t c[13]={};
  for(int i=0;i<7;i++)if(v[i])for(int j=0;j<7;j++)if(b.v[j])c[i+j]=ADD[c[i+j]][MUL[v[i]][b.v[j]]];
  for(int i=12;i>=7;i--)if(c[i])for(int j=0;j<7;j++)c[i-7+j]=SUB[c[i-7+j]][MUL[c[i]][MOD[j]]];
  K a;for(int i=0;i<7;i++)a.v[i]=c[i];return a;
 }
 K scale(int b)const{K c;for(int i=0;i<7;i++)c.v[i]=MUL[v[i]][b];return c;}
 K pow(uint64_t e)const {K a=*this,b(1);while(e){if(e&1)b=b*a;e>>=1;if(e)a=a*a;}return b;}
 K inv()const{if(zero())throw runtime_error("inverse of zero");return pow(6103515623ULL);}
 uint64_t code()const{uint64_t x=0;for(int i=6;i>=0;i--)x=25*x+v[i];return x;}
};
static array<K,29> ROOT;
static constexpr int MUC[8]={1,2,3,4,7,14,16,23};
using Poly=vector<K>;using Mat=vector<vector<K>>;
void init(){
 for(int a=0;a<25;a++){
  NEG[a]=((5-a%5)%5)+5*((5-a/5)%5);
  for(int b=0;b<25;b++){
   ADD[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
   SUB[a][b]=(a%5+5-b%5)%5+5*((a/5+5-b/5)%5);
   MUL[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
  }
 }
 K q;q.v[1]=1;ROOT[0]=K(1);for(int i=1;i<29;i++)ROOT[i]=ROOT[i-1]*q;
 if(ROOT[28]*q!=K(1))throw runtime_error("bad root");
 if(q.pow(6103515625ULL)!=q)throw runtime_error("bad field order");
 for(int x:MUC)if(K(x).pow(8)!=K(1))throw runtime_error("bad mu8");
}
Poly pmul(const Poly&A,const Poly&B){Poly C(A.size()+B.size()-1);for(size_t i=0;i<A.size();i++)for(size_t j=0;j<B.size();j++)C[i+j]=C[i+j]+A[i]*B[j];return C;}
Poly der(const Poly&A){Poly D;if(A.size()<2)return {K()};for(size_t i=1;i<A.size();i++)D.push_back(A[i].scale(i%5));return D;}
K eval(const Poly&A,K q){K b;for(auto i=A.rbegin();i!=A.rend();++i)b=b*q+*i;return b;}
Mat kernel(Mat A,int cols){
 int rows=A.size(),r=0;vector<int> ps;
 for(int j=0;j<cols&&r<rows;j++){
  int i=r;while(i<rows&&A[i][j].zero())i++;if(i==rows)continue;
  swap(A[i],A[r]);K z=A[r][j].inv();for(int l=j;l<cols;l++)A[r][l]=A[r][l]*z;
  for(i=0;i<rows;i++)if(i!=r&&!A[i][j].zero()){
   z=A[i][j];A[i][j]=K();for(int l=j+1;l<cols;l++)A[i][l]=A[i][l]-z*A[r][l];
  }
  ps.push_back(j);r++;
 }
 Mat B;
 for(int j=0;j<cols;j++)if(find(ps.begin(),ps.end(),j)==ps.end()){
  vector<K>b(cols);b[j]=K(1);for(int i=0;i<r;i++)b[ps[i]]=-A[i][j];B.push_back(b);
 }
 return B;
}
struct Spaces {Poly D;Mat W1,W2;};
Spaces spaces(const vector<int>&I){
 int d=I.size();Spaces S;S.D={K(1)};for(int i:I)S.D=pmul(S.D,{-ROOT[i],K(1)});
 Poly dp=der(S.D),ddp=der(dp);Mat M1,M2;
 for(int i:I){K q=ROOT[i],u=eval(dp,q),v=eval(ddp,q);vector<K> row1,row2;K powq(1),prev;
  for(int j=0;j<d+2;j++){
   row1.push_back((j?u.scale(2*j%5)*prev:K())-v*powq);
   row2.push_back((u.scale((2*j+1)%5)-q*v)*powq);
   prev=powq;powq=powq*q;
  }
  M1.push_back(row1);M2.push_back(row2);
 }
 S.W1=kernel(M1,d+2);S.W2=kernel(M2,d+2);return S;
}
K det3(const array<array<K,3>,3>&M){return M[0][0]*(M[1][1]*M[2][2]-M[1][2]*M[2][1])-M[0][1]*(M[1][0]*M[2][2]-M[1][2]*M[2][0])+M[0][2]*(M[1][0]*M[2][1]-M[1][1]*M[2][0]);}
array<K,4> cof(const array<array<K,4>,3>&M){array<K,4> v;for(int j=0;j<4;j++){array<array<K,3>,3>A;for(int i=0;i<3;i++){int l=0;for(int k=0;k<4;k++)if(k!=j)A[i][l++]=M[i][k];}v[j]=det3(A);if(j%2)v[j]=-v[j];}return v;}

// Independent partial-fraction basis. No polynomial derivative matrix is used.
static array<array<K,29>,29> CAUCHY;
void init_cauchy(){for(int i=0;i<29;i++)for(int j=0;j<29;j++)if(i!=j)CAUCHY[i][j]=(ROOT[i]-ROOT[j]).inv();}
struct EvalSpaces {
 vector<array<K,2>> first,second;
 array<K,2> lead1,lead2,constant1,constant2;
};
EvalSpaces polynomial_spaces(const vector<int>&I){
 auto S=spaces(I);if(S.W1.size()!=2||S.W2.size()!=2)throw runtime_error("residue-space dimension is not (2,2)");
 EvalSpaces E;
 for(int i:I){E.first.push_back({eval(S.W1[0],ROOT[i]),eval(S.W1[1],ROOT[i])});E.second.push_back({eval(S.W2[0],ROOT[i]),eval(S.W2[1],ROOT[i])});}
 for(int b=0;b<2;b++){E.lead1[b]=S.W1[b].back();E.lead2[b]=S.W2[b].back();E.constant1[b]=S.W1[b][0];E.constant2[b]=S.W2[b][0];}
 return E;
}
EvalSpaces fraction_spaces(const vector<int>&I){
 const int d=I.size();Mat M1,M2;
 for(int i:I){vector<K>a,b;for(int j:I){a.push_back(CAUCHY[i][j]);b.push_back(CAUCHY[i][j]);}a.push_back(K(1));a.push_back(ROOT[i]);b.push_back(ROOT[(58-2*i)%29]);b.push_back(ROOT[(29-i)%29]);M1.push_back(a);M2.push_back(b);}
 Mat W1=kernel(M1,d+2),W2=kernel(M2,d+2);
 if(W1.size()!=2||W2.size()!=2)throw runtime_error("partial-fraction space dimension is not (2,2)");
 EvalSpaces E;K D0(1);for(int i:I)D0=D0*(-ROOT[i]);
 for(int j=0;j<d;j++){
  K dp(1);for(int l=0;l<d;l++)if(l!=j)dp=dp*(ROOT[I[j]]-ROOT[I[l]]);
  K q2=ROOT[2*I[j]%29];E.first.push_back({dp*W1[0][j],dp*W1[1][j]});E.second.push_back({q2*dp*W2[0][j],q2*dp*W2[1][j]});
 }
 for(int b=0;b<2;b++){
  E.lead1[b]=W1[b][d+1];K sumt,sumr;
  for(int j=0;j<d;j++){sumt=sumt+W2[b][j];sumr=sumr+W1[b][j]*ROOT[(29-I[j])%29];}
  E.lead2[b]=W2[b][d+1]+sumt;E.constant1[b]=D0*(W1[b][d]-sumr);E.constant2[b]=D0*W2[b][d];
 }
 return E;
}
