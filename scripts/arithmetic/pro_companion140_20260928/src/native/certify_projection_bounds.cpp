#include "polynomial_tools.hpp"
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <fstream>
using namespace comp;using boost::property_tree::ptree;
std::vector<int> ints(const ptree&z){std::vector<int>v;for(auto&[s,a]:z)v.push_back(a.get_value<int>());return v;}
std::vector<ptree> arr(const ptree&z){std::vector<ptree>v;for(auto&[s,a]:z)v.push_back(a);return v;}
void row(std::ostream&o,const std::vector<long long>&r){o<<'[';for(size_t j=0;j<r.size();j++){if(j)o<<',';o<<r[j];}o<<']';}
int main(int argc,char**argv){assert(argc==3);ptree data;boost::property_tree::read_json(argv[1],data);auto pp=arr(data.get_child("places")),infty=arr(data.get_child("infinity_coefficient_valuations"));
 std::ofstream out(argv[2]);out<<"{\"duals\":[";bool first=true;int count=0;
 for(int pair=0;pair<2;pair++){
  long long degree=0;
  for(int place=-1;place<(int)pp.size();place++){
   int sheets=place<0||pp[place].get<int>("kind")!=2?2:1;auto vals=place<0?infty:arr(pp[place].get_child("coefficient_valuations"));long long sum=0;
   for(int sheet=0;sheet<sheets;sheet++){
    auto f=ints(arr(vals[0])[sheet]),g=ints(arr(vals[pair+1])[sheet]);std::vector<long long>u,v;long long value=resultant_lower_valuation(f,g,&u,&v);sum+=value;
    if(!first)out<<',';first=false;out<<"{\"pair\":"<<pair<<",\"place\":"<<place<<",\"sheet\":"<<sheet<<",\"lower_bound\":"<<value<<",\"row_potentials\":";row(out,u);out<<",\"column_potentials\":";row(out,v);out<<'}';count++;
   }
   long long expected=place<0?ints(data.get_child("infinity_valuation_bounds"))[pair]:ints(pp[place].get_child("norm_resultant_valuation_bounds"))[pair];assert(sum==expected);
   degree-=sum*(place<0?1:(int)pp[place].get_child("modulus").size()-1);
  }
  assert(degree==ints(data.get_child("projected_degree_bounds"))[pair]);
 }
 out<<"]}\n";std::cout<<"{\"Sylvester_dual_certificates\":"<<count<<",\"all_feasibility_and_degree_checks\":\"PASS\"}"<<std::endl;
}
