// Exact endpoint multiset check over F_25[alpha,zeta].
// alpha has degree 4; zeta has degree 7 and exact order 29.
#include <array>
#include <vector>
#include <algorithm>
#include <iostream>
#include <fstream>
#include <stdexcept>
#include <chrono>
#include <cstdint>
#include <string>
#include <unordered_map>
#include "field_constants.h"
static unsigned char ADD[25][25], MUL[25][25], NEG[25];
struct E {
 std::array<unsigned char,28> a{}; // coefficient of alpha^i zeta^j at 7*i+j
 bool operator==(E const&b)const{return a==b.a;}
 bool operator!=(E const&b)const{return a!=b.a;}
 bool zero()const {for(auto x:a)if(x)return false;return true;}
};
E one(){E a;a.a[0]=1;return a;}
E add(E const&a,E const&b){E c;for(int i=0;i<28;i++)c.a[i]=ADD[a.a[i]][b.a[i]];return c;}
E mul(E const&a,E const&b){
 unsigned char w[7][13]{};
 for(int i=0;i<4;i++)for(int j=0;j<7;j++){
  const auto x=a.a[7*i+j]; if(!x)continue;
  for(int h=0;h<4;h++)for(int k=0;k<7;k++){
   const auto y=b.a[7*h+k]; if(!y)continue;
   auto&v=w[i+h][j+k];v=ADD[v][MUL[x][y]];
  }
 }
 for(int i=6;i>=4;i--)for(int j=0;j<13;j++){
  const auto x=w[i][j];if(!x)continue;
  for(int h=0;h<4;h++)w[i-4+h][j]=ADD[w[i-4+h][j]][MUL[x][NEG[AM[h]]]];
 }
 for(int j=12;j>=7;j--)for(int i=0;i<4;i++){
  const auto x=w[i][j];if(!x)continue;
  for(int k=0;k<7;k++)w[i][j-7+k]=ADD[w[i][j-7+k]][MUL[x][NEG[ZM[k]]]];
 }
 E c;for(int i=0;i<4;i++)for(int j=0;j<7;j++)c.a[7*i+j]=w[i][j];return c;
}
E power(E a,uint64_t n){E s=one();while(n>0){if((n&1)!=0)s=mul(s,a);a=mul(a,a);n>>=1;}return s;}
E inv(E const&a){
 if(a.zero())throw std::runtime_error("zero inverse");
 E a23=power(a,23),a24=mul(a23,a),r=a24;
 // Base-25 expansion: 25^28-2 has 27 digits 24 followed by 23.
 for(int i=26;i>=1;--i)r=mul(power(r,25),a24);
 return mul(power(r,25),a23);
}
E ztimes(E const&a){
 E b;for(int i=0;i<4;i++){
  const auto h=a.a[7*i+6];
  b.a[7*i]=MUL[h][NEG[ZM[0]]];
  for(int j=1;j<7;j++)b.a[7*i+j]=ADD[a.a[7*i+j-1]][MUL[h][NEG[ZM[j]]]];
 }return b;
}
std::pair<E,int> canonical(E a){
 E best=a;int shift=0;
 for(int i=1;i<29;i++){a=ztimes(a);if(a.a<best.a){best=a;shift=i;}}
 return {best,shift};
}
std::vector<E> binverse(std::vector<E> const&a){
 std::vector<E> prefix(a.size()),out(a.size());
 std::array<int,8> failures{};
 #pragma omp parallel for schedule(static) num_threads(4)
 for(int part=0;part<8;part++){
  size_t lo=a.size()*part/8,hi=a.size()*(part+1)/8;E prod=one();
  for(size_t i=lo;i<hi;i++){prefix[i]=prod;prod=mul(prod,a[i]);}
  E r=inv(prod);
  for(size_t i=hi;i-->lo;){out[i]=mul(r,prefix[i]);r=mul(r,a[i]);}
  failures[part]=(r!=one());
 }
 for(int f:failures)if(f)throw std::runtime_error("batch inverse final check failed");
 return out;
}
struct Hash{size_t operator()(E const&e)const{
 uint64_t h=1469598103934665603ULL;for(auto x:e.a){h^=x;h*=1099511628211ULL;}return h;
}};
void init(){for(int a=0;a<25;a++){
 NEG[a]=(-(a%5)+5)%5+5*((-(a/5)+5)%5);
 for(int b=0;b<25;b++){
  ADD[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
  MUL[a][b]=((a%5)*(b%5)+3*(a/5)*(b/5))%5+5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
 }
}}
int main(int argc,char**argv){try{
 init();auto start=std::chrono::steady_clock::now();
 std::string outpath=argc>1?argv[1]:"endpoint_check.json";
 int defect=argc>2?std::stoi(argv[2]):0;
 if(defect<0||defect>4)throw std::runtime_error("defect must be 0..4");
 E offset;offset.a[0]=MUL[8][defect];
 E alpha;alpha.a[7]=1;E zeta;zeta.a[1]=1;
 if(power(zeta,29)!=one()||zeta==one())throw std::runtime_error("zeta order");
 E am=power(alpha,4);E ak=one();
 for(int i=0;i<4;i++){E c;for(int j=0;j<28;j++)c.a[j]=MUL[ak.a[j]][AM[i]];am=add(am,c);ak=mul(ak,alpha);}
 if(!am.zero())throw std::runtime_error("alpha relation");
 int stage=argc>3?std::stoi(argv[3]):0;
 if(stage<0||stage>3)throw std::runtime_error("stage must be 0..3");
 std::vector<uint32_t> reps;std::vector<E>rho,invrho;
 uint64_t enumerated=0,zero_c=0,zero_m=0,zero_both=0;
 auto write_stage1=[&](){
  std::ofstream b(outpath+".ratios",std::ios::binary);uint64_t n=reps.size();
  for(auto z:{uint64_t(20260924),uint64_t(defect),n,enumerated,zero_c,zero_m,zero_both})b.write(reinterpret_cast<char*>(&z),sizeof(z));
  b.write(reinterpret_cast<char*>(reps.data()),reps.size()*sizeof(uint32_t));
  b.write(reinterpret_cast<char*>(rho.data()),rho.size()*sizeof(E));
  if(!b)throw std::runtime_error("stage 1 write failed");
 };
 auto read_stage1=[&](){
  std::ifstream b(outpath+".ratios",std::ios::binary);uint64_t magic,d,n;
  for(auto z:{&magic,&d,&n,&enumerated,&zero_c,&zero_m,&zero_both})b.read(reinterpret_cast<char*>(z),sizeof(*z));
  if(!b||magic!=20260924||d!=uint64_t(defect))throw std::runtime_error("stage 1 header invalid");
  reps.resize(n);rho.resize(n);
  b.read(reinterpret_cast<char*>(reps.data()),reps.size()*sizeof(uint32_t));
  b.read(reinterpret_cast<char*>(rho.data()),rho.size()*sizeof(E));
  if(!b)throw std::runtime_error("stage 1 read failed");
 };
 if(stage<=1){
  std::array<E,29>Z;Z[0]=one();for(int j=1;j<29;j++)Z[j]=ztimes(Z[j-1]);
  std::array<E,116>C,M;
  for(int i=0;i<4;i++)for(int j=0;j<29;j++){
   E ci,mi;for(int h=0;h<4;h++){ci.a[h*7]=CCOEFF[i][h];mi.a[h*7]=MCOEFF[i][h];}
   C[29*i+j]=mul(ci,Z[(5*j)%29]);M[29*i+j]=mul(mi,Z[(8*j)%29]);
  }
  std::vector<E>cs,ms;
  const size_t expected=defect?7940751:273819;reps.reserve(expected);cs.reserve(expected);ms.reserve(expected);
  for(int a=0;a<116;a++){
   if(!defect&&a%29){continue;}int i0=a/29;
   for(int b=a;b<116;b++)for(int c=b;c<116;c++)for(int d=c;d<116;d++){
    std::array<int,4>p={a,b,c,d};bool ok=true;
    for(int q:p){if(defect||q/29!=i0||q%29==0)continue;std::array<int,4>pp;
     for(int j=0;j<4;j++)pp[j]=29*(p[j]/29)+(p[j]%29-q%29+29)%29;
     std::sort(pp.begin(),pp.end());if(pp<p){ok=false;break;}
    }
    if(!ok)continue;
    E cc=add(add(add(C[a],C[b]),add(C[c],C[d])),offset);E mm=add(add(add(M[a],M[b]),add(M[c],M[d])),offset);
    enumerated++;
    if(cc.zero()||mm.zero()){
     zero_c+=cc.zero();zero_m+=mm.zero();zero_both+=(cc.zero()&&mm.zero());
     if(zero_c+zero_m<12)std::cerr<<"Zero shifted sum: "<<a<<","<<b<<","<<c<<","<<d<<" C="<<cc.zero()<<" M="<<mm.zero()<<"\n";
     continue;
    }
    reps.push_back(a|(b<<7)|(c<<14)|(d<<21));cs.push_back(cc);ms.push_back(mm);
   }
  }
  if(enumerated!=expected)throw std::runtime_error("representative count");
  std::cerr<<"Enumerated "<<enumerated<<" multisets/representatives; retained "<<reps.size()<<"; inverting C sums\n";
  auto invc=binverse(cs);rho.resize(reps.size());
  #pragma omp parallel for schedule(static) num_threads(4)
  for(size_t i=0;i<reps.size();i++)rho[i]=mul(ms[i],invc[i]);
  std::cerr<<"Computed ratios\n";
  if(stage==1){write_stage1();std::cout<<"Stage 1 complete\n";return 0;}
 }else read_stage1();
 if(stage<=2){
  std::cerr<<"Inverting ratios\n";invrho=binverse(rho);
  if(stage==2){
   std::ofstream b(outpath+".inverses",std::ios::binary);b.write(reinterpret_cast<char*>(invrho.data()),invrho.size()*sizeof(E));
   if(!b)throw std::runtime_error("stage 2 write failed");
   std::cout<<"Stage 2 complete\n";return 0;
  }
 }else{
  invrho.resize(rho.size());std::ifstream b(outpath+".inverses",std::ios::binary);
  b.read(reinterpret_cast<char*>(invrho.data()),invrho.size()*sizeof(E));
  if(!b)throw std::runtime_error("stage 2 read failed");
 }
 std::unordered_map<E,size_t,Hash>lookup;lookup.reserve(reps.size()*2);std::vector<int>shifts;
 std::cerr<<"Canonicalizing mu_29 ratio classes\n";
 for(size_t i=0;i<rho.size();i++){auto q=defect?std::make_pair(rho[i],0):canonical(rho[i]);lookup.emplace(q.first,i);shifts.push_back(q.second);}
 size_t degenerate_hits=(zero_c&&zero_m)?1:0;
 size_t hits=0;std::vector<std::array<size_t,2>>witnesses;
 for(size_t i=0;i<rho.size();i++){
  // Recheck every computed inverse, not a sample.
  if(mul(rho[i],invrho[i])!=one())throw std::runtime_error("inverse verification failed");
  auto q=defect?std::make_pair(invrho[i],0):canonical(invrho[i]);auto it=lookup.find(q.first);
  if(it!=lookup.end()){hits++;if(witnesses.size()<100)witnesses.push_back({i,it->second});}
 }
 double seconds=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();
 std::ofstream f(outpath);
 f<<"{\n  \"status\": \"executed\",\n  \"defect\": "<<defect<<",\n  \"enumerated\": "<<enumerated<<",\n  \"zero_c\": "<<zero_c<<",\n  \"zero_m\": "<<zero_m<<",\n  \"zero_both\": "<<zero_both<<",\n  \"degenerate_hits\": "<<degenerate_hits<<",\n  \"multisets\": 7940751,\n  \"representatives\": "<<reps.size()<<",\n  \"ratio_classes\": "<<lookup.size()<<",\n  \"reciprocal_hits\": "<<hits<<",\n  \"seconds\": "<<seconds<<",\n  \"witnesses\": [";
 for(size_t k=0;k<witnesses.size();k++){
  if(k){f<<",";}f<<"{\"first\":[";
  for(int j=0;j<4;j++){if(j)f<<",";f<<((reps[witnesses[k][0]]>>(7*j))&127);}f<<"],\"second\":[";
  for(int j=0;j<4;j++){if(j)f<<",";f<<((reps[witnesses[k][1]]>>(7*j))&127);}f<<"]}";
 }
 f<<"]\n}\n";
 std::cout<<"representatives="<<reps.size()<<" ratio_classes="<<lookup.size()<<" reciprocal_hits="<<hits<<" seconds="<<seconds<<"\n";
 return (hits||degenerate_hits)?2:0;
}catch(std::exception const&e){std::cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
