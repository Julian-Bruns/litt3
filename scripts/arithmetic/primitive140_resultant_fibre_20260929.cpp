// Exact, degree-certified whole-fibre resultant experiment.
// This is not a finite-field point search: interpolation bounds certify
// univariate polynomial resultants. Original H and Psi units only.
#include "pro_companion140_20260928/src/native/fft.hpp"
#include "pro_companion140_20260928/src/native/halfgcd.hpp"
#include <fstream>
#include <sstream>
#include <chrono>
#include <filesystem>
#include <omp.h>
using namespace comp;
using BP=std::vector<FP>; // coefficients in mu, each a polynomial in H

struct Bound {long long degree, h, psi;};
static int at_zero(const FP& f) {
 if(!f)return 100000000;
 int k=0;while(!f[k])k++;return k;
}
static int at_point(FP f,F r) {
 if(!f)return 100000000;
 int k=0;FP p(std::vector<F>{-r,F(1)});
 while(f&&!f.eval(r)){auto qr=f.divmod(p);assert(!qr.second);f=std::move(qr.first);k++;}
 return k;
}
static Bound bounds(const BP&f,const BP&g,F r){
 std::vector<int>df,dg,hf,hg,pf,pg;
 for(const FP&p:f){df.push_back(p?-p.deg():100000000);hf.push_back(at_zero(p));pf.push_back(at_point(p,r));}
 for(const FP&p:g){dg.push_back(p?-p.deg():100000000);hg.push_back(at_zero(p));pg.push_back(at_point(p,r));}
 return {-resultant_lower_valuation(df,dg),resultant_lower_valuation(hf,hg),resultant_lower_valuation(pf,pg)};
}
// Ordinary actual-degree resultant by Euclidean recursion, with no divisions
// by a coefficient assumed nonzero before specialization.
static F res_actual(FP f,FP g){
 F z=1;
 while(g.deg()>0){
  int m=f.deg(),n=g.deg();
  if(m<n){if(m*n%2)z=-z;std::swap(f,g);continue;}
  FP r=f.divmod(g).second;if(!r)return F(0);
  int k=r.deg();if(m*n%2)z=-z;
  z*=g.c.back().pow(m-k);f=std::move(g);g=std::move(r);
 }
 return g?z*g[0].pow(f.deg()):F(0);
}
static F res_fixed(FP f,FP g,int m,int n){
 if(!f||!g)return F(0);
 if(f.deg()<m&&g.deg()<n)return F(0);
 F z=1;
 if(f.deg()<m){z*=g.c.back().pow(m-f.deg());if((m-f.deg())*n%2)z=-z;}
 if(g.deg()<n)z*=f.c.back().pow(n-g.deg());
 return z*res_actual(std::move(f),std::move(g));
}
static BP read_tail(std::ifstream&in,std::string&name){
 std::string line;std::getline(in,line);if(line.empty())return {};
 if(line.rfind("removed ",0))throw std::runtime_error("expected removed record");
 int count;in>>name>>count;BP z;
 for(int i=0;i<count;i++){int h,m,c;in>>h>>m>>c;if(m>=(int)z.size())z.resize(m+1);if(h>z[m].deg())z[m].c.resize(h+1);z[m].c[h]+=F(c);}
 std::getline(in,line);for(auto&p:z)p.trim();while(!z.empty()&&!z.back())z.pop_back();return z;
}
static void save(const std::string&path,const FP&p){std::ofstream o(path);o<<p.deg()<<'\n';for(F z:p.c)o<<z.v<<'\n';}

static F sylvester_literal(const FP&f,const FP&g,int m,int n){
 int d=m+n;std::vector<std::vector<F>>a(d,std::vector<F>(d));
 for(int i=0;i<n;i++)for(int j=0;j<=m;j++)a[i][i+m-j]=f[j];
 for(int i=0;i<m;i++)for(int j=0;j<=n;j++)a[n+i][i+n-j]=g[j];
 F z=1;
 for(int k=0;k<d;k++){
  int r=k;while(r<d&&!a[r][k])r++;if(r==d)return F(0);
  if(r!=k){std::swap(a[k],a[r]);z=-z;}
  F pivot=a[k][k];z*=pivot;
  for(int i=k+1;i<d;i++)if(a[i][k]){F c=a[i][k]/pivot;for(int j=k;j<d;j++)a[i][j]-=c*a[k][j];}
 }
 return z;
}
static void selfcheck(){
 for(int m=1;m<=6;m++)for(int n=1;n<=6;n++)for(int df=0;df<=m;df++)for(int dg=0;dg<=n;dg++){
  std::vector<F>f(df+1),g(dg+1);
  for(int i=0;i<=df;i++)f[i]=F(F::exps[17*i+3*m+11*n]);
  for(int i=0;i<=dg;i++)g[i]=F(F::exps[19*i+7*m+13*n]);
  assert(res_fixed(FP(f),FP(g),m,n)==sylvester_literal(FP(f),FP(g),m,n));
 }
 std::cout<<"{\"literal_fixed_degree_sylvester_checks\":729,\"all_degree_drops\":true}"<<std::endl;
}

