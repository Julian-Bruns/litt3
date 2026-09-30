// Seven-label extension: match ALL retained endpoints with the SAME X,Y.
// This is a coefficient-only check until the actual-map bridge is established.
// Field arithmetic is the previously audited native implementation.
// A fixed F5-linear projection is a rejection filter; every possible match
// is then checked in all98 F25 coordinates of the four trace equations.
#define main inherited_quintic_main
#include "pro_mixed_quintic_20260927/src/mixed_phase_check.cpp"
#undef main
#include <algorithm>
#include <fstream>
#include <tuple>
#include <vector>

using Seven=array<int,7>;
using Syn=array<uint8_t,98>;
struct Endpoint{
 int eps;array<int,7> labels;
 bool operator<(const Endpoint&o)const{return std::tie(eps,labels)<std::tie(o.eps,o.labels);}
 bool operator==(const Endpoint&o)const{return eps==o.eps&&labels==o.labels;}
};
int values[4][116][7],frobB[25],projection[20][196],frobenius_matrix[12][7][7];
bool solve_first=false;

Seven frob(const Seven&v,int exponent){
 Seven r{};
 for(int i=0;i<7;++i){int c=exponent%2?frobB[v[i]]:v[i];
  for(int j=0;j<7;++j)r[j]=add25[r[j]][mul25[c][frobenius_matrix[exponent][i][j]]];
 }return r;
}
void initialize_more(){
 for(int i=0;i<25;++i){frobB[i]=polynomial_pow8(i,5);assert(frobB[i]<25);}
 for(int r=0;r<12;++r){int power=1;for(int k=0;k<r;++k)power=power*5%29;
  for(int i=0;i<7;++i)for(int j=0;j<7;++j)frobenius_matrix[r][i][j]=phase[i*power%29][j];
 }
 const int*fv[4]={c_values,e_values,f0_values,f1_values};const int ex[4]={5,8,17,4};
 for(int f=0;f<4;++f)for(int l=0;l<116;++l)for(int j=0;j<7;++j)values[f][l][j]=mul8(fv[f][l%4],phase[ex[f]*(l/4)%29][j]);
 uint32_t seed=solve_first?0x81285a79:0x61e87c90;
 for(auto&r:projection)for(int&x:r){seed=1664525U*seed+1013904223U;x=seed%5;}
}

Syn syndrome(const Endpoint&e,int side){
 int eps=side?div8(1,e.eps):e.eps;
 int m[4][7]={};for(int l:e.labels)for(int f=0;f<4;++f)for(int j=0;j<7;++j)m[f][j]=add8(m[f][j],values[f][l][j]);
 int ec[4],tail=eps;for(int&c:ec){c=tail%25;tail/=25;}
 int pivot=1;while(!ec[pivot])++pivot;assert(pivot<=3);
 Seven X{},Y{};Syn s{};int cursor=0;
 for(int j=0;j<7;++j){
  int left_family=solve_first?1:0,right_family=solve_first?0:1;
  int w=side?negative8[div8(m[right_family][j],22)]:div8(mul8(eps,m[left_family][j]),22);
  int wc[4],a=w;for(int&c:wc){c=a%25;a/=25;}
  Y[j]=mul25[wc[pivot]][inv25[ec[pivot]]];X[j]=add25[mul25[ec[0]][Y[j]]][neg25[wc[0]]];
  for(int i=1;i<4;++i)if(i!=pivot)s[cursor++]=add25[wc[i]][neg25[mul25[ec[i]][Y[j]]]];
 }
 assert(cursor==14);
 if(solve_first){auto oldX=X;X=frob(Y,7);Y=frob(oldX,7);}
 Seven xb=frob(X,7),yb=frob(Y,7),x4=frob(X,4),y8=frob(Y,8),x11=frob(X,11),y1=frob(Y,1);
 for(int block=0;block<3;++block)for(int j=0;j<7;++j){
  int value=0;
  if(block==0){
   if(!solve_first){value=side?negative8[m[0][j]]:mul8(eps,m[1][j]);value=sub8(value,mul8(22,sub8(mul8(eps,xb[j]),yb[j])));}
   else{value=side?negative8[m[1][j]]:mul8(eps,m[0][j]);value=sub8(value,mul8(22,sub8(mul8(eps,Y[j]),X[j])));}
  }
  if(block==1){value=side?0:add8(mul8(eps,m[2][j]),m[3][j]);value=sub8(value,mul8(22,sub8(mul8(eps,x4[j]),y8[j])));}
  if(block==2){value=side?add8(m[2][j],mul8(eps,m[3][j])):0;value=sub8(value,mul8(22,sub8(x11[j],mul8(eps,y1[j]))));}
  for(int i=0;i<4;++i){s[cursor++]=value%25;value/=25;}
 }
 assert(cursor==98);return s;
}

