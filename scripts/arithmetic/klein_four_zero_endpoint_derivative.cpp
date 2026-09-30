#define main old_jet_main
#include "klein_four_constant_character_jet.cpp"
#undef main
int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("usage: zero_derivative data.dat");
 init();std::ifstream f(argv[1]);for(auto&d:D)f>>d;int nc;f>>nc;
 long total=0,bzero=0,bzero_a_nonzero=0,s_zero=0,checked_jets=0,bzero_nonzero_first_jet=0;
 for(int k=0;k<nc;k++){
  std::array<int,4>roots;for(auto&r:roots)f>>r;int np;f>>np;
  if(np!=9&&np!=15)throw std::runtime_error("data shape");int width=np/3;std::vector<Poly>ps(np);
  for(auto&p:ps){int n;f>>n;p.resize(n);for(auto&t:p){for(auto&e:t.e)f>>e;for(auto&c:t.c)f>>c;}}
  for(int a=0;a<29;a++)for(int b=0;b<29;b++)for(int c=0;c<29;c++){
   std::array<int,4>es{0,a,b,c};for(int i=0;i<3;i++){
    total++;if(zero_at(ps[width*i],es)){
     bzero++;if(!zero_at(ps[width*i+1],es))bzero_a_nonzero++;
     if(width==5){checked_jets++;if(!zero_at(ps[width*i+3],es)||!zero_at(ps[width*i+4],es))bzero_nonzero_first_jet++;}
     continue;}
    if(zero_at(ps[width*i+2],es)){
     s_zero++;std::cout<<"ZERO roots=";for(int r:roots)std::cout<<r<<",";
     std::cout<<" phases=0,"<<a<<","<<b<<","<<c<<" character="<<i<<"\n";
    }
   }
  }
 }
 std::cout<<"TOTAL character_tests="<<total<<" zero_B="<<bzero<<" zero_B_nonzero_A="<<bzero_a_nonzero<<" nonzero_B_zero_derivative="<<s_zero<<" zero_B_individual_jet_checks="<<checked_jets<<" zero_B_nonzero_first_jet="<<bzero_nonzero_first_jet<<std::endl;
 if(bzero_a_nonzero||s_zero||bzero_nonzero_first_jet)throw std::runtime_error("unexcluded endpoint label");
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
