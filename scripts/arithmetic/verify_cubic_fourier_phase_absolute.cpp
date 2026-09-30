// Independent absolute-F5 arithmetic for the complete length-three/four
// cubic Fourier test and its doubled-phase condition.
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
#include <unordered_map>
#include <vector>
using V=std::array<uint8_t,14>;
V phase[29],ap[29],bp[29];int f[14]={1,2,4,0,4,4,3,1,3,4,4,0,4,2};
V add(const V&a,const V&b){V c;for(int i=0;i<14;++i){int v=a[i]+b[i];c[i]=v>=5?v-5:v;}return c;}
V multiply(const V&a,const V&b){std::array<int,27> c{};for(int i=0;i<14;++i)for(int j=0;j<14;++j)c[i+j]=(c[i+j]+a[i]*b[j])%5;
 for(int i=26;i>=14;--i)for(int j=0;j<14;++j)c[i-14+j]=(c[i-14+j]+25-c[i]*f[j])%5;V r;for(int i=0;i<14;++i)r[i]=c[i];return r;}
uint64_t enc(const V&v){uint64_t x=0;for(int j=13;j>=0;--j)x=5*x+v[j];return x;}
struct Sum{V v,a,b,v2,a2,b2;};std::vector<Sum> sums;
void generate(int n,int first,Sum s){if(!n){sums.push_back(s);return;}
 for(int i=first;i<29;++i){Sum t{add(s.v,phase[i]),add(s.a,ap[i]),add(s.b,bp[i]),add(s.v2,phase[2*i%29]),add(s.a2,ap[2*i%29]),add(s.b2,bp[2*i%29])};generate(n-1,i,t);}}
int main(int argc,char**argv){int n=argc>1?std::stoi(argv[1]):3;assert(n==3||n==4);
 phase[0][0]=1;for(int i=1;i<29;++i)for(int j=0;j<14;++j)phase[i][j]=((j?phase[i-1][j-1]:0)+25-phase[i-1][13]*f[j])%5;
 V beta={1,1,0,0,4,3,3,1,1,3,1,2,1,1},z;for(int j=0;j<14;++j)z[j]=(2*beta[j]+(j==0))%5;V z2=multiply(z,z),nz{},nz2{};
 for(int j=0;j<14;++j){nz[j]=z[j]?5-z[j]:0;nz2[j]=z2[j]?5-z2[j]:0;}
 for(int i=0;i<29;++i){ap[i]=multiply(nz,phase[i]);bp[i]=multiply(nz2,phase[i]);}
 generate(n,0,Sum{});std::unordered_map<uint64_t,size_t> lookup;lookup.reserve(sums.size()*2);
 for(size_t i=0;i<sums.size();++i)assert(lookup.emplace(enc(sums[i].v),i).second);
 uint64_t triples=0,bad=0,bad2=0;
 for(size_t i=0;i<sums.size();++i)for(size_t j=0;j<sums.size();++j){auto it=lookup.find(enc(add(sums[i].a,sums[j].b)));if(it==lookup.end())continue;++triples;
  if(i!=j||i!=it->second){++bad;bad2+=sums[it->second].v2==add(sums[i].a2,sums[j].b2);}}
 assert((n==3&&sums.size()==4495&&triples==4495&&bad==0)||(n==4&&sums.size()==35960&&triples==42050&&bad==6090));assert(bad2==0);
 std::cout<<"PASS absolute_field length "<<n<<" multisets "<<sums.size()<<" pair_tests "<<uint64_t(sums.size())*sums.size()<<" triples "<<triples<<" first_moment_nonbalanced "<<bad<<" two_moment_nonbalanced "<<bad2<<std::endl;
}
