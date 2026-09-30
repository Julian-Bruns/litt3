// Exhaust the small pole-mass moment conditions in the BALANCED endpoint
// sector only. No curve, return, or unrestricted endpoint classification.
// Field F25[z]/(4+22z+7z^2+20z^3+21z^4+7z^5+24z^6+z^7).
// Every field code is a+5b, b^2=b+3; all arithmetic is exact.
#include <array>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <vector>
using F=std::array<int,7>;
int add25[25][25],mul25[25][25],neg25[25];
F zero{},one{1,0,0,0,0,0,0},zp[29],xp[29],yp[29],xm[29],ym[29];
int lin8[29][7][7],lin5[29][7][7];
F add(F a,const F&b){for(int i=0;i<7;i++)a[i]=add25[a[i]][b[i]];return a;}
F neg(F a){for(auto &v:a)v=neg25[v];return a;}
F sub(F a,const F&b){return add(a,neg(b));}
F scale(F a,int c){for(auto &v:a)v=mul25[v][c];return a;}
F mul(const F&a,const F&b){
 std::array<int,13> c{}; int mod[7]={4,22,7,20,21,7,24};
 for(int i=0;i<7;i++)for(int j=0;j<7;j++)c[i+j]=add25[c[i+j]][mul25[a[i]][b[j]]];
 for(int i=12;i>=7;i--)for(int j=0;j<7;j++)c[i-7+j]=add25[c[i-7+j]][neg25[mul25[c[i]][mod[j]]]];
 F out{};for(int i=0;i<7;i++)out[i]=c[i];return out;
}
void init(){
 for(int a=0;a<25;a++){
  neg25[a]=((5-a%5)%5)+5*((5-a/5)%5);
  for(int b=0;b<25;b++){
   add25[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
   mul25[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
  }
 }
 zp[0]=one;F z{0,1,0,0,0,0,0};for(int i=1;i<29;i++)zp[i]=mul(zp[i-1],z);
 assert(mul(zp[28],z)==one);
 for(int i=0;i<29;i++){
  xp[i]=zp[2*i%29];yp[i]=zp[6*i%29];xm[i]=zp[(29-2*i%29)%29];ym[i]=zp[(29-6*i%29)%29];
  for(int j=0;j<7;j++){
   F e{};e[j]=1;auto a=mul(e,zp[8*i%29]),b=mul(e,zp[5*i%29]);
   for(int k=0;k<7;k++){lin8[i][k][j]=a[k];lin5[i][k][j]=b[k];}
  }
 }
}
struct Run {
 int mass; std::uint64_t profiles=0,detpoints=0,valid=0; std::array<int,29> w{};
 std::vector<std::array<int,30>> witnesses;
 void test(const F&x,const F&y,const F&xb,const F&yb){
  for(int v:w)if(v==5)return;
  ++profiles;
  // (1-xbar)(psi^8-x) - (kappa-y)(kappa psi^5-ybar).
  F a=sub(one,xb),d=sub(scale(one,17),y);
  F b=neg(scale(d,17)),c=sub(mul(d,yb),mul(x,a));
  for(int ph=0;ph<29;ph++){
   bool ok=true;
   for(int k=0;k<7&&ok;k++){
    int v=c[k];for(int j=0;j<7;j++)v=add25[v][add25[mul25[a[j]][lin8[ph][k][j]]][mul25[b[j]][lin5[ph][k][j]]]];
    if(v)ok=false;
   }
   if(!ok)continue;
   ++detpoints;
   F r0=sub(scale(zp[5*ph%29],17),yb),r1=sub(zp[8*ph%29],x);
   bool nonzeroL=a!=zero||d!=zero,nonzeroR=r0!=zero||r1!=zero;
   if(nonzeroL!=nonzeroR)continue;
   // Determinant zero and both vectors nonzero imply a nonzero scale;
   // two zero vectors allow every nonzero scale and are also retained.
   ++valid; std::array<int,30> wit{};for(int i=0;i<29;i++)wit[i]=w[i];wit[29]=ph;
   if(witnesses.size()<100)witnesses.push_back(wit);
  }
 }
 void rec(int start,int left,F x,F y,F xb,F yb){
  if(!left){test(x,y,xb,yb);return;}
  // Nondecreasing multisets give each integer profile once. Weight 5 is
  // forbidden at the terminal check; weight 6 is retained.
  for(int i=start;i<29;i++)if(w[i]<6){
   ++w[i];
   if(left!=1||w[i]!=5)rec(i,left-1,add(x,xp[i]),add(y,yp[i]),add(xb,xm[i]),add(yb,ym[i]));
   --w[i];
  }
 }
 void run(){rec(0,mass,zero,zero,zero,zero);}
};
int main(int argc,char**argv){
 if(argc!=4){std::cerr<<"usage: balanced_mass min_mass max_mass output.json\n";return 2;}
 init();int lo=std::stoi(argv[1]),hi=std::stoi(argv[2]);assert(0<=lo&&lo<=hi&&hi<=8);
 std::ofstream out(argv[3]);out<<"{\"scope\":\"balanced endpoint moments only\",\"results\":[";
 for(int m=lo;m<=hi;m++){
  Run r{m};r.run();if(m>lo)out<<",";
  out<<"{\"mass\":"<<m<<",\"profiles\":"<<r.profiles<<",\"phases_each\":29,\"determinant_points\":"<<r.detpoints<<",\"nonzero_scale_points\":"<<r.valid<<",\"witnesses\":[";
  for(size_t j=0;j<r.witnesses.size();j++){if(j)out<<",";out<<"[";for(int k=0;k<30;k++){if(k)out<<",";out<<r.witnesses[j][k];}out<<"]";}out<<"]}";out.flush();
  std::cout<<"mass="<<m<<" profiles="<<r.profiles<<" determinant="<<r.detpoints<<" valid="<<r.valid<<std::endl;
 }
 out<<"],\"actual_curves_constructed\":0}\n";
}
