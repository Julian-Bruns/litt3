// Degree-certified resultant interpolation with eight Hasse jets.
// No factorial denominators: jets beyond characteristic five are retained.
#define main critical_resultant_main
#include "root9_critical_resultants_20260929.cpp"
#undef main
#include "root9_large_fourier_20260929.hpp"
#include "pro_companion140_20260928/src/native/halfgcd.hpp"
static constexpr int DEPTH=8;
int choose5(int n,int k){static const int c[5][5]={{1,0,0,0,0},{1,1,0,0,0},{1,2,1,0,0},{1,3,3,1,0},{1,4,1,4,1}};int r=1;while(k){r=r*c[n%5][k%5]%5;n/=5;k/=5;}return r;}
struct MJ{
 std::array<F,DEPTH> c{};MJ(int k=0){c[0]=F(k%5);}MJ(F k){c[0]=k;}
 explicit operator bool()const{for(auto x:c)if(x)return true;return false;}
 friend MJ operator+(MJ a,const MJ&b){for(int i=0;i<DEPTH;i++)a.c[i]+=b.c[i];return a;}
 friend MJ operator-(MJ a){for(auto&x:a.c)x=-x;return a;}
 friend MJ operator-(const MJ&a,const MJ&b){return a+-b;}
 friend MJ operator*(const MJ&a,const MJ&b){MJ r;for(int i=0;i<DEPTH;i++)if(a.c[i])for(int j=0;i+j<DEPTH;j++)r.c[i+j]+=a.c[i]*b.c[j];return r;}
 MJ&operator+=(const MJ&b){return *this=*this+b;}MJ&operator-=(const MJ&b){return *this=*this-b;}MJ&operator*=(const MJ&b){return *this=*this*b;}
 friend bool operator==(const MJ&a,const MJ&b){return a.c==b.c;}
 MJ inverse()const{if(!c[0])throw std::runtime_error("nonunit multijet");MJ r(c[0].inverse());for(int n=1;n<DEPTH;n++){F v;for(int j=1;j<=n;j++)v+=c[j]*r.c[n-j];r.c[n]=-v*r.c[0];}return r;}
 MJ pow(int n)const{MJ a=*this,r(1);while(n){if(n&1)r*=a;n>>=1;if(n)a*=a;}return r;}
 MJ up(int n)const{MJ r;for(int i=0;i+n<DEPTH;i++)r.c[i+n]=c[i];return r;}
 MJ down(int n)const{MJ r;for(int i=n;i<DEPTH;i++)r.c[i-n]=c[i];return r;}
 int order()const{for(int i=0;i<DEPTH;i++)if(c[i])return i;return DEPTH;}
};
using MP=Poly<MJ>;
MJ detjet(std::vector<std::vector<MJ>>a){
 int n=a.size();MJ d(1);
 for(int k=0;k<n;k++){
  int r=-1,s=-1,least=DEPTH;
  for(int i=k;i<n;i++)for(int j=k;j<n;j++)if(a[i][j].order()<least){least=a[i][j].order();r=i;s=j;}
  if(r<0||least*(n-k)>=DEPTH)return MJ();
  if(least){d=d.up(least*(n-k));if(!d)return d;for(int i=k;i<n;i++)for(int j=k;j<n;j++)a[i][j]=a[i][j].down(least);}
  if(r!=k){std::swap(a[r],a[k]);d=-d;}if(s!=k){for(auto&row:a)std::swap(row[s],row[k]);d=-d;}
  MJ p=a[k][k],iv=p.inverse();d*=p;
  for(int i=k+1;i<n;i++){MJ t=a[i][k]*iv;for(int j=k+1;j<n;j++)a[i][j]-=t*a[k][j];}
 }return d;
}
MJ syljet(const MP&a,const MP&b,int m,int n){std::vector<std::vector<MJ>>v(m+n,std::vector<MJ>(m+n));for(int i=0;i<n;i++)for(int j=0;j<=m;j++)v[i][i+j]=a[m-j];for(int i=0;i<m;i++)for(int j=0;j<=n;j++)v[n+i][i+j]=b[n-j];return detjet(v);}
MJ resjet(const MP&aa,const MP&bb,int m,int n){
 if(!aa[m].c[0]||!bb[n].c[0])return syljet(aa,bb,m,n);MP a=aa,b=bb;MJ out(1);
 while(b.deg()>0){if(!b.c.back().c[0])return syljet(aa,bb,m,n);int i=a.deg(),j=b.deg();if(i<j){if(i*j%2)out=-out;std::swap(a,b);continue;}auto r=a.mod(b);if(!r)return MJ();if(i*j%2)out=-out;out*=b.c.back().pow(i-r.deg());a=std::move(b);b=std::move(r);}
 return b?out*b[0].pow(a.deg()):MJ();
}
std::vector<F> hasse(const std::vector<F>&a,int k){if((int)a.size()<=k)return {};std::vector<F>b(a.size()-k);for(int i=k;i<(int)a.size();i++)b[i-k]=a[i]*F(choose5(i,k));return b;}
std::vector<F> evaluate_grid(const std::vector<F>&a,int n,F root){std::vector<F>b(n);for(int i=0;i<(int)a.size();i++)b[i%n]+=a[i];return large_dft(b,root);}
std::vector<F> interpolate_grid(const std::vector<F>&v,F root){auto a=large_dft(v,root.inverse());F z=F(v.size()%5).inverse();for(auto&x:a)x*=z;return a;}
using Vals=std::vector<std::vector<F>>;
FP reconstruct(Vals v,F root){
 int n=v[0].size();std::vector<std::vector<F>>blocks;
 for(int j=0;j<DEPTH;j++){
  auto p=interpolate_grid(v[0],root);blocks.push_back(p);int left=DEPTH-j;if(left==1)break;
  Vals ev(left),next(left-1,std::vector<F>(n));
  #pragma omp parallel for schedule(dynamic,1)
  for(int k=0;k<left;k++)ev[k]=evaluate_grid(hasse(p,k),n,root);
  F z(1);
  for(int i=0;i<n;i++){
   assert(v[0][i]==ev[0][i]);std::array<F,DEPTH>g{},w{};F zi=z.inverse(),power=zi;
   for(int k=0;k<left-1;k++){g[k]=F(choose5(n,k+1))*power;power*=zi;}
   F inverse=g[0].inverse();
   for(int k=0;k<left-1;k++){F r=v[k+1][i]-ev[k+1][i];for(int l=1;l<=k;l++)r-=g[l]*w[k-l];w[k]=r*inverse;next[k][i]=w[k];}
   z*=root;
  }v=std::move(next);
 }
 std::vector<F>a(DEPTH*n);for(int j=0;j<DEPTH;j++)for(int k=0;k<=j;k++){
  F c(choose5(j,k));if((j-k)%2)c=-c;for(int i=0;i<n;i++)a[k*n+i]+=c*blocks[j][i];
 }return FP(a);
}
void controls_multijet(){
 for(int m=1;m<=9;m++)for(int n=1;n<=9;n++)for(int mode=0;mode<4;mode++){
  MP a(1),b(1);std::vector<MJ>r,s;
  for(int i=0;i<m;i++){MJ t(F(25).pow(i+1));for(int k=1;k<DEPTH;k++)t.c[k]=F((i+2*k)%5);r.push_back(t);a*=MP(std::vector<MJ>{-t,MJ(1)});}
  for(int j=0;j<n;j++){MJ t(mode?r[j%m]:MJ(F(25).pow(2*j+19)));if(mode)t.c[mode]+=F(1);s.push_back(t);b*=MP(std::vector<MJ>{-t,MJ(1)});}
  MJ want(1);for(auto x:r)for(auto y:s)want*=x-y;assert(resjet(a,b,m,n)==want);assert(syljet(a,b,m,n)==want);
 }
 constexpr int n=312;F root=F(25).pow(F::NN/n);std::vector<F>a(DEPTH*n);for(int i=0;i<(int)a.size();i++)a[i]=F(25).pow(13*i+7);Vals v(DEPTH);for(int k=0;k<DEPTH;k++)v[k]=evaluate_grid(hasse(a,k),n,root);assert(reconstruct(v,root)==FP(a));
 std::cout<<"EIGHT_JET_RESULTANT_AND_RECONSTRUCTION_CONTROLS_PASS"<<std::endl;
}
FP readp(const ptree&r){std::vector<F>a;for(auto&[k,v]:r)a.push_back(F(v.get_value<unsigned>()));return FP(a);}
void writep(std::ostream&o,const FP&p){o<<'[';for(int i=0;i<=p.deg();i++){if(i)o<<',';o<<p[i].v;}o<<']';}
int main(int argc,char**argv){try{
 F::init();FastK::init();large_dft_controls();controls_multijet();if(argc==1)return 0;if(argc!=5)throw std::runtime_error("usage J.json tail1.json tail2.json output-prefix");
 auto start=std::chrono::steady_clock::now();ptree obj;std::vector<std::vector<FP>>rows;std::vector<FP>content;std::vector<int>indices;
 for(int k=1;k<=3;k++){boost::property_tree::read_json(argv[k],obj);rows.emplace_back();for(auto&[key,p]:obj.get_child("coefficients"))rows.back().push_back(readp(p));if(k>1){content.push_back(readp(obj.get_child("content")));indices.push_back(obj.get<int>("index"));}}
 int N=F::NN;F root(25);std::vector<int>bounds;int d0=0;for(auto&p:rows[0])d0=std::max(d0,p.deg());
 for(int i=1;i<3;i++){int d=0;for(auto&p:rows[i])d=std::max(d,p.deg());bounds.push_back((rows[0].size()-1)*d+(rows[i].size()-1)*d0);assert(bounds.back()<DEPTH*N);}
 std::cout<<"BOUNDS "<<bounds[0]<<' '<<bounds[1]<<" depth "<<DEPTH<<std::endl;
 std::vector<std::vector<Vals>>ev(3);std::vector<std::array<int,3>>tasks;
 for(int i=0;i<3;i++){ev[i].resize(rows[i].size(),Vals(DEPTH));for(int j=0;j<(int)rows[i].size();j++)for(int k=0;k<DEPTH;k++)tasks.push_back({i,j,k});}
 #pragma omp parallel for schedule(dynamic,1)
 for(int t=0;t<(int)tasks.size();t++){auto[i,j,k]=tasks[t];ev[i][j][k]=evaluate_grid(hasse(rows[i][j].c,k),N,root);}
 std::cout<<"COEFFICIENT_JETS_EVALUATED"<<std::endl;std::array<Vals,2>values;for(auto&v:values)v=Vals(DEPTH,std::vector<F>(N));
 #pragma omp parallel for schedule(dynamic,64)
 for(int node=0;node<N;node++){
  std::array<MP,3>p;for(int i=0;i<3;i++){p[i].c.resize(rows[i].size());for(int j=0;j<(int)rows[i].size();j++)for(int k=0;k<DEPTH;k++)p[i].c[j].c[k]=ev[i][j][k][node];p[i].trim();}
  for(int i=0;i<2;i++){auto r=resjet(p[0],p[i+1],rows[0].size()-1,rows[i+1].size()-1);for(int k=0;k<DEPTH;k++)values[i][k][node]=r.c[k];}
 }
 std::cout<<"RESULTANT_JETS_EVALUATED"<<std::endl;ev.clear();
 for(int i=0;i<2;i++){
  FP p=reconstruct(std::move(values[i]),root);assert(p.deg()<=bounds[i]);
  for(F z:{F(0),F(25)+F(1),F(25).pow(2)+F(2)}){
   MP a,b;for(int r:{0,i+1}){MP cur;for(auto&co:rows[r]){MJ v;for(int k=0;k<DEPTH;k++)v.c[k]=FP(hasse(co.c,k)).eval(z);cur.c.push_back(v);}cur.trim();if(r==0)a=cur;else b=cur;}
   MJ expected=syljet(a,b,rows[0].size()-1,rows[i+1].size()-1);for(int k=0;k<DEPTH;k++)assert(FP(hasse(p.c,k)).eval(z)==expected.c[k]);
  }
  std::ofstream out(std::string(argv[4])+"."+std::to_string(indices[i])+".json");out<<"{\"index\":"<<indices[i]<<",\"grid\":"<<N<<",\"jets\":"<<DEPTH<<",\"degree_bound\":"<<bounds[i]<<",\"content\":";writep(out,content[i]);out<<",\"norm_of_primitive_row\":";writep(out,p);out<<"}\n";
  std::cout<<"NORM_RECONSTRUCTED "<<indices[i]<<" degree "<<p.deg()<<std::endl;
 }
 std::cout<<"EIGHT_JET_COMPLETE seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
