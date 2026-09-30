// Exact support reduction of the TWO raw row norms. Scalar contents are
// restored before the gcd. Only original and independently excluded pole
// fibres are removed unconditionally; later boundary supports are retained.
#include "pro_companion140_20260928/src/native/algebra.hpp"
#include "pro_companion140_20260928/src/native/halfgcd.hpp"
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <fstream>
using namespace comp;
using boost::property_tree::ptree;
FP readpoly(const ptree&r){std::vector<F>a;for(auto&[k,v]:r)a.push_back(F(v.get_value<unsigned>()));return FP(a);}
void writepoly(std::ostream&o,const FP&p){o<<'[';for(int i=0;i<=p.deg();i++){if(i)o<<',';o<<p[i].v;}o<<']';}
FP loadpoly(const std::string&file,const std::string&key){ptree t;boost::property_tree::read_json(file,t);return readpoly(t.get_child(key));}
FP remove_support(const FP&g,const FP&f,FP&removed){
 FP r=mod_fast(f,g);int power=1;
 while(power<=g.deg()){r=mod_fast(r.fifth(),g);power*=5;}
 auto[d,u,v]=xgcd_half(g,r);auto[q,rem]=fast_divide(g,d);assert(!rem);removed=d;return q.monic();
}
int main(int argc,char**argv){try{
 if(argc!=3&&argc!=6)throw std::runtime_error("usage model.json directory [projection-prefix index1 index2]");F::init();FastK::init();std::string dir=argv[2];std::string prefix=argc==6?argv[3]:"projection",one=argc==6?argv[4]:"53",two=argc==6?argv[5]:"56";ptree m;boost::property_tree::read_json(argv[1],m);
 FP poles(1);for(auto&[k,p]:m.get_child("poles"))poles*=readpoly(p);
 FP p=loadpoly(dir+"/"+prefix+"."+one+".json","norm_of_primitive_row")*loadpoly(dir+"/"+prefix+"."+one+".json","content").pow(12);
 FP q=loadpoly(dir+"/"+prefix+"."+two+".json","norm_of_primitive_row")*loadpoly(dir+"/"+prefix+"."+two+".json","content").pow(12);
 auto[g,u,v]=xgcd_half(p,q,true);std::cout<<"RAW_NORM_GCD "<<g.deg()<<std::endl;
 std::ofstream out(dir+"/"+prefix+".raw_norm_gcd.json");out<<"{\"gcd\":";writepoly(out,g);out<<",\"u\":";writepoly(out,u);out<<",\"v\":";writepoly(out,v);out<<"}\n";out.close();
 FP removed,retained=remove_support(g,poles,removed);std::cout<<"AFTER_ORIGINAL_POLES "<<retained.deg()<<std::endl;
 out.open(dir+"/"+prefix+".retained_projection.json");out<<"{\"original_pole_support\":";writepoly(out,removed);out<<",\"retained\":";writepoly(out,retained);out<<"}\n";out.close();
 FP b(1);for(int i=0;i<3;i++){std::string f=dir+"/boundary_projection."+std::to_string(i)+".json";b*=loadpoly(f,"norm_of_primitive_row");b*=loadpoly(f,"content");}
 FP remaining=remove_support(retained,b,removed);std::cout<<"OUTSIDE_RETAINED_BOUNDARIES "<<remaining.deg()<<std::endl;
 out.open(dir+"/"+prefix+".boundary_split.json");out<<"{\"scope\":\"Both factors remain to be checked; no boundary is discarded\",\"boundary_part\":";writepoly(out,removed);out<<",\"outside_part\":";writepoly(out,remaining);out<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
