#include "halfgcd.hpp"
#include <chrono>
using namespace comp;
uint64_t state=73149856231;
F rnd(){state^=state<<13;state^=state>>7;state^=state<<17;return F(state%F::N);}
FP random_poly(int d){std::vector<F>c(d+1);for(auto&v:c)v=rnd();c[d]=1;return FP(c);}
int main(int argc,char**argv){F::init();FastK::init();auto ts=std::chrono::steady_clock::now();int largest=argc>1?std::stoi(argv[1]):16384;
 for(int n:{1,2,3,48,49,50,99,128,255,256,511,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576}){if(n>largest)break;
  for(int rep=0;rep<(n<=512?5:1);rep++){int dg=rep%4;FP g=random_poly(dg),a=g*random_poly(n),b=g*random_poly(std::max(0,n-(1+rep)));auto[h,u,v]=xgcd_half(a,b);assert(h==g.monic());
   if(n<=512){auto[hh,uu,vv]=xgcd(a,b);assert(h==hh);}
   if(n<=2048){FP f=random_poly(2+rep%3);for(int power:{0,1,4,5,6,24,25,26,124,125,126}){FP z=random_poly(8);while(!z.mod(f))z=random_poly(8);auto[k,y]=remove_frobenius(z*f.pow(power),f);assert(k==power&&y==z);}}
  }
  std::cout<<"{\"degree\":"<<n<<",\"half_gcd_and_Bezout\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-ts).count()<<"}"<<std::endl;
 }
 for(int n:{10,100,1000})for(int ratio:{1,3,5}){
 FP a=random_poly(n).fifth(),b=random_poly(std::max(1,n/ratio)).fifth(),g=random_poly(n/2).pow(3);
 auto[h,u,v]=xgcd_half(g*a,g*b);assert(h==g.monic());
 auto[z,uu,vv]=xgcd_half(g*a,FP());assert(z==(g*a).monic());
 }
 std::cout<<"{\"halfgcd_calls\":"<<hgcd_calls<<",\"sparse_Frobenius_division\":\"PASS\"}"<<std::endl;
}