uint64_t project(const Syn&s,bool negate){
 uint64_t code=0,power=1;
 for(int j=0;j<20;++j){int v=0;for(int i=0;i<98;++i)v+=projection[j][2*i]*(s[i]%5)+projection[j][2*i+1]*(s[i]/5);
  v%=5;if(negate&&v)v=5-v;code+=power*v;power*=5;
 }return code;
}
struct Entry{int eps;uint64_t code;uint32_t index;
 bool operator<(const Entry&o)const{return std::tie(eps,code)<std::tie(o.eps,o.code);}};

int main(int argc,char**argv){
 assert(argc>=3&&argc<=5);solve_first=argc>=4&&std::string(argv[3])=="--solve-first";
 std::ofstream samples;if(argc==5)samples.open(argv[4],std::ios::binary);
 initialize_fields();initialize_more();std::ifstream in(argv[1],std::ios::binary);assert(in);
 std::vector<Endpoint> endpoints;uint64_t source_rows=0;
 for(;;){unsigned char data[11];in.read(reinterpret_cast<char*>(data),11);if(!in.gcount())break;assert(in.gcount()==11);
  int eps=int(data[0])+(int(data[1])<<8)+(int(data[2])<<16)+(int(data[3])<<24);++source_rows;assert(eps>0&&eps<FIELD_ORDER);
  int pow25=1;
  for(int shift=0;shift<4;++shift){Endpoint e;e.eps=exponential8[(int64_t(logarithm8[eps])*pow25)%GROUP_ORDER];pow25*=25;
   for(int i=0;i<7;++i){int l=data[4+i];assert(l<116);e.labels[i]=4*(l/4)+(l%4+shift)%4;}
   std::sort(e.labels.begin(),e.labels.end());endpoints.push_back(e);
  }
 }
 std::sort(endpoints.begin(),endpoints.end());endpoints.erase(std::unique(endpoints.begin(),endpoints.end()),endpoints.end());
 std::cout<<"SOURCE "<<source_rows<<" EXPANDED_DEDUPLICATED "<<endpoints.size()<<" solve_first "<<solve_first<<std::endl;
 std::vector<Entry> left,right;left.reserve(endpoints.size());right.reserve(endpoints.size());
 for(uint32_t i=0;i<endpoints.size();++i){const auto&e=endpoints[i];
  Syn s0=syndrome(e,0),s1=syndrome(e,1);
  left.push_back({e.eps,project(s0,false),i});right.push_back({div8(1,e.eps),project(s1,true),i});
  bool distinct=true;for(int k=1;k<7;++k)if(e.labels[k]/4==e.labels[k-1]/4)distinct=false;
  if(samples&&(i%9973==0||distinct))for(int side=0;side<2;++side){
   for(int k=0;k<4;++k)samples.put(char((e.eps>>(8*k))&255));for(int l:e.labels)samples.put(char(l));
   samples.put(char(side));samples.put(char(solve_first));const auto&s=side?s1:s0;for(auto c:s)samples.put(char(c));
  }
  if(i%100000==0)std::cout<<"SYNDROMES "<<i<<std::endl;
 }
 std::sort(left.begin(),left.end());std::sort(right.begin(),right.end());
 std::ofstream out(argv[2],std::ios::binary);assert(out);size_t i=0,j=0;uint64_t hashes=0,exact=0;
 while(i<left.size()&&j<right.size()){
  if(left[i]<right[j]){++i;continue;}if(right[j]<left[i]){++j;continue;}
  size_t ii=i+1,jj=j+1;while(ii<left.size()&&!(left[ii]<left[i])&&!(left[i]<left[ii]))++ii;
  while(jj<right.size()&&!(right[jj]<right[j])&&!(right[j]<right[jj]))++jj;
  for(size_t p=i;p<ii;++p)for(size_t q=j;q<jj;++q){++hashes;const auto&a=endpoints[left[p].index];const auto&b=endpoints[right[q].index];
   auto sa=syndrome(a,0),sb=syndrome(b,1);bool ok=true;for(int k=0;k<98;++k)if(add25[sa[k]][sb[k]]){ok=false;break;}
   if(ok){++exact;int eps=a.eps;for(int k=0;k<4;++k)out.put(char((eps>>(8*k))&255));for(int l:a.labels)out.put(char(l));for(int l:b.labels)out.put(char(l));
    if(exact<=20){std::cout<<"MATCH "<<eps<<" zero";for(int l:a.labels)std::cout<<' '<<l;std::cout<<" inf";for(int l:b.labels)std::cout<<' '<<l;std::cout<<std::endl;}
   }
  }i=ii;j=jj;
 }
 std::cout<<"COMPLETE source_rows "<<source_rows<<" endpoints "<<endpoints.size()<<" hash_matches "<<hashes<<" exact_matches "<<exact<<std::endl;
}
