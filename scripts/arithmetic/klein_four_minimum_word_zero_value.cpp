// Exact nonvanishing of F(0) and T(0) on minimum words, independent of
// the forced first endpoint ratio. Handles the doubled-zero boundary.
#define KLEIN_FOUR_MINIMUM_WORD_ALL_NO_MAIN
#include "klein_four_minimum_word_all.cpp"
int main(){try{
 init();D={4,6,23,9,5,23,8,1};
 for(int d=0;d<=4;d++){
  int N=13-2*d;Mask comb=(Mask(1)<<(N-1))-1,limit=Mask(1)<<28;
  uint64_t visited=0,reps=0,covered=0,tzero=0,fzero=0;
  while(comb<limit){Mask mask=(comb<<1)|1;visited++;Mask x=comb&-comb,y=comb+x;comb=(((comb^y)>>2)/x)|y;
   if(!canonical(mask))continue;reps++;covered+=orbit_normalized(mask);
   std::array<std::array<int,29>,8>es{};es[0][0]=1;int used=0;Mask bits=mask;
   while(bits){int a=__builtin_ctz(bits);bits&=bits-1;used++;
    for(int j=std::min(7,used);j>=1;j--)for(int k=0;k<29;k++)es[j][(k+a)%29]=(es[j][(k+a)%29]+es[j-1][k])%5;
   }
   std::array<F7,8>hs{};for(int i=0;i<8;i++)hs[i]=scale(red(es[i]),i%2?4:1);
   auto h=[&](int i){return i>=0&&i<8?hs[i]:F7{};};
   std::vector<std::vector<F7>>mat(d,std::vector<F7>(d+1));for(int i=0;i<d;i++)for(int j=0;j<=d;j++)mat[i][j]=h(7-2*d+i+j);
   std::vector<F7>ts(d+1);if(!d)ts[0][0]=1;
   else for(int c=0;c<=d;c++){
    std::vector<std::vector<F7>>minor(d);for(int i=0;i<d;i++)for(int j=0;j<=d;j++)if(j!=c)minor[i].push_back(mat[i][j]);
    ts[c]=scale(determinant(minor),c%2?4:1);
   }
   bool nonzero=false;for(auto&t:ts)if(!zero(t))nonzero=true;if(!nonzero)throw std::runtime_error("cofactor rank");
   F7 q0{};for(int j=0;j<=d;j++)q0=add(q0,mul(ts[j],h(6-2*d+j)));
   if(zero(ts[0])){tzero++;std::cout<<"ZERO_T d="<<d<<" J_mask="<<mask<<'\n';}
   if(zero(q0)){fzero++;std::cout<<"ZERO_F d="<<d<<" J_mask="<<mask<<'\n';}
  }
  std::cout<<"TOTAL d="<<d<<" normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered<<" zero_T0="<<tzero<<" zero_F0="<<fzero<<std::endl;
  if(visited!=covered)throw std::runtime_error("coverage");
 }
 return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
