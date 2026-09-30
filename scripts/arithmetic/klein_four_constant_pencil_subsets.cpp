// Exhaustive meet-in-the-middle check of the nonrational constant pencils.
#define KLEIN_FOUR_MINIMUM_WORD_NO_MAIN
#include "klein_four_minimum_word_endpoints.cpp"
#include <unordered_map>
#include <string>
F7 plus7(const F7&a,const F7&b){F7 r{};for(int i=0;i<7;i++)r[i]=add25[a[i]][b[i]];return r;}
F7 minus7(const F7&a,const F7&b){F7 r{};for(int i=0;i<7;i++)r[i]=add25[a[i]][neg25[b[i]]];return r;}
uint64_t pack7(const F7&a){uint64_t r=0;for(int i=6;i>=0;i--)r=25*r+a[i];return r;}
struct Target{F7 a,b;long sum_hits=0,full_hits=0;};
int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("usage: subsets targets.dat");
 init();D={4,6,23,9,5,23,8,1};
 std::ifstream f(argv[1]);int nt;f>>nt;std::vector<Target>ts(nt);
 for(auto&t:ts){for(auto&a:t.a)f>>a;for(auto&b:t.b)f>>b;}
 int nr;f>>nr;std::vector<std::pair<F7,F7>>rational(nr);
 for(auto&t:rational){for(auto&a:t.first)f>>a;for(auto&a:t.second)f>>a;}
 F7 z{};z[1]=1;F7 one{};one[0]=1;
 std::array<F7,29>zs;zs[0]=one;for(int i=1;i<29;i++)zs[i]=mul(zs[i-1],z);
 std::vector<F7>lo(1<<14),hi(1<<15);
 std::unordered_map<uint64_t,std::vector<Mask>>lookup;
 for(Mask a=0;a<(1u<<14);a++){
  if(a){int bit=__builtin_ctz(a);lo[a]=plus7(lo[a&(a-1)],zs[(29-bit)%29]);}
  lookup[pack7(lo[a])].push_back(a);
 }
 long full=0,hits=0,queries=0;
 for(Mask b=0;b<(1u<<15);b++){
  if(b){int bit=__builtin_ctz(b)+14;hi[b]=plus7(hi[b&(b-1)],zs[(29-bit)%29]);}
  int needed=14-__builtin_popcount(b);if(needed<0)continue;
  for(int k=0;k<nt;k++){
   queries++;auto it=lookup.find(pack7(minus7(ts[k].a,hi[b])));if(it==lookup.end())continue;
   for(Mask a:it->second){if(__builtin_popcount(a)!=needed)continue;
    Mask m=a|(b<<14);hits++;ts[k].sum_hits++;
    std::cout<<"SUM target="<<k<<" complement_mask="<<m<<"\n";
    std::array<std::array<int,29>,7>e{};e[0][0]=1;int used=0,sum=0;Mask bits=m;
    while(bits){int r=__builtin_ctz(bits);bits&=bits-1;sum+=r;used++;
     for(int j=std::min(6,used);j>=1;j--)for(int i=0;i<29;i++)e[j][(i+r)%29]=(e[j][(i+r)%29]+e[j-1][i])%5;
    }
    F7 intercept=mul(red(e[6]),zs[(29-sum%29)%29]);for(auto&v:intercept)v=mul25[3][v];
    if(intercept==ts[k].b){full++;ts[k].full_hits++;
     std::cout<<"MATCH target="<<k<<" complement_mask="<<m<<"\n";
    }
   }
  }
 }
 for(int i=0;i<nt;i++)std::cout<<"TARGET "<<i<<" sum_hits="<<ts[i].sum_hits<<" full_hits="<<ts[i].full_hits<<"\n";
 std::cout<<"TOTAL low_subsets="<<lo.size()<<" high_subsets="<<hi.size()<<" targets="<<nt<<" queries="<<queries<<" sum_hits="<<hits<<" full_hits="<<full<<" rational_targets_not_checked="<<nr<<std::endl;
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
