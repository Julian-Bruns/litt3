// c=16,d=1 boundary, one unused cyclotomic location.
// Tests every nonrational forced first-endpoint jet against the mixed pencil.
// Degenerate endpoint pencils force a rational endpoint and are counted.
#define KLEIN_FOUR_MINIMUM_WORD_NO_MAIN
#include "klein_four_minimum_word_endpoints.cpp"
F7 a7(const F7&a,const F7&b){F7 r{};for(int i=0;i<7;i++)r[i]=add25[a[i]][b[i]];return r;}
F7 s7(const F7&a,const F7&b){F7 r{};for(int i=0;i<7;i++)r[i]=add25[a[i]][neg25[b[i]]];return r;}
F7 c7(F7 a,int b){for(auto&v:a)v=mul25[v][b];return a;}
int p25(int a,int n){int b=1;while(n){if(n&1)b=mul25[a][b];a=mul25[a][a];n>>=1;}return b;}
struct Target{F7 lambda,nu,tau,upsilon;std::array<F7,7>mult;};
struct Quartic{F7 a,b,c;};
int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("usage: mixed_linear targets.dat");
 init();D={4,6,23,9,5,23,8,1};std::ifstream input(argv[1]);int nt;input>>nt;std::vector<Target>targets(nt);
 for(auto&t:targets){for(auto&v:t.lambda)input>>v;for(auto&v:t.nu)input>>v;for(auto&v:t.tau)input>>v;for(auto&v:t.upsilon)input>>v;
  for(int j=0;j<7;j++){F7 b{};b[j]=1;t.mult[j]=mul(t.lambda,b);}}
 F7 z{};z[1]=1;F7 one{};one[0]=1;F7 minusone{};minusone[0]=4;
 std::array<F7,29>zs;zs[0]=one;for(int i=1;i<29;i++)zs[i]=mul(zs[i-1],z);
 std::vector<Quartic>quartics;int raw[2][3]={{10,15,0},{24,18,14}};
 for(int f=0;f<2;f++)for(int k=0;k<29;k++)for(int j=0;j<2;j++)quartics.push_back({c7(zs[5*k%29],f?p25(raw[j][0],5):raw[j][0]),c7(zs[4*k%29],f?p25(raw[j][1],5):raw[j][1]),c7(zs[3*k%29],f?p25(raw[j][2],5):raw[j][2])});
 std::array<F7,58>rat_r,rat_s;
 for(int f=0;f<2;f++)for(int k=0;k<29;k++){
  rat_r[f*29+k]=c7(zs[(29-k)%29],f?p25(22,5):22);
  rat_s[f*29+k]=c7(zs[3*k%29],f?p25(8,5):8);
 }
 Mask comb=(Mask(1)<<12)-1,limit=Mask(1)<<28;long visited=0,reps=0,covered=0,nodes=0,degenerate=0,first=0,hits=0,qhits=0,rhits=0;
 while(comb<limit){
  Mask mask=(comb<<1)|1;visited++;Mask bit=comb&-comb,tmp=comb+bit;comb=(((comb^tmp)>>2)/bit)|tmp;
  if(!canonical(mask))continue;reps++;covered+=orbit_normalized(mask);
  std::array<std::array<int,29>,14>es{};es[0][0]=1;int used=0,sum=0;F7 alpha{};Mask bits=mask;
  while(bits){int a=__builtin_ctz(bits);bits&=bits-1;used++;sum+=a;alpha=a7(alpha,zs[(29-a)%29]);
   for(int j=used;j>=1;j--)for(int k=0;k<29;k++)es[j][(k+a)%29]=(es[j][(k+a)%29]+es[j-1][k])%5;
  }
  F7 C0=zs[(29-sum%29)%29],h5=c7(red(es[5]),4),h6=red(es[6]);
  F7 twiceC0h5=c7(mul(C0,h5),2),twiceC0h6=c7(mul(C0,h6),2);
  bits=mask;
  while(bits){int node=__builtin_ctz(bits);bits&=bits-1;nodes++;
   std::array<int,29>cyc{};
   for(int j=0;j<=12;j++){
    int scalar=(j+(j>=7?2:0))%5;if(j%2)scalar=(5-scalar)%5;
    int shift=(6-j)*node%29;if(shift<0)shift+=29;
    for(int k=0;k<29;k++)cyc[(k+shift)%29]=(cyc[(k+shift)%29]+scalar*es[j][k])%5;
   }
   F7 a0=red(cyc),B0=a7(twiceC0h6,mul(C0,a0)),delta=mul(mul(C0,zs[node]),a0);
   F7 D0=a7(mul(alpha,B0),twiceC0h5),D1=a7(mul(alpha,delta),twiceC0h6);
   F7 bn=a7(D1,B0),cn=s7(mul(D0,delta),mul(D1,B0));
   if(delta==F7{}){degenerate++;continue;}
#ifndef KLEIN_FOUR_MIXED_RATIONAL
   for(int k=0;k<nt;k++){
    const auto&t=targets[k];bool ok=true;
    for(int i=0;i<7;i++){
     int v=t.tau[i];for(int j=0;j<7;j++)v=add25[v][mul25[t.mult[j][i]][delta[j]]];
     if(v!=bn[i]){ok=false;break;}
    }
    if(ok){first++;if(a7(mul(t.nu,delta),t.upsilon)==cn){hits++;std::cout<<"MATCH mask="<<mask<<" node="<<node<<" target="<<k<<"\n";}}
   }
   for(int k=0;k<(int)quartics.size();k++){
    const auto&t=quartics[k];if(mul(t.a,delta)==minusone&&mul(t.b,delta)==bn&&mul(t.c,delta)==cn){qhits++;std::cout<<"QUARTIC mask="<<mask<<" node="<<node<<" target="<<k<<"\n";}
   }
#else
   for(int k=0;k<58;k++)if(mul(rat_s[k],delta)==a7(s7(mul(bn,rat_r[k]),mul(rat_r[k],rat_r[k])),cn)){
    rhits++;std::cout<<"RATIONAL mask="<<mask<<" node="<<node<<" coefficient_frobenius="<<k/29<<" phase="<<k%29<<"\n";
   }
#endif
  }
  if(reps%25000==0)std::cout<<"PROGRESS orbits="<<reps<<" nodes="<<nodes<<" nonrational_hits="<<hits<<" quartic_hits="<<qhits<<std::endl;
 }
 std::cout<<"TOTAL normalized="<<visited<<" representatives="<<reps<<" covered="<<covered<<" nodes="<<nodes<<" degenerate="<<degenerate<<" first_equation_matches="<<first<<" nonrational_hits="<<hits<<" quartic_hits="<<qhits<<" rational_hits="<<rhits<<std::endl;
#ifdef KLEIN_FOUR_MIXED_RATIONAL
 std::cout<<"MODE rational_only: nonrational counters inactive\n";
#else
 std::cout<<"MODE nonrational_only: rational counter inactive\n";
#endif
 if(covered!=visited||nodes!=13*reps)throw std::runtime_error("coverage");return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
