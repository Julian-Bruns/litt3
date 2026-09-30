// Independent absolute-F5 model of the complete odd-scalar matching.
// Reconstructs endpoint character sums in F5[Z]/m14, rather than F25[Z]/f7.
// C++17; assertion-enabled. Compares the exact full candidate pair set.
#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <utility>
#include <vector>
using E=std::array<uint8_t,14>;
constexpr int modulus[14]={1,2,4,0,4,4,3,1,3,4,4,0,4,2};
E sum(E a,const E&b){for(int i=0;i<14;++i)a[i]=(a[i]+b[i])%5;return a;}
E times(const E&a,const E&b){int c[27]={};for(int i=0;i<14;++i)for(int j=0;j<14;++j)c[i+j]+=a[i]*b[j];
 for(int i=26;i>=14;--i){int t=(c[i]%5+5)%5;for(int j=0;j<14;++j)c[i-14+j]-=t*modulus[j];}
 E r{};for(int i=0;i<14;++i)r[i]=(c[i]%5+5)%5;return r;}
E scalar(E a,int n){for(auto&v:a)v=v*n%5;return a;}
E powr(E a,uint64_t n){E r{};r[0]=1;while(n){if(n%2)r=times(r,a);a=times(a,a);n/=2;}return r;}
uint64_t encode(const E&a){uint64_t r=0;for(int i=13;i>=0;--i)r=r*5+a[i];return r;}
uint32_t encode_labels(const std::array<int,4>&a){return a[0]+(a[1]<<7)+(a[2]<<14)+(a[3]<<21);}
std::array<int,4> decode_labels(uint32_t a){return {int(a&127),int((a>>7)&127),int((a>>14)&127),int((a>>21)&127)};}
E zeta[29],values[4][116];
E evaluate(const std::array<int,4>&ls,int family){E r{};for(int i:ls)r=sum(r,values[family][i]);return r;}
struct HEntry{uint64_t sum;uint32_t labels;bool operator<(const HEntry&b)const{return sum<b.sum||(sum==b.sum&&labels<b.labels);}};
struct QEntry{std::array<int,4> labels;E num,den,head;};
int main(int argc,char**argv){
 assert(argc==2);E one{};one[0]=1;E z{};z[1]=1;zeta[0]=one;
 for(int i=1;i<29;++i)zeta[i]=times(zeta[i-1],z);
 assert(times(zeta[28],z)==one);for(int i=1;i<29;++i)assert(zeta[i]!=one);
 int chars[4][4]={{1,2,4,3},{1,2,4,3},{1,4,1,4},{1,4,1,4}};int exps[4]={4,8,5,17};
 for(int r=0;r<4;++r)for(int i=0;i<4;++i)for(int j=0;j<29;++j)values[r][29*i+j]=scalar(zeta[exps[r]*j%29],chars[r][i]);
 std::vector<HEntry> hs;hs.reserve(7940751);uint64_t total=0;
 // Reverse lexicographic nesting differs from the primary enumeration.
 for(int d=0;d<116;++d)for(int c=0;c<=d;++c)for(int b=0;b<=c;++b)for(int a=0;a<=b;++a){
  std::array<int,4> ls={a,b,c,d};++total;E p=evaluate(ls,1),r=evaluate(ls,3);
  if(p==E{}||r==E{})continue;hs.push_back({encode(p),encode_labels(ls)});}
 assert(total==7940751&&hs.size()==7932196);std::sort(hs.begin(),hs.end());
 std::vector<QEntry> qs;E prod=one;
 for(int d=0;d<116;++d)for(int c=0;c<=d;++c)for(int b=0;b<=c;++b){
  std::array<int,4> ls={0,b,c,d};E p=evaluate(ls,1),den=evaluate(ls,3);if(p==E{}||den==E{})continue;
  E num=scalar(times(evaluate(ls,0),evaluate(ls,2)),4);qs.push_back({ls,num,den,prod});prod=times(prod,den);}
 assert(qs.size()==266627);E inverse=powr(prod,6103515623ULL);assert(times(prod,inverse)==one);
 uint64_t first=0;std::vector<std::pair<uint32_t,uint32_t>> matches;
 for(auto it=qs.rbegin();it!=qs.rend();++it){E target=times(it->num,times(inverse,it->head));inverse=times(inverse,it->den);
  uint64_t key=encode(target);auto pos=std::lower_bound(hs.begin(),hs.end(),HEntry{key,0});
  for(;pos!=hs.end()&&pos->sum==key;++pos){++first;auto h=decode_labels(pos->labels);
   E r=sum(times(evaluate(it->labels,1),evaluate(h,3)),times(evaluate(h,0),evaluate(h,2)));
   if(r==E{})matches.emplace_back(encode_labels(it->labels),pos->labels);}}
 assert(inverse==one);assert(first==93015&&matches.size()==503);std::sort(matches.begin(),matches.end());
 std::ifstream f(argv[1]);assert(f);std::string line;std::getline(f,line);std::vector<std::pair<uint32_t,uint32_t>> claimed;
 while(std::getline(f,line)){std::istringstream in(line);std::array<int,4> a{},b{};for(int&i:a)in>>i;for(int&i:b)in>>i;assert(in);claimed.emplace_back(encode_labels(a),encode_labels(b));}
 std::sort(claimed.begin(),claimed.end());assert(claimed==matches);
 std::cout<<"PASS: absolute F5 degree14 model, all 7940751 H and 266916 normalized Q; exact 503-pair set agrees.\n";
 return 0;
}
