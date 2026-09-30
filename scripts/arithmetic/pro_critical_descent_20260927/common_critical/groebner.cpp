// Exact Buchberger engine with the Gebauer--Moeller pair installation.
// Coefficients use the problem's K-codes, not integers modulo five.
#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <map>
#include <set>
#include <string>
#include <sstream>
#include <tuple>
#include <vector>
using namespace std;
static const int NN=390625, MM=390624;
static vector<int32_t> EX(2*MM), LG(NN);
static int AD[625][625], NE[625];
inline int add(int a,int b){return AD[a%625][b%625]+625*AD[a/625][b/625];}
inline int neg(int a){return NE[a%625]+625*NE[a/625];}
inline int sub(int a,int b){return add(a,neg(b));}
inline int mul(int a,int b){return a&&b?EX[LG[a]+LG[b]]:0;}
inline int inv(int a){if(!a)abort();return EX[MM-LG[a]];}
static int NV=3;static array<int,6> WG={1,1,1,1,1,1};
using Mon=uint64_t;
int exponent(Mon a,int i){return (a>>(8*i))&255;}
int degree(Mon a){int d=0;for(int i=0;i<NV;i++)d+=WG[i]*exponent(a,i);return d;}
struct Order{bool operator()(Mon a,Mon b)const{int da=degree(a),db=degree(b);return da!=db?da>db:a<b;}};
bool dvd(Mon a,Mon b){for(int i=0;i<NV;i++)if(exponent(a,i)>exponent(b,i))return false;return true;}
Mon lcm(Mon a,Mon b){Mon c=0;for(int i=0;i<NV;i++)c|=Mon(max(exponent(a,i),exponent(b,i)))<<(8*i);return c;}
bool coprime(Mon a,Mon b){for(int i=0;i<NV;i++)if(exponent(a,i)&&exponent(b,i))return false;return true;}
// Every monomial product is range-checked before using packed exponents.
Mon mprod(Mon a,Mon b){
 for(int i=0;i<NV;i++)if(exponent(a,i)+exponent(b,i)>255){
  cerr<<"MONOMIAL_EXPONENT_OVERFLOW\n";abort();
 }
 return a+b;
}
struct Poly{vector<pair<Mon,int>> t;Mon lm()const{return t[0].first;}};
using Work=map<Mon,int,Order>;
void inc(Work& a,Mon m,int c){if(!c)return;auto p=a.find(m);if(p==a.end())a[m]=c;else{int v=add(p->second,c);if(v)p->second=v;else a.erase(p);}}
vector<Poly> F;set<int> G;
int nfreductions=0;long long canceled=0;
struct Step{int reducer;Mon shift;int coefficient;};
struct Derivation{int type,first,second,scale;vector<Step> steps;};
static bool proof_enabled=false;
static vector<Step> nf_steps;
static int nf_scale=1;
static vector<Derivation> provenance;
static string proof_path;
static int original_count;

