// Exact finite forced-label test, NOT a search for geometric curves.
#include <array>
#include <fstream>
#include <iostream>
#include <vector>
#include <stdexcept>
using K=std::array<int,4>;
int add25[25][25],mul25[25][25],neg25[25];
int red5(int x){x%=5;return x<0?x+5:x;}
void init(){for(int a=0;a<25;a++){
 neg25[a]=red5(-a%5)+5*red5(-a/5);
 for(int b=0;b<25;b++){
  add25[a][b]=((a%5+b%5)%5)+5*((a/5+b/5)%5);
  int c0=(a%5)*(b%5)+3*(a/5)*(b/5);
  int c1=(a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5);
  mul25[a][b]=(c0%5)+5*(c1%5);
 }}}
struct Term{std::array<int,4> e;K c;};
using Poly=std::vector<Term>;
std::array<int,8> D;
bool zero_at(const Poly&p,const std::array<int,4>&es){
 std::array<K,29> v{};
 for(const auto&t:p){int e=0;for(int i=0;i<4;i++)e+=t.e[i]*es[i];e%=29;
  for(int i=0;i<4;i++)v[e][i]=add25[v[e][i]][t.c[i]];
 }
 for(int e=28;e>=7;e--)for(int i=0;i<4;i++)if(v[e][i]){
  int c=v[e][i];for(int j=0;j<=7;j++)v[e-7+j][i]=add25[v[e-7+j][i]][neg25[mul25[c][D[j]]]];
 }
 for(int e=0;e<7;e++)for(int i=0;i<4;i++)if(v[e][i])return false;
 return true;
}
int main(int argc,char**argv){try{
 if(argc!=2)throw std::runtime_error("usage: jet input.dat");
 init();std::ifstream f(argv[1]);if(!f)throw std::runtime_error("missing data");
 for(auto &d:D)f>>d;if(D.back()!=1)throw std::runtime_error("nonmonic D7");
 int nc;f>>nc;long total=0,open=0,zeros=0;
 for(int c=0;c<nc;c++){
  std::array<int,4> tags;for(auto &t:tags)f>>t;
  int np;f>>np;std::vector<Poly> ps(np);
  for(auto&p:ps){int n;f>>n;p.resize(n);for(auto&t:p){for(auto&e:t.e)f>>e;for(auto&a:t.c)f>>a;}}
  long used=0,zs=0,degenerate=0;
  for(int a=0;a<29;a++)for(int b=0;b<29;b++)for(int d=0;d<29;d++){
   std::array<int,4> exps{0,a,b,d};total++;
   bool good=true;for(int i=1;i<np;i++)if(zero_at(ps[i],exps)){good=false;break;}
   if(!good){degenerate++;continue;} used++;open++;
   if(zero_at(ps[0],exps)){zeros++;zs++;std::cout<<"ZERO roots=";for(int v:tags)std::cout<<v<<",";std::cout<<" exponents=0,"<<a<<","<<b<<","<<d<<"\n";}
  }
  std::cout<<"CASE roots=";for(int t:tags)std::cout<<t<<",";
  std::cout<<" tested=24389 open="<<used<<" degenerate="<<degenerate<<" determinant_zeros="<<zs<<std::endl;
 }
 std::cout<<"TOTAL tested="<<total<<" open="<<open<<" zeros="<<zeros<<std::endl;
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
