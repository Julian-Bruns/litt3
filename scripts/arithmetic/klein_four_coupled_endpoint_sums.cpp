// Necessary endpoint test for the new coupled single-triple-pole polynomial.
// No search for curves; records all leading-denominator boundaries separately.
#define KLEIN_FOUR_TWO_ENDPOINT_NO_MAIN
#include "klein_four_two_endpoint_planes.cpp"
int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("data.dat");
 init();for(int i=1;i<25;i++)for(int j=1;j<25;j++)if(mul25[i][j]==1)inv25[i]=j;
 std::ifstream f(argv[1]);for(auto&x:AP)f>>x;for(auto&x:D)f>>x;
 std::array<std::array<K,7>,4> coeff;for(auto&r:coeff)for(auto&a:r)for(auto&v:a)f>>v;
 if(!f)throw std::runtime_error("bad data");
 std::array<F7,29>zp{};zp[0][0]=1;F7 zz{};zz[1]=1;for(int i=1;i<29;i++)zp[i]=mul(zp[i-1],zz);
 std::array<std::array<std::array<M4,7>,29>,4>labels{};
 for(int root=0;root<4;root++)for(int p=0;p<29;p++)for(int c=0;c<7;c++){
  int ex=c==0?0:(c==5?4*p:(c==6?5*p:p));
  for(int a=0;a<4;a++)labels[root][p][c][a]=scalar7(zp[ex%29],coeff[root][c][a]);
 }
 int signs[3][4]={{1,1,4,4},{1,4,1,4},{1,4,4,1}};
 uint64_t patterns=0,boundaries=0,zero_sum=0,zero_jet=0;
 for(int a=0;a<4;a++)for(int b=a;b<4;b++)for(int c=b;c<4;c++)for(int d=c;d<4;d++){
  std::array<int,4>tags{a,b,c,d};uint64_t old=zero_sum;
  for(int pa=0;pa<29;pa++)for(int pb=0;pb<29;pb++)for(int pc=0;pc<29;pc++){
   patterns++;std::array<int,4>phase{0,pa,pb,pc};std::array<std::array<M4,7>,3>s{};bool bz=false;
   for(int ch=0;ch<3;ch++){
    for(int i=0;i<4;i++)for(int k:{0,1,5,6})s[ch][k]=plus4(s[ch][k],scalar4(labels[tags[i]][phase[i]][k],signs[ch][i]));
    bz|=!nz4(s[ch][1]);
   }
   if(bz){boundaries++;continue;}
   M4 val{},der{};
   for(int i=0;i<3;i++){
    int j=(i+1)%3,k=(i+2)%3;
    val=plus4(val,times4(s[i][0],times4(s[j][1],s[k][1])));
   }
   if(nz4(val))continue;zero_sum++;
   if(a!=d)throw std::runtime_error("unexpected noncoalesced zero value sum");
   for(int i=0;i<3;i++){
    int j=(i+1)%3,k=(i+2)%3;
    der=plus4(der,times4(s[i][5],times4(s[j][1],s[k][1])));
    der=plus4(der,times4(s[i][0],plus4(times4(s[j][6],s[k][1]),times4(s[j][1],s[k][6]))));
   }
   if(!nz4(der)){zero_jet++;std::cout<<"ZERO_JET tags=";for(int v:tags)std::cout<<v<<',';std::cout<<" phase=";for(int v:phase)std::cout<<v<<',';std::cout<<'\n';}
  }
  if(zero_sum!=old){std::cout<<"CASE tags=";for(int v:tags)std::cout<<v<<',';std::cout<<" zero_sums="<<zero_sum-old<<std::endl;}
 }
 std::cout<<"TOTAL patterns="<<patterns<<" Bzero_boundaries="<<boundaries<<" zero_sum="<<zero_sum<<" zero_jet="<<zero_jet<<std::endl;
 if(patterns!=853615 || boundaries!=514 || zero_sum!=97216 || zero_jet!=0)
  throw std::runtime_error("endpoint coverage or nonvanishing assertion failed");
 return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
