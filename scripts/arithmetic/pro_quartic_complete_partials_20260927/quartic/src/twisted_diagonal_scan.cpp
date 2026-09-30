#include "fast_field.hpp"
#include <chrono>
#include <string>
using namespace exact;
using V4=std::array<int,4>;
struct Affine {bool consistent=true;int rank=0;V4 p{};std::vector<V4> null;};
inline int coord(F f,int i){return i%2?f.c[i/2].b:f.c[i/2].a;}
Affine solve(const std::array<F,4>&cols,F constant){
 int a[7][5];for(int i=0;i<7;++i){for(int j=0;j<4;++j)a[i][j]=coord(cols[j],i+1);a[i][4]=neg(coord(constant,i+1));}
 std::array<int,4> piv{};piv.fill(-1);int rank=0;
 for(int j=0;j<4;++j){
  int ii=rank;while(ii<7&&!a[ii][j])++ii;if(ii==7)continue;
  for(int k=0;k<5;++k)std::swap(a[rank][k],a[ii][k]);
  int v=inv(a[rank][j]);for(int k=j;k<5;++k)a[rank][k]=mul(a[rank][k],v);
  for(int i=0;i<7;++i)if(i!=rank&&a[i][j]){int v=a[i][j];for(int k=j;k<5;++k)a[i][k]=sub(a[i][k],mul(v,a[rank][k]));}
  piv[j]=rank++;
 }
 Affine out;out.rank=rank;
 for(int i=rank;i<7;++i)if(a[i][4]){out.consistent=false;return out;}
 for(int j=0;j<4;++j)if(piv[j]>=0)out.p[j]=a[piv[j]][4];
 for(int j=0;j<4;++j)if(piv[j]<0){V4 n{};n[j]=1;for(int k=0;k<4;++k)if(piv[k]>=0)n[k]=neg(a[piv[k]][j]);out.null.push_back(n);}
 return out;
}
int quadratic(V4 v,const std::array<F,4>&cols,F constant){
 int r=coord(constant,0);for(int i=0;i<4;++i)r=add(r,mul(coord(cols[i],0),v[i]));
 int nx=add(add(mul(v[0],v[0]),mul(v[0],v[1])),smul(mul(v[1],v[1]),2));
 int ny=add(add(mul(v[2],v[2]),mul(v[2],v[3])),smul(mul(v[3],v[3]),2));
 return add(r,sub(nx,ny));
}
V4 line(V4 p,V4 n,int t){for(int i=0;i<4;++i)p[i]=add(p[i],mul(n[i],t));return p;}
std::vector<int> roots(int a,int b,int c,bool&all){
 all=false;if(!a){if(!b){all=!c;return {};}return{divi(neg(c),b)};}
 int disc=sub(mul(b,b),smul(mul(a,c),4));if(disc&&lg[disc]%2)return{};
 int sq=disc?ex[lg[disc]/2]:0,den=inv(smul(a,2));
 std::vector<int>r={mul(sub(sq,b),den)};if(sq)r.push_back(mul(sub(neg(sq),b),den));return r;
}
void printK(K v){std::cout<<'['<<v.a<<','<<v.b<<']';}
void printF(F v){std::cout<<'[';for(int j=0;j<4;++j){if(j)std::cout<<',';printK(v.c[j]);}std::cout<<']';}
int main(int argc,char**argv){
 if(argc<2){std::cerr<<"usage: twisted_diagonal_scan delta [start stop [phase_multiplier phase_shift type_sign]]\n";return 2;}
 int delta=std::stoi(argv[1]),start=0,stop=116;
 if(delta<0||delta>3)throw std::runtime_error("delta out of range");
 if(argc>2) start=std::stoi(argv[2]);
 if(argc>3) stop=std::stoi(argv[3]);
 int phase_mult=1,phase_shift=0,type_sign=1;
 if(argc>4) phase_mult=std::stoi(argv[4]);
 if(argc>5) phase_shift=std::stoi(argv[5]);
 if(argc>6) type_sign=std::stoi(argv[6]);
 if(phase_mult%29==0 || (type_sign!=1 && type_sign!=-1)) throw std::runtime_error("invalid transform");
 if(start<0 || stop>116 || start>stop) throw std::runtime_error("invalid label range");
 init();init_labels();
 uint64_t total=0,ad=0,lin=0,quad=0,pass3=0,pass4=0,whole_line=0,unresolved_plane=0;
 std::array<uint64_t,5> ranks{},lin_ranks{};
 K eta=K::code(22),ie=eta.inverse(),bet=K::code(5),one(1);
 auto begin=std::chrono::steady_clock::now();
 for(int i=start;i<stop;++i)for(int j=i;j<116;++j)for(int k=j;k<116;++k)for(int l=k;l<116;++l){
  std::array<int,4> ix={i,j,k,l};++total;if(!admissible(ix))continue;++ad;
  F B=(labels[i][0]+labels[j][0]+labels[k][0]+labels[l][0]).times(ie);
  F A=(labels[i][1]+labels[j][1]+labels[k][1]+labels[l][1]).times(ie);
  std::array<int,4> hx=ix;
  for(int& v:hx){int ph=((phase_mult*(v/4)+phase_shift)%29+29)%29;int ty=((type_sign*(v%4)+delta)%4+4)%4;v=4*ph+ty;}
  std::sort(hx.begin(),hx.end());
  if(!admissible(hx))throw std::runtime_error("Admissibility not preserved");
  auto HT=endpoint(hx);
  F C=HT[0].times(ie),D=HT[1].times(ie);
  std::array<F,4>cols={-A-D,-A.times(bet)-D.times(one-bet),B+C,B.times(one-bet)+C.times(bet)};
  F constant=A*D-B*C;Affine af=solve(cols,constant);++ranks[af.rank];
  if(!af.consistent) continue;
  ++lin; ++lin_ranks[af.rank];
  std::cout<<"{\"kind\":\"linear_candidate\",\"delta\":"<<delta<<",\"phase_mult\":"<<phase_mult<<",\"phase_shift\":"<<phase_shift<<",\"type_sign\":"<<type_sign<<",\"rank\":"<<af.rank<<",\"Q\":";print_ix(ix,std::cout);std::cout<<",\"H\":";print_ix(hx,std::cout);std::cout<<",\"particular\":[";for(int v=0;v<4;++v){if(v)std::cout<<',';std::cout<<af.p[v];}std::cout<<"],\"quadric_at_particular\":"<<quadratic(af.p,cols,constant)<<"}\n";
  // In the retained exhaustive runs, every consistent point fails this
  // scalar-quadric test. The subsequent (3),(4) replay is UNEXERCISED there.
  auto candidate=[&](V4 v){
   if(quadratic(v,cols,constant)) return;
   ++quad;
   K x(v[0],v[1]),y(v[2],v[3]);
   F epsilon=(D-F(x))/(B-F(y));
   if(epsilon*(A-F(x.bar()))!=C-F(y.bar())||epsilon*(B-F(y))!=D-F(x))throw std::runtime_error("First-two replay failed");
   auto Q=endpoint(ix),H=HT;
   F eq3=epsilon*(Q[2]-F(eta*x.frob(4)))+Q[3]+F(eta*y.bar().frob(1));
   if(!eq3.zero()) return;
   ++pass3;
   F eq4=H[2]+epsilon*(H[3]+F(eta*y.frob(1)))-F(eta*x.bar().frob(4));
   if(!eq4.zero()) return;
   ++pass4;
   std::cout<<"{\"kind\":\"full_four_trace_candidate\",\"delta\":"<<delta<<",\"Q\":";print_ix(ix,std::cout);
   std::cout<<",\"H\":";print_ix(hx,std::cout);std::cout<<",\"x\":";printK(x);std::cout<<",\"y\":";printK(y);std::cout<<",\"epsilon\":";printF(epsilon);std::cout<<"}\n";
  };
  if(af.rank==4){candidate(af.p);continue;}
  // This branch is retained for reuse, but NO consistent rank-three
  // case occurred in the recorded runs. No claim relies on this tail.
  if(af.rank==3){
   auto n=af.null[0];int c=quadratic(af.p,cols,constant);
   int plus=quadratic(line(af.p,n,1),cols,constant),minus=quadratic(line(af.p,n,4),cols,constant);
   int a=smul(sub(add(plus,minus),smul(c,2)),3); // 1/2=3
   int b=smul(sub(plus,minus),3);bool all;
   auto rr=roots(a,b,c,all);
   if(all){++whole_line;for(int t=0;t<q;++t)candidate(line(af.p,n,t));}
   else for(int t:rr)candidate(line(af.p,n,t));
   continue;
  }
  ++unresolved_plane;
  std::cout<<"{\"kind\":\"unresolved_affine_dimension_ge_two\",\"delta\":"<<delta<<",\"rank\":"<<af.rank<<",\"Q\":";print_ix(ix,std::cout);std::cout<<"}\n";
 }
 std::cerr<<"{\"delta\":"<<delta<<",\"phase_mult\":"<<phase_mult<<",\"phase_shift\":"<<phase_shift<<",\"type_sign\":"<<type_sign<<",\"start\":"<<start<<",\"stop\":"<<stop<<",\"total\":"<<total<<",\"admissible\":"<<ad<<",\"linear_consistent\":"<<lin<<",\"quadratic_pass\":"<<quad<<",\"equation3_pass\":"<<pass3<<",\"equation4_pass\":"<<pass4<<",\"whole_lines_enumerated\":"<<whole_line<<",\"unresolved_planes\":"<<unresolved_plane<<",\"rank_counts\":[";
 for(int i=0;i<5;++i){if(i)std::cerr<<',';std::cerr<<ranks[i];}
 std::cerr<<"],\"linear_consistent_rank_counts\":[";for(int i=0;i<5;++i){if(i)std::cerr<<',';std::cerr<<lin_ranks[i];}
 std::cerr<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count()<<"}\n";
}
