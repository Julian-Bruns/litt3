// Exhaust all length-m multisets of mu_29, m<=6, in F_(5^14).
// Equality of reduced multiplicity vectors (mod 5) is a Frobenius-block collision.
#include <array>
#include <vector>
#include <algorithm>
#include <cstdint>
#include <iostream>
using V=std::array<int,14>;
using U128=unsigned __int128;
struct Row {std::uint64_t key; U128 counts;};
V powers[29];
int countv[29];
std::vector<Row> rows;
std::uint64_t encode(const V& a) {std::uint64_t z=0;for(int j=13;j>=0;--j)z=5*z+a[j];return z;}
V add(const V&a,const V&b){V c{};for(int j=0;j<14;++j)c[j]=(a[j]+b[j])%5;return c;}
void generate(int m,int start,const V&sum){
 if(!m){U128 z=0;for(int j=28;j>=0;--j)z=z*5+(countv[j]%5);rows.push_back({encode(sum),z});return;}
 for(int j=start;j<29;++j){++countv[j];generate(m-1,j,add(sum,powers[j]));--countv[j];}
}
void print_counts(U128 z){std::cout<<"[";for(int j=0;j<29;++j){int c=z%5;z/=5;if(c)std::cout<<j<<":"<<c<<",";}std::cout<<"]";}
int main(int argc,char**argv){
 // ascending coefficients of first factor of Phi_29 over F5 (monic degree 14)
 int f[14]={1,2,4,0,4,4,3,1,3,4,4,0,4,2};
 powers[0][0]=1;
 for(int i=1;i<29;++i){int lead=powers[i-1][13];for(int j=0;j<14;++j)powers[i][j]=((j?powers[i-1][j-1]:0)-lead*f[j]+25)%5;}
 V next{};int lead=powers[28][13];for(int j=0;j<14;++j)next[j]=((j?powers[28][j-1]:0)-lead*f[j]+25)%5;
 if(next!=powers[0])return 2;
 int total_bad=0;
 int maximum=argc>1?std::stoi(argv[1]):6;
 int minimum=argc>2?std::stoi(argv[2]):1;
 for(int m=minimum;m<=maximum;++m){
  rows.clear();generate(m,0,V{});
  std::sort(rows.begin(),rows.end(),[](const Row&a,const Row&b){return a.key!=b.key?a.key<b.key:a.counts<b.counts;});
  std::uint64_t groups=0,collision_groups=0,bad_groups=0,max_group=0;
  for(std::size_t i=0;i<rows.size();){std::size_t j=i+1;while(j<rows.size()&&rows[j].key==rows[i].key)++j;++groups;
   if(j-i>1)++collision_groups;
   if(j-i>max_group)max_group=j-i;
   if(rows[i].counts!=rows[j-1].counts){++bad_groups;if(total_bad++<20){std::cout<<"NONTRIVIAL m="<<m<<" key="<<rows[i].key<<" ";print_counts(rows[i].counts);std::cout<<" versus ";print_counts(rows[j-1].counts);std::cout<<"\n";}}
   i=j;
  }
  std::cout<<"m="<<m<<" multisets="<<rows.size()<<" sums="<<groups<<" collision_groups="<<collision_groups<<" max_group="<<max_group<<" non_frobenius_groups="<<bad_groups<<"\n";
 }
 return total_bad ? 3 : 0;
}
