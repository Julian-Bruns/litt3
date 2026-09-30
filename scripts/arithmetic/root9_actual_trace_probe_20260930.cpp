#include "root9_actual_trace_engine_20260930.hpp"
int main(int argc,char**argv){try{
 if(argc!=5)throw std::runtime_error("usage: probe FIELD SOURCE h w");
 exact::loadfield(argv[1]);root9trace::load(argv[2]);exact::F h=std::stoi(argv[3]),w=std::stoi(argv[4]);
 auto start=std::chrono::steady_clock::now();auto d=root9trace::data(h,w);
 std::vector<root9trace::Multiplier> ms{{0,0,0},{0,0,1},{0,0,2},{1,0,2},{2,0,2},{0,1,2},{3,0,2},{4,0,2},{1,1,2}};
 std::vector<exact::F> xs;std::vector<std::vector<exact::F>> ys(ms.size());
 for(exact::F ell=1;xs.size()<18&&ell<390625;ell++){
  try{auto vs=root9trace::values(d,ell,ms);xs.push_back(ell);for(size_t j=0;j<ms.size();j++)ys[j].push_back(vs[j]);}
  catch(const std::exception&e){if(std::string(e.what())!="bad projection fibre")throw;}
 }
 std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"fibre_count\":"<<xs.size()<<",\"profiles\":[";
 for(size_t i=0;i<ms.size();i++){auto p=criticaltrace::interpolate(xs,ys[i]);if(i)std::cout<<',';std::cout<<"{\"multiplier\":["<<ms[i].x<<','<<ms[i].y<<','<<ms[i].v<<"],\"degree\":"<<p.deg()<<",\"coefficients\":";exact::jsonpoly(std::cout,p);std::cout<<'}';}
 std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
