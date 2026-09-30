// Complete nonrational first-jet test for c=17,d=1 shortened characters.
// Uses a symmetry-closed SUPerset of the forced endpoint targets.
#define KLEIN_FOUR_MINIMUM_WORD_NO_MAIN
#include "klein_four_minimum_word_endpoints.cpp"
#include <string>
F7 add7(const F7&a,const F7&b){F7 c{};for(int i=0;i<7;i++)c[i]=add25[a[i]][b[i]];return c;}
F7 sub7(const F7&a,const F7&b){F7 c{};for(int i=0;i<7;i++)c[i]=add25[a[i]][neg25[b[i]]];return c;}
F7 scale7(F7 a,int c){for(auto&x:a)x=mul25[x][c];return a;}
struct Target{F7 lambda,nu,tau,upsilon;std::array<F7,7> ml;};
int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("usage: linear_subsets targets.dat");
 init();D={4,6,23,9,5,23,8,1};
 std::ifstream f(argv[1]);int nt;f>>nt;std::vector<Target>ts(nt);
 for(auto&t:ts){for(auto&a:t.lambda)f>>a;for(auto&a:t.nu)f>>a;for(auto&a:t.tau)f>>a;for(auto&a:t.upsilon)f>>a;
  for(int j=0;j<7;j++){F7 base{};base[j]=1;t.ml[j]=mul(t.lambda,base);}}
 F7 z{};z[1]=1;F7 one{};one[0]=1;
 std::array<F7,29>zs;zs[0]=one;for(int i=1;i<29;i++)zs[i]=mul(zs[i-1],z);
 Mask comb=(Mask(1)<<11)-1,limit=Mask(1)<<28;
 long visited=0,reps=0,covered=0,first=0,both=0,zero6=0;
 while(comb<limit){
  Mask mask=(comb<<1)|1;visited++;
  Mask x=comb&-comb,y=comb+x;comb=(((comb^y)>>2)/x)|y;
  if(!canonical(mask))continue;
  reps++;covered+=orbit_normalized(mask);
  std::array<std::array<int,29>,7>e{};e[0][0]=1;int used=0,sum=0;Mask bits=mask;F7 alpha{};
  while(bits){int r=__builtin_ctz(bits);bits&=bits-1;sum+=r;used++;alpha=add7(alpha,zs[(29-r)%29]);
   for(int j=std::min(6,used);j>=1;j--)for(int i=0;i<29;i++)e[j][(i+r)%29]=(e[j][(i+r)%29]+e[j-1][i])%5;
  }
  F7 e4=red(e[4]),e5=red(e[5]),e6=red(e[6]);F7 invprod=zs[(29-sum%29)%29];
  if(e6==F7{}){zero6++;continue;}
  F7 m=scale7(mul(invprod,e6),3);
  F7 bnum=add7(mul(m,alpha),scale7(mul(invprod,e5),4));
  F7 cnum=scale7(mul(mul(invprod,invprod),sub7(mul(e4,e6),mul(e5,e5))),4);
  for(int k=0;k<nt;k++){
   const auto&t=ts[k];bool pass=true;
   for(int i=0;i<7;i++){
    int a=t.tau[i];for(int j=0;j<7;j++)a=add25[a][mul25[t.ml[j][i]][m[j]]];
    if(a!=bnum[i]){pass=false;break;}
   }
   if(!pass)continue;first++;
   std::cout<<"FIRST complement_mask="<<mask<<" target="<<k<<"\n";
   if(add7(mul(m,t.nu),t.upsilon)==cnum){both++;
    std::cout<<"MATCH complement_mask="<<mask<<" target="<<k<<"\n";}
  }
 }
 std::cout<<"TOTAL normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered<<" targets="<<nt<<" zero_h6="<<zero6<<" first_equation="<<first<<" both_equations="<<both<<std::endl;
 if(covered!=visited||zero6)throw std::runtime_error("coverage or MDS failed");
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
