#include "algebra.hpp"
#include <limits>

// Portable certificate format: see CERTIFICATE_FORMAT.md.
static constexpr uint32_t FULL=(1u<<29)-1;
static constexpr uint64_t FIELD_SIZE=6103515625ULL;
static constexpr char MAGIC[8]={'R','R','2','9','C','0','0','1'};
struct Stats {
 uint64_t layouts=0,cases=0,covered=0,power_exclusions=0,open_exclusions=0,degree_exclusions=0;
 array<uint64_t,68> reasons{}; K fingerprint=K(1);
};
uint64_t choose(int n,int k){if(k<0||k>n)return 0;k=min(k,n-k);uint64_t v=1;for(int j=1;j<=k;j++)v=v*(n-k+j)/j;return v;}
uint64_t orbit_count(int d){uint64_t fix=0;for(auto hp:array<pair<int,int>,3>{{{2,1},{7,6},{14,6}}})for(int e=0;e<=1;e++)if((d-e)%hp.first==0)fix+=hp.second*choose(28/hp.first,(d-e)/hp.first);return (choose(29,d)+29*fix)/406;}
void put32(ostream&o,uint32_t v){for(int i=0;i<4;i++)o.put(char((v>>(8*i))&255));if(!o)throw runtime_error("write failed");}
void put64(ostream&o,uint64_t v){for(int i=0;i<8;i++)o.put(char((v>>(8*i))&255));if(!o)throw runtime_error("write failed");}
uint32_t get32(istream&i){uint32_t v=0;for(int j=0;j<4;j++){int c=i.get();if(c==EOF)throw runtime_error("truncated certificate");v|=uint32_t(c)<<(8*j);}return v;}
uint64_t get64(istream&i){uint64_t v=0;for(int j=0;j<8;j++){int c=i.get();if(c==EOF)throw runtime_error("truncated certificate");v|=uint64_t(c)<<(8*j);}return v;}
vector<int> indices(uint32_t mask){vector<int>I;for(int j=0;j<29;j++)if(mask&(1u<<j))I.push_back(j);return I;}

// Coverage verification uses direct affine images, independently of necklace generation.
uint64_t check_orbit(uint32_t mask,int d){
 if(mask>FULL||int(indices(mask).size())!=d)throw runtime_error("invalid pole mask");
 int h=1,stabilizer=0;
 for(int t=0;t<14;t++){
  uint32_t x=0;for(int j=0;j<29;j++)if(mask&(1u<<j))x|=1u<<((h*j)%29);
  for(int b=0;b<29;b++){
   if(x<mask)throw runtime_error("pole mask is not the canonical affine representative");
   if(x==mask)stabilizer++;
   x=((x<<1)&FULL)|(x>>28);
  }
  h=h*5%29;
 }
 if(!stabilizer||406%stabilizer)throw runtime_error("invalid stabilizer");
 return 406/stabilizer;
}

