// Exact endpoint test for the d=0,c=16 Hermite equality case.
// A normalized minimum word is determined by its thirteen complementary
// 29th roots. Both endpoint ratios require e6^29=e7^29=[18].
#define main old_jet_main
#include "klein_four_constant_character_jet.cpp"
#undef main
#include <algorithm>
#include <cstdint>
using Mask=uint32_t;
constexpr Mask ALL=(Mask(1)<<29)-1;
using F7=std::array<int,7>;
Mask rot(Mask m,int r){return r?((m>>r)|(m<<(29-r)))&ALL:m;}
Mask frob(Mask m){Mask z=0;while(m){int r=__builtin_ctz(m);m&=m-1;z|=Mask(1)<<((5*r)%29);}return z;}
bool canonical(Mask m){Mask v=m;for(int b=0;b<14;b++){Mask bits=v;while(bits){int r=__builtin_ctz(bits);bits&=bits-1;if(rot(v,r)<m)return false;}v=frob(v);}return true;}
int orbit_normalized(Mask m){std::vector<Mask>all;Mask v=m;for(int b=0;b<14;b++){Mask bits=v;while(bits){int r=__builtin_ctz(bits);bits&=bits-1;all.push_back(rot(v,r));}v=frob(v);}std::sort(all.begin(),all.end());return std::unique(all.begin(),all.end())-all.begin();}
F7 red(std::array<int,29>a){for(int e=28;e>=7;e--){int c=a[e];if(c)for(int j=0;j<=7;j++)a[e-7+j]=add25[a[e-7+j]][neg25[mul25[c][D[j]]]];}F7 b;std::copy(a.begin(),a.begin()+7,b.begin());return b;}
F7 mul(const F7&a,const F7&b){std::array<int,29>c{};for(int i=0;i<7;i++)for(int j=0;j<7;j++)c[i+j]=add25[c[i+j]][mul25[a[i]][b[j]]];return red(c);}
F7 power(F7 a,int n){F7 r{};r[0]=1;while(n){if(n&1)r=mul(r,a);a=mul(a,a);n>>=1;}return r;}
int code_if_constant(const F7&a){for(int i=1;i<7;i++)if(a[i])return -1;return a[0];}
#ifndef KLEIN_FOUR_MINIMUM_WORD_NO_MAIN
int main(){try{
 init();D={4,6,23,9,5,23,8,1};
 F7 z{};z[1]=1;F7 one{};one[0]=1;
 if(power(z,29)!=one)throw std::runtime_error("wrong cyclotomic field");
 Mask comb=(Mask(1)<<12)-1,limit=Mask(1)<<28;
 long visited=0,reps=0,covered=0,first_hits=0,both_hits=0;
 while(comb<limit){Mask m=(comb<<1)|1;visited++;
  if(canonical(m)){
   reps++;covered+=orbit_normalized(m);
   std::array<std::array<int,29>,8>e{};e[0][0]=1;int used=0;Mask bits=m;
   while(bits){int r=__builtin_ctz(bits);bits&=bits-1;used++;
    for(int k=std::min(7,used);k>=1;k--)for(int i=0;i<29;i++)e[k][(i+r)%29]=(e[k][(i+r)%29]+e[k-1][i])%5;
   }
   F7 e6=red(e[6]);int c6=code_if_constant(power(e6,29));
   if(c6==18||c6==11){
    first_hits++;F7 e7=red(e[7]);int c7=code_if_constant(power(e7,29));
    if(c7==c6){
     both_hits++;std::cout<<"BOTH roots=";Mask b=m;while(b){int r=__builtin_ctz(b);b&=b-1;std::cout<<r<<",";}
     std::cout<<" common_norm="<<c6<<"\n";
    }
   }
  }
  Mask x=comb&-comb,y=comb+x;comb=(((comb^y)>>2)/x)|y;
 }
 std::cout<<"normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered<<" first_endpoint_orbits="<<first_hits<<" both_endpoint_orbits="<<both_hits<<std::endl;
 if(covered!=visited||first_hits||both_hits)throw std::runtime_error("coverage or endpoint exclusion failed");
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
#endif
