// Newton-polygon bounds for projecting bivariate equations in H.
// At infinity the valuation inequality gives an upper degree bound.
// At a finite chart root it gives a guaranteed factor multiplicity.
#include "degree140_trace_engine_20260929.hpp"
#include <fstream>
#include <array>
#include <limits>
using namespace exact;
using I=long long;
struct Pt {I x,y;};
I cross(Pt a,Pt b,Pt c){return (b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x);}
std::vector<Pt> hull(const std::vector<int>&v,bool upper){
 std::vector<Pt>h;for(int i=0;i<int(v.size());i++)if(v[i]>=0){Pt p{I(i),I(v[i])};
  while(h.size()>1&&(upper?cross(h[h.size()-2],h.back(),p)>=0:cross(h[h.size()-2],h.back(),p)<=0))h.pop_back();h.push_back(p);
 }return h;
}
I bound(const std::vector<int>&a,const std::vector<int>&b,bool upper){
 if(a.empty()||b.empty()||a.back()<0||b.back()<0)throw std::runtime_error("missing leading coefficient");
 auto h=hull(a,upper);I out=I(b.size()-1)*a.back();
 if(h.front().x!=0)throw std::runtime_error("remove the common H monomial first");
 for(size_t k=1;k<h.size();k++){
  I dx=h[k].x-h[k-1].x,dy=h[k].y-h[k-1].y,best=upper?std::numeric_limits<I>::min():std::numeric_limits<I>::max();
  for(int j=0;j<int(b.size());j++)if(b[j]>=0){I v=dx*b[j]-j*dy;best=upper?std::max(best,v):std::min(best,v);}out+=best;
 }return out;
}
int valuation(Poly p,F root){
 if(p.empty())return -1;int n=0;
 while(p.deg()>0){Poly q(p.deg());F c=p.back();q.back()=c;for(int i=p.deg()-1;i>=1;i--){c=add(p[i],mul(root,c));q[i-1]=c;}if(add(p[0],mul(root,c)))break;p=std::move(q);p.trim();n++;}return n;
}
void ints(std::ostream&o,const std::vector<int>&v){o<<'[';for(size_t i=0;i<v.size();i++){if(i)o<<',';o<<v[i];}o<<']';}
int main(int argc,char**argv){try{
 if(argc<4)throw std::runtime_error("usage: newton FIELD POLYNOMIAL_TEXT OUTPUT_JSON [native chart roots]...");
 loadfield(argv[1]);std::ifstream in(argv[2]);int count;in>>count;std::vector<std::vector<Poly>>p(count);
 std::vector<F>cv(390625);for(int i=1;i<390625;i++)cv[i]=add(i%5,mul(25,cv[i/5]));
 for(auto&r:p){int dh,dq,nt;in>>dh>>dq>>nt;r.resize(dh+1);for(auto&c:r)c.resize(dq+1);for(int i=0;i<nt;i++){int h,q,code;in>>h>>q>>code;r.at(h).at(q)=cv.at(code);}for(auto&c:r)c.trim();}
 if(!in)throw std::runtime_error("incomplete input");
 std::vector<std::vector<std::vector<int>>>vv;
 std::vector<std::vector<int>>degrees(count);for(int i=0;i<count;i++)for(auto&c:p[i])degrees[i].push_back(c.deg());
 for(int k=4;k<argc;k++){F root=std::stoi(argv[k]);std::vector<std::vector<int>>v(count);for(int i=0;i<count;i++)for(auto&c:p[i])v[i].push_back(valuation(c,root));vv.push_back(v);}
 std::ofstream out(argv[3]);out<<"{\"scope\":\"global degree bounds and guaranteed chart factors, not a locus decision\",\"coefficient_degrees\":[";
 for(int i=0;i<count;i++){if(i)out<<',';ints(out,degrees[i]);}out<<"],\"valuations\":[";
 for(size_t k=0;k<vv.size();k++){if(k)out<<',';out<<"{\"root\":"<<argv[k+4]<<",\"coefficient_valuations\":[";for(int i=0;i<count;i++){if(i)out<<',';ints(out,vv[k][i]);}out<<"]}";}out<<"],\"pairs\":[";
 bool first=true;for(int j=1;j<count;j++){
  if(!first)out<<',';first=false;I hi=bound(degrees[0],degrees[j],true),hi2=bound(degrees[j],degrees[0],true);if(hi!=hi2)throw std::runtime_error("asymmetric degree bound");
  I sum=0;std::vector<I>vs;for(auto&v:vv){I lo=bound(v[0],v[j],false),lo2=bound(v[j],v[0],false);if(lo!=lo2)throw std::runtime_error("asymmetric valuation bound");if(lo<0)throw std::runtime_error("negative resultant valuation");vs.push_back(lo);sum+=lo;}
  out<<"{\"pair\":[0,"<<j<<"],\"degree_bound\":"<<hi<<",\"chart_factor_powers\":[";for(size_t k=0;k<vs.size();k++){if(k)out<<',';out<<vs[k];}out<<"],\"quotient_degree_bound\":"<<hi-sum<<'}';
  std::cerr<<"pair 0,"<<j<<" degree "<<hi<<" removed lower bound "<<sum<<" quotient "<<hi-sum<<" powers";for(I v:vs)std::cerr<<' '<<v;std::cerr<<'\n';
 }out<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
