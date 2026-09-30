// Reuse the exact cyclotomic evaluator, with a different certified question.
#define main previous_jet_evaluator_main
#include "klein_four_constant_character_jet.cpp"
#undef main

int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("usage: field_jet data.dat");
 init();std::ifstream f(argv[1]);if(!f)throw std::runtime_error("missing data");
 for(auto &d:D)f>>d;
 int nc;f>>nc;long total=0,open=0,rational0=0,rational1=0;
 for(int c=0;c<nc;c++){
  std::array<int,4> tags;for(auto &t:tags)f>>t;
  int np;f>>np;if(np!=9)throw std::runtime_error("need three triples");
  std::vector<Poly> ps(np);
  for(auto&p:ps){int n;f>>n;p.resize(n);for(auto&t:p){for(auto&e:t.e)f>>e;for(auto&a:t.c)f>>a;}}
  long op=0,r0=0,r1=0;
  for(int a=0;a<29;a++)for(int b=0;b<29;b++)for(int d=0;d<29;d++){
   std::array<int,4> es{0,a,b,d};
   for(int i=0;i<3;i++){
    total++;
    if(zero_at(ps[3*i],es))continue;open++;op++;
    if(!zero_at(ps[3*i+1],es))continue;rational0++;r0++;
    if(!zero_at(ps[3*i+2],es))continue;rational1++;r1++;
    if(r1<=3){std::cout<<"SURVIVOR roots=";for(int t:tags)std::cout<<t<<",";
     std::cout<<" character="<<i<<" exponents=0,"<<a<<","<<b<<","<<d<<"\n";}
   }
  }
  std::cout<<"CASE roots=";for(int t:tags)std::cout<<t<<",";
  std::cout<<" open="<<op<<" rational_value="<<r0<<" rational_first_jet="<<r1<<std::endl;
 }
 std::cout<<"TOTAL tests="<<total<<" open="<<open<<" rational_value="<<rational0<<" rational_first_jet="<<rational1<<std::endl;
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
