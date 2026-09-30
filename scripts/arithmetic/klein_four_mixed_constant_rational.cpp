// Complete rational endpoint test for c=14,d=0 with one unused node.
// Cprime has degree15, Jprime its14 complementary roots. The mixed
// pencil intercept is old_intercept+Cprime(0)*a^21*Jprime(a).
#define KLEIN_FOUR_MINIMUM_WORD_NO_MAIN
#include "klein_four_minimum_word_endpoints.cpp"
#include <unordered_map>
F7 plus7(const F7&a,const F7&b){F7 r{};for(int i=0;i<7;i++)r[i]=add25[a[i]][b[i]];return r;}
F7 minus7(const F7&a,const F7&b){F7 r{};for(int i=0;i<7;i++)r[i]=add25[a[i]][neg25[b[i]]];return r;}
F7 times25(F7 a,int c){for(auto&v:a)v=mul25[v][c];return a;}
int pow25(int a,int n){int b=1;while(n){if(n&1)b=mul25[a][b];a=mul25[a][a];n>>=1;}return b;}
uint64_t pack7(const F7&a){uint64_t r=0;for(int i=6;i>=0;i--)r=25*r+a[i];return r;}
int main(){try{
 init();D={4,6,23,9,5,23,8,1};F7 z{};z[1]=1;F7 one{};one[0]=1;
 std::array<F7,29>zs;zs[0]=one;for(int i=1;i<29;i++)zs[i]=mul(zs[i-1],z);
 std::array<F7,58>rr,ss;
 for(int f=0;f<2;f++)for(int k=0;k<29;k++){
  rr[29*f+k]=times25(zs[(29-k)%29],f?pow25(22,5):22);
  ss[29*f+k]=times25(zs[3*k%29],f?pow25(8,5):8);
 }
 Mask comb=(Mask(1)<<13)-1,limit=Mask(1)<<28;
 long visited=0,reps=0,covered=0,nodes=0,hits=0;
 while(comb<limit){
  Mask mask=(comb<<1)|1;visited++;Mask b=comb&-comb,c=comb+b;comb=(((comb^c)>>2)/b)|c;
  if(!canonical(mask))continue;reps++;covered+=orbit_normalized(mask);
  std::array<std::array<int,29>,15>es{};es[0][0]=1;int used=0,sum=0;F7 slope{};Mask bits=mask;
  while(bits){int a=__builtin_ctz(bits);bits&=bits-1;used++;sum+=a;slope=plus7(slope,zs[(29-a)%29]);
   for(int j=used;j>=1;j--)for(int k=0;k<29;k++)es[j][(k+a)%29]=(es[j][(k+a)%29]+es[j-1][k])%5;
  }
  std::unordered_map<uint64_t,std::vector<int>>target;
  for(int k=0;k<58;k++)target[pack7(minus7(ss[k],mul(slope,rr[k])))].push_back(k);
  // Work in the group ring F5[mu29], reducing only after each node.
  for(int node=0;node<29;node++)if(!(mask>>node&1)){
   nodes++;std::array<int,29>coeff{};
   for(int k=0;k<29;k++)coeff[(k+29-sum%29)%29]=3*es[6][k]%5;
   for(int j=0;j<=14;j++){
    int shift=((6-j)*node-sum)%29;if(shift<0)shift+=29;int scalar=j%2?1:4;
    for(int k=0;k<29;k++)coeff[(k+shift)%29]=(coeff[(k+shift)%29]+scalar*es[j][k])%5;
   }
   auto it=target.find(pack7(red(coeff)));
   if(it!=target.end())for(int k:it->second){hits++;std::cout<<"MATCH complement14_mask="<<mask<<" unused_node="<<node<<" coefficient_frobenius="<<k/29<<" phase="<<k%29<<"\n";}
  }
 }
 std::cout<<"TOTAL normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered<<" nodes="<<nodes<<" matching_labels="<<hits<<std::endl;
 if(covered!=visited||nodes!=15*reps)throw std::runtime_error("coverage");return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
