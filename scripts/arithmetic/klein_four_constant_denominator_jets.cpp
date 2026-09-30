// Exact test: can the logarithmic first jet c_i/B_i lie in M=F_(25^7)?
// This is a necessary condition for a constant T_i, since C_i/z_i has
// logarithmic derivative in M at the unramified parameter endpoint.
#define KLEIN_FOUR_TWO_ENDPOINT_NO_MAIN
#include "klein_four_two_endpoint_planes.cpp"
int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("usage: program two_endpoint_planes.dat");
 init();std::ifstream f(argv[1]);for(auto&x:AP)f>>x;for(auto&x:D)f>>x;
 std::array<std::array<K,7>,4> coeff;for(auto&r:coeff)for(auto&a:r)for(auto&v:a)f>>v;
 if(!f)throw std::runtime_error("bad data");
 std::array<F7,29>zp{};zp[0][0]=1;F7 zz{};zz[1]=1;for(int i=1;i<29;i++)zp[i]=mul(zp[i-1],zz);
 std::array<std::array<std::array<M4,2>,29>,4> labels{};
 for(int root=0;root<4;root++)for(int p=0;p<29;p++)for(int j=0;j<2;j++)
  for(int a=0;a<4;a++)labels[root][p][j][a]=scalar7(zp[(j==0?p:5*p)%29],coeff[root][j==0?1:6][a]);
 int signs[3][4]={{1,1,4,4},{1,4,1,4},{1,4,4,1}};
 uint64_t tested=0,bzero=0,rational=0;
 for(int a=0;a<4;a++)for(int b=a;b<4;b++)for(int c=b;c<4;c++)for(int d=c;d<4;d++){
  std::array<int,4>tags{a,b,c,d};uint64_t before=rational;
  for(int pa=0;pa<29;pa++)for(int pb=0;pb<29;pb++)for(int pc=0;pc<29;pc++){
   std::array<int,4>phase{0,pa,pb,pc};
   for(int ch=0;ch<3;ch++){
    tested++;M4 B{},C{};
    for(int i=0;i<4;i++){
     B=plus4(B,scalar4(labels[tags[i]][phase[i]][0],signs[ch][i]));
     C=plus4(C,scalar4(labels[tags[i]][phase[i]][1],signs[ch][i]));
    }
    if(!nz4(B)){bzero++;continue;}
    int pivot=0;while(!nz(B[pivot]))pivot++;
    bool proportional=true;
    for(int i=0;i<4;i++)if(i!=pivot && mul(C[i],B[pivot])!=mul(C[pivot],B[i])){proportional=false;break;}
    if(proportional){rational++;
     if(rational<=32){std::cout<<"MATCH tags=";for(int x:tags)std::cout<<x<<',';
      std::cout<<" phases=";for(int x:phase)std::cout<<x<<',';std::cout<<" character="<<ch<<'\n';}
    }
   }
  }
  if(rational>before){std::cout<<"CASE tags=";for(int x:tags)std::cout<<x<<',';
   std::cout<<" rational="<<rational-before<<std::endl;}
 }
 std::cout<<"TOTAL tested="<<tested<<" Bzero="<<bzero<<" rational_logarithmic_jets="<<rational<<std::endl;
 if(tested!=2560845)throw std::runtime_error("coverage mismatch");
 return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
