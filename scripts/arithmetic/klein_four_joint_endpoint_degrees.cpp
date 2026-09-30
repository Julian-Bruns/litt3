// Joint subfield degrees of the three forced endpoint jets.
// This is a necessary local test, not a curve search.
#define KLEIN_FOUR_TWO_ENDPOINT_NO_MAIN
#include "klein_four_two_endpoint_planes.cpp"
M4 pow4(M4 a,int n){M4 b{};b[0][0]=1;while(n){if(n&1)b=times4(b,a);a=times4(a,a);n>>=1;}return b;}
int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("data.dat");
 init();for(int i=1;i<25;i++)for(int j=1;j<25;j++)if(mul25[i][j]==1)inv25[i]=j;
 std::ifstream f(argv[1]);for(auto&x:AP)f>>x;for(auto&x:D)f>>x;
 std::array<std::array<K,7>,4> coeff;for(auto&r:coeff)for(auto&a:r)for(auto&v:a)f>>v;
 if(!f)throw std::runtime_error("bad data");
 M4 aa{};aa[1][0]=1;std::array<M4,4>sig2{};for(int i=0;i<4;i++)sig2[i]=pow4(aa,625*i);
 auto fixed=[&](const M4&v){M4 w{};for(int i=0;i<4;i++)for(int j=0;j<4;j++)w[j]=plus7(w[j],scalar7(v[i],sig2[i][j][0]));return w==v;};
 std::array<F7,29>zp{};zp[0][0]=1;F7 zz{};zz[1]=1;for(int i=1;i<29;i++)zp[i]=mul(zp[i-1],zz);
 std::array<std::array<std::array<M4,7>,29>,4>labels{};
 for(int root=0;root<4;root++)for(int p=0;p<29;p++)for(int c=0;c<7;c++){
  int ex=c==0?0:(c==5?4*p:(c==6?5*p:p));
  for(int a=0;a<4;a++)labels[root][p][c][a]=scalar7(zp[ex%29],coeff[root][c][a]);
 }
 int signs[3][4]={{1,1,4,4},{1,4,1,4},{1,4,4,1}};
 uint64_t patterns=0,allnonzero=0,joint[4]{},rat[4]{},qzero=0;int samples=0;
 for(int a=0;a<4;a++)for(int b=a;b<4;b++)for(int c=b;c<4;c++)for(int d=c;d<4;d++){
  std::array<int,4>tags{a,b,c,d};uint64_t counts[4]{};
  for(int pa=0;pa<29;pa++)for(int pb=0;pb<29;pb++)for(int pc=0;pc<29;pc++){
   patterns++;std::array<int,4>phase{0,pa,pb,pc};int qm=0,rm=0,bz=0;
   for(int ch=0;ch<3;ch++){
    std::array<M4,7>s{};for(int i=0;i<4;i++)for(int k=0;k<7;k++)s[k]=plus4(s[k],scalar4(labels[tags[i]][phase[i]][k],signs[ch][i]));
    if(!nz4(s[1])){bz|=1<<ch;continue;}
    M4 h=times4(times4(s[2],s[3]),s[4]),r=times4(s[0],h);
    M4 num=minus4(times4(s[5],s[1]),times4(s[0],s[6])),dr=times4(num,times4(h,h));
    if(fixed(r)&&fixed(dr)){qm|=1<<ch;if(!nz4(s[0]))qzero++;}
    if(!nz3(Vec{r[1],r[2],r[3]})&&!nz3(Vec{dr[1],dr[2],dr[3]}))rm|=1<<ch;
   }
   if(!bz){allnonzero++;int n=__builtin_popcount(qm);joint[n]++;rat[__builtin_popcount(rm)]++;counts[n]++;
    if(n>=2&&samples++<16){std::cout<<"MULTI tags=";for(int i:tags)std::cout<<i<<',';std::cout<<" phases=";for(int i:phase)std::cout<<i<<',';std::cout<<" quadratic_mask="<<qm<<" rational_mask="<<rm<<'\n';}
   }
  }
  if(counts[2]||counts[3]){std::cout<<"CASE tags=";for(int i:tags)std::cout<<i<<',';std::cout<<" two="<<counts[2]<<" three="<<counts[3]<<std::endl;}
 }
 std::cout<<"TOTAL patterns="<<patterns<<" nonzero_B="<<allnonzero<<" quadratic_counts=";for(auto n:joint)std::cout<<n<<',';
 std::cout<<" rational_counts=";for(auto n:rat)std::cout<<n<<',';std::cout<<" zero_first_quadratic="<<qzero<<std::endl;
 return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
