// Exact necessary endpoint matching for sigma^2(epsilon)=-epsilon.
// Neither moments nor scalars are sampled. Output is a candidate list,
// NOT a proof of the four equations or an actual curve realization.
#include <algorithm>
#include <array>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using E=std::array<unsigned char,7>;
unsigned char add25[25][25],mul25[25][25],neg25[25];
constexpr int mod[7]={4,22,7,20,21,7,24};
E add(const E&a,const E&b){E r{};for(int i=0;i<7;++i)r[i]=add25[a[i]][b[i]];return r;}
E scale(const E&a,int b){E r{};for(int i=0;i<7;++i)r[i]=mul25[a[i]][b];return r;}
E mul(const E&a,const E&b){
 unsigned char t[13]={};
 for(int i=0;i<7;++i)for(int j=0;j<7;++j)t[i+j]=add25[t[i+j]][mul25[a[i]][b[j]]];
 for(int i=12;i>=7;--i)for(int j=0;j<7;++j)t[i-7+j]=add25[t[i-7+j]][mul25[neg25[t[i]]][mod[j]]];
 E r{};for(int i=0;i<7;++i)r[i]=t[i];return r;
}
bool zero(const E&a){return a==E{};}
E power(E a,uint64_t n){E r{};r[0]=1;while(n){if(n&1)r=mul(r,a);n>>=1;if(n)a=mul(a,a);}return r;}
uint64_t code(const E&a){uint64_t n=0;for(int i=6;i>=0;--i)n=25*n+a[i];return n;}
uint32_t pack(int a,int b,int c,int d){return a|(b<<7)|(c<<14)|(d<<21);}
std::array<int,4> unpack(uint32_t p){return {int(p&127),int((p>>7)&127),int((p>>14)&127),int((p>>21)&127)};}
struct Sums { E t24,t28,t45,t417; };
Sums add(const Sums&a,const Sums&b){return {add(a.t24,b.t24),add(a.t28,b.t28),add(a.t45,b.t45),add(a.t417,b.t417)};}
struct Indexed { uint64_t key;uint32_t labels; };
struct Query { uint32_t labels;Sums sums;E prefix; };

int main(int argc,char**argv){
 assert(argc==2);std::string prefix=argv[1];
 auto begin=std::chrono::steady_clock::now();
 for(int a=0;a<25;++a){neg25[a]=(5-a%5)%5+5*((5-a/5)%5);
  for(int b=0;b<25;++b){add25[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
   mul25[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}}
 E one{};one[0]=1;E z{};z[1]=1;E powers[30];powers[0]=one;
 for(int j=1;j<=29;++j)powers[j]=mul(powers[j-1],z);
 assert(powers[29]==one);for(int j=1;j<29;++j)assert(powers[j]!=one);
 Sums labels[116];int two[4]={1,2,4,3};
 for(int i=0;i<4;++i)for(int j=0;j<29;++j){int s=i%2?4:1;
  labels[29*i+j]={scale(powers[4*j%29],two[i]),scale(powers[8*j%29],two[i]),
                 scale(powers[5*j%29],s),scale(powers[17*j%29],s)};}
 std::vector<Indexed> index;index.reserve(7940751);
 uint64_t all_h=0,zero_h=0;
 for(int a=0;a<116;++a)for(int b=a;b<116;++b){Sums ab=add(labels[a],labels[b]);
  for(int c=b;c<116;++c){Sums abc=add(ab,labels[c]);
   for(int d=c;d<116;++d){++all_h;Sums h=add(abc,labels[d]);
    assert(zero(h.t24)==zero(h.t28));assert(zero(h.t45)==zero(h.t417));
    if(zero(h.t28)||zero(h.t417)){++zero_h;continue;}
    index.push_back({code(h.t28),pack(a,b,c,d)});}}}
 assert(all_h==7940751);
 std::sort(index.begin(),index.end(),[](auto&a,auto&b){return a.key<b.key||(a.key==b.key&&a.labels<b.labels);});
 std::cout<<"H indexed "<<index.size()<<" excluded character-zero "<<zero_h<<std::endl;
 std::vector<Query> queries;queries.reserve(266916);E prod=one;uint64_t all_q=0,zero_q=0;
 for(int a=0;a<116;++a){Sums ab=add(labels[0],labels[a]);
  for(int b=a;b<116;++b){Sums abc=add(ab,labels[b]);
   for(int c=b;c<116;++c){++all_q;Sums q=add(abc,labels[c]);
    if(zero(q.t28)||zero(q.t417)){++zero_q;continue;}
    queries.push_back({pack(0,a,b,c),q,prod});prod=mul(prod,q.t417);}}}
 assert(all_q==266916);E inv=power(prod,6103515623ULL);assert(mul(inv,prod)==one);
 std::ofstream out(prefix+".pairs.tsv");assert(out);out<<"q0\tq1\tq2\tq3\th0\th1\th2\th3\n";
 uint64_t first=0,second=0,queries_done=0;unsigned maxbucket=0;
 for(auto it=queries.rbegin();it!=queries.rend();++it){
  auto&q=it->sums;E deninv=mul(inv,it->prefix);inv=mul(inv,q.t417);assert(mul(deninv,q.t417)==one);
  E target=scale(mul(mul(q.t24,q.t45),deninv),4);uint64_t key=code(target);
  auto lo=std::lower_bound(index.begin(),index.end(),key,[](auto&a,uint64_t k){return a.key<k;});
  unsigned bucket=0;
  for(auto jt=lo;jt!=index.end()&&jt->key==key;++jt){++first;++bucket;
   auto ids=unpack(jt->labels);Sums h=add(add(labels[ids[0]],labels[ids[1]]),add(labels[ids[2]],labels[ids[3]]));
   assert(add(mul(h.t28,q.t417),mul(q.t24,q.t45))==E{});
   if(!zero(add(mul(q.t28,h.t417),mul(h.t24,h.t45))))continue;
   ++second;auto qs=unpack(it->labels);
   for(int id:qs)out<<id<<'\t';out<<ids[0]<<'\t'<<ids[1]<<'\t'<<ids[2]<<'\t'<<ids[3]<<'\n';
  }
  maxbucket=std::max(maxbucket,bucket);++queries_done;
 }
 assert(inv==one);out.close();
 auto seconds=std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count();
 std::ofstream summary(prefix+".json");assert(summary);
 summary<<"{\n  \"status\":\"COMPLETE\",\n  \"scope\":\"necessary two-endpoint matching for trace-zero quartic scalar; full equations not tested\",\n"
 <<"  \"all_H\":"<<all_h<<",\n  \"character_zero_H\":"<<zero_h<<",\n  \"indexed_H\":"<<index.size()<<",\n"
 <<"  \"all_normalized_Q\":"<<all_q<<",\n  \"character_zero_Q\":"<<zero_q<<",\n  \"queries\":"<<queries_done<<",\n"
 <<"  \"first_matches\":"<<first<<",\n  \"both_matches\":"<<second<<",\n  \"largest_bucket\":"<<maxbucket<<",\n  \"elapsed_seconds\":"<<seconds<<"\n}\n";
 std::cout<<"Q queries "<<queries_done<<" first matches "<<first<<" both "<<second<<" maximum bucket "<<maxbucket<<" seconds "<<seconds<<std::endl;
}
