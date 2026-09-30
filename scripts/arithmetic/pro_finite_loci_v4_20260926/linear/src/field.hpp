#pragma once
#include <bits/stdc++.h>
namespace kfield {
constexpr int ORDER=390625, N=ORDER-1;
inline std::vector<int> lg,ex,neg;
inline std::vector<int> add625;
inline int a25[25][25],m25[25][25];
inline int slowadd(int a,int b){int s=0,q=1;while(a||b){s+=((a%5+b%5)%5)*q;a/=5;b/=5;q*=5;}return s;}
inline int slowneg(int a){int s=0,q=1;while(a){s+=((5-a%5)%5)*q;a/=5;q*=5;}return s;}
inline int slowmul(int a,int b){
 int aa[4],bb[4],c[7]={0};for(int i=0;i<4;i++){aa[i]=a%25;bb[i]=b%25;a/=25;b/=25;}
 for(int i=0;i<4;i++)for(int j=0;j<4;j++)c[i+j]=a25[c[i+j]][m25[aa[i]][bb[j]]];
 const int mod[4]={5,2,6,7};
 for(int i=6;i>=4;i--)for(int j=0;j<4;j++)c[i-4+j]=a25[c[i-4+j]][slowneg(m25[c[i]][mod[j]])];
 int v=0;for(int i=3;i>=0;i--)v=25*v+c[i];return v;
}
inline int slowpow(int a,int n){int v=1;while(n){if(n&1)v=slowmul(v,a);a=slowmul(a,a);n>>=1;}return v;}
inline int primitive;
inline void init(){
 if(!lg.empty())return;
 for(int a=0;a<25;a++)for(int b=0;b<25;b++){
  a25[a][b]=slowadd(a,b);int aa=a%5,ab=a/5,ba=b%5,bb=b/5;
  m25[a][b]=(aa*ba+3*ab*bb)%5+5*((aa*bb+ab*ba+ab*bb)%5);
 }
 for(primitive=2;primitive<ORDER;primitive++){
  bool ok=slowpow(primitive,N)==1;for(int p:{2,3,13,313})if(slowpow(primitive,N/p)==1)ok=false;
  if(ok)break;
 }
 if(primitive==ORDER)throw std::runtime_error("field primitive not found");
 lg.assign(ORDER,-1);ex.resize(2*N);neg.resize(ORDER);int a=1;
 for(int i=0;i<N;i++){if(lg[a]!=-1)throw std::runtime_error("nonprimitive element");lg[a]=i;ex[i]=a;a=slowmul(a,primitive);}
 if(a!=1)throw std::runtime_error("wrong field size");
 for(int i=0;i<N;i++)ex[i+N]=ex[i];
 for(int i=0;i<ORDER;i++)neg[i]=slowneg(i);
 add625.resize(625*625);for(int i=0;i<625;i++)for(int j=0;j<625;j++)add625[i*625+j]=slowadd(i,j);
}
inline int add(int a,int b){return add625[(a%625)*625+b%625]+625*add625[(a/625)*625+b/625];}
inline int mul(int a,int b){return (!a||!b)?0:ex[lg[a]+lg[b]];}
struct F {
 int v=0;
 F()=default;
 F(long long a){v=int((a%5+5)%5);}
 static F code(int a){if(a<0||a>=ORDER)throw std::runtime_error("invalid field code");F t;t.v=a;return t;}
 explicit operator bool()const{return v!=0;}
 F operator-()const{return code(neg[v]);}
 F operator+(F b)const{return code(add(v,b.v));}
 F operator-(F b)const{return code(add(v,neg[b.v]));}
 F operator*(F b)const{return code(mul(v,b.v));}
 F inv()const{if(!v)throw std::runtime_error("division by zero");return code(ex[N-lg[v]]);}
 F operator/(F b)const{return (*this)*b.inv();}
 F& operator+=(F b){v=add(v,b.v);return *this;}
 F& operator-=(F b){v=add(v,neg[b.v]);return *this;}
 F& operator*=(F b){v=mul(v,b.v);return *this;}
 F& operator/=(F b){return *this*=b.inv();}
 bool operator==(F b)const{return v==b.v;}
 bool operator!=(F b)const{return v!=b.v;}
 F pow(long long n)const{if(n<0)return inv().pow(-n);if(!n)return F(1);if(!v)return F(0);return code(ex[(static_cast<long long>(lg[v])*n)%N]);}
};
inline std::ostream& operator<<(std::ostream& os,F a){return os<<a.v;}
}
