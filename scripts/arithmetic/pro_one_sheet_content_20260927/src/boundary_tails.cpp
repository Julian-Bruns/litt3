// Complete geometric all-scale exclusion certificate generator for the B1=0 fibres.
// Arithmetic in K[H]/f(H), followed by K[H]/f(H)[mu]. No enumeration of mu.
#include "field.cpp"
#include <array>
#include <string>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <chrono>
using UP=std::vector<U>;
static UP trim(UP a){while(!a.empty()&&!a.back())a.pop_back();return a;}
static UP ua(UP a,const UP&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=kadd(a[i],b[i]);return trim(a);}
static UP un(UP a){for(auto&v:a)v=kneg(v);return a;}
static UP us(UP a,const UP&b){return ua(a,un(b));}
static UP uc(UP a,U c){for(auto&v:a)v=kmul(v,c);return trim(a);}
static UP um(const UP&a,const UP&b){if(a.empty()||b.empty())return {};UP c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(a[i])for(size_t j=0;j<b.size();j++)if(b[j])c[i+j]=kadd(c[i+j],kmul(a[i],b[j]));return trim(c);}
static std::pair<UP,UP> ud(UP a,const UP&b){assert(!b.empty());a=trim(a);UP q(a.size()>=b.size()?a.size()-b.size()+1:0);U ib=kinv(b.back());while(a.size()>=b.size()){size_t i=a.size()-b.size();U c=kmul(a.back(),ib);q[i]=c;for(size_t j=0;j<b.size();j++)a[i+j]=kadd(a[i+j],kneg(kmul(c,b[j])));a=trim(a);}return {trim(q),a};}
static int d=0;static UP modulus;
struct E{std::array<U,16>a{};E(){}explicit E(U c){a[0]=c;}bool zero()const{for(int i=0;i<d;i++)if(a[i])return false;return true;}bool one()const{if(a[0]!=1)return false;for(int i=1;i<d;i++)if(a[i])return false;return true;}};
static E operator+(E a,const E&b){for(int i=0;i<d;i++)a.a[i]=kadd(a.a[i],b.a[i]);return a;}
static E operator-(E a,const E&b){for(int i=0;i<d;i++)a.a[i]=kadd(a.a[i],kneg(b.a[i]));return a;}
static E ec(E a,U c){for(int i=0;i<d;i++)a.a[i]=kmul(a.a[i],c);return a;}
static E operator*(const E&a,const E&b){std::array<U,32>r{};for(int i=0;i<d;i++)if(a.a[i])for(int j=0;j<d;j++)if(b.a[j])r[i+j]=kadd(r[i+j],kmul(a.a[i],b.a[j]));for(int i=2*d-2;i>=d;i--)if(r[i])for(int j=0;j<d;j++)r[i-d+j]=kadd(r[i-d+j],kneg(kmul(r[i],modulus[j])));E c;for(int i=0;i<d;i++)c.a[i]=r[i];return c;}
static E ei(const E&a){UP aa(a.a.begin(),a.a.begin()+d);aa=trim(aa);if(aa.empty())throw std::runtime_error("inverse of zero coefficient");UP r=modulus,s=aa,u={},v={1};while(!s.empty()){auto [q,t]=ud(r,s);r=s;s=t;UP w=us(u,um(q,v));u=v;v=w;}if(r.size()!=1)throw std::runtime_error("nonunit extension coefficient");u=ud(uc(u,kinv(r[0])),modulus).second;E z;for(size_t i=0;i<u.size();i++)z.a[i]=u[i];assert((z*a).one());return z;}
static bool ee(const E&a,const E&b){for(int i=0;i<d;i++)if(a.a[i]!=b.a[i])return false;return true;}
static std::vector<E> hp;
static void setfield(const UP&f){modulus=f;d=f.size()-1;assert(d>0&&d<=16&&f.back()==1);hp.assign(25*(d-1)+38,E());hp[0]=E(1);E H;if(d==1)H=E(kneg(f[0]));else H.a[1]=1;for(size_t i=1;i<hp.size();i++)hp[i]=hp[i-1]*H;}
static E ef(const E&a,int n){E c;for(int i=0;i<d;i++)if(a.a[i])c=c+ec(hp[n*i],kpow(a.a[i],n));return c;}
using MP=std::vector<E>;
static MP mt(MP a){while(!a.empty()&&a.back().zero())a.pop_back();return a;}
static MP ma(MP a,const MP&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=a[i]+b[i];return mt(a);}
static MP mn(MP a){for(auto&c:a)c=ec(c,4);return a;}
static MP ms(MP a,const MP&b){return ma(a,mn(b));}
static MP mc(MP a,const E&c){for(auto&v:a)v=v*c;return mt(a);}
static MP mm(const MP&a,const MP&b){if(a.empty()||b.empty())return {};MP c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(!a[i].zero())for(size_t j=0;j<b.size();j++)if(!b[j].zero())c[i+j]=c[i+j]+a[i]*b[j];return mt(c);}
static void maddmul(MP&c,const MP&a,const MP&b){if(a.empty()||b.empty())return;c.resize(std::max(c.size(),a.size()+b.size()-1));for(size_t i=0;i<a.size();i++)if(!a[i].zero())for(size_t j=0;j<b.size();j++)if(!b[j].zero())c[i+j]=c[i+j]+a[i]*b[j];}
static std::pair<MP,MP> md(MP a,const MP&b){assert(!b.empty());a=mt(a);MP q(a.size()>=b.size()?a.size()-b.size()+1:0);E iv=ei(b.back());while(a.size()>=b.size()){size_t i=a.size()-b.size();E c=a.back()*iv;q[i]=c;for(size_t j=0;j<b.size();j++)a[i+j]=a[i+j]-c*b[j];a=mt(a);}return {mt(q),a};}
static std::array<MP,3> mxg(MP a,MP b){MP u={E(1)},v={},s={},t={E(1)};while(!b.empty()){auto[q,r]=md(a,b);a=b;b=r;MP w=ms(u,mm(q,s));u=s;s=w;w=ms(v,mm(q,t));v=t;t=w;}E iv=ei(a.back());return {mc(a,iv),mc(u,iv),mc(v,iv)};}
using Series=std::vector<MP>;
static int prec=73;
static Series smul(const Series&a,const Series&b){Series c(prec);for(int i=0;i<prec;i++)if(!a[i].empty())for(int j=0;i+j<prec;j++)if(!b[j].empty())maddmul(c[i+j],a[i],b[j]);for(auto&v:c)v=mt(v);return c;}
static Series sfrob(const Series&a,int n){Series c(prec);for(int i=0;i*n<prec;i++)if(!a[i].empty()){c[i*n].resize((a[i].size()-1)*n+1);for(size_t j=0;j<a[i].size();j++)c[i*n][j*n]=ef(a[i][j],n);}return c;}
static void wm(std::ostream&o,const std::string&name,const MP&a){size_t nn=0;for(auto&c:a)for(int i=0;i<d;i++)if(c.a[i])nn++;o<<name<<" "<<a.size()<<" "<<nn<<"\n";for(size_t j=0;j<a.size();j++)for(int i=0;i<d;i++)if(a[j].a[i])o<<j<<" "<<i<<" "<<a[j].a[i]<<"\n";}
static Series loadR(const std::string&file){std::ifstream f(file);std::string name;size_t n;f>>name>>n;if(!f)throw std::runtime_error("cannot read fixed residual");Series r(prec);int maxx=-1;for(size_t i=0;i<n;i++){int x,y,h,q,mu;U c;f>>x>>y>>h>>q>>mu>>c;assert(f&&y==0&&q==0&&h<int(hp.size()));maxx=std::max(maxx,x);int k=140-x;if(k<0)throw std::runtime_error("residual degree above 140");if(k<prec){r[k].resize(std::max(r[k].size(),size_t(mu+1)));r[k][mu]=r[k][mu]+ec(hp[h],c);}}assert(maxx==140);for(auto&v:r)v=mt(v);assert(r[0].size()==1);E iv=ei(r[0][0]);for(auto&v:r)v=mc(v,iv);assert(r[0][0].one());return r;}
int main(int argc,char**argv){try{if(argc<4){std::cerr<<"usage: boundary_tails jobs fixed_R_directory output_directory [start_job] [stop_job]\n";return 2;}initfield(nullptr);std::ifstream jobs(argv[1]);int nn;jobs>>nn;int start=argc>4?std::stoi(argv[4]):0,stop=argc>5?std::stoi(argv[5]):nn;
 for(int job=0;job<nn;job++){std::string id;U q;int dd;jobs>>id>>q>>dd;UP f(dd+1);for(auto&c:f)jobs>>c;if(job<start||job>=stop)continue;setfield(f);auto begin=std::chrono::steady_clock::now();std::cout<<"start "<<job<<" "<<id<<" degree="<<dd<<std::endl;
  Series p=loadR(std::string(argv[2])+"/R_q"+std::to_string(q)+".txt"),p2=smul(p,p),p3=smul(p2,p);Series root=smul(smul(p3,sfrob(p2,5)),sfrob(p2,25));
  // Independent formal recursion, compared coefficientwise (all mu coefficients).
  Series rec(prec);rec[0]={E(1)};
  for(int n=1;n<prec;n++){MP total;for(int i=1;i<n;i++)maddmul(total,rec[i],rec[n-i]);rec[n]=mc(ms(p[n],mt(total)),E(3));}
  for(int n=0;n<prec;n++)assert(ms(root[n],rec[n]).empty());
  MP C71=mt(root[71]),C72=mt(root[72]);auto [g,u,v]=mxg(C71,C72);assert(mt(ms(ma(mm(u,C71),mm(v,C72)),g)).empty());
  std::ofstream o(std::string(argv[3])+"/tails_"+id+".txt");o<<"field "<<dd;for(U c:f)o<<" "<<c;o<<"\nq "<<q<<"\n";wm(o,"C71",C71);wm(o,"C72",C72);wm(o,"U",u);wm(o,"V",v);wm(o,"GCD",g);
  bool unit=g.size()==1&&g[0].one();double secs=std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count();std::cout<<"finished "<<id<<" C71_degree="<<int(C71.size())-1<<" C72_degree="<<int(C72.size())-1<<" gcd_degree="<<int(g.size())-1<<" recursion_audit=PASS UNIT="<<unit<<" seconds="<<secs<<std::endl;
 }
 return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
