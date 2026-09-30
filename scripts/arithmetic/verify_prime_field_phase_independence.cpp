// Exact prime-field ranks of normalized subsets of the 29th roots.
// All arithmetic is in F25[x]/(the specified degree-seven factor).
#include <array>
#include <cassert>
#include <cstdint>
#include <functional>
#include <iostream>
#include <vector>
using Row=std::array<int,7>;
int add25[25][25],mul25[25][25],negative25[25];
Row phases[29];
int rank5(const std::vector<int>& exponents) {
 std::vector<std::array<int,14>> a(exponents.size());
 for(size_t i=0;i<exponents.size();++i)for(int j=0;j<7;++j){
  a[i][2*j]=phases[exponents[i]][j]%5;
  a[i][2*j+1]=phases[exponents[i]][j]/5;
 }
 const int inverse[5]={0,1,3,2,4};int r=0;
 for(int j=0;j<14 && r<(int)a.size();++j){
  int p=r;while(p<(int)a.size()&&!a[p][j])++p;
  if(p==(int)a.size())continue;
  std::swap(a[p],a[r]);int u=inverse[a[r][j]];
  for(int k=j;k<14;++k)a[r][k]=a[r][k]*u%5;
  for(int i=r+1;i<(int)a.size();++i)if(a[i][j]){
   int c=a[i][j];for(int k=j;k<14;++k)a[i][k]=(a[i][k]+5-c*a[r][k]%5)%5;
  }++r;
 }return r;
}
int main(int argc,char**argv){
 int size=argc>1?std::stoi(argv[1]):6;assert(size>=2&&size<=14);
 for(int a=0;a<25;++a)for(int b=0;b<25;++b){
  add25[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
  mul25[a][b]=((a%5)*(b%5)+3*(a/5)*(b/5))%5
   +5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
  if(!add25[a][b])negative25[a]=b;
 }
 const int factor[7]={4,22,7,20,21,7,24};phases[0][0]=1;
 for(int i=1;i<=29;++i){
  Row next{};const Row&v=phases[(i-1)%29];
  for(int j=0;j<7;++j)next[j]=add25[j?v[j-1]:0][negative25[mul25[v[6]][factor[j]]]];
  if(i==29)assert(next==phases[0]);else phases[i]=next;
 }
 std::array<uint64_t,15> counts{};std::vector<int> subset{0};
 std::function<void(int)> visit=[&](int start){
  if((int)subset.size()==size){
   int r=rank5(subset);++counts[r];
   if(r<size&&counts[r]<=12){std::cout<<"DEPENDENT";for(int e:subset)std::cout<<' '<<e;std::cout<<" rank "<<r<<'\n';}
   return;
  }
  int left=size-(int)subset.size();
  for(int e=start;e<=29-left;++e){subset.push_back(e);visit(e+1);subset.pop_back();}
 };
 visit(1);uint64_t total=0;
 for(int r=0;r<=size;++r){total+=counts[r];std::cout<<"rank "<<r<<" count "<<counts[r]<<'\n';}
 std::cout<<"SIZE "<<size<<" TOTAL "<<total<<" FULL_RANK "<<counts[size]<<'\n';
 return 0;
}
