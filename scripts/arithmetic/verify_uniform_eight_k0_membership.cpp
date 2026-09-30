// Independent relative-F25 verification of uniform eight-label K0 membership.
// The producer uses Sage's absolute degree14 field and polynomial arithmetic.
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
#include <set>
#include <vector>
#include "sextic_paired_data.hpp"
using V=std::array<int,7>;using Packet=std::array<int,4>;
constexpr uint64_t field_order=6103515625ULL;
int mod[7]={4,22,7,20,21,7,24};
V add(const V&a,const V&b){V r;for(int i=0;i<7;++i)r[i]=add25[a[i]][b[i]];return r;}
V scale(const V&a,int c){V r;for(int i=0;i<7;++i)r[i]=mul25[a[i]][c];return r;}
V product(const V&a,const V&b){int c[13]={};
 for(int i=0;i<7;++i)for(int j=0;j<7;++j)c[i+j]=add25[c[i+j]][mul25[a[i]][b[j]]];
 for(int i=12;i>=7;--i)for(int j=0;j<7;++j)c[i-7+j]=add25[c[i-7+j]][neg25[mul25[c[i]][mod[j]]]];
 V r;for(int i=0;i<7;++i)r[i]=c[i];return r;}
V power(V a,uint64_t n){V r{};r[0]=1;while(n){if(n&1)r=product(r,a);n>>=1;if(n)a=product(a,a);}return r;}
bool nz(const V&a){for(int x:a)if(x)return true;return false;}
uint64_t encode(const V&a){uint64_t r=0;for(int i=6;i>=0;--i)r=25*r+a[i];return r;}
V decode(uint64_t a){V r;for(int&i:r){i=a%25;a/=25;}assert(!a);return r;}
std::vector<Packet> packets,seq;
uint64_t tested=0,free_count=0,finite=0,halfturn=0,nonhalfturn=0;
std::set<uint64_t> classes;
int general_mass=0;
int ph[4];
void check(){
 ++tested;V s[2][2]{};
 for(size_t j=0;j<seq.size();++j){int weight[2]={0,0},p1=1,p2=1;
  for(int i=0;i<4;++i){weight[0]=(weight[0]+p1*seq[j][i])%5;weight[1]=(weight[1]+p2*seq[j][i])%5;p1=p1*2%5;p2=p2*4%5;}
  for(int l=0;l<2;++l)for(int e=0;e<2;++e){V v;for(int k=0;k<7;++k)v[k]=phase[((e?4:17)*ph[j])%29][k];s[l][e]=add(s[l][e],scale(v,weight[l]));}
 }
 V lam{};bool chosen=false;
 for(int l=0;l<2;++l){V rhs=scale(s[l][1],l?18:10);
  if(!nz(s[l][0])){if(nz(rhs))return;continue;}
  if(!chosen){lam=product(rhs,power(s[l][0],field_order-2));chosen=true;}
  else if(product(lam,s[l][0])!=rhs)return;
 }
 if(!chosen){++free_count;for(auto v:seq)assert(v[0]%5==v[1]%5&&v[1]%5==v[2]%5&&v[2]%5==v[3]%5);return;}
 assert(nz(lam));++finite;bool ht=true;for(auto v:seq)ht=ht&&v[0]==v[2]&&v[1]==v[3];halfturn+=ht;nonhalfturn+=!ht;
 classes.insert(encode(power(lam,29)));
}
void phases(int i,int first){if(i==(int)seq.size()){check();return;}for(int j=first;j<=29-((int)seq.size()-i);++j){ph[i]=j;phases(i+1,j+1);}}
void partition(Packet remaining){
 if(remaining==Packet{}){ph[0]=0;phases(1,1);return;}
 for(auto p:packets){Packet r;bool ok=true;for(int i=0;i<4;++i){r[i]=remaining[i]-p[i];ok=ok&&r[i]>=0;}
  if(ok){seq.push_back(p);partition(r);seq.pop_back();}}
}
void mass_partition(int remaining){
 if(!remaining){assert(seq.size()<=4);ph[0]=0;phases(1,1);return;}
 for(auto p:packets){int size=0;for(int v:p)size+=v;if(size<=remaining){seq.push_back(p);mass_partition(remaining-size);seq.pop_back();}}
}
int main(int argc,char**argv){
 general_mass=argc>1?std::stoi(argv[1]):0;assert(!general_mass||general_mass==8||general_mass==9);
 int cap=general_mass?general_mass:2;
 for(int a=0;a<=cap;++a)for(int b=0;b<=cap;++b)for(int c=0;c<=cap;++c)for(int d=0;d<=cap;++d)
  if(a+b+c+d&&(!general_mass||a+b+c+d<=general_mass)&&(a+3*b+4*c+2*d)%5==0)packets.push_back({a,b,c,d});
 if(general_mass)mass_partition(general_mass);else{assert(packets.size()==16);partition({2,2,2,2});}
 uint64_t inverse=0;
 for(auto k:classes)inverse+=classes.count(encode(power(decode(k),field_order-2)));
 if(!general_mass)assert(tested==29149&&free_count==29&&finite==24360&&halfturn==24360&&nonhalfturn==0&&classes.size()==2849&&inverse==0);
 else assert(tested==(general_mass==8?126341:635980));
 std::cout<<"PASS mass "<<general_mass<<" tested "<<tested<<" free_balanced "<<free_count<<" finite "<<finite<<" halfturn "<<halfturn<<" nonhalfturn "<<nonhalfturn<<" scalar_classes "<<classes.size()<<" reciprocal_classes "<<inverse<<std::endl;
}
