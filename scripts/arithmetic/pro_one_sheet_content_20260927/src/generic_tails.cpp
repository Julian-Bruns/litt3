#include "function_algebra.hpp"
static int prec=73;
using Series=std::vector<QA>;
static QA sum_products(const std::vector<std::pair<const QA*,const QA*>>&pairs,const std::vector<U>&sc){
 QA c;std::vector<UP>ds;ds.reserve(pairs.size());
 for(auto&[a,b]:pairs){UP d=um(a->d,b->d);if(c.d!=d){UP g=ug(c.d,d);c.d=um(c.d,ux(d,g));}ds.push_back(std::move(d));}
 for(size_t i=0;i<pairs.size();i++){QA p=qraw(*pairs[i].first,*pairs[i].second);UP factor=c.d==ds[i]?UP{1}:ux(c.d,ds[i]);for(int j=0;j<6;j++)c.n[j]=ua(c.n[j],uc(um(p.n[j],factor),sc[i]));}
 c.normal();return c;
}
static Series smul(const Series&a,const Series&b){Series c(prec);
#pragma omp parallel for schedule(dynamic,1)
 for(int n=0;n<prec;n++){std::vector<std::pair<const QA*,const QA*>>p;std::vector<U>sc;for(int i=0;i<=n&&i<int(a.size());i++)if(n-i<int(b.size())&&!a[i].zero()&&!b[n-i].zero()){p.emplace_back(&a[i],&b[n-i]);sc.push_back(1);}c[n]=sum_products(p,sc);}return c;}
static Series ssq(const Series&a){Series c(prec);
#pragma omp parallel for schedule(dynamic,1)
 for(int n=0;n<prec;n++){std::vector<std::pair<const QA*,const QA*>>p;std::vector<U>sc;for(int i=0;2*i<n;i++)if(i<int(a.size())&&n-i<int(a.size())&&!a[i].zero()&&!a[n-i].zero()){p.emplace_back(&a[i],&a[n-i]);sc.push_back(2);}if(n%2==0&&n/2<int(a.size())&&!a[n/2].zero()){p.emplace_back(&a[n/2],&a[n/2]);sc.push_back(1);}c[n]=sum_products(p,sc);}return c;}
static Series sa(Series a,const Series&b){for(int i=0;i<prec;i++)a[i]=a[i]+b[i];return a;}
static Series sc(Series a,U c){for(auto&v:a)v=scale(v,c);return a;}
static Series shift(Series a,int n){Series b(prec);for(int i=0;i+n<prec;i++)b[i+n]=a[i];return b;}
static Series pscalar(const Series&a,const UP&p,const QA&c){Series b(prec);
#pragma omp parallel for schedule(dynamic,1)
for(int i=0;i<prec;i++){QA s;for(int j=0;j<=i&&j<int(p.size());j++)s=s+scale(a[i-j],p[j]);b[i]=s*c;}return b;}
static QA readp(std::istream&in,std::string&name,bool isF=false){int n;in>>name>>n;QA a;for(int k=0;k<n;k++){int v,s;U c;in>>v>>s>>c;assert(v>=0&&s<=6);if(isF){if(s==6){assert(v==0&&c==1);continue;}F[s].resize(std::max(F[s].size(),size_t(v+1)));F[s][v]=c;}else{assert(s<6);a.n[s].resize(std::max(a.n[s].size(),size_t(v+1)));a.n[s][v]=c;}}if(!in)throw std::runtime_error("read chart");return a;}
int main(int argc,char**argv){try{if(argc<6){std::cerr<<"usage: generic_tails chart coordinates Ecache out_prefix branch [precision]\n";return 2;}if(argc>6)prec=std::stoi(argv[6]);int branch=std::stoi(argv[5]);initfield(nullptr);std::ifstream in(argv[1]);U r;in>>r;std::string name;readp(in,name,true);SP[0]=QA(1);SP[1].n[1]={1};for(int i=2;i<126;i++)SP[i]=SP[i-1]*SP[1];std::ifstream co(argv[2]);QA H=loadq(co);std::array<QA,4>mu;for(auto&m:mu)m=loadq(co);std::ifstream ee(argv[3]);std::array<std::array<std::array<QA,47>,3>,3>E;for(auto&mm:E)for(auto&yy:mm)for(auto&c:yy)c=loadq(ee);
 QA scalevar=mu[branch],musq=scalevar*scalevar;std::array<Series,3>e;const int deg[3]={46,43,40};for(int j=0;j<3;j++){e[j].resize(prec);for(int i=0;i<prec&&i<=deg[j];i++){int x=deg[j]-i;e[j][i]=E[0][j][x]+E[1][j][x]*scalevar+E[2][j][x]*musq;}std::cout<<"E specialize component="<<j<<" height_last="<<height(e[j][std::min(prec-1,deg[j])])<<std::endl;}
 QA ell=e[2][0];std::cout<<"ell height="<<height(ell)<<std::endl;
 // Form the raw norm first. Normalizing its 73 coefficients only once
 // avoids introducing the leading-coefficient inverse into every factor product.
 auto a2=ssq(e[0]);std::cout<<"a2 complete"<<std::endl;auto a3=smul(a2,e[0]);std::cout<<"a3 complete"<<std::endl;
 auto b2=ssq(e[1]);auto b3=smul(b2,e[1]);std::cout<<"b3 complete"<<std::endl;
 auto c2=ssq(e[2]);auto c3=smul(c2,e[2]);std::cout<<"c3 complete"<<std::endl;
 auto ab=smul(e[0],e[1]);auto abc=smul(ab,e[2]);std::cout<<"abc complete"<<std::endl;
 UP P={11,22,18,5,19,20,15,16,9,22,1};U pr=ue(P,r);std::reverse(P.begin(),P.end());QA q(pr);q.d={0,0,0,1};
 Series Urev=sa(sa(pscalar(c3,um(P,P),QA(1)),shift(pscalar(sa(b3,sc(abc,2)),P,q),1)),shift(pscalar(a3,{1},q*q),2));
 assert((Urev[0]-powq(ell,3)).zero());QA ilc=powq(inverse(ell),3);
#pragma omp parallel for schedule(dynamic,1)
 for(int i=0;i<prec;i++)Urev[i]=Urev[i]*ilc;
 assert((Urev[0]-QA(1)).zero());
 {std::ofstream o(std::string(argv[4])+"_U.txt");o<<prec<<"\n";for(auto&c:Urev)saveq(o,c);}
 for(int i=0;i<prec;i++)std::cout<<"U "<<i<<" height="<<height(Urev[i])<<std::endl;
 return 0;
 }catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
