// Exact bounded-degree membership in a polynomial module over F25.
// Input nr nz nw D, followed by each relation's number of terms and terms
// (module_component, field_code, monomial_degree, variable_indices...).
// Tests membership of all constant module basis vectors. No point search.
#include <algorithm>
#include <bit>
#include <chrono>
#include <cstdint>
#include <iostream>
#include <numeric>
#include <unordered_map>
#include <vector>
using namespace std;
uint8_t ad[25][25],su[25][25],mu[25][25],iv[25];
void field(){for(int a=0;a<25;a++)for(int b=0;b<25;b++){
 ad[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
 su[a][b]=(a%5-b%5+5)%5+5*((a/5-b/5+5)%5);
 mu[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
}for(int a=1;a<25;a++)for(int b=1;b<25;b++)if(mu[a][b]==1)iv[a]=b;}
struct Mon{uint64_t code;int deg;};
void gen(int n,int d,int i,uint64_t code,vector<Mon>&v,int orig){
 if(i==n-1){v.push_back({code+(uint64_t(d)<<(3*i)),orig});return;}
 for(int e=0;e<=d;e++)gen(n,d-e,i+1,code+(uint64_t(e)<<(3*i)),v,orig);
}
struct Term{int z;uint8_t c;uint64_t mon;};
struct Rel{int deg;vector<Term>ts;};
struct Instance{int degree;uint64_t mon;int row;};
int main(){
 field();int nr,nz,nw,D;cin>>nr>>nz>>nw>>D;
 if(!cin||nw>21||D>7||D<0){cerr<<"Unsupported dimensions\n";return 2;}
 vector<Rel>rel(nr);
 for(auto&r:rel){int nt;cin>>nt;r.deg=0;for(int t=0;t<nt;t++){
  int z,c,d;cin>>z>>c>>d;uint64_t mon=0;for(int k=0;k<d;k++){int w;cin>>w;mon+=uint64_t(1)<<(3*w);}r.deg=max(r.deg,d);r.ts.push_back({z,uint8_t(c),mon});
 }}
 if(!cin)return 2;
 vector<Mon>mons;for(int d=D;d>=0;d--)gen(nw,d,0,0,mons,d);
 sort(mons.begin(),mons.end(),[](auto&a,auto&b){return a.deg>b.deg||(a.deg==b.deg&&a.code<b.code);});
 unordered_map<uint64_t,int>ix;ix.reserve(2*mons.size());for(int i=0;i<int(mons.size());i++)ix[mons[i].code]=i;
 int nc=mons.size()*nz,nb=(nc+63)/64;
 if(nc>10000000){cerr<<"column guard exceeded\n";return 3;}
 vector<Instance>instances;
 for(int r=0;r<nr;r++)for(auto&m:mons)if(m.deg+rel[r].deg<=D)instances.push_back({m.deg+rel[r].deg,m.code,r});
 sort(instances.begin(),instances.end(),[](auto&a,auto&b){if(a.degree!=b.degree)return a.degree>b.degree;if(a.mon!=b.mon)return a.mon<b.mon;return a.row<b.row;});
 vector<vector<uint32_t>>base(nc);vector<uint8_t>work(nc);vector<uint64_t>bits(nb);
 int rk=0;long long ops=0,entries=0;auto start=chrono::steady_clock::now();
 auto reduce=[&](bool store){
  int bl=0;
  while(true){
   while(bl<nb&&!bits[bl])bl++;if(bl==nb)return -1;
   int p=bl*64+countr_zero(bits[bl]);
   if(base[p].empty()){
    if(!store)return p;
    uint8_t c=iv[work[p]];auto&v=base[p];
    for(int b=bl;b<nb;b++){
     uint64_t mask=bits[b];while(mask){int k=64*b+countr_zero(mask);mask&=mask-1;v.push_back((uint32_t(k)<<5)|mu[c][work[k]]);work[k]=0;}bits[b]=0;
    }
    v.shrink_to_fit();entries+=v.size();rk++;return p;
   }
   auto c=work[p];ops+=base[p].size();
   for(auto e:base[p]){int k=e>>5;int a=e&31;auto old=work[k],val=su[old][mu[c][a]];work[k]=val;if((old==0)!=(val==0))bits[k/64]^=uint64_t(1)<<(k%64);}
  }
 };
 cerr<<"degree "<<D<<" rows "<<instances.size()<<" columns "<<nc<<"\n";
 for(int n=0;n<int(instances.size());n++){
  auto &in=instances[n];
  for(auto&t:rel[in.row].ts){auto it=ix.find(in.mon+t.mon);if(it==ix.end()){cerr<<"index error\n";return 2;}int k=it->second*nz+t.z;auto old=work[k],val=ad[old][t.c];work[k]=val;if((old==0)!=(val==0))bits[k/64]^=uint64_t(1)<<(k%64);}
  reduce(true);
  if((n+1)%1000==0){double sec=chrono::duration<double>(chrono::steady_clock::now()-start).count();cerr<<"rows "<<n+1<<" rank "<<rk<<" entries "<<entries<<" ops "<<ops<<" sec "<<sec<<"\n";}
  if(entries>650000000){cerr<<"memory guard exceeded; incomplete check\n";return 3;}
 }
 int proved=0;vector<int>fails;
 for(int z=0;z<nz;z++){
  fill(work.begin(),work.end(),0);fill(bits.begin(),bits.end(),0);int k=ix[0]*nz+z;work[k]=1;bits[k/64]|=uint64_t(1)<<(k%64);if(reduce(false)==-1)proved++;else fails.push_back(z);
 }
 double sec=chrono::duration<double>(chrono::steady_clock::now()-start).count();
 cout<<"{\"degree\":"<<D<<",\"rows\":"<<instances.size()<<",\"columns\":"<<nc<<",\"rank\":"<<rk<<",\"targets_proved\":"<<proved<<",\"targets_total\":"<<nz<<",\"stored_entries\":"<<entries<<",\"field_ops\":"<<ops<<",\"seconds\":"<<sec<<",\"failed\":[";for(int i=0;i<int(fails.size());i++)cout<<(i?",":"")<<fails[i];cout<<"]}\n";
}