Poly nf(Work f,const set<int>&gg,bool make_monic=true){
 if(proof_enabled){nf_steps.clear();nf_scale=1;}
 vector<int> reducers(gg.begin(),gg.end());
 sort(reducers.begin(),reducers.end(),[](int a,int b){return Order()(F[b].lm(),F[a].lm());});
 Poly rem;
 while(!f.empty()){
  auto it=f.begin();Mon m=it->first;int c=it->second;int j=-1;
  for(int k:reducers)if(dvd(F[k].lm(),m)){j=k;break;}
  if(j<0){rem.t.emplace_back(m,c);f.erase(it);}
  else{
   Mon shift=m-F[j].lm();int cc=neg(c);f.erase(it);
   if(proof_enabled)nf_steps.push_back({j,shift,c});
   for(size_t k=1;k<F[j].t.size();k++)inc(f,mprod(F[j].t[k].first,shift),mul(cc,F[j].t[k].second));
   canceled++;
  }
 }
 if(make_monic&&!rem.t.empty()){int c=inv(rem.t[0].second);if(proof_enabled)nf_scale=c;for(auto &u:rem.t)u.second=mul(u.second,c);}
 nfreductions++;return rem;
}
struct Pair{int a,b;Mon l;};
struct POrder{bool operator()(Pair a,Pair b)const{
 if(a.l!=b.l)return Order()(b.l,a.l);
 return tie(a.a,a.b)<tie(b.a,b.b);
}};
set<Pair,POrder> B;
void update(int ih){
 Mon mh=F[ih].lm();set<int>C=G,D;
 while(!C.empty()){
  int ig=*C.begin();C.erase(C.begin());Mon ml=lcm(mh,F[ig].lm());bool ok=true;
  if(!coprime(mh,F[ig].lm())){
   for(int z:C)if(dvd(lcm(mh,F[z].lm()),ml)){ok=false;break;}
   if(ok)for(int z:D)if(dvd(lcm(mh,F[z].lm()),ml)){ok=false;break;}
  }
  if(ok)D.insert(ig);
 }
 vector<Pair> E;
 for(int ig:D)if(!coprime(mh,F[ig].lm()))E.push_back({min(ih,ig),max(ih,ig),lcm(mh,F[ig].lm())});
 for(auto it=B.begin();it!=B.end();){
  Mon ml=it->l;
  if(dvd(mh,ml)&&lcm(mh,F[it->a].lm())!=ml&&lcm(mh,F[it->b].lm())!=ml)it=B.erase(it);else ++it;
 }
 for(auto p:E)B.insert(p);
 for(auto it=G.begin();it!=G.end();)if(dvd(mh,F[*it].lm()))it=G.erase(it);else ++it;
 G.insert(ih);
}
void writeproof(){
 if(!proof_enabled)return;
 vector<bool> needed(F.size(),false);
 for(int i:G)needed[i]=true;
 for(int i=(int)F.size()-1;i>=0;i--)if(needed[i]){
  const auto&d=provenance[i];
  if(d.type==1){needed[d.first]=true;needed[d.second]=true;}
  for(const auto&s:d.steps)needed[s.reducer]=true;
 }
 vector<int> ids(F.size(),-1);int n=0;for(int i=0;i<(int)F.size();i++)if(needed[i])ids[i]=n++;
 ofstream o(proof_path);o<<NV<<" "<<original_count<<" "<<n<<" "<<G.size()<<"\n";
 long long total=0;
 for(int i=0;i<(int)F.size();i++)if(needed[i]){
  const auto&d=provenance[i];int a=d.type==0?d.first:ids[d.first];int b=d.type==0?-1:ids[d.second];
  o<<d.type<<" "<<a<<" "<<b<<" "<<d.scale<<" "<<d.steps.size()<<"\n";
  for(const auto&s:d.steps){o<<ids[s.reducer]<<" "<<s.coefficient;for(int j=0;j<NV;j++)o<<" "<<exponent(s.shift,j);o<<"\n";}total+=d.steps.size();
 }
 for(int i:G)o<<ids[i]<<" ";o<<"\n";
 cerr<<"PROVENANCE retained="<<n<<" reductions="<<total<<endl;
}
void writegb(const string &name){
 ofstream o(name);o<<NV<<" "<<G.size()<<"\n";
 for(int j:G){o<<F[j].t.size()<<"\n";for(auto [m,c]:F[j].t){o<<c;for(int i=0;i<NV;i++)o<<" "<<exponent(m,i);o<<"\n";}}
}
int main(int argc,char**argv){
 if(argc<4){cerr<<"usage gb field.bin input.txt output.txt [max_seconds] [weights_csv]\n";return 2;}
 ifstream fl(argv[1],ios::binary);fl.read((char*)EX.data(),EX.size()*4);fl.read((char*)LG.data(),LG.size()*4);if(!fl)return 3;
 for(int a=0;a<625;a++){NE[a]=0;for(int p=1;p<625;p*=5)NE[a]+=((5-a/p%5)%5)*p;for(int b=0;b<625;b++){int c=0;for(int p=1;p<625;p*=5)c+=((a/p%5+b/p%5)%5)*p;AD[a][b]=c;}}
 ifstream inp(argv[2]);int ngen;inp>>NV>>ngen;if(NV>6)return 4;
 original_count=ngen;
 if(argc>=7){proof_enabled=true;proof_path=argv[6];}
 if(argc>=6){string ss=argv[5];replace(ss.begin(),ss.end(),',',' ');istringstream s(ss);for(int i=0;i<NV;i++)s>>WG[i];}
 auto start=chrono::steady_clock::now();double maxsec=argc>=5?stod(argv[4]):120;
 auto seconds=[&](){return chrono::duration<double>(chrono::steady_clock::now()-start).count();};
 for(int k=0;k<ngen;k++){
  int n;inp>>n;Work w;
  for(int j=0;j<n;j++){int c;inp>>c;Mon m=0;for(int i=0;i<NV;i++){int e;inp>>e;if(e>255)return 5;m|=Mon(e)<<(8*i);}inc(w,m,c);}
  Poly f=nf(w,G);if(!f.t.empty()){int i=F.size();if(proof_enabled)provenance.push_back({0,k,-1,nf_scale,std::move(nf_steps)});F.push_back(move(f));update(i);}
 }
 int npair=0;double last=0;
 while(!B.empty()){
  Pair p=*B.begin();B.erase(B.begin());Work w;
  Mon a=p.l-F[p.a].lm(),b=p.l-F[p.b].lm();
  for(auto [m,c]:F[p.a].t)inc(w,mprod(m,a),c);
  for(auto [m,c]:F[p.b].t)inc(w,mprod(m,b),neg(c));
  Poly h=nf(w,G);npair++;
  if(!h.t.empty()){
   int i=F.size();if(proof_enabled)provenance.push_back({1,p.a,p.b,nf_scale,std::move(nf_steps)});F.push_back(move(h));update(i);
   if(seconds()-last>2){
    cerr<<"sec="<<seconds()<<" pair="<<npair<<" all="<<F.size()<<" active="<<G.size()<<" pending="<<B.size()<<" deg="<<degree(F[i].lm())<<" terms="<<F[i].t.size()<<" lm=";
    for(int j=0;j<NV;j++)cerr<<exponent(F[i].lm(),j)<<",";cerr<<" cancels="<<canceled<<endl;last=seconds();
   }
   if(F[i].lm()==0){cerr<<"UNIT_IDEAL\n";B.clear();}
  }
  if(seconds()>maxsec){cerr<<"TIME_BOUND_INCOMPLETE sec="<<seconds()<<" pending="<<B.size()<<endl;writegb(argv[3]);return 10;}
 }
 cerr<<"COMPLETE sec="<<seconds()<<" processed="<<npair<<" active="<<G.size()<<" all="<<F.size()<<" reductions="<<nfreductions<<" cancels="<<canceled<<endl;
 writegb(argv[3]);writeproof();return 0;
}
