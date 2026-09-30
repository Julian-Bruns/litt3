#pragma once
#include <vector>
#include <cstdint>
#include <stdexcept>
#include <fstream>
#include <iostream>
namespace ff {
using E=uint32_t; const E SIZE=390625, ORDER=390624;
inline uint16_t a625[625*625]; inline E negs[SIZE], logs[SIZE], exps[2*ORDER];
inline E a25(E a,E b){return (a%5+b%5)%5+5*((a/5+b/5)%5);}
inline E n25(E a){return (5-a%5)%5+5*((5-a/5)%5);}
inline E m25(E a,E b){E A=a%5,B=a/5,C=b%5,D=b/5;return (A*C+3*B*D)%5+5*((A*D+B*C+B*D)%5);}
inline E rawadd(E a,E b){E r=0,t=1;for(int i=0;i<4;i++,t*=25,a/=25,b/=25)r+=t*a25(a%25,b%25);return r;}
inline E rawmul(E a,E b){E v[7]={0}, aa[4],bb[4];for(int i=0;i<4;i++,a/=25,b/=25){aa[i]=a%25;bb[i]=b%25;}
for(int i=0;i<4;i++)for(int j=0;j<4;j++)v[i+j]=a25(v[i+j],m25(aa[i],bb[j]));
const E mod[4]={5,2,6,7}; for(int i=6;i>=4;i--)for(int j=0;j<4;j++)v[i-4+j]=a25(v[i-4+j],n25(m25(v[i],mod[j])));
E r=0,t=1;for(int i=0;i<4;i++,t*=25)r+=t*v[i];return r;}
inline E rawpow(E a,uint64_t n){E r=1;while(n){if(n&1)r=rawmul(r,a);a=rawmul(a,a);n>>=1;}return r;}
inline E add(E a,E b){return a625[(a%625)*625+b%625]+625u*a625[(a/625)*625+b/625];}
inline E neg(E a){return negs[a];} inline E sub(E a,E b){return add(a,negs[b]);}
inline E mul(E a,E b){return (!a||!b)?0:exps[logs[a]+logs[b]];}
inline E inv(E a){if(!a)throw std::runtime_error("division by zero");return exps[ORDER-logs[a]];}
inline E div(E a,E b){return mul(a,inv(b));}
inline E pow(E a,uint64_t n){if(n==0)return 1;if(!a)return 0;return exps[(uint64_t(logs[a])*n)%ORDER];}
inline E init(){
for(E a=0;a<625;a++)for(E b=0;b<625;b++)a625[a*625+b]=a25(a%25,b%25)+25*a25(a/25,b/25);
for(E a=0;a<SIZE;a++){E b=a,r=0,t=1;for(int i=0;i<4;i++,t*=25,b/=25)r+=t*n25(b%25);negs[a]=r;logs[a]=SIZE;}
std::vector<E> fac;E m=ORDER;for(E p=2;p*p<=m;p++)if(m%p==0){fac.push_back(p);while(m%p==0)m/=p;}if(m>1)fac.push_back(m);
E gen=2;for(;gen<SIZE;gen++){bool ok=true;for(E p:fac)if(rawpow(gen,ORDER/p)==1)ok=false;if(ok&&rawpow(gen,ORDER)==1)break;}if(gen==SIZE)throw std::runtime_error("no generator");
E a=1;for(E i=0;i<ORDER;i++){if(logs[a]!=SIZE)throw std::runtime_error("field cycle");logs[a]=i;exps[i]=a;a=rawmul(a,gen);}if(a!=1)throw std::runtime_error("bad field order");for(E i=0;i<ORDER;i++)exps[ORDER+i]=exps[i];return gen;
}
}
