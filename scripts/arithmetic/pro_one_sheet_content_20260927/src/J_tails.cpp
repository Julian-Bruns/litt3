#include "finite_tensor.hpp"
#include <map>
static UP readu(std::istream&i){int n;i>>n;UP p(n);for(U&c:p)i>>c;assert(i);return p;}
static E30 readp(std::istream&i,const std::vector<E30>&vs,const std::vector<E30>&ss){std::string name;int n;i>>name>>n;E30 p;for(int k=0;k<n;k++){int v,s;U c;i>>v>>s>>c;assert(v>=0&&v<int(vs.size())&&s>=0&&s<int(ss.size()));p=p+scale(vs[v]*ss[s],c);}if(!i)throw std::runtime_error("bad J input");return p;}
int main(int argc,char**argv){try{if(argc!=4){std::cerr<<"usage: J_tails J_input Ehat output\n";return 2;}initfield(nullptr);std::ifstream in(argv[1]);U r,pr;in>>r>>pr;UP f=readu(in),a=readu(in),b=readu(in);assert(f.size()==7&&f[6]==1);for(int i=0;i<6;i++){fm[i]=f[i];ga[i]=i<int(a.size())?a[i]:0;gb[i]=i<int(b.size())?b[i]:0;}E30 v,S;v.at(1)=1;S.at(6)=1;std::vector<E30>vs(200),ss(12);vs[0]=ss[0]=E30(1);for(int i=1;i<200;i++)vs[i]=vs[i-1]*v;for(int i=1;i<12;i++)ss[i]=ss[i-1]*S;initfrob();
 E30 beta=readp(in,vs,ss),delta=readp(in,vs,ss),hn=readp(in,vs,ss),hd=readp(in,vs,ss);E30 H=hn*inverse(hd);std::array<E30,4>mn,md;for(int j=0;j<4;j++){mn[j]=readp(in,vs,ss);md[j]=readp(in,vs,ss);}
 E30 q=scale(inverse(vs[3]),pr);std::array<E30,61>qp;qp[6]=E30(1);for(int i=7;i<61;i++)qp[i]=qp[i-1]*q;E30 iq=inverse(q);for(int i=5;i>=0;i--)qp[i]=qp[i+1]*iq;
 E30 a0;for(U c:UP{245794,356725,33043,315361,163299,214299,311173,89654})a0=a0*q+E30(c);E30 a1=q*(E30(299833)+scale(q,232505)),psi=a0+a1*H;
 E30 baseopen=v*S*beta*delta*H*q*psi*(q-E30(1))*(q-E30(15383))*a0;
 E30 baseinv=inverse(baseopen);std::ofstream out(argv[3]);out<<"r "<<r<<" dimension 30\n";we(out,"H",H);we(out,"q",q);we(out,"base_open",baseopen);we(out,"base_open_inverse",baseinv);
 std::array<E30,13>hp;hp[0]=E30(1);for(int h=1;h<13;h++)hp[h]=hp[h-1]*H;
 std::ifstream ein(argv[2]);std::string name;int terms;ein>>name>>terms;std::map<int,E30>groups;for(int i=0;i<terms;i++){int x,y,h,qq,m;U c;ein>>x>>y>>h>>qq>>m>>c;assert(qq>=-6&&qq<=54);int k=x+64*y+256*h+4096*m;groups[k]=groups[k]+scale(qp[qq+6],c);}
 std::array<std::array<std::array<E30,47>,3>,3>E;for(auto&[k,c]:groups){int x=k%64,y=(k/64)%4,h=(k/256)%16,m=k/4096;E[m][y][x]=E[m][y][x]+c*hp[h];}
 assert(E[1][2][40].zero()&&E[2][2][40].zero());UP P={1,22,9,16,15,20,19,5,18,22,11};
 for(int branch=0;branch<4;branch++){auto start=std::chrono::steady_clock::now();E30 deninv=inverse(md[branch]);E30 mu=mn[branch]*deninv;E30 branchopen=md[branch]*mu;E30 branchinv=inverse(branchopen);std::array<S30,3>e;const int deg[3]={46,43,40};E30 musq=mu*mu;
  for(int j=0;j<3;j++){e[j].resize(PR);for(int i=0;i<=deg[j];i++){int x=deg[j]-i;e[j][i]=E[0][j][x]+E[1][j][x]*mu+E[2][j][x]*musq;}}
  auto a2=ssq30(e[0]);auto a3=smul30(a2,e[0]);auto b2=ssq30(e[1]);auto b3=smul30(b2,e[1]);auto c2=ssq30(e[2]);auto c3=smul30(c2,e[2]);auto abc=smul30(smul30(e[0],e[1]),e[2]);
  S30 U=sadd30(sadd30(sps30(c3,um(P,P),E30(1)),ssh30(sps30(sadd30(b3,ssc30(abc,2)),P,q),1)),ssh30(sps30(a3,{1},q*q),2));E30 ilc=inverse(U[0]);for(auto&c:U)c=c*ilc;assert((U[0]-E30(1)).zero());
  S30 rec(PR);rec[0]=E30(1);for(int n=1;n<PR;n++){E30 total;for(int i=1;2*i<n;i++)total=total+scale(rec[i]*rec[n-i],2);if(n%2==0)total=total+rec[n/2]*rec[n/2];rec[n]=scale(U[n]-total,3);}
  auto U2=ssq30(U);auto root=smul30(smul30(smul30(U2,U),sf30(U2,5)),sf30(U2,25));for(int n=0;n<PR;n++)assert((root[n]-rec[n]).zero());
  auto uv=linear_unit({rec[71],rec[72]});if(uv.empty())throw std::runtime_error("two tails do not generate unit ideal");out<<"branch "<<branch<<"\n";we(out,"mu",mu);we(out,"branch_open",branchopen);we(out,"branch_open_inverse",branchinv);we(out,"C71",rec[71]);we(out,"C72",rec[72]);we(out,"U",uv[0]);we(out,"V",uv[1]);
  double secs=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();std::cout<<"r="<<r<<" branch="<<branch<<" algebra_dimension=30 base_opens=UNIT scale_opens=UNIT tails=BEZOUT_1 recursion_vs_power63=PASS seconds="<<secs<<std::endl;
 }
 return 0;
 }catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
