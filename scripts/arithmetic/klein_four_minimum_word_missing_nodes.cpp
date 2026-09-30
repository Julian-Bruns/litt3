// Test the necessary node-value condition for dependent unused-pole constraints.
// Minimum words G in S_d have high block 2*t^22*T and 16+2d zeros C.
// At b in the complementary roots J, test G(b)=b^22*T(b).
// This is a finite code calculation, not an existence test for covers.
#define KLEIN_FOUR_MINIMUM_WORD_ALL_NO_MAIN
#include "klein_four_minimum_word_all.cpp"

int main(int argc,char**argv){try{
 init();D={4,6,23,9,5,23,8,1};
 int lo=argc>1?std::stoi(argv[1]):0,hi=argc>2?std::stoi(argv[2]):5;
 if(lo<0||hi>5||lo>hi)throw std::runtime_error("require 0<=lo<=hi<=5");
 F7 z{};z[1]=1;F7 one{};one[0]=1;
 std::array<F7,29>zs;zs[0]=one;for(int i=1;i<29;i++)zs[i]=mul(zs[i-1],z);
 for(int d=lo;d<=hi;d++){
  int N=13-2*d;Mask comb=(Mask(1)<<(N-1))-1,limit=Mask(1)<<28;
  long visited=0,reps=0,covered=0,tested=0,hits=0;
  while(comb<limit){
   Mask mask=(comb<<1)|1;visited++;
   Mask bit=comb&-comb,tmp=comb+bit;comb=(((comb^tmp)>>2)/bit)|tmp;
   if(!canonical(mask))continue;
   reps++;covered+=orbit_normalized(mask);
   std::array<std::array<int,29>,8>es{};es[0][0]=1;int used=0;Mask bits=mask;
   std::vector<int>roots;
   while(bits){int a=__builtin_ctz(bits);bits&=bits-1;roots.push_back(a);used++;
    for(int k=std::min(7,used);k>=1;k--)for(int j=0;j<29;j++)es[k][(j+a)%29]=(es[k][(j+a)%29]+es[k-1][j])%5;
   }
   std::array<F7,8>hs{};for(int k=0;k<8;k++)hs[k]=(k%2)?neg(red(es[k])):red(es[k]);
   auto h=[&](int k){return k<0||k>7?F7{}:hs[k];};
   std::vector<std::vector<F7>>mat(d,std::vector<F7>(d+1));
   for(int a=0;a<d;a++)for(int b=0;b<=d;b++)mat[a][b]=h(7-2*d+a+b);
   std::vector<F7>ts(d+1);
   if(!d)ts[0]=one;
   else for(int col=0;col<=d;col++){
    std::vector<std::vector<F7>>minor(d);
    for(int a=0;a<d;a++)for(int b=0;b<=d;b++)if(b!=col)minor[a].push_back(mat[a][b]);
    ts[col]=determinant(minor);if(col%2)ts[col]=neg(ts[col]);
   }
   if(std::all_of(ts.begin(),ts.end(),zero))throw std::runtime_error("zero kernel");
   std::vector<F7>qs(7-d);
   for(int a=0;a<=6-d;a++)for(int b=0;b<=d;b++)qs[a]=add(qs[a],mul(ts[b],h(6-2*d-a+b)));
   for(int a:roots){
    tested++;F7 tb{},qb{},jp=one;
    for(int k=0;k<=d;k++)tb=add(tb,mul(ts[k],zs[a*k%29]));
    for(int k=0;k<=6-d;k++)qb=add(qb,mul(qs[k],zs[a*k%29]));
    for(int b:roots)if(a!=b)jp=mul(jp,add(zs[a],neg(zs[b])));
    // C(b)=29*b^28/J'(b), so clear the nonzero J'(b).
    F7 diff=add(scale(mul(zs[a*28%29],qb),3),neg(mul(mul(zs[a*22%29],tb),jp)));
    if(zero(diff)){
     hits++;std::cout<<"HIT d="<<d<<" mask="<<mask<<" node="<<a<<" Tzero="<<zero(tb)<<"\n";
    }
   }
  }
  std::cout<<"TOTAL d="<<d<<" normalized="<<visited<<" representatives="<<reps<<" covered="<<covered<<" nodes="<<tested<<" hits="<<hits<<std::endl;
  if(visited!=covered)throw std::runtime_error("coverage failed");
 }
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
