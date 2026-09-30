#define FINITE_ALGEBRA_NO_MAIN
#include "finite_algebra.cpp"
#undef main
#include "kpoly.hpp"
std::mt19937 rng(20260927);
std::vector<KP> factors;
void edf(const KP&f,int d){
 if((int)f.size()-1==d){factors.push_back(f);return;}
 cpp_int exponent=1;for(int j=0;j<d;j++)exponent*=NN;exponent=(exponent-1)/2;
 for(;;){KP a(f.size()-1);for(int&c:a)c=rng()%NN;KP g=gd(f,ps(mpow(a,exponent,f),KP{1}));if(g.size()>1&&g.size()<f.size()){edf(g,d);edf(pd(f,g).first,d);return;}}
}
int main(int argc,char**argv){
 if(argc!=4)return 2;initfield(argv[1]);std::ifstream in(argv[2]);int n;in>>n;KP f(n);for(int&c:f)in>>c;KP original=f;
 KP z={0,1};int d=1;
 while(2*d<=(int)f.size()-1){
  z=mpow(z,NN,f);KP g=gd(f,ps(z,KP{0,1}));
  if(g.size()>1){std::cerr<<"DDF degree="<<d<<" total="<<g.size()-1<<std::endl;edf(g,d);f=pd(f,g).first;if(f.size()==1)break;z=md(z,f);}
  d++;
 }
 if(f.size()>1)factors.push_back(monic(f));
 KP product={1};std::ofstream out(argv[3]);out<<factors.size()<<"\n";
 for(auto f:factors){
  int d=f.size()-1;KP z={0,1};for(int i=0;i<d;i++)z=mpow(z,NN,f);if(z!=KP({0,1})&&md(ps(z,KP{0,1}),f).size())abort();
  int e=d;for(int p=2;p<=e;p++)if(e%p==0){while(e%p==0)e/=p;z={0,1};for(int i=0;i<d/p;i++)z=mpow(z,NN,f);if(gd(f,ps(z,KP{0,1})).size()!=1)abort();}
  product=pm(product,f);std::cerr<<"verified irreducible degree "<<d<<std::endl;out<<f.size()<<"\n";for(int c:f)out<<c<<" ";out<<"\n";
 }
 if(product!=original)abort();std::cerr<<"factorization verified; factors="<<factors.size()<<std::endl;
}
