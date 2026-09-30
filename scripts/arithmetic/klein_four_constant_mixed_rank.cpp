// Abstract rank of two mixed-node conditions on c=15,d=0 words.
// No forced endpoint jet is used in this test.
#define KLEIN_FOUR_TWO_ENDPOINT_NO_MAIN
#include "klein_four_two_endpoint_planes.cpp"
#include <unordered_map>
uint64_t fieldcode(const F7&a){uint64_t r=0;for(int i=6;i>=0;i--)r=25*r+a[i];return r;}
int main(){try{
 init();D={4,6,23,9,5,23,8,1};
 Mask comb=(Mask(1)<<13)-1,limit=Mask(1)<<28;
 uint64_t visited=0,reps=0,covered=0,nodes=0,pairs=0,masks=0;
 while(comb<limit){Mask mask=(comb<<1)|1;visited++;Mask b=comb&-comb,c=comb+b;comb=(((comb^c)>>2)/b)|c;
  if(!canonical(mask))continue;reps++;covered+=orbit_normalized(mask);
  std::array<std::array<int,29>,15>es{};es[0][0]=1;int used=0;Mask bits=mask;
  while(bits){int a=__builtin_ctz(bits);bits&=bits-1;used++;
   for(int j=used;j>=1;j--)for(int k=0;k<29;k++)es[j][(k+a)%29]=(es[j][(k+a)%29]+es[j-1][k])%5;
  }
  std::unordered_map<uint64_t,std::vector<int>>seen;bool repeated=false;bits=mask;
  while(bits){int a=__builtin_ctz(bits);bits&=bits-1;nodes++;std::array<int,29>values{};
   for(int j=0;j<=14;j++){
    int coefficient=red5((j+1)-(j<=7?2:0));if(j%2)coefficient=red5(-coefficient);
    int shift=((7-j)*a)%29;if(shift<0)shift+=29;
    for(int k=0;k<29;k++)values[(k+shift)%29]=(values[(k+shift)%29]+coefficient*es[j][k])%5;
   }
   F7 value=red(values);auto&previous=seen[fieldcode(value)];
   for(int other:previous){pairs++;repeated=true;std::cout<<"COLLISION J_mask="<<mask<<" nodes="<<other<<','<<a<<" value=";for(int x:value)std::cout<<x<<',';std::cout<<'\n';}
   previous.push_back(a);
  }
  masks+=repeated;
 }
 std::cout<<"TOTAL normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered<<" nodes="<<nodes<<" collision_masks="<<masks<<" collision_pairs="<<pairs<<std::endl;
 if(covered!=visited||nodes!=14*reps)throw std::runtime_error("coverage");return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
