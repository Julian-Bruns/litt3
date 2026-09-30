// New complete repeated-pair sectors, using the accepted incoming exact field.
// Compile with -I.../september29_evening_replies/rank3/src and OpenMP.
// Arguments: first-start first-end partner-mode(0 adjacent,1 opposite,2 both).
#include "span2_families.hpp"
#include <chrono>
#include <iostream>
#include <unordered_map>
#include <omp.h>
using namespace fastk;
using namespace span2;
uint32_t knorm(const K&x){return hsub(hmul(x.a,x.a),scalar[3][hmul(x.b,x.b)]);}
K kbar(const K&x){return K(x.a,negative[x.b]);}
struct Feature {uint32_t nA,nB,h0,h1;uint16_t q,r;uint8_t d,opposite;};
struct Hit {int first,d,q,r,opposite,rotation,translation;EP L,M;bool rank3;};
std::array<std::array<K,3>,435> ev;
void print_ep(const EP&p){std::cout<<'[';for(int i=0;i<4;i++){if(i)std::cout<<',';std::cout<<'['<<p[i][0]<<','<<p[i][1]<<']';}std::cout<<']';}
EP canonical_frobenius(const EP& ep,int mult){
 EP q=affine_rotate(ep,mult,0,0);
 int a=q[0][0],b=q[0][1],diff=(b-a+29)%29;
 int shift=diff<=14?(29-a)%29:(29-b)%29;
 return affine_rotate(q,1,shift,0);
}
std::vector<First> repeated_firsts(uint64_t& total){
 std::array<uint32_t,435> mask;for(int p=0;p<435;p++)mask[p]=(1u<<pairs[p][0])|(1u<<pairs[p][1]);
 std::vector<First> out;total=0;
 for(int d=0;d<15;d++){
  int p=pairidx(0,d);
  for(int q=0;q<435;q++)if(q!=p)for(int r=0;r<435;r++)if(r!=p&&r!=q){
   if(__builtin_popcount(mask[p]|mask[q]|mask[r])<=2)continue;
   total++;EP ep={pairs[p],pairs[p],pairs[q],pairs[r]};
   uint64_t code=epcode(ep);bool minimal=true;int mult=25;
   for(int k=1;k<7;k++,mult=mult*25%29)if(epcode(canonical_frobenius(ep,mult))<code){minimal=false;break;}
   if(!minimal)continue;
   Rows rr=erows(ep);Mat T;for(int l=0;l<3;l++)T[l]={rr[1][l],rr[0][l],rr[2][l]};
   Mat ti=inverse(T);out.push_back({ep,rr,ti[0][0],ti[0][1],d,0});
  }
 }
 if(total!=2818746||out.size()!=402678)throw std::runtime_error("unexpected free seven-orbit count");
 return out;
}
std::pair<K,K> abpoint(int d,int q,int r,bool opposite){
 int p=pairidx(0,d);K d3,w3,z1,z2;
 if(!opposite){
  d3=K(2)*(K(4)*ev[p][0]+K(4)*ev[q][0]+K(2)*ev[r][0]);
  w3=K(11)*(K(4)*ev[p][1]+K(4)*ev[q][1]+K(2)*ev[r][1]);
  z1=K(21)*(K(3)*ev[p][2]+K(4)*ev[q][2]+K(3)*ev[r][2]);
  z2=K(11)*(ev[q][2]-ev[r][2]);
 }else{
  d3=K(2)*(K(3)*ev[q][0]+K(2)*ev[r][0]);
  w3=K(11)*(K(3)*ev[q][1]+K(2)*ev[r][1]);
  z1=K(21)*(K(2)*ev[q][2]+K(3)*ev[r][2]);
  z2=K(11)*(K(2)*ev[p][2]-ev[q][2]-ev[r][2]);
 }
 if(d3.zero()||w3.zero()||z1.zero()||z2.zero())throw std::runtime_error("lost full support");
 K f=-d3/w3;return {f*z1,f*z2};
}
std::vector<Feature> features(int mode){
 std::array<uint32_t,435> mask;for(int p=0;p<435;p++)mask[p]=(1u<<pairs[p][0])|(1u<<pairs[p][1]);
 std::vector<Feature> out;out.reserve(mode==2?4228119:(mode?1409373:2818746));
 for(int o=0;o<2;o++){if(mode!=2&&o!=mode)continue;
 for(int d=0;d<15;d++){
  int p=pairidx(0,d);
  for(int q=0;q<435;q++)if(q!=p)for(int r=0;r<435;r++)if(r!=p&&r!=q&&(!o||q<r)){
   if(__builtin_popcount(mask[p]|mask[q]|mask[r])<=2)continue;
   auto [A,B]=abpoint(d,q,r,o);K h=A*kbar(B);
   out.push_back({knorm(A),knorm(B),h.a,h.b,uint16_t(q),uint16_t(r),uint8_t(d),uint8_t(o)});
  }
 }}
 size_t want=mode==2?4228119:(mode?1409373:2818746);
 if(out.size()!=want)throw std::runtime_error("wrong partner count");return out;
}
int main(int argc,char**argv){try{
 if(argc!=4){std::cerr<<"usage: repeated START END MODE\n";return 2;}
 int start=std::stoi(argv[1]),end=std::stoi(argv[2]),mode=std::stoi(argv[3]);
 if(mode<0||mode>2)throw std::runtime_error("bad mode");
 auto began=std::chrono::steady_clock::now();setup();
 int nn[3]={5,17,4};for(int p=0;p<435;p++)for(int i=0;i<3;i++)ev[p][i]=xp[nn[i]*pairs[p][0]%29]+xp[nn[i]*pairs[p][1]%29];
 uint64_t bases=0;auto first=repeated_firsts(bases);
 if(start<0||end>int(first.size())||start>=end)throw std::runtime_error("invalid interval");
 auto points=features(mode);std::unordered_map<uint64_t,int> translations;
 for(int s=0;s<29;s++)translations.emplace(xp[8*s%29].code(),s);
 auto setup_end=std::chrono::steady_clock::now();
 uint64_t processed=0,normhits=0,rowhits=0,r3hits=0,zeroa=0,zerob=0;std::vector<Hit> hits;
 #pragma omp parallel
 {
  uint64_t pc=0,nc=0,hc=0,rc=0,za=0,zb=0;std::vector<Hit> local;
  #pragma omp for schedule(dynamic,1)
  for(int i=start;i<end;i++){
   const First&f=first[i];za+=f.a.zero();zb+=f.b.zero();
   uint32_t na=knorm(f.a),nb=knorm(f.b);K g=f.a*kbar(f.b);
   uint32_t g0=scalar[2][g.a],g1=g.b;
   for(const auto&p:points){pc++;
    uint32_t A=hmul(na,p.nA),B=hadd(hmul(g0,p.h0),hmul(g1,p.h1)),C=hsub(hmul(nb,p.nB),1);
    uint32_t plus=hadd(A,C),minus=hsub(A,C),twob=scalar[2][B];
    bool pass[4]={plus==negative[B],minus==negative[twob],plus==B,minus==twob};
    if(!(pass[0]||pass[1]||pass[2]||pass[3]))continue;
    auto [a,b]=abpoint(p.d,p.q,p.r,p.opposite);K u=f.a*a,v=f.b*b;
    for(int rot=0;rot<4;rot++)if(pass[rot]){
     nc++;int t=pmod(2,rot);K kappa=K(t)*u+K(t*t%5)*v;
     auto it=translations.find(kappa.code());if(it==translations.end())continue;
     hc++;int shift=it->second,pi=pairidx(0,p.d);
     EP base=p.opposite?EP{pairs[pi],pairs[p.q],pairs[pi],pairs[p.r]}:EP{pairs[pi],pairs[pi],pairs[p.q],pairs[p.r]};
     EP m=affine_rotate(base,1,shift,rot);Rows mr=erows(m);
     if(!full(mr)||!(mr[0][2]*(f.a*mr[3][0]+f.b*mr[3][1])+mr[2][2]).zero())throw std::runtime_error("incorrect reconstructed row incidence");
     bool r3=rank3(f.r,mr);rc+=r3;local.push_back({i,p.d,p.q,p.r,p.opposite,rot,shift,f.ep,m,r3});
    }
   }
  }
  #pragma omp critical
  {processed+=pc;normhits+=nc;rowhits+=hc;r3hits+=rc;zeroa+=za;zerob+=zb;hits.insert(hits.end(),local.begin(),local.end());}
 }
 std::sort(hits.begin(),hits.end(),[](const Hit&a,const Hit&b){return std::tie(a.first,a.opposite,a.d,a.q,a.r,a.rotation,a.translation)<std::tie(b.first,b.opposite,b.d,b.q,b.r,b.rotation,b.translation);});
 std::cout<<"{\"status\":\"complete_interval\",\"start\":"<<start<<",\"end\":"<<end<<",\"partner_mode\":"<<mode<<",\"first_representatives\":"<<first.size()<<",\"first_bases\":"<<bases<<",\"partner_bases\":"<<points.size()<<",\"processed_base_pairs\":"<<processed<<",\"norm_hits\":"<<normhits<<",\"row_hits\":"<<rowhits<<",\"rank_three\":"<<r3hits<<",\"zero_a\":"<<zeroa<<",\"zero_b\":"<<zerob<<",\"hits\":[";
 bool comma=false;for(const auto&h:hits){if(comma)std::cout<<',';comma=true;std::cout<<"{\"first_index\":"<<h.first<<",\"d\":"<<h.d<<",\"q_index\":"<<h.q<<",\"r_index\":"<<h.r<<",\"opposite\":"<<h.opposite<<",\"rotation\":"<<h.rotation<<",\"translation\":"<<h.translation<<",\"L\":";print_ep(h.L);std::cout<<",\"M\":";print_ep(h.M);std::cout<<",\"rank_three\":"<<(h.rank3?"true":"false")<<'}';}
 std::cout<<"],\"setup_seconds\":"<<std::chrono::duration<double>(setup_end-began).count()<<",\"scan_seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-setup_end).count()<<",\"threads\":"<<omp_get_max_threads()<<",\"compiler\":\""<<__VERSION__<<"\"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
