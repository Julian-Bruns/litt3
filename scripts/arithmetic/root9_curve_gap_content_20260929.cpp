// Exact scalar content of the new curve-square rows. Unknown factors are
// retained; this diagnostic never treats them as chart units.
#define main accepted_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main
#include "pro_companion140_20260928/src/native/halfgcd.hpp"
FP gcdp(FP a,FP b){if(!a)return b.monic();if(!b)return a.monic();return std::get<0>(xgcd_half(std::move(a),std::move(b)));}
int main(int argc,char**argv){try{
 if(argc!=4)throw std::runtime_error("usage model.json curve_gaps.json output_prefix");F::init();FastK::init();ptree model,rows;boost::property_tree::read_json(argv[1],model);boost::property_tree::read_json(argv[2],rows);std::array<FP,5>factors;int k=0;for(auto&[key,r]:model.get_child("poles"))factors[k++]=frow(r);assert(k==5);
 std::vector<int>indices;for(auto&[key,i]:rows.get_child("indices"))indices.push_back(i.get_value<int>());k=0;
 for(auto&[key,row]:rows.get_child("rows")){
  if(k>=3)break;std::vector<FP>p;std::vector<std::array<int,5>>den;std::array<int,5>high{};
  for(auto&[kk,r]:row){assert(r.get_child("b").empty());p.push_back(frow(r.get_child("a")));std::array<int,5>d;int j=0;for(auto&[key,v]:r.get_child("den")){d[j]=v.get_value<int>();high[j]=std::max(high[j],d[j]);j++;}assert(j==5);den.push_back(d);}
  for(size_t i=0;i<p.size();i++)for(int j=0;j<5;j++)if(high[j]>den[i][j])p[i]*=factors[j].pow(high[j]-den[i][j]);
  FP content;for(size_t i=0;i<p.size();i++){content=gcdp(content,p[i]);std::cout<<"ROW "<<indices[k]<<" column "<<i<<" gcd_degree "<<content.deg()<<std::endl;if(content.deg()==0)break;}
  std::ofstream out(std::string(argv[3])+"."+std::to_string(indices[k])+".json");out<<"{\"scope\":\"Scalar content retained, not inverted\",\"index\":"<<indices[k]<<",\"common_denominator_exponents\":[";
  for(int j=0;j<5;j++){if(j)out<<',';out<<high[j];}out<<"],\"content\":";json(out,content);out<<",\"coefficients\":[";
  for(size_t i=0;i<p.size();i++){FP q=exact_fast(p[i],content);if(i)out<<',';json(out,q);std::cout<<"PRIMITIVE_COLUMN "<<indices[k]<<" "<<i<<" "<<q.deg()<<std::endl;}out<<"]}\n";k++;
 }
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
