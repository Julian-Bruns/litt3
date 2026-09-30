// New all-partner continuation for a doubled-pair endpoint of phase span three.
// Partners are streamed; no 35-billion-element table is stored.
#include "span2_families.hpp"
#include <chrono>
#include <iostream>
#include <set>
#include <unordered_map>
#include <omp.h>
using namespace span2;
uint32_t kn(const K&x){return hsub(hmul(x.a,x.a),scalar[3][hmul(x.b,x.b)]);}
K bar(const K&x){return K(x.a,negative[x.b]);}
struct Part{K d,w,z1,z2,c1,c2;};
Part contrib(int pos,int p){auto&r=tab[pos][p];return {r[0][2],r[2][2],r[3][0],r[3][1],r[0][0],r[0][1]};}
Part sum(const Part&a,const Part&b){return {a.d+b.d,a.w+b.w,a.z1+b.z1,a.z2+b.z2,a.c1+b.c1,a.c2+b.c2};}
struct Feature{uint32_t na,nb,h0,h1;uint64_t index;};
std::vector<First> loop_firsts(int distinct){
 std::vector<First> out;
 for(int a=0;a<29;a++)for(int b=0;b<29;b++)for(int c=0;c<29;c++){
  std::set<int> phases{0,a,b,c};if((int)phases.size()!=distinct)continue;
  EP ep={{{0,0},{a,a},{b,b},{c,c}}};uint64_t code=epcode(ep);bool good=true;int mult=1;
  for(int k=0;k<7&&good;k++,mult=mult*25%29)for(int r=0;r<4;r++){
   EP t=affine_rotate(ep,mult,0,r);t=affine_rotate(t,1,(29-t[0][0])%29,0);if(epcode(t)<code){good=false;break;}
  }
  if(!good)continue;Rows rr=erows(ep);if(!full(rr))throw std::runtime_error("loop representative lost support");Mat t;for(int i=0;i<3;i++)t[i]={rr[1][i],rr[0][i],rr[2][i]};Mat ti=inverse(t);out.push_back({ep,rr,ti[0][0],ti[0][1],0,0});
 }
 if(out.size()!=size_t(distinct==4?702:162))throw std::runtime_error("wrong all-loop orbit count");return out;
}
int main(int argc,char**argv){try{
 if(argc!=3&&argc!=4){std::cerr<<"usage: all_loop_partners START END [DISTINCT_PHASES]\n";return 2;}
 int distinct=argc==4?std::stoi(argv[3]):4;if(distinct!=3&&distinct!=4)throw std::runtime_error("distinct phases must be3 or4");
 uint64_t start=std::stoull(argv[1]),end=std::stoull(argv[2]),block=2000000,total=15ULL*435*435*435;
 if(start>=end||end>total)throw std::runtime_error("bad stream interval");auto began=std::chrono::steady_clock::now();setup();auto fs=loop_firsts(distinct);
 std::vector<Part> left,right;for(int d=0;d<15;d++)for(int q=0;q<435;q++)left.push_back(sum(contrib(0,pairidx(0,d)),contrib(1,q)));
 for(int r=0;r<435;r++)for(int s=0;s<435;s++)right.push_back(sum(contrib(2,r),contrib(3,s)));
 std::unordered_map<uint64_t,int> shifts;for(int s=0;s<29;s++)shifts[xp[8*s%29].code()]=s;
 uint64_t fullpartners=0,processed=0,normhits=0,rowhits=0,rankhits=0;
 for(uint64_t begin=start;begin<end;begin+=block){uint64_t stop=std::min(end,begin+block);std::vector<Feature> points(stop-begin);uint64_t valid=0;
  #pragma omp parallel for schedule(static) reduction(+:valid)
  for(uint64_t ix=begin;ix<stop;ix++){
   Part p=sum(left[ix/(435*435)],right[ix%(435*435)]);auto&f=points[ix-begin];f.na=UINT32_MAX;
   if(p.c1.zero()||p.c2.zero()||p.d.zero())continue;if(p.w.zero())throw std::runtime_error("full partner zero third U");
   K rat=-p.d/p.w,A=rat*p.z1,B=rat*p.z2,hh=A*bar(B);f={kn(A),kn(B),hh.a,hh.b,ix};valid++;
  }
  fullpartners+=valid;uint64_t nh=0,rh=0,rk=0;
  #pragma omp parallel for schedule(dynamic,1) reduction(+:nh,rh,rk)
  for(size_t i=0;i<fs.size();i++){
   auto&f=fs[i];uint32_t na=kn(f.a),nb=kn(f.b);K g=f.a*bar(f.b);uint32_t g0=scalar[2][g.a],g1=g.b;
   for(auto&p:points){if(p.na==UINT32_MAX)continue;
    uint32_t A=hmul(na,p.na),B=hadd(hmul(g0,p.h0),hmul(g1,p.h1)),C=hsub(hmul(nb,p.nb),1),plus=hadd(A,C),minus=hsub(A,C),twob=scalar[2][B];
    bool pass[4]={plus==negative[B],minus==negative[twob],plus==B,minus==twob};if(!(pass[0]||pass[1]||pass[2]||pass[3]))continue;
    auto pp=sum(left[p.index/(435*435)],right[p.index%(435*435)]);K rat=-pp.d/pp.w,u=f.a*(rat*pp.z1),v=f.b*(rat*pp.z2);
    for(int r=0;r<4;r++)if(pass[r]){nh++;int t=pmod(2,r);K kap=K(t)*u+K(t*t%5)*v;auto sh=shifts.find(kap.code());if(sh==shifts.end())continue;rh++;
     uint64_t ix=p.index;int s=ix%435;ix/=435;int rr=ix%435;ix/=435;int q=ix%435;int d=ix/435;EP ep={pairs[pairidx(0,d)],pairs[q],pairs[rr],pairs[s]};ep=affine_rotate(ep,1,sh->second,r);
     Rows er=erows(ep);if(!full(er))throw std::runtime_error("reconstructed support mismatch");bool yes=rank3(f.r,er);rk+=yes;
     #pragma omp critical
     {std::cout<<"{\"type\":\"row_hit\",\"first\":"<<i<<",\"partner_base\":"<<p.index<<",\"rotation\":"<<r<<",\"shift\":"<<sh->second<<",\"rank_three\":"<<(yes?"true":"false")<<"}\n";}
    }
   }
  }
  processed+=valid*fs.size();normhits+=nh;rowhits+=rh;rankhits+=rk;
  std::cout<<"{\"type\":\"checkpoint\",\"start\":"<<start<<",\"end_completed\":"<<stop<<",\"end_target\":"<<end<<",\"total_partner_bases\":"<<total<<",\"first_representatives\":"<<fs.size()<<",\"full_partners\":"<<fullpartners<<",\"processed\":"<<processed<<",\"norm_hits\":"<<normhits<<",\"row_hits\":"<<rowhits<<",\"rank_three\":"<<rankhits<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-began).count()<<"}\n";std::cout.flush();
 }
 std::cout<<"{\"status\":\"complete_interval\",\"start\":"<<start<<",\"end\":"<<end<<",\"full_partners\":"<<fullpartners<<",\"processed\":"<<processed<<",\"row_hits\":"<<rowhits<<",\"rank_three\":"<<rankhits<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
