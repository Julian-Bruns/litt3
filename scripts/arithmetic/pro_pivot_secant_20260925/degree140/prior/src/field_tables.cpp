#include <array>
#include <vector>
#include <fstream>
#include <iostream>
#include <cstdint>
#include <stdexcept>
using namespace std;
constexpr int SIZE=390625, ORDER=SIZE-1;
int add25[25][25],mul25[25][25];
int slowmul(int x,int y){int a[4],b[4],c[7]={};for(int i=0;i<4;i++){a[i]=x%25;x/=25;b[i]=y%25;y/=25;}
 for(int i=0;i<4;i++)for(int j=0;j<4;j++)c[i+j]=add25[c[i+j]][mul25[a[i]][b[j]]];
 int mod[4]={5,2,6,7};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)c[i-4+j]=add25[c[i-4+j]][mul25[c[i]][mul25[4][mod[j]]]];
 int z=0;for(int i=3;i>=0;i--)z=z*25+c[i];return z;}
int power(int a,int n){int r=1;for(;n;n>>=1,a=slowmul(a,a))if(n&1)r=slowmul(r,a);return r;}
int main(int argc,char**argv){if(argc!=2)throw runtime_error("output file required");
 for(int a=0;a<25;a++)for(int b=0;b<25;b++){add25[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);mul25[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}
 vector<int> primes;int n=ORDER;for(int p=2;p*p<=n;p++)if(n%p==0){primes.push_back(p);while(n%p==0)n/=p;}if(n>1)primes.push_back(n);
 int primitive=0;for(int a=2;a<SIZE;a++){bool ok=power(a,ORDER)==1;for(int p:primes)if(power(a,ORDER/p)==1)ok=false;if(ok){primitive=a;break;}}
 if(!primitive)throw runtime_error("not a finite field");
 vector<int32_t> logs(SIZE,-1),exps(ORDER);int a=1;for(int i=0;i<ORDER;i++){if(logs[a]!=-1)throw runtime_error("cycle not primitive");logs[a]=i;exps[i]=a;a=slowmul(a,primitive);}if(a!=1)throw runtime_error("cycle");
 ofstream out(argv[1],ios::binary);int32_t head[3]={SIZE,ORDER,primitive};auto put32=[&](int32_t v){uint32_t u=static_cast<uint32_t>(v);for(int j=0;j<4;j++)out.put(static_cast<char>((u>>(8*j))&255));};for(auto v:head)put32(v);for(auto v:logs)put32(v);for(auto v:exps)put32(v);
 cout<<"Finite field size "<<SIZE<<", primitive encoded element "<<primitive<<"; all nonzero elements in one multiplicative cycle.\n";
}
