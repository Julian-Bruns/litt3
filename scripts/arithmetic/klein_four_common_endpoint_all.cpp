// Complete old-moment test: one endpoint has a common phase, other arbitrary.
// Exact F_(5^7) log tables accelerate arithmetic; no field point is sampled.
// All nontrivial survivors are emitted for the established four-trace routine.
#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
constexpr int Q=78125,N=78124;
int A125[125][125],Neg[Q],Small[5][Q],Log[Q],Exp[2*N];
int add(int a,int b){return A125[a%125][b%125]+125*A125[(a/125)%125][(b/125)%125]+15625*((a/15625+b/15625)%5);}
int sub(int a,int b){return add(a,Neg[b]);}
int slow(int a,int b){int av[7],bv[7],p[13]={};for(int i=0;i<7;++i){av[i]=a%5;a/=5;bv[i]=b%5;b/=5;}
 for(int i=0;i<7;++i)for(int j=0;j<7;++j)p[i+j]+=av[i]*bv[j];
 int h[7]={4,4,2,3,3,2,2};for(int i=12;i>=7;--i){int x=(p[i]%5+5)%5;for(int j=0;j<7;++j)p[i-7+j]-=x*h[j];}
 int r=0;for(int i=6;i>=0;--i)r=5*r+(p[i]%5+5)%5;return r;}
int pow_slow(int a,int n){int r=1;while(n){if(n&1)r=slow(r,a);a=slow(a,a);n>>=1;}return r;}
int mul(int a,int b){if(!a||!b)return 0;return Exp[Log[a]+Log[b]];}
int inv(int a){assert(a);return Exp[N-Log[a]];}
void init(){
 for(int a=0;a<125;++a)for(int b=0;b<125;++b)A125[a][b]=(a%5+b%5)%5+5*((a/5%5+b/5%5)%5)+25*((a/25+b/25)%5);
 for(int a=0;a<Q;++a)for(int s=0;s<5;++s){int v=a,r=0,p=1;for(int i=0;i<7;++i){r+=p*((v%5)*s%5);v/=5;p*=5;}Small[s][a]=r;if(s==4)Neg[a]=r;}
 std::vector<int> factors;int n=N;for(int p=2;p*p<=n;++p)if(n%p==0){factors.push_back(p);while(n%p==0)n/=p;}if(n>1)factors.push_back(n);
 int primitive=5;for(;;++primitive){bool ok=true;for(int p:factors)if(pow_slow(primitive,N/p)==1)ok=false;if(ok)break;}
 std::fill(Log,Log+Q,-1);int a=1;for(int i=0;i<N;++i){assert(a&&Log[a]==-1);Log[a]=i;Exp[i]=Exp[i+N]=a;a=slow(a,primitive);}assert(a==1);
 for(int i=1;i<Q;++i)assert(Log[i]>=0&&mul(i,inv(i))==1);
 std::cout<<"Full exact field table; primitive "<<primitive<<std::endl;
}
using E=std::array<int,8>;
E plus(E a,const E&b){for(int i=0;i<8;++i)a[i]=add(a[i],b[i]);return a;}
E minus(E a,const E&b){for(int i=0;i<8;++i)a[i]=sub(a[i],b[i]);return a;}
E fscale(E a,int s){for(auto&x:a)x=mul(x,s);return a;}
using K=std::array<int,2>;
K km(K a,K b){int c=mul(a[0],b[0]),d=mul(a[1],b[1]);return {add(c,Small[3][d]),add(add(mul(a[0],b[1]),mul(a[1],b[0])),d)};}
E times(E a,E b){K p[7]={};for(int i=0;i<4;++i)for(int j=0;j<4;++j){K t=km({a[2*i],a[2*i+1]},{b[2*j],b[2*j+1]});for(int k=0;k<2;++k)p[i+j][k]=add(p[i+j][k],t[k]);}
 K m[4]={{0,1},{2,0},{1,1},{2,1}};for(int i=6;i>=4;--i)for(int j=0;j<4;++j){K t=km(p[i],m[j]);for(int k=0;k<2;++k)p[i-4+j][k]=sub(p[i-4+j][k],t[k]);}
 E r{};for(int i=0;i<4;++i)for(int k=0;k<2;++k)r[2*i+k]=p[i][k];return r;}
