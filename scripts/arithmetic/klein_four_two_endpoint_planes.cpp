// Complete finite endpoint-plane collision test. Not a search for curves.
// Usage: executable data.dat [distinct|all] [exception-output.tsv]
#define KLEIN_FOUR_MINIMUM_WORD_NO_MAIN
#include "klein_four_minimum_word_endpoints.cpp"
#include <cstring>
#include <chrono>
#include <set>

using M4=std::array<F7,4>;
using Vec=std::array<F7,3>;
std::array<int,5> AP;
int inv25[25];
F7 plus7(F7 a,const F7&b){for(int i=0;i<7;i++)a[i]=add25[a[i]][b[i]];return a;}
F7 minus7(F7 a,const F7&b){for(int i=0;i<7;i++)a[i]=add25[a[i]][neg25[b[i]]];return a;}
F7 scalar7(F7 a,int b){for(int&i:a)i=mul25[i][b];return a;}
bool nz(const F7&a){for(int v:a)if(v)return true;return false;}
F7 inverse7(const F7&a){
 if(!nz(a))throw std::runtime_error("inverse of zero");
 std::array<int,8> r0=D,r1{};std::copy(a.begin(),a.end(),r1.begin());
 F7 s0{},s1{};s1[0]=1;
 auto deg=[](const std::array<int,8>&r){for(int j=7;j>=0;j--)if(r[j])return j;return -1;};
 while(deg(r1)>0){
  auto r2=r0;F7 q{};int d1=deg(r1),i1=inv25[r1[d1]];
  while(deg(r2)>=d1){int d=deg(r2)-d1,c=mul25[r2[deg(r2)]][i1];q[d]=add25[q[d]][c];
   for(int j=0;j<=d1;j++)r2[d+j]=add25[r2[d+j]][neg25[mul25[c][r1[j]]]];
  }
  F7 s2=minus7(s0,mul(q,s1));r0=r1;r1=r2;s0=s1;s1=s2;
 }
 if(deg(r1)<0)throw std::runtime_error("not a field");
 return scalar7(s1,inv25[r1[0]]);
}
M4 plus4(M4 a,const M4&b){for(int i=0;i<4;i++)a[i]=plus7(a[i],b[i]);return a;}
M4 minus4(M4 a,const M4&b){for(int i=0;i<4;i++)a[i]=minus7(a[i],b[i]);return a;}
M4 scalar4(M4 a,int b){for(auto&v:a)v=scalar7(v,b);return a;}
M4 times4(const M4&a,const M4&b){
 std::array<F7,7> p{};
 for(int i=0;i<4;i++)if(nz(a[i]))for(int j=0;j<4;j++)if(nz(b[j]))p[i+j]=plus7(p[i+j],mul(a[i],b[j]));
 for(int i=6;i>=4;i--)if(nz(p[i]))for(int j=0;j<4;j++)p[i-4+j]=minus7(p[i-4+j],scalar7(p[i],AP[j]));
 M4 c;std::copy(p.begin(),p.begin()+4,c.begin());return c;
}
bool nz4(const M4&a){for(const auto&v:a)if(nz(v))return true;return false;}
Vec cross(const Vec&a,const Vec&b){return {minus7(mul(a[1],b[2]),mul(a[2],b[1])),minus7(mul(a[2],b[0]),mul(a[0],b[2])),minus7(mul(a[0],b[1]),mul(a[1],b[0]))};}
bool nz3(const Vec&a){for(auto&v:a)if(nz(v))return true;return false;}
struct Row{
 // Full normalized plane normal and unnormalized first-ratio direction.
 std::array<uint8_t,21> key,dir;
 std::array<uint8_t,4> tags,phases;
 uint8_t character;
 bool operator<(const Row&o)const{return key<o.key;}
};
Vec unpack(const std::array<uint8_t,21>&a){Vec r;for(int i=0;i<3;i++)for(int j=0;j<7;j++)r[i][j]=a[7*i+j];return r;}
void pack(const Vec&a,std::array<uint8_t,21>&r){for(int i=0;i<3;i++)for(int j=0;j<7;j++)r[7*i+j]=a[i][j];}
void descriptor(std::ostream&o,const Row&r){for(auto x:r.tags)o<<int(x)<<',';o<<'\t';for(auto x:r.phases)o<<int(x)<<',';o<<'\t'<<int(r.character);}
#ifndef KLEIN_FOUR_TWO_ENDPOINT_NO_MAIN
int main(int argc,char**argv){try{
 if(argc<3)throw std::runtime_error("data.dat distinct|all [exceptions.tsv]");
 init();for(int i=1;i<25;i++)for(int j=1;j<25;j++)if(mul25[i][j]==1)inv25[i]=j;
 std::ifstream f(argv[1]);for(auto&x:AP)f>>x;for(auto&x:D)f>>x;
 std::array<std::array<K,7>,4> coeff;for(auto&r:coeff)for(auto&a:r)for(auto&v:a)f>>v;
 if(!f)throw std::runtime_error("bad data");
 std::array<F7,29> zp{};zp[0][0]=1;F7 zz{};zz[1]=1;for(int i=1;i<29;i++)zp[i]=mul(zp[i-1],zz);
 if(mul(zp[28],zz)!=zp[0])throw std::runtime_error("bad zeta");
 for(int k=1;k<29;k++){F7 a=plus7(zp[k],zp[(3*k)%29]);if(nz(a)&&mul(a,inverse7(a))!=zp[0])throw std::runtime_error("inverse check");}
 std::array<std::array<std::array<M4,7>,29>,4> labels;
 for(int root=0;root<4;root++)for(int p=0;p<29;p++)for(int c=0;c<7;c++){
  int exponent=c==0?0:(c==5?4*p:(c==6?5*p:p));
  for(int a=0;a<4;a++)labels[root][p][c][a]=scalar7(zp[exponent%29],coeff[root][c][a]);
 }
 int signs[3][4]={{1,1,4,4},{1,4,1,4},{1,4,4,1}};
 std::vector<std::array<int,4>> cases;
 if(std::string(argv[2])=="distinct")cases.push_back({0,1,2,3});
 else if(std::string(argv[2])=="all")for(int a=0;a<4;a++)for(int b=a;b<4;b++)for(int c=b;c<4;c++)for(int d=c;d<4;d++)cases.push_back({a,b,c,d});
 else throw std::runtime_error("unknown mode");
 std::vector<Row> rows;rows.reserve(cases.size()*73167);
 std::ofstream samples;if(argc>4)samples.open(argv[4]);
 std::set<std::array<int,28>> affine_targets;
 if(argc>5){std::ifstream at(argv[5]);int n;at>>n;for(int i=0;i<n;i++){std::array<int,28>a;for(int&v:a)at>>v;affine_targets.insert(a);}if(!at)throw std::runtime_error("bad affine targets");}
 uint64_t tested=0,bzero=0,affine=0,kept=0;
 uint64_t affine_nonrational=0,affine_checked=0;
 for(const auto&tags:cases){uint64_t oldkept=kept,oldaffine=affine;
 for(int pa=0;pa<29;pa++)for(int pb=0;pb<29;pb++)for(int pc=0;pc<29;pc++){
  std::array<int,4> phases{0,pa,pb,pc};
  for(int ch=0;ch<3;ch++){
   tested++;std::array<M4,7> sums{};
   for(int i=0;i<4;i++)for(int c=0;c<7;c++)sums[c]=plus4(sums[c],scalar4(labels[tags[i]][phases[i]][c],signs[ch][i]));
   if(!nz4(sums[1])){
    bzero++;std::vector<int>positive,negative;
    for(int i=0;i<4;i++)(signs[ch][i]==1?positive:negative).push_back(29*tags[i]+phases[i]);
    std::sort(positive.begin(),positive.end());std::sort(negative.begin(),negative.end());
    if(positive!=negative)throw std::runtime_error("unpaired zero leading labels");
    continue;
   }
   M4 h=times4(times4(sums[2],sums[3]),sums[4]);
   M4 ar=times4(sums[0],h);
   M4 br=minus4(times4(sums[5],sums[1]),times4(sums[0],sums[6]));
   M4 as=times4(br,times4(h,h));
   Vec r{ar[1],ar[2],ar[3]},s{as[1],as[2],as[3]},normal=cross(r,s);
   if(!nz3(normal)){
    affine++;
    if(nz3(r)){
     affine_nonrational++;
     if(!affine_targets.empty()){
      M4 norm=times4(sums[1],h);if(nz(norm[1])||nz(norm[2])||nz(norm[3]))throw std::runtime_error("norm not in M");
      F7 invn=inverse7(norm[0]),invn2=mul(invn,invn);int pivot=1;while(!nz(ar[pivot]))pivot++;
      F7 factor=mul(inverse7(ar[pivot]),invn);
      F7 lambda=mul(as[pivot],factor),nu=mul(minus7(as[0],mul(mul(lambda,norm[0]),ar[0])),invn2);
      M4 ar2=times4(ar,ar);F7 trace=mul(ar2[pivot],factor),constant=mul(minus7(ar2[0],mul(mul(trace,norm[0]),ar[0])),invn2);
      for(int i=1;i<4;i++)if(as[i]!=mul(mul(lambda,norm[0]),ar[i])||ar2[i]!=mul(mul(trace,norm[0]),ar[i]))throw std::runtime_error("missing higher-degree affine target");
      std::array<int,28>key{};int pos=0;for(const auto&v:{lambda,nu,trace,constant})for(int x:v)key[pos++]=x;
      if(!affine_targets.count(key))throw std::runtime_error("unlisted affine target");
      affine_checked++;
     }
    }
    continue;
   }
   int pivot=0;while(!nz(normal[pivot]))pivot++;
   F7 ni=inverse7(normal[pivot]);for(auto&v:normal)v=mul(v,ni);
   Row out{};pack(normal,out.key);pack(r,out.dir);
   for(int i=0;i<4;i++){out.tags[i]=tags[i];out.phases[i]=phases[i];}out.character=ch;
   if(samples&&((pa==0&&pb==1&&pc==2)||(pa==7&&pb==19&&pc==23)||(pa==0&&pb==0&&pc==0))){
    descriptor(samples,out);samples<<'\t';for(int x:out.key)samples<<x<<',';samples<<'\t';for(int x:out.dir)samples<<x<<',';samples<<'\n';
   }
   rows.push_back(out);kept++;
  }
 }
 std::cout<<"CASE tags=";for(int a:tags)std::cout<<a<<',';std::cout<<" nonaffine="<<kept-oldkept<<" affine="<<affine-oldaffine<<std::endl;
 }
 std::sort(rows.begin(),rows.end());
 std::ofstream exceptions;if(argc>3)exceptions.open(argv[3]);
 uint64_t groups=0,multi=0,badgroups=0,badrows=0,maxsize=0;
 for(size_t i=0;i<rows.size();){size_t j=i+1;while(j<rows.size()&&rows[j].key==rows[i].key)j++;
  groups++;multi+=j>i+1;maxsize=std::max<uint64_t>(maxsize,j-i);bool bad=false;Vec r0=unpack(rows[i].dir);
  for(size_t k=i+1;k<j;k++)if(nz3(cross(r0,unpack(rows[k].dir)))){
   if(!bad&&exceptions){exceptions<<"PLANE\t";for(int v:rows[i].key)exceptions<<v<<',';exceptions<<'\n';descriptor(exceptions,rows[i]);exceptions<<'\n';}
   bad=true;badrows++;if(exceptions){descriptor(exceptions,rows[k]);exceptions<<'\n';}
  }
  if(bad)badgroups++;i=j;
 }
 std::cout<<"TOTAL root_cases="<<cases.size()<<" tested="<<tested<<" Bzero="<<bzero<<" paired_zero_labels="<<bzero<<" affine="<<affine<<" affine_nonrational="<<affine_nonrational<<" affine_checked="<<affine_checked<<" nonaffine="<<kept<<" planes="<<groups<<" repeated_planes="<<multi<<" max_multiplicity="<<maxsize<<" ambiguous_planes="<<badgroups<<" different_direction_rows="<<badrows<<std::endl;
 return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
#endif
