// Complete H-fibres above every remaining geometric Z-projection factor.
// Retains all twelve sheets and removes only actual-scale/chart units.
#define main accepted_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main
#include "root9_fast_finite_20260929.hpp"
Poly<FE> at(const std::vector<FP>&p){Poly<FE>r;for(auto&v:p)r.c.push_back(FE(mod_fast(v,FE::modulus)));r.trim();return r;}
std::vector<FP> readcoeff(const std::string&f){ptree t;boost::property_tree::read_json(f,t);std::vector<FP>r;for(auto&[key,p]:t.get_child("coefficients"))r.push_back(frow(p));return r;}
FP readcontent(const std::string&f){ptree t;boost::property_tree::read_json(f,t);return frow(t.get_child("content"));}
Poly<FE> gcdh(Poly<FE>a,Poly<FE>b){return std::get<0>(xgcd(a,b));}
int main(int argc,char**argv){try{
 if(argc!=3&&argc!=7)throw std::runtime_error("usage original_J.json directory [row-prefix index1 index2 output-tag]");F::init();FastK::init();std::string dir=argv[2],prefix=argc==7?argv[3]:"gap_content",one=argc==7?argv[4]:"53",two=argc==7?argv[5]:"56",tag=argc==7?argv[6]:"regular_root";
 std::vector<std::vector<FP>>rows{readcoeff(argv[1]),readcoeff(dir+"/"+prefix+"."+one+".json"),readcoeff(dir+"/"+prefix+"."+two+".json")};
 std::vector<FP>contents{FP(1),readcontent(dir+"/"+prefix+"."+one+".json"),readcontent(dir+"/"+prefix+"."+two+".json")};
 for(int i=0;i<3;i++){rows.push_back(readcoeff(dir+"/boundary."+std::to_string(i)+".json"));contents.push_back(readcontent(dir+"/boundary."+std::to_string(i)+".json"));}
 ptree ff;boost::property_tree::read_json(dir+"/projection_boundary_factors.json",ff);std::ofstream out(dir+"/"+tag+".boundary_fibre_results.json");
 out<<"{\"scope\":\"Full geometric fibres of supplied exact rows on the actual-scale graph\",\"rows\":["<<one<<','<<two<<"],\"fibres\":[";int i=0;bool complete=true;
 for(auto&[key,row]:ff.get_child("factors")){
  FP f=frow(row);FE::setmod(f);std::vector<Poly<FE>>p;for(size_t j=0;j<rows.size();j++)p.push_back(at(rows[j]).scale(FE(mod_fast(contents[j],f))));assert(p[0].deg()==12);
  auto g=gcdh(gcdh(p[0],p[1]),p[2]);int initial=g.deg();auto unit=Poly<FE>(std::vector<FE>{FE(0),FE(1)})*p[3]*p[4]*p[5];
  for(int k=0;k<13&&g.deg()>0;k++){auto h=gcdh(g,unit);if(h.deg()==0)break;g=g.exactdiv(h);}
  std::cout<<"FIBRE "<<i<<" base_degree "<<f.deg()<<" common_H "<<initial<<" allowed_H "<<g.deg()<<std::endl;
  if(i)out<<',';out<<"{\"index\":"<<i<<",\"base_degree\":"<<f.deg()<<",\"common_H_degree\":"<<initial<<",\"allowed_H_degree\":"<<g.deg()<<"}";if(g.deg()>0)complete=false;i++;
 }out<<"],\"all_excluded\":"<<(complete?"true":"false")<<"}\n";std::cout<<"COMPLETE "<<complete<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