E power(E a,int n){E r{};r[0]=1;while(n){if(n&1)r=times(r,a);a=times(a,a);n>>=1;}return r;}
E row(std::array<int,4> r){E a{};for(int i=0;i<4;++i){a[2*i]=r[i]%5;a[2*i+1]=r[i]/5;}return a;}
struct Pair{E c,e;};
Pair plus(Pair a,Pair b){return {plus(a.c,b.c),plus(a.e,b.e)};}
struct Test{std::array<int,4> q;E a,b,ba,bb;int ma[8][8],mb[8][8];uint64_t bad_linear=0,bad_scalar=0,retained=0;};
void build(Test&t,E a,E b){t.a=a;t.b=b;E beta{};beta[1]=1;E barbeta{};barbeta[0]=1;barbeta[1]=4;t.ba=times(beta,a);t.bb=times(barbeta,b);
 for(int j=0;j<8;++j){E v{};v[j]=1;E aa=times(a,v),bb=times(b,v);for(int i=0;i<8;++i){assert(aa[i]<5&&bb[i]<5);t.ma[i][j]=aa[i];t.mb[i][j]=bb[i];}}}
// Return -1 for linear contradiction, -2 for nonzero scalar remainder;
// otherwise return the rank. The point is meaningful at rank four.
int test(const Test&t,const Pair&h,std::array<int,4>&point,int (*saved)[5]=nullptr){
 int eq[8][5];
 for(int i=0;i<8;++i){int cn=0;for(int j=0;j<8;++j){cn=add(cn,Small[t.ma[i][j]][h.e[j]]);cn=sub(cn,Small[t.mb[i][j]][h.c[j]]);}
  eq[i][0]=Neg[add(t.a[i],h.e[i])];
  int bd=(i%2)?Neg[h.e[i-1]]:add(h.e[i],Small[2][h.e[i+1]]);
  eq[i][1]=Neg[add(t.ba[i],bd)];eq[i][2]=add(t.b[i],h.c[i]);
  int bc=(i%2)?add(h.c[i-1],h.c[i]):Small[3][h.c[i+1]];
  eq[i][3]=add(t.bb[i],bc);eq[i][4]=Neg[cn];}
 if(saved)for(int i=0;i<8;++i)for(int j=0;j<5;++j)saved[i][j]=eq[i][j];
 int m[7][5];for(int i=0;i<7;++i)for(int j=0;j<5;++j)m[i][j]=eq[i+1][j];int rank=0,piv[4];
 for(int col=0;col<4;++col){int p=rank;while(p<7&&!m[p][col])++p;if(p==7)continue;for(int j=col;j<5;++j)std::swap(m[p][j],m[rank][j]);
  int den=inv(m[rank][col]);for(int j=col;j<5;++j)m[rank][j]=mul(m[rank][j],den);
  for(int i=rank+1;i<7;++i){int a=m[i][col];if(!a)continue;m[i][col]=0;for(int j=col+1;j<5;++j)m[i][j]=sub(m[i][j],mul(a,m[rank][j]));}piv[rank++]=col;}
 for(int i=rank;i<7;++i)if(m[i][4])return -1;
 if(rank<4)return rank;
 point={0,0,0,0};for(int i=3;i>=0;--i){int s=m[i][4];for(int j=piv[i]+1;j<4;++j)s=sub(s,mul(m[i][j],point[j]));point[piv[i]]=s;}
 int scalar=Neg[eq[0][4]];for(int j=0;j<4;++j)scalar=add(scalar,mul(eq[0][j],point[j]));
 auto norm=[](int x,int y){return add(add(mul(x,x),mul(x,y)),Small[2][mul(y,y)]);};
 scalar=add(scalar,sub(norm(point[0],point[1]),norm(point[2],point[3])));
 return scalar?-2:rank;
}
int main(int argc,char**argv){assert(argc==2||argc==3);std::string prefix=argv[1];init();
 E z{};int d=0,base=1;int ds[7]={1,2,4,1,3,0,1};for(int i=0;i<7;++i){d+=base*ds[i];base*=5;}
 z[0]=Small[3][sub(5,d)];z[1]=d;assert(power(z,29)==row({1,0,0,0}));
 E zp[29]{};zp[0][0]=1;for(int i=1;i<29;++i)zp[i]=times(zp[i-1],z);
 E eta=row({22,0,0,0}),ie=power(eta,23);assert(times(eta,ie)==row({1,0,0,0}));
 E c=row({22,7,9,23}),e=row({1,3,8,15});Pair labels[116];
 for(int i=0;i<4;++i){for(int j=0;j<29;++j)labels[29*i+j]={times(times(c,zp[5*j%29]),ie),times(times(e,zp[8*j%29]),ie)};c=power(c,25);e=power(e,25);}
 std::array<std::array<int,4>,8> counts={{{0,0,0,4},{0,0,1,3},{0,0,2,2},{0,0,3,1},{0,1,0,3},{0,1,1,2},{0,1,2,1},{0,2,1,1}}};
 std::vector<Test> tests;for(auto ns:counts){Test t{};Pair sums{};int p=0;for(int i=0;i<4;++i)for(int j=0;j<ns[i];++j){t.q[p++]=29*i;sums=plus(sums,labels[29*i]);}build(t,sums.e,sums.c);tests.push_back(t);}
 if(argc==3){assert(std::string(argv[2])=="--sample-matrices");std::ifstream in(prefix+".samples.tsv");std::ofstream mats(prefix+".sample_matrices.tsv");assert(in&&mats);std::string line;std::getline(in,line);int count=0;
  while(std::getline(in,line)){std::istringstream s(line);std::array<int,4> q,h;int status;for(int&v:q)s>>v;for(int&v:h)s>>v;s>>status;assert(s);
   auto t=std::find_if(tests.begin(),tests.end(),[&](auto&t){return t.q==q;});assert(t!=tests.end());Pair hs{};for(int v:h)hs=plus(hs,labels[v]);std::array<int,4> pt{};int mm[8][5];assert(test(*t,hs,pt,mm)==status);
   for(int i=0;i<8;++i)for(int j=0;j<5;++j)mats<<(i||j?"\t":"")<<mm[i][j];mats<<'\n';++count;}
  assert(count==2008);std::cout<<"Reconstructed all2008 original sample matrices.\n";return 0;}
 std::ofstream out(prefix+".candidates.tsv"),samples(prefix+".samples.tsv");assert(out&&samples);
 out<<"q0\tq1\tq2\tq3\th0\th1\th2\th3\trank\tx0\tx1\ty0\ty1\n";
 samples<<"q0\tq1\tq2\tq3\th0\th1\th2\th3\tstatus\n";uint64_t n=0;
 for(int a=0;a<116;++a){for(int b=a;b<116;++b){Pair ab=plus(labels[a],labels[b]);for(int c=b;c<116;++c){Pair abc=plus(ab,labels[c]);for(int d=c;d<116;++d){Pair h=plus(abc,labels[d]);++n;
  for(auto&t:tests){std::array<int,4> pt{};int status=test(t,h,pt);if(status==-1)++t.bad_linear;else if(status==-2)++t.bad_scalar;else{++t.retained;for(int v:t.q)out<<v<<'\t';out<<a<<'\t'<<b<<'\t'<<c<<'\t'<<d<<'\t'<<status;for(int v:pt)out<<'\t'<<v;out<<'\n';}
   if(n%31717==1){for(int v:t.q)samples<<v<<'\t';samples<<a<<'\t'<<b<<'\t'<<c<<'\t'<<d<<'\t'<<status<<'\n';}}
 }}}
 if(a%8==0){std::cout<<"H "<<n<<" first-label "<<a;for(auto&t:tests)std::cout<<" / "<<t.retained;std::cout<<std::endl;out.flush();}}
 assert(n==7940751);std::ofstream summary(prefix+".json");summary<<"{\"status\":\"COMPLETE\",\"H_count\":"<<n<<",\"cases\":[";
 for(unsigned i=0;i<tests.size();++i){auto&t=tests[i];assert(t.bad_linear+t.bad_scalar+t.retained==n);if(i)summary<<',';summary<<"{\"Q\":[";for(int j=0;j<4;++j)summary<<(j?",":"")<<t.q[j];summary<<"],\"linear_inconsistent\":"<<t.bad_linear<<",\"scalar_inconsistent\":"<<t.bad_scalar<<",\"retained\":"<<t.retained<<'}';}summary<<"]}\n";
}
