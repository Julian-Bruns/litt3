// Independent prime-field replay of balanced moment exclusions.
// No include or arithmetic call to the F25 implementation.
#include <array>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <vector>
using V=std::array<int,14>;
const int modulus[15]={1,2,4,0,4,4,3,1,3,4,4,0,4,2,1};
V identity{1},origin{},phase[29],beta{1,1,0,0,4,3,3,1,1,3,1,2,1,1};
V plus(V a,const V&b){for(int j=0;j<14;j++)a[j]=(a[j]+b[j])%5;return a;}
V minus(V a,const V&b){for(int j=0;j<14;j++)a[j]=(a[j]+5-b[j])%5;return a;}
V times(V a,int b){for(auto &v:a)v=v*b%5;return a;}
V product(const V&a,const V&b){
 std::array<int,27> raw{};
 for(int i=0;i<14;i++)for(int j=0;j<14;j++)raw[i+j]+=a[i]*b[j];
 for(int i=26;i>=14;i--){int r=raw[i]%5;for(int j=0;j<14;j++)raw[i-14+j]+=r*(5-modulus[j]);}
 V out{};for(int j=0;j<14;j++)out[j]=raw[j]%5;return out;
}
V power(V a,std::uint64_t n){V r=identity;while(n){if(n&1)r=product(r,a);a=product(a,a);n>>=1;}return r;}
V kap;
int first[29][14][14],second[29][14][14];
void setup(){
 V z{};z[1]=1;phase[0]=identity;for(int i=1;i<29;i++)phase[i]=product(phase[i-1],z);
 assert(product(phase[28],z)==identity);
 assert(product(beta,beta)==plus(beta,times(identity,3)));
 assert(power(beta,25)==beta&&power(beta,5)!=beta);
 // Verify the specified degree-seven F25 factor using the absolute basis.
 int codes[8]={4,22,7,20,21,7,24,1};V value{};
 for(int i=0;i<8;i++)value=plus(value,product(phase[i],plus(times(identity,codes[i]%5),times(beta,codes[i]/5))));
 assert(value==origin);
 kap=plus(times(identity,2),times(beta,3));
 for(int i=0;i<29;i++)for(int j=0;j<14;j++){
  V e{};e[j]=1;auto a=product(e,phase[8*i%29]),b=product(e,phase[5*i%29]);
  for(int k=0;k<14;k++){first[i][k][j]=a[k];second[i][k][j]=b[k];}
 }
}
struct Audit {
 int mass;std::uint64_t count=0,matches=0;
 void evaluate(V x,V y,V xb,V yb){
  ++count;
  V a=minus(identity,xb),b=times(product(kap,minus(kap,y)),4);
  V c=minus(product(minus(kap,y),yb),product(x,a));
  for(int p=0;p<29;p++){
   bool good=true;
   for(int k=0;k<14&&good;k++){
    int v=c[k];for(int j=0;j<14;j++)v+=a[j]*first[p][k][j]+b[j]*second[p][k][j];
    good=(v%5==0);
   }
   if(good){
    // Direct, different expression for every surviving determinant point.
    assert(product(minus(identity,xb),minus(phase[8*p%29],x))==
           product(minus(kap,y),minus(product(kap,phase[5*p%29]),yb)));
    ++matches;
   }
  }
 }
 void visit(int node,int remaining,V x,V y,V xb,V yb){
  if(!remaining){evaluate(x,y,xb,yb);return;}
  if(node==29)return;
  // Integer weights per node, unlike the multiset generator being checked.
  for(int w=0;w<=remaining&&w<=6;w++)if(w!=5)
   visit(node+1,remaining-w,plus(x,times(phase[2*node%29],w)),
    plus(y,times(phase[6*node%29],w)),plus(xb,times(phase[(29-2*node%29)%29],w)),
    plus(yb,times(phase[(29-6*node%29)%29],w)));
 }
};
int main(int argc,char**argv){
 if(argc!=4)return 2;int low=std::stoi(argv[1]),high=std::stoi(argv[2]);
 assert(low>=0&&high<=8&&low<=high);setup();
 std::ofstream out(argv[3]);out<<"{\"method\":\"independent absolute F5 arithmetic and weight enumeration\",\"results\":[";
 std::array<std::uint64_t,9> expected{};expected[0]=1;
 for(int node=0;node<29;node++){
  auto previous=expected;expected.fill(0);
  for(int d=0;d<=8;d++)for(int w:{0,1,2,3,4,6})if(w<=d)expected[d]+=previous[d-w];
 }
 for(int m=low;m<=high;m++){
  Audit a{m};a.visit(0,m,origin,origin,origin,origin);assert(a.count==expected[m]);
  if(m>low)out<<",";out<<"{\"mass\":"<<m<<",\"profiles\":"<<a.count<<",\"phases_each\":29,\"determinant_points\":"<<a.matches<<"}";out.flush();
  std::cout<<"independent mass="<<m<<" count="<<a.count<<" matches="<<a.matches<<std::endl;
 }
 out<<"]}\n";
}
