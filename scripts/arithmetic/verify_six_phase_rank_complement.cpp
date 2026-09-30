// Complete normalized six-subset rank complement in F25[x]/(Phi_29 factor).
// Do not compile with NDEBUG. This does not enumerate covers or scalar values.
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
using Row=std::array<int,7>;
int add[25][25],mul[25][25],neg[25],inv[25];
Row phase[29];
int rank6(std::array<Row,6> a){
 int rank=0;
 for(int col=0;col<7&&rank<6;col++){
  int p=rank;while(p<6&&!a[p][col])p++;if(p==6)continue;
  std::swap(a[p],a[rank]);int u=inv[a[rank][col]];
  for(int c=col;c<7;c++)a[rank][c]=mul[a[rank][c]][u];
  for(int r=rank+1;r<6;r++)if(a[r][col]){
   int b=neg[a[r][col]];
   for(int c=col;c<7;c++)a[r][c]=add[a[r][c]][mul[b][a[rank][c]]];
  }rank++;
 }return rank;
}
int main(int argc,char**argv){
 const bool list_all=argc>1;
 for(int a=0;a<25;a++)for(int b=0;b<25;b++){
  add[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
  mul[a][b]=((a%5)*(b%5)+3*(a/5)*(b/5))%5
   +5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
 }
 for(int a=0;a<25;a++){for(int b=0;b<25;b++){if(!add[a][b])neg[a]=b;if(mul[a][b]==1)inv[a]=b;}assert(!a||mul[a][inv[a]]==1);}
 int f[7]={4,22,7,20,21,7,24};phase[0][0]=1;
 for(int i=1;i<=29;i++){
  Row next{};const Row &v=phase[(i-1)%29];
  for(int j=0;j<7;j++)next[j]=add[j?v[j-1]:0][neg[mul[v[6]][f[j]]]];
  if(i<29)phase[i]=next;else assert(next==phase[0]);
 }
 std::uint64_t counts[7]={};int bad=0,both=0;
 for(int a=1;a<25;a++)for(int b=a+1;b<26;b++)for(int c=b+1;c<27;c++)
 for(int d=c+1;d<28;d++)for(int e=d+1;e<29;e++){
  int r=rank6({phase[0],phase[a],phase[b],phase[c],phase[d],phase[e]});counts[r]++;
  if(r<6){
   if(bad++<12||list_all)std::cout<<"DEPENDENT "<<a<<' '<<b<<' '<<c<<' '<<d<<' '<<e<<" rank "<<r<<'\n';
   int s=rank6({phase[0],phase[8*a%29],phase[8*b%29],phase[8*c%29],phase[8*d%29],phase[8*e%29]});
   if(s<6){both++;std::cout<<"BOTH "<<a<<' '<<b<<' '<<c<<' '<<d<<' '<<e<<'\n';}
  }
 }
 std::uint64_t total=0;for(int r=0;r<=6;r++){total+=counts[r];std::cout<<"rank "<<r<<" count "<<counts[r]<<'\n';}
 assert(total==98280);std::cout<<"TOTAL "<<total<<" DEFICIENT "<<bad<<" ALSO_EIGHTH_DEFICIENT "<<both<<'\n';
 assert(counts[5]==126 && counts[6]==98154 && both==0);
 return 0;
}
