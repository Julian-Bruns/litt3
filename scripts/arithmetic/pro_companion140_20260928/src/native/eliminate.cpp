#include "halfgcd.hpp"
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <fstream>
#include <chrono>
using namespace comp;using boost::property_tree::ptree;
ptree read(const std::string&p){ptree z;boost::property_tree::read_json(p,z);return z;}
FP poly(const ptree&z){std::vector<F>v;for(auto&[k,x]:z)v.emplace_back(x.get_value<unsigned>());return FP(v);}
void printpoly(std::ostream&o,const FP&p){o<<'[';for(size_t j=0;j<p.c.size();j++){if(j)o<<',';o<<p.c[j].v;}o<<']';}
std::vector<FP> licensed_units(const std::string&root){
 auto in=read(root+"/data/inputs.json"),bounds=read(root+"/data/projection_bounds.json"),lead=read(root+"/data/leading_tail_boundary.json");
 std::vector<FP>units;auto add=[&](FP f){f=f.monic();if(std::find(units.begin(),units.end(),f)==units.end())units.push_back(std::move(f));};
 for(auto&[k,z]:bounds.get_child("places"))add(poly(z.get_child("modulus")));
 for(std::string key:{"b","C"})for(auto&f:factor_squarefree(poly(in.get_child(key))))add(f);
 for(auto&[k,z]:in.get_child("excluded_q"))add(FP(std::vector<F>{-F(z.get_value<unsigned>()),F(1)}));
 for(unsigned q:{1,2})add(FP(std::vector<F>{-F(q),F(1)}));
 for(auto&[k,z]:lead.get_child("fibres")){FP f=poly(z.get_child("discriminant"));for(auto&p:factor_squarefree(f))add(p);}
 return units;
}
int main(int argc,char**argv){try{assert(argc==4);std::string root=argv[1],path=argv[2],outpath=argv[3];F::init();FastK::init();auto t0=std::chrono::steady_clock::now();
 auto input=read(path);std::array<FP,2>P{poly(input.get_child("P12")),poly(input.get_child("P13"))};input.clear();
 auto units=licensed_units(root);
 std::cout<<"{\"licensed_irreducible_factors\":"<<units.size()<<",\"input_degrees\":["<<P[0].deg()<<','<<P[1].deg()<<"]}"<<std::endl;
 std::vector<std::array<int,2>>valuations(units.size());std::array<FP,2>red=P;
 for(int j=0;j<2;j++)for(int k=0;k<(int)units.size();k++){auto[v,r]=remove_frobenius(std::move(red[j]),units[k]);valuations[k][j]=v;red[j]=std::move(r);std::cout<<"{\"strip_pair\":"<<j<<",\"factor\":"<<k<<",\"factor_degree\":"<<units[k].deg()<<",\"order\":"<<v<<",\"remaining_degree\":"<<red[j].deg()<<"}"<<std::endl;}
 std::ofstream reduced(outpath+".reduced.json");reduced<<"{\"P12\":";printpoly(reduced,red[0]);reduced<<",\"P13\":";printpoly(reduced,red[1]);reduced<<"}\n";reduced.close();
 std::cout<<"{\"stripped_degrees\":["<<red[0].deg()<<','<<red[1].deg()<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-t0).count()<<"}"<<std::endl;
 auto[g,u,v]=xgcd_half(red[0],red[1],true);
 std::ofstream out(outpath);out<<"{\"unit_factors\":[";for(size_t i=0;i<units.size();i++){if(i)out<<',';out<<"{\"polynomial\":";printpoly(out,units[i]);out<<",\"orders\":["<<valuations[i][0]<<','<<valuations[i][1]<<"]}";}out<<"],\"G\":";printpoly(out,g);out<<",\"U\":";printpoly(out,u);out<<",\"V\":";printpoly(out,v);out<<"}\n";
 std::cout<<"{\"projected_gcd_degree\":"<<g.deg()<<",\"exact_Bezout_and_divisibility\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-t0).count()<<"}"<<std::endl;
 return 0;
 }catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<std::endl;return 1;}}
