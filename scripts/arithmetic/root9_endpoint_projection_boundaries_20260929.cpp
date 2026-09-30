// Export only the three necessary boundary functions of the actual
// scale graph: its numerator, denominator and residual leading value.
#define main accepted_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main
FP gcdp(FP a,FP b){while(b){auto r=a.mod(b);a=std::move(b);b=std::move(r);}return a.monic();}
int main(int argc,char**argv){try{
 if(argc!=4)throw std::runtime_error("usage model.json residual.json output-prefix");F::init();FastK::init();ptree model,rr;boost::property_tree::read_json(argv[1],model);boost::property_tree::read_json(argv[2],rr);
 std::array<FP,5>fac;int k=0;for(auto&[key,r]:model.get_child("poles"))fac[k++]=frow(r);
 std::vector<ptree>rows{model.get_child("homogeneous_num_H"),model.get_child("homogeneous_den_H")};
 k=0;for(auto&[key,r]:rr.get_child("coefficients"))if(k++==140)rows.push_back(r);assert(rows.size()==3);
 for(int i=0;i<3;i++){
  std::vector<FP>p;std::vector<std::array<int,5>>ds;std::array<int,5>high{};
  for(auto&[key,r]:rows[i]){assert(r.get_child("b").empty());p.push_back(frow(r.get_child("a")));std::array<int,5>d;int j=0;for(auto&[key,v]:r.get_child("den")){d[j]=v.get_value<int>();high[j]=std::max(high[j],d[j]);j++;}ds.push_back(d);}
  for(size_t j=0;j<p.size();j++)for(int k=0;k<5;k++)if(high[k]>ds[j][k])p[j]*=fac[k].pow(high[k]-ds[j][k]);
  while(!p.empty()&&!p.back())p.pop_back();FP c;for(auto&v:p)c=gcdp(c,v);for(auto&v:p)v=v.exactdiv(c);
  std::ofstream out(std::string(argv[3])+"."+std::to_string(i)+".json");out<<"{\"index\":"<<i<<",\"scope\":\"Boundary function; its projection fibre is retained, never automatically discarded\",\"content\":";json(out,c);out<<",\"coefficients\":[";
  for(size_t j=0;j<p.size();j++){if(j)out<<',';json(out,p[j]);}out<<"]}\n";
  std::cout<<"BOUNDARY "<<i<<" H_degree "<<p.size()-1<<" content_degree "<<c.deg()<<std::endl;
 }
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
