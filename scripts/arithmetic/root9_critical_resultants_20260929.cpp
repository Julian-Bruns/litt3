// Exact fixed-degree Sylvester resultants by degree-certified Fourier
// interpolation. Samples reconstruct a polynomial; they are not a point search.
#include "pro_companion140_20260928/src/native/algebra.hpp"
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <fstream>
#include <chrono>
#include <omp.h>
using namespace comp;
using boost::property_tree::ptree;

F resultant(FP a,FP b){
 F out(1);
 while(b.deg()>0){
  int m=a.deg(),n=b.deg();
  if(m<n){if((m*n)&1)out=-out;std::swap(a,b);continue;}
  auto r=a.mod(b);if(!r)return F(0);
  if((m*n)&1)out=-out;
  out*=b.c.back().pow(m-r.deg());a=std::move(b);b=std::move(r);
 }
 if(!b)return F(0);return out*b[0].pow(a.deg());
}
F fixed_resultant(const FP&a,const FP&b,int m,int n){
 if(!a||!b)return F(0);
 if(a.deg()<m&&b.deg()<n)return F(0);
 F r=resultant(a,b);
 if(a.deg()<m){r*=b.c.back().pow(m-a.deg());if((n*(m-a.deg()))&1)r=-r;}
 if(b.deg()<n)r*=a.c.back().pow(n-b.deg());
 return r;
}
F determinant(std::vector<std::vector<F>> a){F d(1);int n=a.size();for(int j=0;j<n;j++){
 int k=j;while(k<n&&!a[k][j])k++;if(k==n)return F(0);if(k!=j){std::swap(a[k],a[j]);d=-d;}
 F t=a[j][j];d*=t;F inv=t.inverse();for(int k=j+1;k<n;k++){F c=a[k][j]*inv;for(int l=j+1;l<n;l++)a[k][l]-=c*a[j][l];}
 }return d;}
F sylvester(const FP&a,const FP&b,int m,int n){
 std::vector<std::vector<F>> s(m+n,std::vector<F>(m+n));
 for(int i=0;i<n;i++)for(int j=0;j<=m;j++)s[i][i+j]=a[m-j];
 for(int i=0;i<m;i++)for(int j=0;j<=n;j++)s[n+i][i+j]=b[n-j];return determinant(s);
}
std::vector<F> dft(const std::vector<F>&a,F root){
 int n=a.size();if(n==1)return a;
 int r=0;for(int p:{2,3,13})if(n%p==0){r=p;break;}
 if(!r){std::vector<F>b(n);F w(1);for(int k=0;k<n;k++){F t(1);for(int j=0;j<n;j++){b[k]+=a[j]*t;t*=w;}w*=root;}return b;}
 int m=n/r;std::vector<std::vector<F>>parts(r);
 for(int j=0;j<r;j++){std::vector<F>x(m);for(int i=0;i<m;i++)x[i]=a[j+r*i];parts[j]=dft(x,root.pow(r));}
 std::vector<F>b(n);F w(1);for(int k=0;k<n;k++){F t(1);for(int j=0;j<r;j++){b[k]+=parts[j][k%m]*t;t*=w;}w*=root;}return b;
}
void controls(){
 for(int m=1;m<=7;m++)for(int n=1;n<=7;n++)for(int dropa=0;dropa<=2;dropa++)for(int dropb=0;dropb<=2;dropb++){
  std::vector<F>a(std::max(1,m-dropa+1)),b(std::max(1,n-dropb+1));
  for(int i=0;i<(int)a.size();i++)a[i]=F(25).pow(7*i+3*m+n);
  for(int i=0;i<(int)b.size();i++)b[i]=F(25).pow(11*i+m+5*n);
  assert(fixed_resultant(FP(a),FP(b),m,n)==sylvester(FP(a),FP(b),m,n));
 }
 constexpr int N=15024;F rt=F(25).pow(F::NN/N);assert(rt.pow(N)==F(1));for(int p:{2,3,313})assert(rt.pow(N/p)!=F(1));
 std::vector<F>a(N);for(int i=0;i<N;i+=113)a[i]=F(25).pow(i+2);
 auto b=dft(dft(a,rt),rt.inverse());F ni=F(N%5).inverse();for(int i=0;i<N;i++)assert(b[i]*ni==a[i]);
 std::cout<<"SYLVESTER_DEGREE_DROP_AND_DFT_CONTROLS_PASS"<<std::endl;
}
int main(int argc,char**argv){try{
 F::init();FastK::init();controls();if(argc==1)return 0;if(argc!=3)throw std::runtime_error("usage native_tails.json output.json");
 ptree data;boost::property_tree::read_json(argv[1],data);std::vector<std::vector<FP>> rows;
 for(auto&[key,row]:data.get_child("rows")){
  std::vector<FP> hs;
  for(auto&[k,term]:row){auto it=term.begin();int h=it++->second.get_value<int>(),q=it++->second.get_value<int>();F c(it->second.get_value<unsigned>());
   if(h>=(int)hs.size())hs.resize(h+1);if(q>=(int)hs[h].c.size())hs[h].c.resize(q+1);hs[h].c[q]=c;
  }rows.push_back(std::move(hs));
 }
 int maxbound=0;for(auto&[key,b]:data.get_child("resultant_bounds"))maxbound=std::max(maxbound,b.get_value<int>());
 int N=0;for(int k=maxbound+1;k<=(int)F::NN;k++)if(F::NN%k==0){N=k;break;}
 if(!N)throw std::runtime_error("degree bound exceeds available multiplicative grid");
 F rt=F(25).pow(F::NN/N);std::vector<F> qs(N);qs[0]=1;for(int i=1;i<N;i++)qs[i]=qs[i-1]*rt;
 std::vector<std::vector<F>> values(2,std::vector<F>(N));
 #pragma omp parallel for schedule(dynamic,16)
 for(int k=0;k<N;k++){
  std::array<FP,3> p;for(int i=0;i<3;i++){for(auto&c:rows[i])p[i].c.push_back(c.eval(qs[k]));p[i].trim();}
  for(int i=0;i<2;i++)values[i][k]=fixed_resultant(p[0],p[i+1],rows[0].size()-1,rows[i+1].size()-1);
 }
 std::cout<<"ALL_EXACT_SAMPLES_DONE "<<N<<std::endl;
 std::ofstream out(argv[2]);out<<"{\"scope\":\"Fixed H-resultants of critical-norm tails17/18 and17/19; not a geometric exclusion by themselves\",\"length\":"<<N<<",\"root\":"<<rt.v<<",\"rows\":[";
 int i=0;for(auto&[key,bb]:data.get_child("resultant_bounds")){
  int bound=bb.get_value<int>();assert(bound<N);auto coeff=dft(values[i],rt.inverse());F invn=F(N%5).inverse();for(auto&c:coeff)c*=invn;
  for(int j=bound+1;j<N;j++)assert(!coeff[j]);FP p(coeff);for(int k:{0,1,71,313,N/2,N-1})assert(p.eval(qs[k%N])==values[i][k%N]);
  if(i)out<<',';out<<"{\"bound\":"<<bound<<",\"degree\":"<<p.deg()<<",\"coefficients\":[";
  for(int j=0;j<=p.deg();j++){if(j)out<<',';out<<p[j].v;}out<<"]}";
  std::cout<<"RECONSTRUCTED "<<i<<" degree "<<p.deg()<<" bound "<<bound<<std::endl;i++;
 }out<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
