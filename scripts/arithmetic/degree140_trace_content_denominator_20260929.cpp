// New exact identification of the finite-endpoint denominator of trace fits.
// Reads accepted local J_p formulae, retaining all three cubic sheets.
#include "fast.hpp"
#include <sstream>
using namespace exact;

Poly endpoint_norm(const std::string& file,F w){
 std::ifstream in(file);std::string header;std::getline(in,header);
 if(header!="ENDPOINT_V1 H v unused unused")throw std::runtime_error("endpoint header");
 int root,p,m,zeta;in>>root>>p>>m>>zeta;
 Curve j;
 for(int block=0;block<6;block++){
  int n;in>>n;
  for(int k=0;k<n;k++){
   int eh,ev,e2,e3,c;in>>eh>>ev>>e2>>e3>>c;
   if(block!=5)continue;
   if(e2||e3)throw std::runtime_error("unexpected endpoint variable");
   int r=ev%3;if(r<0)r+=3;int q=(ev-r)/3;
   F a=mul(c,mul(power(w,eh),power(divide(p,power(w,3)),q)));
   if(j[r].size()<=size_t(eh))j[r].resize(eh+1);
   j[r][eh]=add(j[r][eh],a);
  }
 }
 for(auto&z:j)z.trim();baseP=Poly{divide(p,power(w,3))};
 Poly out=norm(j);return scale(out,inv(out.back()));
}
int main(int argc,char**argv){try{
 if(argc!=4){std::cerr<<"usage: content_denominator FIELD_DATA ENDPOINT_DIR W\n";return 2;}
 loadfield(argv[1]);F w=std::stoi(argv[3]);Poly product{1};
 std::cout<<"{\"w\":"<<w<<",\"endpoint_norms\":[";bool first=true;
 for(int root:{145049,211895,211959}){
  auto p=endpoint_norm(std::string(argv[2])+"/endpoint_"+std::to_string(root)+".txt",w);
  if(!first)std::cout<<',';first=false;std::cout<<"{\"root\":"<<root<<",\"polynomial\":";jsonpoly(std::cout,p);std::cout<<'}';product=product*p;
 }
 std::cout<<"],\"product\":";jsonpoly(std::cout,product);std::cout<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
