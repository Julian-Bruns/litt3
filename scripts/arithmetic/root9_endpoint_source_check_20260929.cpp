// Full-source checks of the common H-polynomial cache on entire H fibres.
#define main accepted_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main
template<class T>T evrat(const ptree&r,T z,const std::vector<FP>&poles){T v=at(frow(r.get_child("a")),z),den=1;assert(!frow(r.get_child("b")));int i=0;for(auto&[k,e]:r.get_child("den"))den*=at(poles[i++],z).pow(e.get_value<int>());return v/den;}
int main(int argc,char**argv){try{
 if(argc<4)throw std::runtime_error("usage source-root model source-cache");init(argv[1]);ptree model,cache;boost::property_tree::read_json(argv[2],model);boost::property_tree::read_json(argv[3],cache);std::vector<FP>poles;for(auto&[k,r]:cache.get_child("poles"))poles.push_back(frow(r));
 for(F z0:{F(2),F(3),F(25)}){
  std::vector<F>mod;for(auto&[k,r]:model.get_child("J_monic_H"))mod.push_back(evrat(r,z0,poles));E::setmod(FP(mod));E h(FP(std::vector<F>{0,1})),z(z0),q(evrat(model.get_child("actual_q"),z0,poles));auto full=small_critical(q,h*q);int i=0;unsigned checked=0;
  for(auto&[k,row]:cache.get_child("rows")){int j=0;for(auto&[k,pol]:row){int l=0;for(auto&[k,co]:pol){E v,pow(1);for(auto&[k,rat]:co){v+=evrat(rat,z,poles)*pow;pow*=h;}assert(v==full[i].c[j][l++]);checked++;}j++;}i++;}
  std::cout<<"FULL_SOURCE_CACHE_PASS Z="<<z0.v<<" coefficients="<<checked<<" fibre_degree="<<E::modulus.deg()<<std::endl;
 }
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
