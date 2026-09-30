// Exact two-endpoint test for c=14,d=0 words, affine endpoint sector.
// Non-affine jets are excluded separately by the endpoint-plane theorem.
// Usage: executable two_endpoint_planes.dat linear_pencil_targets.dat
#define KLEIN_FOUR_TWO_ENDPOINT_NO_MAIN
#include "klein_four_two_endpoint_planes.cpp"
#include <unordered_map>
uint64_t packed(const F7&a){uint64_t out=0;for(int i=6;i>=0;i--)out=25*out+a[i];return out;}
struct Target{F7 lambda,nu,trace,constant;};
F7 flipscale(F7 a,int power){for(int k=0;k<power;k++)a=::power(a,5);return a;}
int main(int argc,char**argv){try{
 if(argc!=3&&argc!=4)throw std::runtime_error("data.dat linear_targets.dat [marked-candidates.tsv]");
 init();for(int i=1;i<25;i++)for(int j=1;j<25;j++)if(mul25[i][j]==1)inv25[i]=j;
 std::ifstream f(argv[1]);for(auto&x:AP)f>>x;for(auto&x:D)f>>x;
 std::ifstream tf(argv[2]);int nt;tf>>nt;std::vector<Target> ts(nt);
 for(auto&t:ts)for(F7*p:{&t.lambda,&t.nu,&t.trace,&t.constant})for(auto&x:*p)tf>>x;
 if(!f||!tf)throw std::runtime_error("bad input");
 std::ofstream marked;if(argc==4)marked.open(argv[3]);uint64_t marked_candidates=0;
 std::unordered_map<uint64_t,std::vector<int>>by_slope;
 for(int i=0;i<nt;i++)by_slope[packed(ts[i].lambda)].push_back(i);
 std::vector<F7>slopes;std::vector<std::vector<int>>slope_targets;
 for(auto&e:by_slope){slopes.push_back(ts[e.second[0]].lambda);slope_targets.push_back(e.second);}
 std::array<F7,29>zp{};zp[0][0]=1;F7 z{};z[1]=1;for(int i=1;i<29;i++)zp[i]=mul(zp[i-1],z);
 std::array<F7,58>rr,ss;F7 rbase{},sbase{};rbase[0]=22;sbase[0]=8;
 for(int fr=0;fr<2;fr++)for(int k=0;k<29;k++){
  rr[29*fr+k]=mul(flipscale(rbase,fr),zp[(29-k)%29]);ss[29*fr+k]=mul(flipscale(sbase,fr),zp[3*k%29]);
 }
 std::unordered_map<uint64_t,std::vector<int>>rational;
 for(int i=0;i<58;i++)rational[packed(rr[i])].push_back(i);
 std::vector<F7>diff(slopes.size()),prefix(slopes.size()),invs(slopes.size());
 Mask comb=(Mask(1)<<14)-1,limit=Mask(1)<<28;
 uint64_t visited=0,reps=0,covered=0,lambda_pairs=0,jet_pairs=0,trace_pairs=0,full_pairs=0,rational_pairs=0,rational_consistent=0,zero_potential=0,zero_matches=0;
 while(comb<limit){Mask mask=(comb<<1)|1;visited++;Mask b=comb&-comb,c=comb+b;comb=(((comb^c)>>2)/b)|c;
  if(!canonical(mask))continue;reps++;covered+=orbit_normalized(mask);
  std::array<std::array<int,29>,9>es{};es[0][0]=1;int used=0,sum=0;F7 alpha{},gamma{};Mask bits=mask;
  while(bits){int k=__builtin_ctz(bits);bits&=bits-1;used++;sum+=k;gamma=plus7(gamma,zp[k]);alpha=plus7(alpha,zp[(29-k)%29]);
   for(int j=std::min(8,used);j>=1;j--)for(int k0=0;k0<29;k0++)es[j][(k0+k)%29]=(es[j][(k0+k)%29]+es[j-1][k0])%5;
  }
  F7 prod=zp[sum%29],e7=red(es[7]),e8=red(es[8]);
  // All M-rational endpoint jets, with the safe coefficient conjugate.
  for(int i=0;i<58;i++){
   F7 rp=plus7(mul(prod,minus7(ss[i],mul(alpha,rr[i]))),scalar7(e7,2));
   F7 sp=plus7(minus7(mul(prod,rr[i]),scalar7(e8,2)),mul(gamma,rp));
   auto ri=rational.find(packed(rp));if(ri!=rational.end())for(int j:ri->second)if(sp==ss[j]){
    rational_pairs++;rational_consistent+=i/29==j/29;
    std::cout<<"RATIONAL J_mask="<<mask<<" first="<<i<<" second="<<j<<" same_coefficient_conjugate="<<(i/29==j/29)<<'\n';
   }
  }
  // Batch inversion replaces thousands of field inversions by products.
  F7 acc=zp[0];for(size_t i=0;i<slopes.size();i++){
   diff[i]=minus7(slopes[i],alpha);prefix[i]=acc;if(nz(diff[i]))acc=mul(acc,diff[i]);
  }
  F7 inverse=inverse7(acc);
  for(size_t ii=slopes.size();ii-->0;){if(nz(diff[ii])){invs[ii]=mul(inverse,prefix[ii]);inverse=mul(inverse,diff[ii]);}else invs[ii]={};}
  if(inverse!=zp[0])throw std::runtime_error("batch inverse");
  for(size_t i=0;i<slopes.size();i++){
   if(!nz(diff[i])){
    for(int ti:slope_targets[i]){zero_potential++;std::cout<<"ZERO_SLOPE J_mask="<<mask<<" first="<<ti<<'\n';if(marked)marked<<"ZERO "<<mask<<' '<<ti<<'\n';if(!nz(plus7(mul(prod,ts[ti].nu),scalar7(e7,2)))){
     zero_matches++;std::cout<<"ZERO_OTHER_ENDPOINT J_mask="<<mask<<" first="<<ti<<'\n';
    }}continue;
   }
   F7 lp=plus7(gamma,invs[i]);auto it=by_slope.find(packed(lp));if(it==by_slope.end())continue;
   for(int ti:slope_targets[i]){
    const Target&t=ts[ti];F7 k=mul(prod,diff[i]),l=plus7(mul(prod,t.nu),scalar7(e7,2));
    F7 np=minus7(scalar7(e8,3),mul(invs[i],l));
    for(int tj:it->second){lambda_pairs++;const Target&u=ts[tj];
     if(marked){F7 shift=scalar7(minus7(u.trace,mul(k,t.trace)),3);
      F7 constant=minus7(minus7(mul(mul(k,k),t.constant),mul(mul(k,t.trace),shift)),mul(shift,shift));
      if(constant==u.constant){marked_candidates++;marked<<"PAIR "<<mask<<' '<<ti<<' '<<tj<<'\n';}
     }
     if(np!=u.nu)continue;jet_pairs++;
     std::cout<<"AFFINE_JETS J_mask="<<mask<<" first="<<ti<<" second="<<tj<<'\n';
     F7 tr=plus7(mul(k,t.trace),scalar7(l,2));if(tr!=u.trace)continue;trace_pairs++;
     F7 cn=minus7(minus7(mul(mul(k,k),t.constant),mul(mul(k,t.trace),l)),mul(l,l));
     if(cn==u.constant){full_pairs++;std::cout<<"BOTH_ENDPOINTS J_mask="<<mask<<" first="<<ti<<" second="<<tj<<'\n';}
    }
   }
  }
  if(reps%20000==0)std::cout<<"PROGRESS reps="<<reps<<" slope_pairs="<<lambda_pairs<<" jet_pairs="<<jet_pairs<<" full_pairs="<<full_pairs<<std::endl;
 }
 std::cout<<"TOTAL normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered<<" targets="<<nt<<" slopes="<<slopes.size()<<" slope_pairs="<<lambda_pairs<<" jet_pairs="<<jet_pairs<<" trace_pairs="<<trace_pairs<<" full_pairs="<<full_pairs<<" rational_pairs="<<rational_pairs<<" rational_consistent="<<rational_consistent<<" zero_potential="<<zero_potential<<" zero_matches="<<zero_matches<<std::endl;
 if(covered!=visited)throw std::runtime_error("coverage");return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
