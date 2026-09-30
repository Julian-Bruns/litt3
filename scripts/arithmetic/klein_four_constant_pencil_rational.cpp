// The remaining rational endpoint label for a c=15,d=0 Hermite pencil.
#define KLEIN_FOUR_MINIMUM_WORD_NO_MAIN
#include "klein_four_minimum_word_endpoints.cpp"
F7 add7(const F7&a,const F7&b){F7 c{};for(int i=0;i<7;i++)c[i]=add25[a[i]][b[i]];return c;}
F7 scale7(F7 a,int c){for(auto&x:a)x=mul25[x][c];return a;}
int p25(int a,int n){int b=1;while(n){if(n&1)b=mul25[a][b];a=mul25[a][a];n>>=1;}return b;}
int main(){try{
 init();D={4,6,23,9,5,23,8,1};
 F7 z{};z[1]=1;F7 one{};one[0]=1;
 std::array<F7,29>zs;zs[0]=one;for(int i=1;i<29;i++)zs[i]=mul(zs[i-1],z);
 std::array<std::array<F7,29>,2>rr,ss;
 for(int f=0;f<2;f++)for(int k=0;k<29;k++){
  rr[f][k]=scale7(zs[(29-k)%29],f?p25(22,5):22);
  ss[f][k]=scale7(zs[(3*k)%29],f?p25(8,5):8);
 }
 Mask comb=(Mask(1)<<13)-1,limit=Mask(1)<<28;
 long visited=0,reps=0,covered=0,hits=0;
 while(comb<limit){
  Mask m=(comb<<1)|1;visited++;
  Mask x=comb&-comb,y=comb+x;comb=(((comb^y)>>2)/x)|y;
  if(!canonical(m))continue;
  reps++;covered+=orbit_normalized(m);
  std::array<std::array<int,29>,7>e{};e[0][0]=1;int used=0,sum=0;Mask bits=m;F7 a{};
  while(bits){int r=__builtin_ctz(bits);bits&=bits-1;sum+=r;used++;a=add7(a,zs[(29-r)%29]);
   for(int j=std::min(6,used);j>=1;j--)for(int i=0;i<29;i++)e[j][(i+r)%29]=(e[j][(i+r)%29]+e[j-1][i])%5;
  }
  F7 b=scale7(mul(red(e[6]),zs[(29-sum%29)%29]),3);
  for(int f=0;f<2;f++)for(int k=0;k<29;k++)if(add7(mul(a,rr[f][k]),b)==ss[f][k]){
   hits++;std::cout<<"MATCH complement_mask="<<m<<" coefficient_frobenius="<<f<<" phase="<<k<<"\n";
  }
 }
 std::cout<<"TOTAL normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered<<" matching_labels="<<hits<<std::endl;
 if(covered!=visited)throw std::runtime_error("incomplete orbit coverage");
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
