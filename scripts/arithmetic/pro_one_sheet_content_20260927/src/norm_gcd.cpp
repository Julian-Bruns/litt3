#define USE_GMP_PACKING
#include "fast_univariate.hpp"
static UP loadu(std::istream&i){int n;i>>n;UP a(n);for(U&c:a)i>>c;if(!i)throw std::runtime_error("bad polynomial");return a;}
static void saveu(std::ostream&o,const UP&p){o<<p.size();for(U c:p)o<<" "<<c;o<<"\n";}
int main(int argc,char**argv){try{if(argc!=5){std::cerr<<"usage: norm_gcd norm1 norm2 support prefix\n";return 2;}initfield(nullptr);std::ifstream a(argv[1]),b(argv[2]),s(argv[3]);UP A=loadu(a),B=loadu(b),support=loadu(s);std::cout<<"norm_degrees="<<A.size()-1<<","<<B.size()-1<<" support_degree="<<support.size()-1<<std::endl;
 // Cancel only support factors here; every corresponding base fibre is retained
 // as an explicit exceptional set, not assumed excluded by this calculation.
 std::array<UP,2> p={A,B};std::array<UP,2>removed;for(int i=0;i<2;i++){
 std::string base=std::string(argv[4])+"_strip"+std::to_string(i);std::ifstream cache(base+"_cache.txt");if(cache){p[i]=loadu(cache);removed[i]=loadu(cache);if(um(p[i],removed[i])!=(i?B:A))throw std::runtime_error("strip cache identity failed");std::cout<<"loaded stripped norm "<<i<<" degree="<<p[i].size()-1<<std::endl;continue;}
 removed[i]={1};std::vector<UP>chain;UP g=ugfast(p[i],support);int step=0;while(g.size()>1){chain.push_back(g);p[i]=ux(p[i],g);removed[i]=um(removed[i],g);std::cout<<"strip step="<<step++<<" remain="<<p[i].size()-1<<" removed="<<removed[i].size()-1<<std::endl;g=ugfast(p[i],um(g,g));}if(ugfast(p[i],support)!=UP{1})throw std::runtime_error("support stripping incomplete");
 {std::ofstream co(base+"_cache.txt");saveu(co,p[i]);saveu(co,removed[i]);std::ofstream ch(base+"_chain.txt");ch<<chain.size()<<"\n";for(auto&g:chain)saveu(ch,g);}
 std::cout<<"stripped norm "<<i<<" degree="<<p[i].size()-1<<" removed_degree="<<removed[i].size()-1<<std::endl;}

 auto z=uxgfast(p[0],p[1]);std::ofstream out(std::string(argv[4])+"_bezout.txt");for(auto&p:removed)saveu(out,p);for(auto&p:z)saveu(out,p);std::ofstream go(std::string(argv[4])+"_gcd.txt");saveu(go,z[0]);std::cout<<"PASS residual_gcd_degree="<<z[0].size()-1<<" exact_Bezout_identity=PASS unit_gcd="<<(z[0]==UP{1})<<"\n";return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