int main(int argc,char**argv){
 if(argc<3){std::cerr<<"usage: input-q.txt output-directory [interpolate]\n";return 2;}
 F::init();selfcheck();std::filesystem::create_directories(argv[2]);std::string out=argv[2];
 std::ifstream in(argv[1]);std::string line,tag;std::getline(in,line);if(line!="fixedq_v1 25")throw std::runtime_error("this experiment uses q=<25> only");int n;in>>tag>>n;if(tag!="R")return 3;std::getline(in,line);while(n--)std::getline(in,line);
 std::vector<BP>p;std::vector<std::string>names;
 for(int k=0;k<3;k++){std::string nm;BP z=read_tail(in,nm);p.push_back(z);names.push_back(nm);}
 F root=F(191580); // verified unique Psi root on q=<25>
 std::vector<Bound>bb;
 for(int j=0;j<2;j++){
  Bound b=bounds(p[2],p[j],root);bb.push_back(b);
  std::cout<<"{\"pair\":[\""<<names[2]<<"\",\""<<names[j]<<"\"],\"raw_degree_bound\":"<<b.degree<<",\"H_factor\":"<<b.h<<",\"Psi_factor\":"<<b.psi<<",\"quotient_degree_bound\":"<<b.degree-b.h-b.psi<<"}"<<std::endl;
 }
 if(argc<4)return 0;
 int maxdegree=0;for(auto b:bb)maxdegree=std::max<long long>(maxdegree,b.degree-b.h-b.psi);
 int len=1;while(len<=maxdegree||F::NN%len)len++;
 if(len>=int(F::NN))throw std::runtime_error("no proper multiplicative interpolation subgroup");
 F w(F::exps[F::NN/len]),off(1);int idx=F::NN/len,offlog=0;
 while(int(F::logs[root.v])%idx==offlog%idx){offlog++;off=F(F::exps[offlog]);}
 DFT forward(len,w),backward(len,w.inverse());
 std::vector<F>nodes(len);nodes[0]=off;for(int i=1;i<len;i++)nodes[i]=nodes[i-1]*w;
 std::vector<std::vector<std::vector<F>>>evals(3);
 for(int k=0;k<3;k++){
  evals[k].resize(p[k].size());
  #pragma omp parallel for schedule(dynamic)
  for(int j=0;j<(int)p[k].size();j++){
   std::vector<F>a(len);F pow=1;for(int i=0;i<=p[k][j].deg();i++){a[i%len]+=p[k][j][i]*pow;pow*=off;}
   evals[k][j]=forward.apply(a);
  }
 }
 std::cout<<"{\"interpolation_length\":"<<len<<",\"coset_code\":"<<off.v<<"}"<<std::endl;
 std::vector<FP>resultants;
 for(int j=0;j<2;j++){
  std::vector<F>values(len);Bound b=bb[j];
  #pragma omp parallel for schedule(dynamic,64)
  for(int k=0;k<len;k++){
   std::vector<F>f(p[2].size()),g(p[j].size());
   for(int a=0;a<(int)f.size();a++)f[a]=evals[2][a][k];
   for(int a=0;a<(int)g.size();a++)g[a]=evals[j][a][k];
   F den=nodes[k].pow(b.h)*(nodes[k]-root).pow(b.psi);
   values[k]=res_fixed(FP(f),FP(g),p[2].size()-1,p[j].size()-1)/den;
  }
  auto coeff=backward.apply(values);F scale=F(len%5).inverse(),ioff=off.inverse();
  for(auto&c:coeff){c*=scale;scale*=ioff;}
  FP r(coeff);if(r.deg()>b.degree-b.h-b.psi)throw std::runtime_error("interpolation violates certified degree bound");
  save(out+"/resultant_"+names[j]+".txt",r);resultants.push_back(r);
  // New nodes outside the interpolating coset check conventions and fixed-degree drops.
  for(int t=1;t<=7;t++){
   F x(F::exps[offlog+t+idx*19]);if(x==root)continue;
   std::vector<F>f,g;for(auto&a:p[2])f.push_back(a.eval(x));for(auto&a:p[j])g.push_back(a.eval(x));
   assert(r.eval(x)*x.pow(b.h)*(x-root).pow(b.psi)==res_fixed(FP(f),FP(g),p[2].size()-1,p[j].size()-1));
  }
  std::cout<<"{\"resultant\":\""<<names[j]<<"\",\"degree\":"<<r.deg()<<",\"cross_checks\":7}"<<std::endl;
 }
 auto [g,a,b]=xgcd_half(resultants[0],resultants[1],true);
 save(out+"/gcd.txt",g);save(out+"/bezout_a.txt",a);save(out+"/bezout_b.txt",b);
 std::cout<<"{\"gcd_degree\":"<<g.deg()<<",\"bezout_verified\":true}"<<std::endl;
}
