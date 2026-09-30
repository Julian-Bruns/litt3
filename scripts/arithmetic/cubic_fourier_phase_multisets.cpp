// Complete cubic Fourier triples of equal-length phase multisets.
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
#include <unordered_map>
#include <vector>
#include "sextic_paired_data.hpp"
using V=std::array<uint8_t,7>;
struct Sum{V v;std::array<int,5> labels;};
std::vector<Sum> sums;int labels[5];
uint64_t enc(const V&a){uint64_t r=0;for(int i=6;i>=0;--i)r=25*r+a[i];return r;}
void generate(int n,int k,int first,V v){
 if(k==n){Sum s;s.v=v;for(int i=0;i<5;++i)s.labels[i]=i<n?labels[i]:-1;sums.push_back(s);return;}
 for(int j=first;j<29;++j){labels[k]=j;V w;for(int i=0;i<7;++i)w[i]=add25[v[i]][phase[j][i]];generate(n,k+1,j,w);}
}
int main(int argc,char**argv){int n=argc>1?std::stoi(argv[1]):3;assert(n>=1&&n<=4);generate(n,0,0,V{});
 std::unordered_map<uint64_t,size_t> lookup;lookup.reserve(sums.size()*2);std::vector<V>a(sums.size()),b(sums.size());
 int z=11,z2=mul25[z][z],nz=0,nz2=0;while(add25[z][nz])++nz;while(add25[z2][nz2])++nz2;
 for(size_t i=0;i<sums.size();++i){assert(lookup.emplace(enc(sums[i].v),i).second);for(int j=0;j<7;++j){a[i][j]=mul25[nz][sums[i].v[j]];b[i][j]=mul25[nz2][sums[i].v[j]];}}
 std::vector<V>squared(sums.size());for(size_t i=0;i<sums.size();++i)for(int l=0;l<n;++l)for(int k=0;k<7;++k)squared[i][k]=add25[squared[i][k]][phase[2*sums[i].labels[l]%29][k]];
 uint64_t triples=0,bad=0,two_moment_bad=0;for(size_t i=0;i<sums.size();++i)for(size_t j=0;j<sums.size();++j){V v;for(int k=0;k<7;++k)v[k]=add25[a[i][k]][b[j][k]];auto it=lookup.find(enc(v));if(it==lookup.end())continue;
  ++triples;if(i!=j||i!=it->second){++bad;bool second=true;for(int k=0;k<7;++k)second=second&&!add25[squared[i][k]][add25[mul25[z][squared[j][k]]][mul25[z2][squared[it->second][k]]]];two_moment_bad+=second;
   if(bad<=12||second){std::cout<<(second?"TWO_MOMENT_NONTRIVIAL ":"NONTRIVIAL ");for(size_t k:{i,j,it->second}){std::cout<<'[';for(int l=0;l<n;++l)std::cout<<sums[k].labels[l]<<',';std::cout<<"] ";}std::cout<<'\n';}}
 }
 std::cout<<"COMPLETE length "<<n<<" multisets "<<sums.size()<<" pair_tests "<<uint64_t(sums.size())*sums.size()<<" triples "<<triples<<" nonbalanced "<<bad<<" two_moment_nonbalanced "<<two_moment_bad<<std::endl;
}
