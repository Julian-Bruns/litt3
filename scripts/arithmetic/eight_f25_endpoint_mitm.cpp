// Complete eight-label endpoint membership for all24 F25 scalars.
// Split each sorted eight-tuple into its first and last four labels.
// An F5-linear projection is a necessary filter only; all candidate sums
// are checked in the full E8/K0 coordinates. No hash assumption is made.
#define main inherited_quintic_main
#include "pro_mixed_quintic_20260927/src/mixed_phase_check.cpp"
#undef main
#include <algorithm>
#include <fstream>
#include <vector>
using HashVec=array<uint8_t,14>;
struct Entry {uint64_t key;uint32_t labels;bool operator<(const Entry&o)const{return key!=o.key?key<o.key:labels<o.labels;}};
uint64_t encode(const HashVec&v){uint64_t n=0;for(int i=13;i>=0;--i)n=5*n+v[i];return n;}
uint64_t negative_key(uint64_t n){uint64_t r=0,p=1;for(int i=0;i<14;++i){int c=n%5;n/=5;r+=(c?5-c:0)*p;p*=5;}return r;}
HashVec plus(const HashVec&a,const HashVec&b){HashVec c;for(int i=0;i<14;++i){int x=a[i]+b[i];c[i]=x>=5?x-5:x;}return c;}
array<int,4> unpack(uint32_t n){array<int,4> a;for(int&i:a){i=n&127;n>>=7;}return a;}
bool full_check(int eps,const array<int,8>&l){
 for(int j=0;j<7;++j){int sum=0;for(int i:l)sum=add8(sum,add8(mul8(eps,u_table[i][j]),v_table[i][j]));if(sum>=25)return false;}return true;
}
int main(int argc,char**argv){
 assert(argc==2||argc==3);initialize_fields();initialize_signatures();std::ofstream out(argv[1],std::ios::binary);assert(out);
 int proj[14][42];uint32_t seed=argc==3?0x4138bcf2:0x7983e591;
 for(auto&r:proj)for(int&x:r){seed=1664525U*seed+1013904223U;x=seed%5;}
 uint64_t total=0;
 for(int eps=1;eps<25;++eps){
  HashVec labels[116];for(int l=0;l<116;++l){int raw[42],k=0;
   for(int j=0;j<7;++j){int v=add8(mul8(eps,u_table[l][j]),v_table[l][j]);v/=25;
    for(int r=1;r<4;++r){int c=v%25;v/=25;raw[k++]=c%5;raw[k++]=c/5;}}
   assert(k==42);bool nonzero=false;for(int v:raw)nonzero=nonzero||v;assert(nonzero);
   for(int i=0;i<14;++i){int v=0;for(int j=0;j<42;++j)v+=proj[i][j]*raw[j];labels[l][i]=v%5;}
  }
  std::vector<Entry> list;list.reserve(8000000);
  for(int a=0;a<116;++a)for(int b=a;b<116;++b){auto x=plus(labels[a],labels[b]);
   for(int c=b;c<116;++c){auto y=plus(x,labels[c]);for(int d=c;d<116;++d)
    list.push_back({encode(plus(y,labels[d])),uint32_t(a+(b<<7)+(c<<14)+(d<<21))});}}
  assert(list.size()==7940751);std::sort(list.begin(),list.end());
  uint64_t hashes=0,accepted=0;
  for(size_t i=0;i<list.size();){size_t j=i+1;while(j<list.size()&&list[j].key==list[i].key)++j;
   uint64_t target=negative_key(list[i].key);
   auto lo=std::lower_bound(list.begin(),list.end(),Entry{target,0});
   auto hi=std::upper_bound(list.begin(),list.end(),Entry{target,UINT32_MAX});
   for(size_t a=i;a<j;++a){auto left=unpack(list[a].labels);if(left[0]%4)continue;
    for(auto it=lo;it!=hi;++it){auto right=unpack(it->labels);if(left[3]>right[0])continue;++hashes;
     array<int,8> l;for(int k=0;k<4;++k){l[k]=left[k];l[4+k]=right[k];}
     if(!full_check(eps,l))continue;++accepted;out.put(char(eps));for(int v:l)out.put(char(v));}}
   i=j;
  }
  total+=accepted;std::cout<<"SCALAR "<<eps<<" quartets "<<list.size()<<" projected_pairs "<<hashes<<" accepted "<<accepted<<" total "<<total<<std::endl;
 }
 std::cout<<"COMPLETE total "<<total<<std::endl;
}
