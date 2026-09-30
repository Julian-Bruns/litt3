#include "root9_actual_trace_residues_20260930.hpp"
int main(int argc,char**argv){try{
 if(argc!=6)throw std::runtime_error("usage: probe FIELD SOURCE h w vp");
 exact::loadfield(argv[1]);root9trace::load(argv[2]);exact::F h=std::stoi(argv[3]),w=std::stoi(argv[4]);int vp=std::stoi(argv[5]);
 infinitytrace::CAP=200;auto start=std::chrono::steady_clock::now();
 std::vector<std::pair<int,int>> fs{{0,0},{1,0},{2,0},{0,1},{3,0},{4,0},{1,1}};
 auto ps=root9residue::profiles(h,w,fs,vp);auto d=root9trace::data(h,w);
 std::vector<root9trace::Multiplier> ms;for(auto[i,j]:fs)ms.push_back({i,j,vp});int n=0;exact::F sign=0;
 for(exact::F ell=1;n<12&&ell<390625;ell++){
  try{auto vs=root9trace::values(d,ell,ms);for(size_t j=0;j<fs.size();j++){
   auto pred=exact::eval(ps[j],ell);if(!sign&&pred)sign=exact::divide(vs[j],pred);
   if(vs[j]!=exact::mul(sign,pred)){std::cerr<<"mismatch "<<ell<<' '<<j<<' '<<vs[j]<<' '<<pred<<" sign="<<sign<<'\n';throw std::runtime_error("root9 trace mismatch");}
  }n++;}catch(const std::exception&e){if(std::string(e.what())!="bad projection fibre")throw;}
 }
 std::cout<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"vp\":"<<vp<<",\"checks\":"<<n*fs.size()<<",\"sign\":"<<sign<<",\"profiles\":[";
 for(size_t j=0;j<ps.size();j++){if(j)std::cout<<',';exact::jsonpoly(std::cout,ps[j]);}
 std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
