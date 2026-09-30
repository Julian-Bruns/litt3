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
static E scalar(uint32_t a){E r;r.a[0]=a;return r;}
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
struct Rec {E v;uint32_t label;};
struct Work {E a,b;uint32_t label;};
static uint32_t code4(int i,int j,int k,int l){return i|(j<<7)|(k<<14)|(l<<21);}
static void print_code(uint32_t c){cout<<'['<<(c&127)<<','<<((c>>7)&127)<<','<<((c>>14)&127)<<','<<((c>>21)&127)<<']';}
int main(int argc,char** argv){
 try {
  string profile="one2",out="";uint64_t limit=7940751, first=0;bool writekeys=false;
  for(int i=1;i<argc;i++){
   string a=argv[i];if(a=="--profile"&&i+1<argc)profile=argv[++i];
   else if(a=="--output"&&i+1<argc)out=argv[++i];
   else if(a=="--limit"&&i+1<argc)limit=stoull(argv[++i]);
   else if(a=="--start"&&i+1<argc)first=stoull(argv[++i]);
   else if(a=="--write-keys")writekeys=true;
   else throw runtime_error("Usage: --profile one2|two1|two2 --output file.json [--start N --limit N] [--write-keys]");
  }
  if(profile!="one2"&&profile!="two1"&&profile!="two2")throw runtime_error("unknown profile");
  auto start=chrono::steady_clock::now();initialize();cout<<"PASS finite-field construction and arithmetic checks\n";
  E z;z.a[1]=1;array<E,29> zp;zp[0]=one();for(int i=1;i<29;i++)zp[i]=mul(zp[i-1],z);
  E mn2,m6,kappa;int d=profile=="two2"?2:1;
  if(profile=="one2"){mn2=scalar(2);m6=scalar(2);kappa=one();}
  else {mn2=add(one(),zp[(29-2*d)%29]);m6=add(one(),zp[(6*d)%29]);kappa=zp[(58-8*d)%29];}
  E offsetE=scale(mn2,22),offsetC=scale(m6,22);
  uint32_t canonical_c=22+25*7+625*9+15625*23;
  uint32_t canonical_e=1+25*3+625*8+15625*15;
  array<E,116> cl,el;
  for(int i=0;i<4;i++){
   for(int j=0;j<29;j++){cl[29*i+j]=scale(zp[(5*j)%29],canonical_c);el[29*i+j]=scale(zp[(8*j)%29],canonical_e);}
   canonical_c=pow8(canonical_c,25);canonical_e=pow8(canonical_e,25);
  }
  static E cp[116][116], ep[116][116];
  for(int i=0;i<116;i++)for(int j=i;j<116;j++){cp[i][j]=add(cl[i],cl[j]);ep[i][j]=add(el[i],el[j]);}
  vector<Rec> lhs,rhs;lhs.reserve(min<uint64_t>(limit,7940751));rhs.reserve(min<uint64_t>(limit,7940751));
  vector<Work> batch;batch.reserve(32768);vector<E> prefix;prefix.reserve(32768);
  vector<uint32_t> zeroa,zerob,zeroboth;
  uint64_t count=0,batchcount=0, ordinal=0;
  auto flush=[&](){
   if(batch.empty())return;
   prefix.resize(batch.size());vector<E> denom(batch.size());E product=one();
   for(size_t i=0;i<batch.size();i++){prefix[i]=product;denom[i]=mul(batch[i].a,batch[i].b);product=mul(product,denom[i]);}
   E carry=inverse(product);
   for(size_t ii=batch.size();ii>0;--ii){size_t i=ii-1;auto &w=batch[i];E inv=mul(prefix[i],carry);carry=mul(carry,denom[i]);
    E ratio=mul(square(w.a),inv), rev=mul(square(w.b),inv);if(profile!="one2")rev=mul(kappa,rev);
    lhs.push_back({ratio,w.label});rhs.push_back({rev,w.label});
   }
   if(!(carry==one()))throw runtime_error("batch inverse chain");
   batch.clear();++batchcount;
   if(batchcount%16==0){double s=chrono::duration<double>(chrono::steady_clock::now()-start).count();cout<<"PROGRESS "<<profile<<" endpoints="<<count<<" seconds="<<s<<endl;}
  };
  for(int i=0;i<116;i++)for(int j=i;j<116;j++)for(int k=j;k<116;k++)for(int l=k;l<116;l++){
   if(ordinal++<first)continue;
   if(count>=limit)goto generated;
   Work w{sub(add(ep[i][j],ep[k][l]),offsetE),sub(add(cp[i][j],cp[k][l]),offsetC),code4(i,j,k,l)};
   ++count;
   if(w.a.zero()&&w.b.zero())zeroboth.push_back(w.label);
   else if(w.a.zero())zeroa.push_back(w.label);
   else if(w.b.zero())zerob.push_back(w.label);
   else batch.push_back(w);
   if(batch.size()==32768)flush();
  }
 generated:flush();
  cout<<"GENERATED "<<count<<" zero_a="<<zeroa.size()<<" zero_b="<<zerob.size()<<" zero_both="<<zeroboth.size()<<endl;
  auto less=[](const Rec& a,const Rec& b){return a.v.a<b.v.a;};sort(lhs.begin(),lhs.end(),less);sort(rhs.begin(),rhs.end(),less);
  uint64_t hits=0;vector<pair<uint32_t,uint32_t>> firsthits;
  size_t i=0,j=0;while(i<lhs.size()&&j<rhs.size()){
   if(lhs[i].v.a<rhs[j].v.a){i++;continue;}if(rhs[j].v.a<lhs[i].v.a){j++;continue;}
   size_t ii=i+1,jj=j+1;while(ii<lhs.size()&&lhs[ii].v==lhs[i].v)ii++;while(jj<rhs.size()&&rhs[jj].v==rhs[j].v)jj++;
   hits+=uint64_t(ii-i)*(jj-j);if(firsthits.size()<20)firsthits.emplace_back(lhs[i].label,rhs[j].label);i=ii;j=jj;
  }
  double seconds=chrono::duration<double>(chrono::steady_clock::now()-start).count();
  cout<<"RESULT "<<profile<<" count="<<count<<" nonzero_ratio_hits="<<hits<<" zero_a="<<zeroa.size()<<" zero_b="<<zerob.size()<<" zero_both="<<zeroboth.size()<<" seconds="<<seconds<<endl;
  for(auto h:firsthits){cout<<"HIT ";print_code(h.first);cout<<" ";print_code(h.second);cout<<'\n';}
  if(out.empty())return 0;
  ofstream f(out);if(!f)throw runtime_error("cannot open output");
  f<<"{\n  \"profile\": \""<<profile<<"\",\n  \"scope\": \"endpoint moment equations only; not a geometric curve search\",\n  \"range_start\": "<<first<<",\n  \"quartets_checked\": "<<count<<",\n  \"quartets_total\": 7940751,\n  \"exhaustive\": "<<((first==0&&count==7940751)?"true":"false")<<",\n  \"nonzero_ratio_hits\": "<<hits<<",\n  \"zero_a_count\": "<<zeroa.size()<<",\n  \"zero_b_count\": "<<zerob.size()<<",\n  \"zero_both_count\": "<<zeroboth.size()<<",\n  \"first_hit_codes\": [";
  for(size_t k=0;k<firsthits.size();k++){if(k)f<<',';f<<'['<<firsthits[k].first<<','<<firsthits[k].second<<']';}f<<"],\n  \"elapsed_seconds\": "<<seconds<<"\n}\n";
  if(writekeys){for(int k=0;k<2;k++){ofstream b(out+(k?".right.keys":".left.keys"),ios::binary);auto& v=k?rhs:lhs;for(auto& r:v){b.write(reinterpret_cast<const char*>(r.v.a.data()),7*sizeof(uint32_t));b.write(reinterpret_cast<const char*>(&r.label),sizeof(uint32_t));}}}
 }catch(const exception&e){cerr<<"ERROR: "<<e.what()<<endl;return 1;}
 return 0;
}