// Generator only. Verification reads the recorded masks and checks their total coverage.
static uint32_t PERM[14][5][64];
uint32_t minrot(uint32_t x){uint32_t z=x;for(int j=1;j<29;j++){x=((x<<1)&FULL)|(x>>28);if(x<z)z=x;}return z;}
void initperm(){int h=1;for(int t=0;t<14;t++){for(int b=0;b<5;b++)for(int x=0;x<64;x++){uint32_t v=0;for(int j=0;j<6;j++)if((x&(1<<j))&&6*b+j<29)v|=1u<<((h*(6*b+j))%29);PERM[t][b][x]=v;}h=h*5%29;}}
bool canonical_fast(uint32_t mask){for(int t=1;t<14;t++){uint32_t y=0;for(int b=0;b<5;b++)y|=PERM[t][b][(mask>>(6*b))&63];if(minrot(y)<mask)return false;}return true;}
vector<uint32_t> representatives(int d){
 int a[30]={};vector<uint32_t> out;
 function<void(int,int,int)> rec=[&](int t,int p,int w){
  if(w>d||w+(30-t)<d)return;
  if(t>29){if(29%p==0&&w==d){uint32_t mask=0;for(int i=1;i<=29;i++)mask=(mask<<1)|a[i];if(canonical_fast(mask))out.push_back(mask);}return;}
  a[t]=a[t-p];rec(t+1,p,w+a[t]);if(a[t-p]==0){a[t]=1;rec(t+1,t,w+1);}
 };
 rec(1,1,0);sort(out.begin(),out.end());
 if(adjacent_find(out.begin(),out.end())!=out.end()||out.size()!=orbit_count(d))throw runtime_error("enumerator count failure");
 return out;
}
K value(const array<K,2>&b,const array<K,4>&v,int offset){return b[0]*v[offset]+b[1]*v[offset+1];}
array<K,4> phase_kernel(const vector<int>&I,const EvalSpaces&E,int b,int c){
 array<array<K,4>,3>M;
 const int phases[3]={1,MUC[b],MUC[c]};
 for(int j=0;j<3;j++){
  K factor=ROOT[4*I[j]%29].scale(phases[j]);
  M[j]={-factor*E.first[j][0],-factor*E.first[j][1],E.second[j][0],E.second[j][1]};
 }
 auto v=cof(M);
 if(all_of(v.begin(),v.end(),[](const K&x){return x.zero();}))throw runtime_error("a three-row comparison matrix has rank below three");
 return v;
}
int find_reason(const vector<int>&I,const EvalSpaces&E,const array<K,4>&v){
 for(size_t j=0;j<I.size();j++){
  K x=value(E.first[j],v,0),y=value(E.second[j],v,2);
  if(x.zero()||y.zero())return 32+j;
  if(j>=3&&y.pow(8)!=ROOT[3*I[j]%29]*x.pow(8))return j;
 }
 const K extra[4]={value(E.lead1,v,0),value(E.lead2,v,2),value(E.constant1,v,0),value(E.constant2,v,2)};
 for(int j=0;j<4;j++)if(extra[j].zero())return 64+j;
 throw runtime_error("a residue-compatible projective line survives: no emptiness certificate produced");
}
K check_reason(int r,const vector<int>&I,const EvalSpaces&E,const array<K,4>&v,Stats&S){
 K rank_witness;for(auto x:v)if(!x.zero()){rank_witness=x;break;}
 K factor=rank_witness;
 if(r>=0&&r<int(I.size())){
  K x=value(E.first[r],v,0),y=value(E.second[r],v,2),H=y.pow(8)-ROOT[3*I[r]%29]*x.pow(8);
  if(H.zero())throw runtime_error("recorded power obstruction is zero");factor=factor*H;S.power_exclusions++;
 }else if(r>=32&&r<32+int(I.size())){
  int j=r-32;if(!value(E.first[j],v,0).zero()&&!value(E.second[j],v,2).zero())throw runtime_error("recorded open-condition failure is false");S.open_exclusions++;
 }else if(r>=64&&r<=67){
  const K extra[4]={value(E.lead1,v,0),value(E.lead2,v,2),value(E.constant1,v,0),value(E.constant2,v,2)};
  if(!extra[r-64].zero())throw runtime_error("recorded leading/constant-coefficient failure is false");S.degree_exclusions++;
 }else throw runtime_error("invalid reason byte");
 if(factor.zero())throw runtime_error("zero witness factor");S.cases++;S.reasons[r]++;return factor;
}
void summary(int d,const string&mode,const string&basis,const Stats&S,double sec){
 cout<<"{\"status\":\"PASS\",\"mode\":\""<<mode<<"\",\"basis\":\""<<basis<<"\",\"n\":"<<d+3<<",\"d\":"<<d<<",\"layouts\":"<<S.layouts<<",\"phase_cases\":"<<S.cases<<",\"covered_subsets\":"<<S.covered<<",\"power_exclusions\":"<<S.power_exclusions<<",\"open_exclusions\":"<<S.open_exclusions<<",\"degree_exclusions\":"<<S.degree_exclusions<<",\"fingerprint\":"<<S.fingerprint.code()<<",\"reason_counts\":{";
 bool first=true;for(int i=0;i<68;i++)if(S.reasons[i]){if(!first)cout<<",";first=false;cout<<"\""<<i<<"\":"<<S.reasons[i];}
 cout<<"},\"seconds\":"<<setprecision(10)<<sec<<"}"<<endl;
}
void finish_checks(int d,const Stats&S){if(S.layouts!=orbit_count(d)||S.covered!=choose(29,d)||S.cases!=64*S.layouts||S.power_exclusions+S.open_exclusions+S.degree_exclusions!=S.cases)throw runtime_error("coverage or case-count mismatch");}
int main(int argc,char**argv){
 try{
  if(argc<4){cerr<<"Usage: certificate generate D FILE | certificate verify D FILE [polynomial|fractions]\nD=n-3, so 4<=D<=23.\n";return 2;}
  string mode=argv[1],file=argv[3],basis=(argc>4?argv[4]:"fractions");int d=stoi(argv[2]);
  if(d<4||d>23)throw runtime_error("degree outside certified range");
  if(mode!="generate"&&mode!="verify")throw runtime_error("invalid mode");
  if(basis!="polynomial"&&basis!="fractions")throw runtime_error("invalid basis");
  init();initperm();if(mode=="verify"&&basis=="fractions")init_cauchy();
  auto start=chrono::steady_clock::now();Stats S;uint32_t previous=0;
  if(mode=="generate"){
   basis="polynomial";auto masks=representatives(d);ofstream o(file,ios::binary);if(!o)throw runtime_error("cannot open output certificate");o.write(MAGIC,8);put32(o,d);put32(o,masks.size());
   for(uint32_t mask:masks){
    if(mask<=previous)throw runtime_error("unordered/duplicate mask");previous=mask;S.covered+=check_orbit(mask,d);auto I=indices(mask);auto E=polynomial_spaces(I);array<uint8_t,64>w{};K product(1);
    for(int b=0;b<8;b++)for(int c=0;c<8;c++){auto v=phase_kernel(I,E,b,c);int r=find_reason(I,E,v);w[8*b+c]=r;product=product*check_reason(r,I,E,v,S);}
    put32(o,mask);for(auto r:w)o.put(char(r));put64(o,product.code());S.fingerprint=S.fingerprint*product;S.layouts++;
    if(S.layouts%10000==0)cerr<<"generated d="<<d<<" layouts="<<S.layouts<<"\n";
   }
   finish_checks(d,S);o.close();if(!o)throw runtime_error("certificate close failed");
  }else{
   ifstream in(file,ios::binary);if(!in)throw runtime_error("cannot open certificate");char magic[8];in.read(magic,8);if(in.gcount()!=8||memcmp(magic,MAGIC,8))throw runtime_error("bad certificate magic");
   uint32_t fd=get32(in),count=get32(in);if(fd!=uint32_t(d)||count!=orbit_count(d))throw runtime_error("bad certificate header");
   for(uint32_t j=0;j<count;j++){
    uint32_t mask=get32(in);if(mask<=previous)throw runtime_error("unordered/duplicate mask");previous=mask;S.covered+=check_orbit(mask,d);array<uint8_t,64>w{};
    for(auto&r:w){int c=in.get();if(c==EOF)throw runtime_error("truncated reasons");r=c;}uint64_t claimed=get64(in);if(!claimed||claimed>=FIELD_SIZE)throw runtime_error("invalid polynomial-basis fingerprint");
    auto I=indices(mask);auto E=(basis=="polynomial"?polynomial_spaces(I):fraction_spaces(I));K product(1);
    for(int b=0;b<8;b++)for(int c=0;c<8;c++){auto v=phase_kernel(I,E,b,c);product=product*check_reason(w[8*b+c],I,E,v,S);}
    if(basis=="polynomial"&&product.code()!=claimed)throw runtime_error("polynomial-basis fingerprint mismatch");S.fingerprint=S.fingerprint*product;S.layouts++;
    if(S.layouts%10000==0)cerr<<"verified d="<<d<<" layouts="<<S.layouts<<" basis="<<basis<<"\n";
   }
   if(in.get()!=EOF)throw runtime_error("trailing certificate bytes");finish_checks(d,S);
  }
  summary(d,mode,basis,S,chrono::duration<double>(chrono::steady_clock::now()-start).count());return 0;
 }catch(const exception&e){cerr<<"FAIL: "<<e.what()<<endl;return 1;}
}
