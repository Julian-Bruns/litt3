#include "function_algebra.hpp"
#include <map>
static QA readp(std::istream&in,std::string&name,bool isF=false){int n;in>>name>>n;QA a;for(int k=0;k<n;k++){int v,s;U c;in>>v>>s>>c;assert(v>=0&&s<=6);if(isF){if(s==6){assert(v==0&&c==1);continue;}F[s].resize(std::max(F[s].size(),size_t(v+1)));F[s][v]=c;}else{assert(s<6);a.n[s].resize(std::max(a.n[s].size(),size_t(v+1)));a.n[s][v]=c;}}if(!in)throw std::runtime_error("read chart");return a;}
static void status(std::string s){std::cout<<s<<" normalizations="<<norm_calls<<" products="<<mul_calls<<std::endl;}
int main(int argc,char**argv){try{if(argc<4){std::cerr<<"usage: generic_curve input_chart Ehat out_prefix [branch]\n";return 2;}initfield(nullptr);std::ifstream in(argv[1]);U r;in>>r;std::string name;readp(in,name,true);SP[0]=QA(1);SP[1].n[1]={1};for(int i=2;i<126;i++)SP[i]=SP[i-1]*SP[1];QA hn=readp(in,name),hd=readp(in,name);QA H=hn*inverse(hd);status("H height="+std::to_string(height(H)));
 std::array<QA,4>mu;for(int k=0;k<4;k++){QA n=readp(in,name),d=readp(in,name);mu[k]=n*inverse(d);status("mu"+std::to_string(k)+" height="+std::to_string(height(mu[k])));}
 {std::ofstream o(std::string(argv[3])+"_coordinates.txt");saveq(o,H);for(auto&m:mu)saveq(o,m);}

 std::array<QA,13>hp;hp[0]=QA(1);for(int h=1;h<=12;h++)hp[h]=hp[h-1]*H;
 std::ifstream ein(argv[2]);int terms;ein>>name>>terms;std::map<int,UP> groups;
 U pr=ue({11,22,18,5,19,20,15,16,9,22,1},r);
 for(int i=0;i<terms;i++){int x,y,h,q,m;U co;ein>>x>>y>>h>>q>>m>>co;int k=x+64*y+256*h+4096*m;auto&g=groups[k];int deg=162-3*q;assert(deg>=0);g.resize(std::max(g.size(),size_t(deg+1)));g[deg]=kadd(g[deg],kmul(co,kpow(pr,q)));}
 std::array<std::array<std::array<QA,47>,3>,3> E;
 UP vd(163);vd[162]=1;int done=0;
 for(auto&[k,n]:groups){trim(n);int x=k%64,y=(k/64)%4,h=(k/256)%16,m=k/4096;E[m][y][x]=E[m][y][x]+scalar(hp[h],n,vd);done++;if(done%500==0)status("E groups="+std::to_string(done)+"/"+std::to_string(groups.size()));}
 assert(E[1][2][40].zero()&&E[2][2][40].zero());
 int mh=0;for(auto&ee:E)for(auto&yy:ee)for(auto&c:yy)mh=std::max(mh,height(c));status("E complete maxheight="+std::to_string(mh));
 {std::ofstream o(std::string(argv[3])+"_E.txt");for(auto&ee:E)for(auto&yy:ee)for(auto&c:yy)saveq(o,c);}
 return 0;
 }catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
