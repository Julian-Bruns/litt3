// Necessary endpoint tests; permitted labels do NOT construct curves.
#define main old_evaluator_main
#include "klein_four_constant_character_jet.cpp"
#undef main

int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("usage: near_word data.dat");
 init();std::ifstream f(argv[1]);if(!f)throw std::runtime_error("missing data");
 for(auto &d:D)f>>d;int nc;f>>nc;
 long total=0,valid=0,duplicates=0,zeros[4]={},hist3[4]={},hist4[4]={};
 long linear_pairs=0,linear_pair_bad=0,quadratic_only=0;
 for(int ci=0;ci<nc;ci++){
  std::array<int,4> tags;for(auto&t:tags)f>>t;
  int np;f>>np;if(np!=9)throw std::runtime_error("need triples");
  std::vector<Poly> ps(np);
  for(auto&p:ps){int n;f>>n;p.resize(n);for(auto&t:p){for(auto&e:t.e)f>>e;for(auto&a:t.c)f>>a;}}
  int alpha_nonzero=0;
  int signs[3][4]={{1,1,-1,-1},{1,-1,1,-1},{1,-1,-1,1}};
  for(int i=0;i<3;i++){int count[4]={};for(int j=0;j<4;j++)count[tags[j]]+=signs[i][j];
   bool nonzero=false;for(int j=0;j<4;j++)if(count[j])nonzero=true;if(nonzero)alpha_nonzero|=1<<i;}
  long count=0,zs[4]={},h3[4]={},h4[4]={};
  for(int a=0;a<29;a++)for(int b=0;b<29;b++)for(int c=0;c<29;c++){
   total++;std::array<int,4> es{0,a,b,c};bool dup=false;
   for(int i=0;i<4;i++)for(int j=0;j<i;j++)if(tags[i]==tags[j]&&es[i]==es[j])dup=true;
   if(dup)duplicates++;valid++;count++;
   int nz=0,k3=0,k4=0,mask3=0,mask4=0;
   for(int i=0;i<3;i++){
    if(zero_at(ps[3*i],es)){nz++;continue;}
    if(zero_at(ps[3*i+1],es)){k3++;mask3|=1<<i;}
    if(zero_at(ps[3*i+2],es)){k4++;mask4|=1<<i;}
   }
   zeros[nz]++;zs[nz]++;hist3[k3]++;hist4[k4]++;h3[k3]++;h4[k4]++;
   int only4=mask4&~mask3&alpha_nonzero;
   if(only4){quadratic_only+=__builtin_popcount((unsigned)only4);
    std::cout<<"QUADRATIC roots=";for(int t:tags)std::cout<<t<<",";
    std::cout<<" exponents=0,"<<a<<","<<b<<","<<c<<" mask="<<only4<<"\n";}
   if(nz==0&&__builtin_popcount((unsigned)(mask4&alpha_nonzero))>=2){
    linear_pairs++;if(only4)linear_pair_bad++;
   }
   if(mask3&alpha_nonzero){
    std::cout<<"LABEL roots=";for(int t:tags)std::cout<<t<<",";
    std::cout<<" exponents=0,"<<a<<","<<b<<","<<c<<" mask3="<<mask3<<" mask4="<<mask4<<"\n";
   }
  }
  std::cout<<"CASE roots=";for(int t:tags)std::cout<<t<<",";
  std::cout<<" tested="<<count<<" zeroB=";for(auto a:zs)std::cout<<a<<",";
  std::cout<<" rank3=";for(auto a:h3)std::cout<<a<<",";
  std::cout<<" rank4=";for(auto a:h4)std::cout<<a<<",";std::cout<<std::endl;
 }
 std::cout<<"TOTAL tested="<<total<<" retained="<<valid<<" coincident_leading_labels="<<duplicates<<" zeroB=";for(auto a:zeros)std::cout<<a<<",";
 std::cout<<" rank3=";for(auto a:hist3)std::cout<<a<<",";
 std::cout<<" rank4=";for(auto a:hist4)std::cout<<a<<",";std::cout<<std::endl;
 std::cout<<"LINEAR pair_labels="<<linear_pairs<<" quadratic_only_pairs="<<linear_pair_bad<<" quadratic_only_characters="<<quadratic_only<<std::endl;
 if(linear_pair_bad)throw std::runtime_error("additional degree-four pair case");
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
