#pragma once
// Reused exact arithmetic kernel from the retained degree-14 verifier.
// Exact finite endpoint-moment search. No geometric curve enumeration.
// C++17, standard library only. Field: F_(5^8)[z]/f7(z).
#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>
using namespace std;
static constexpr uint32_t Q=390625, N=390624;
static vector<uint16_t> plus625;
static vector<uint32_t> lg, ex, ng;
static uint32_t logf[7];
static int f25add(int a,int b){return (a%5+b%5)%5+5*((a/5+b/5)%5);}
static int f25neg(int a){return (5-a%5)%5+5*((5-a/5)%5);}
static int f25mul(int a,int b){return (a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}
static inline uint32_t add8(uint32_t a,uint32_t b){return plus625[(a%625)*625+b%625]+625u*plus625[(a/625)*625+b/625];}
static inline uint32_t mul8(uint32_t a,uint32_t b){return a&&b?ex[lg[a]+lg[b]]:0;}
static uint32_t slow8(uint32_t a,uint32_t b){
 int aa[4],bb[4],cc[7]={};
 for(int i=0;i<4;i++){aa[i]=a%25;bb[i]=b%25;a/=25;b/=25;}
 for(int i=0;i<4;i++)for(int j=0;j<4;j++)cc[i+j]=f25add(cc[i+j],f25mul(aa[i],bb[j]));
 const int am[4]={5,2,6,7};
 for(int d=6;d>=4;d--)for(int j=0;j<4;j++)cc[d-4+j]=f25add(cc[d-4+j],f25neg(f25mul(cc[d],am[j])));
 uint32_t r=0;for(int i=3;i>=0;i--)r=25*r+cc[i];return r;
}
static uint32_t pow8(uint32_t a,uint64_t n){uint32_t r=1;while(n){if(n&1)r=mul8(r,a);a=mul8(a,a);n>>=1;}return r;}
struct E {
 array<uint32_t,7> a{};
 bool operator==(const E& b)const{return a==b.a;}
 bool zero()const {for(auto x:a)if(x)return false;return true;}
};
static E one(){E r;r.a[0]=1;return r;}
[[maybe_unused]] static E scalar(uint32_t a){E r;r.a[0]=a;return r;}
static E add(const E& a,const E& b){E r;for(int i=0;i<7;i++)r.a[i]=add8(a.a[i],b.a[i]);return r;}
static E neg(const E& a){E r;for(int i=0;i<7;i++)r.a[i]=ng[a.a[i]];return r;}
static E sub(const E& a,const E& b){return add(a,neg(b));}
static E scale(const E& a,uint32_t c){E r;for(int i=0;i<7;i++)r.a[i]=mul8(a.a[i],c);return r;}
static E mul(const E& a,const E& b){
 uint32_t p[13]={},la[7],lb[7];
 for(int i=0;i<7;i++){la[i]=lg[a.a[i]];lb[i]=lg[b.a[i]];}
 for(int i=0;i<7;i++)if(a.a[i])for(int j=0;j<7;j++)if(b.a[j])p[i+j]=add8(p[i+j],ex[la[i]+lb[j]]);
 for(int d=12;d>=7;d--)if(p[d]){uint32_t l=lg[p[d]];for(int j=0;j<7;j++)p[d-7+j]=add8(p[d-7+j],ex[l+logf[j]]);}
 E r;copy(p,p+7,r.a.begin());return r;
}
static E square(const E& a){
 uint32_t p[13]={},la[7];for(int i=0;i<7;i++)la[i]=lg[a.a[i]];
 for(int i=0;i<7;i++)if(a.a[i]){
  p[2*i]=add8(p[2*i],ex[2*la[i]]);
  for(int j=i+1;j<7;j++)if(a.a[j]){uint32_t z=ex[la[i]+la[j]];p[i+j]=add8(p[i+j],add8(z,z));}
 }
 for(int d=12;d>=7;d--)if(p[d]){uint32_t l=lg[p[d]];for(int j=0;j<7;j++)p[d-7+j]=add8(p[d-7+j],ex[l+logf[j]]);}
 E r;copy(p,p+7,r.a.begin());return r;
}
static E power(E a,uint64_t n){E r=one();while(n){if(n&1)r=mul(r,a);a=square(a);n>>=1;}return r;}
static E inverse(E a){
 if(a.zero())throw runtime_error("inverse of zero");
 // q^7-2 = (q-2)+(q-1)q+...+(q-1)q^6, q=5^8.
 E r=power(a,Q-2),aq=a;
 for(int i=1;i<7;i++){aq=power(aq,Q);r=mul(r,power(aq,Q-1));}
 if(!(mul(a,r)==one()))throw runtime_error("inverse check");
 return r;
}
static uint64_t rngstate=0x7e54af829012bc3dULL;
static uint32_t rnd(){rngstate^=rngstate<<13;rngstate^=rngstate>>7;rngstate^=rngstate<<17;return rngstate%Q;}
static void initialize(){
 plus625.resize(625*625);lg.resize(Q);ex.resize(2*N);ng.resize(Q);
 for(int a=0;a<625;a++)for(int b=0;b<625;b++){int aa=a,bb=b,r=0,p=1;for(int j=0;j<4;j++){r+=p*((aa%5+bb%5)%5);aa/=5;bb/=5;p*=5;}plus625[a*625+b]=r;}
 for(uint32_t a=0;a<Q;a++){uint32_t aa=a,r=0,p=1;for(int j=0;j<8;j++){r+=p*((5-aa%5)%5);aa/=5;p*=5;}ng[a]=r;}
 vector<bool> seen(Q,false);uint32_t a=1;
 for(uint32_t i=0;i<N;i++){if(!a||seen[a])throw runtime_error("nonprimitive alpha");seen[a]=true;ex[i]=a;lg[a]=i;a=slow8(a,25);}
 if(a!=1)throw runtime_error("field generator order");
 for(uint32_t i=N;i<2*N;i++)ex[i]=ex[i-N];
 const int ff[7]={4,22,7,20,21,7,24};for(int i=0;i<7;i++)logf[i]=lg[ng[ff[i]]];
 for(int j=0;j<2000;j++){uint32_t a=rnd(),b=rnd();if(mul8(a,b)!=slow8(a,b))throw runtime_error("F8 product mismatch");}
 E z;z.a[1]=1;if(!(power(z,29)==one())||z==one())throw runtime_error("cyclotomic field relation");
 for(int j=0;j<100;j++){
  E a,b,c;for(int i=0;i<7;i++){a.a[i]=rnd();b.a[i]=rnd();c.a[i]=rnd();}
  if(!(mul(a,add(b,c))==add(mul(a,b),mul(a,c))))throw runtime_error("distributivity");
  if(!(mul(mul(a,b),c)==mul(a,mul(b,c))))throw runtime_error("associativity");
  if(!(square(a)==mul(a,a)))throw runtime_error("square mismatch");
  if(j<5)inverse(a);
 }
}

#include <sstream>
static constexpr uint64_t TOTAL_QUARTETS=7940751, TOTAL_ORBITS=1985630;
static array<E,116> CLabel, ELabel;
static array<E,29> ZP;
static vector<uint32_t> frob8;
static uint32_t quartet_code(int i,int j,int k,int l){return i|(j<<7)|(k<<14)|(l<<21);}
static array<int,4> decode_quartet(uint32_t c){return {int(c&127),int((c>>7)&127),int((c>>14)&127),int((c>>21)&127)};}
static uint32_t rotated_code(uint32_t c,int r){
 auto a=decode_quartet(c);for(auto&x:a)x=29*((x/29+r)%4)+x%29;
 sort(a.begin(),a.end());return quartet_code(a[0],a[1],a[2],a[3]);
}
static uint32_t canonical_code(uint32_t c){uint32_t m=c;for(int r=1;r<4;r++)m=min(m,rotated_code(c,r));return m;}
static E sigma(E v,int r=1){for(int h=0;h<r;h++)for(auto &x:v.a)x=frob8[x];return v;}
struct OrbitRec { E v; uint32_t code; }; // code: low 28 bits labels, next two bits Frobenius shift
[[maybe_unused]] static OrbitRec canonical_record(E v,uint32_t code){
 E best=v;int br=0;for(int r=1;r<4;r++){v=sigma(v);if(v.a<best.a){best=v;br=r;}}
 return {best,code|(uint32_t(br)<<28)};
}
static void initialize_labels(){
 initialize();frob8.resize(Q);for(uint32_t i=0;i<Q;i++)frob8[i]=pow8(i,25);
 E z;z.a[1]=1;ZP[0]=one();for(int i=1;i<29;i++)ZP[i]=mul(ZP[i-1],z);
 uint32_t c=22+25*7+625*9+15625*23,e=1+25*3+625*8+15625*15;
 for(int i=0;i<4;i++){
  for(int j=0;j<29;j++){CLabel[29*i+j]=scale(ZP[5*j%29],c);ELabel[29*i+j]=scale(ZP[8*j%29],e);}
  c=frob8[c];e=frob8[e];
 }
 for(int i=0;i<116;i++){
  int j=29*((i/29+1)%4)+i%29;
  if(!(sigma(CLabel[i])==CLabel[j])||!(sigma(ELabel[i])==ELabel[j]))throw runtime_error("label Frobenius action");
 }
}
struct Offsets { E eneg2,cpos6,epos2,cneg6; };
static vector<pair<int,int>> parse_nodes(const string&s){
 vector<pair<int,int>> nodes; string part;istringstream in(s);int total=0;
 while(getline(in,part,',')){
  auto p=part.find(':');if(p==string::npos)throw runtime_error("nodes use exponent:weight comma-separated");
  int e=stoi(part.substr(0,p)),w=stoi(part.substr(p+1));
  if(e<0||e>=29||w<1||w>6||w==5)throw runtime_error("invalid weighted node");
  for(auto x:nodes)if(x.first==e)throw runtime_error("duplicate node");
  nodes.emplace_back(e,w);total+=w;
 }
 if(nodes.empty()||total>75)throw runtime_error("invalid common-pole mass");
 return nodes;
}
static Offsets make_offsets(const string &nodes){
 auto w=parse_nodes(nodes);E mn2,m6,m2,mn6;
 for(auto [e,m]:w){mn2=add(mn2,scale(ZP[(58-2*e)%29],m%5));m6=add(m6,scale(ZP[6*e%29],m%5));m2=add(m2,scale(ZP[2*e%29],m%5));mn6=add(mn6,scale(ZP[(174-6*e)%29],m%5));}
 return {scale(mn2,22),scale(m6,22),scale(m2,22),scale(mn6,22)};
}
[[maybe_unused]] static pair<E,E> label_sums(uint32_t code){
 E c,e;for(int x:decode_quartet(code)){c=add(c,CLabel[x]);e=add(e,ELabel[x]);}return {c,e};
}
