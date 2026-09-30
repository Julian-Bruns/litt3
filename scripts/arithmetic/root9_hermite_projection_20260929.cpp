// Three-jet, degree-certified multiplicative interpolation of resultants.
// Uses F_(5^8)[epsilon]/epsilon^3 at ALL nonzero field nodes. Reconstructs
// polynomials of degree<3*(5^8-1), not a finite-point existence test.
#define main critical_resultant_main
#include "root9_critical_resultants_20260929.cpp"
#undef main
#include "root9_large_fourier_20260929.hpp"
#include "pro_companion140_20260928/src/native/halfgcd.hpp"
struct Jet{
 std::array<F,3>c{};Jet(int a=0){c[0]=F(a%5);}Jet(F a){c[0]=a;}
 explicit operator bool()const{return bool(c[0])||bool(c[1])||bool(c[2]);}
 friend Jet operator+(Jet a,const Jet&b){for(int i=0;i<3;i++)a.c[i]+=b.c[i];return a;}
 friend Jet operator-(Jet a){for(auto&x:a.c)x=-x;return a;}
 friend Jet operator-(const Jet&a,const Jet&b){return a+-b;}
 friend Jet operator*(const Jet&a,const Jet&b){Jet z;for(int i=0;i<3;i++)for(int j=0;i+j<3;j++)z.c[i+j]+=a.c[i]*b.c[j];return z;}
 Jet&operator+=(const Jet&b){return *this=*this+b;}Jet&operator-=(const Jet&b){return *this=*this-b;}Jet&operator*=(const Jet&b){return *this=*this*b;}
 friend bool operator==(const Jet&a,const Jet&b){return a.c==b.c;}
 Jet inverse()const{if(!c[0])throw std::runtime_error("jet nonunit");Jet b(c[0].inverse());for(int n=1;n<3;n++){F t;for(int j=1;j<=n;j++)t+=c[j]*b.c[n-j];b.c[n]=-t*b.c[0];}return b;}
 Jet pow(int n)const{Jet z(1),a=*this;while(n){if(n&1)z*=a;n>>=1;if(n)a*=a;}return z;}
};
using JP=Poly<Jet>;
Jet schur_det(std::vector<std::vector<Jet>>a){
 int n=a.size();Jet d(1);
 for(int k=0;k<n;k++){
  int r=-1,s=-1;for(int i=k;i<n&&r<0;i++)for(int j=k;j<n;j++)if(a[i][j].c[0]){r=i;s=j;break;}
  if(r<0){int m=n-k;if(m>=3)return Jet();if(m==1)return d*a[k][k];return d*(a[k][k]*a[k+1][k+1]-a[k][k+1]*a[k+1][k]);}
  if(r!=k){std::swap(a[r],a[k]);d=-d;}if(s!=k){for(auto&row:a)std::swap(row[s],row[k]);d=-d;}
  Jet p=a[k][k],iv=p.inverse();d*=p;
  for(int i=k+1;i<n;i++){Jet t=a[i][k]*iv;for(int j=k+1;j<n;j++)a[i][j]-=t*a[k][j];}
 }return d;
}
Jet syljet(const JP&a,const JP&b,int m,int n){std::vector<std::vector<Jet>>s(m+n,std::vector<Jet>(m+n));for(int i=0;i<n;i++)for(int j=0;j<=m;j++)s[i][i+j]=a[m-j];for(int i=0;i<m;i++)for(int j=0;j<=n;j++)s[n+i][i+j]=b[n-j];return schur_det(s);}
Jet resjet(const JP&aa,const JP&bb,int m,int n){
 if(!aa[m].c[0]||!bb[n].c[0])return syljet(aa,bb,m,n);
 JP a=aa,b=bb;Jet out(1);
 while(b.deg()>0){if(!b.c.back().c[0])return syljet(aa,bb,m,n);int i=a.deg(),j=b.deg();if(i<j){if(i*j%2)out=-out;std::swap(a,b);continue;}auto r=a.mod(b);if(!r)return Jet();if(i*j%2)out=-out;out*=b.c.back().pow(i-r.deg());a=std::move(b);b=std::move(r);}
 return b?out*b[0].pow(a.deg()):Jet();
}
std::vector<F> derivative(const std::vector<F>&a,int k){std::vector<F>b(a.size());for(int i=k;i<(int)a.size();i++){int v=k==1?i%5:((i%5)*((i-1)%5)*3)%5;b[i-k]=a[i]*F(v);}return b;}
std::vector<F> invdft(const std::vector<F>&v,F root){auto a=large_dft(v,root.inverse());F n=F(v.size()%5).inverse();for(auto&c:a)c*=n;return a;}
FP reconstruct(const std::array<std::vector<F>,3>&values,F root){
 int n=values[0].size();F nn(n%5),nn2((n%5)*((n-1)%5)*3%5);auto p0=invdft(values[0],root);
 auto d0=large_dft(derivative(p0,1),root),d20=large_dft(derivative(p0,2),root);std::vector<F>v1(n),v2(n);F z(1),ni=nn.inverse();
 for(int i=0;i<n;i++){v1[i]=(values[1][i]-d0[i])*z*ni;z*=root;}
 auto p1=invdft(v1,root),d1=large_dft(derivative(p1,1),root);z=1;
 for(int i=0;i<n;i++){F l1=nn/z,l2=nn2/(z*z);v2[i]=(values[2][i]-d20[i]-l1*d1[i]-l2*v1[i])/(l1*l1);z*=root;}
 auto p2=invdft(v2,root);std::vector<F>a(3*n);for(int i=0;i<n;i++){a[i]=p0[i]-p1[i]+p2[i];a[n+i]=p1[i]-F(2)*p2[i];a[2*n+i]=p2[i];}return FP(a);
}
void controls_jet(){
 for(int m=1;m<=5;m++)for(int n=1;n<=5;n++)for(int mode=0;mode<3;mode++){
  JP a(1),b(1);std::vector<Jet>r,s;
  for(int i=0;i<m;i++){Jet t(F(25).pow(i+1));t.c[1]=F(i%5);t.c[2]=F((i+2)%5);r.push_back(t);a*=JP(std::vector<Jet>{-t,Jet(1)});}
  for(int j=0;j<n;j++){Jet t(mode?r[j%m]:Jet(F(25).pow(2*j+9)));t.c[1]+=F(mode%5);s.push_back(t);b*=JP(std::vector<Jet>{-t,Jet(1)});}
  Jet expect(1);for(auto x:r)for(auto y:s)expect*=x-y;assert(resjet(a,b,m,n)==expect);assert(syljet(a,b,m,n)==expect);
 }
 constexpr int n=312;F root=F(25).pow(F::NN/n);std::vector<F>a(3*n);for(int j=0;j<3*n;j++)a[j]=F(25).pow(17*j+3);
 std::array<std::vector<F>,3>v;for(int k=0;k<3;k++){auto d=k?derivative(a,k):a;std::vector<F>fold(n);for(int j=0;j<(int)d.size();j++)fold[j%n]+=d[j];v[k]=large_dft(fold,root);}assert(reconstruct(v,root)==FP(a));
 std::cout<<"JET_RESULTANT_AND_HERMITE_CONTROLS_PASS"<<std::endl;
}
FP readp(const ptree&r){std::vector<F>a;for(auto&[k,v]:r)a.push_back(F(v.get_value<unsigned>()));return FP(a);}
void writep(std::ostream&o,const FP&p){o<<'[';for(int i=0;i<=p.deg();i++){if(i)o<<',';o<<p[i].v;}o<<']';}
int main(int argc,char**argv){try{
 F::init();FastK::init();large_dft_controls();controls_jet();if(argc==1)return 0;
 if(argc!=5)throw std::runtime_error("usage J.json tail1.json tail2.json output-prefix");auto start=std::chrono::steady_clock::now();
 ptree obj;std::vector<std::vector<FP>>rows;std::vector<FP>contents;std::vector<int>indices;
 for(int k=1;k<=3;k++){boost::property_tree::read_json(argv[k],obj);rows.emplace_back();for(auto&[key,p]:obj.get_child("coefficients"))rows.back().push_back(readp(p));if(k>1){contents.push_back(readp(obj.get_child("content")));indices.push_back(obj.get<int>("index"));}}
 int N=F::NN;F root=F(25);std::vector<int>bounds;int d0=0;for(auto&p:rows[0])d0=std::max(d0,p.deg());
 for(int i=1;i<3;i++){int d=0;for(auto&p:rows[i])d=std::max(d,p.deg());bounds.push_back((rows[0].size()-1)*d+(rows[i].size()-1)*d0);assert(bounds.back()<3*N);}
 std::cout<<"BOUNDS "<<bounds[0]<<' '<<bounds[1]<<" N "<<N<<std::endl;
 using HCol=std::array<std::vector<F>,3>;std::vector<std::vector<HCol>>ev(3);std::vector<std::array<int,3>>tasks;
 for(int i=0;i<3;i++){ev[i].resize(rows[i].size());for(int j=0;j<(int)rows[i].size();j++)for(int k=0;k<3;k++)tasks.push_back({i,j,k});}
 #pragma omp parallel for schedule(dynamic,1)
 for(int t=0;t<(int)tasks.size();t++){auto[i,j,k]=tasks[t];auto d=k?derivative(rows[i][j].c,k):rows[i][j].c;std::vector<F>fold(N);for(int n=0;n<(int)d.size();n++)fold[n%N]+=d[n];ev[i][j][k]=large_dft(fold,root);}
 std::cout<<"ALL_COEFFICIENT_JETS_EVALUATED"<<std::endl;
 std::array<std::array<std::vector<F>,3>,2>values;for(auto&v:values)for(auto&w:v)w.resize(N);
 #pragma omp parallel for schedule(dynamic,64)
 for(int node=0;node<N;node++){
  std::array<JP,3>p;for(int i=0;i<3;i++){p[i].c.resize(rows[i].size());for(int j=0;j<(int)rows[i].size();j++)for(int k=0;k<3;k++)p[i].c[j].c[k]=ev[i][j][k][node];p[i].trim();}
  for(int i=0;i<2;i++){auto r=resjet(p[0],p[i+1],rows[0].size()-1,rows[i+1].size()-1);for(int k=0;k<3;k++)values[i][k][node]=r.c[k];}
 }
 std::cout<<"ALL_RESULTANT_JETS_EVALUATED"<<std::endl;ev.clear();std::vector<FP>norms;
 for(int i=0;i<2;i++){
  FP p=reconstruct(values[i],root);assert(p.deg()<=bounds[i]);
  for(F z:{F(0),F(25)+F(1),F(25).pow(2)+F(2)}){
   JP a,b;for(int r:{0,i+1}){JP cur;for(auto&coef:rows[r]){Jet v;for(int k=0;k<3;k++){FP der(k?derivative(coef.c,k):coef.c);v.c[k]=der.eval(z);}cur.c.push_back(v);}cur.trim();if(r==0)a=cur;else b=cur;}
   Jet expected=syljet(a,b,rows[0].size()-1,rows[i+1].size()-1);for(int k=0;k<3;k++){FP der(k?derivative(p.c,k):p.c);assert(der.eval(z)==expected.c[k]);}
  }
  std::ofstream out(std::string(argv[4])+"."+std::to_string(indices[i])+".json");out<<"{\"index\":"<<indices[i]<<",\"grid\":"<<N<<",\"jets\":3,\"degree_bound\":"<<bounds[i]<<",\"content\":";writep(out,contents[i]);out<<",\"norm_of_primitive_row\":";writep(out,p);out<<"}\n";
  norms.push_back(std::move(p));std::cout<<"NORM_RECONSTRUCTED "<<indices[i]<<" degree "<<norms.back().deg()<<std::endl;
 }
 auto[g,u,v]=xgcd_half(norms[0],norms[1],true);std::ofstream out(std::string(argv[4])+".gcd.json");out<<"{\"gcd\":";writep(out,g);out<<",\"u\":";writep(out,u);out<<",\"v\":";writep(out,v);out<<"}\n";
 std::cout<<"EXACT_HERMITE_COMPLETE gcd_degree "<<g.deg()<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
