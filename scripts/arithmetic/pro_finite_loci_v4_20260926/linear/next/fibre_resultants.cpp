#include "../src/residual.hpp"
#include "fast_dft.hpp"
#include "resultant.hpp"
Rows read_unknown(const fs::path& p){std::ifstream f(p,std::ios::binary);int n=read32(f),m=read32(f);f.close();return read_rows(p,n,m);}
Poly eval_bivar(const Rows& a,F H){std::vector<F> out(a[0].size());for(int i=int(a.size())-1;i>=0;i--)for(int j=0;j<(int)out.size();j++)out[j]=out[j]*H+a[i][j];return Poly(out);}
int main(int argc,char** argv){try{
 if(argc<2)throw std::runtime_error("usage: fibre_resultants DIRECTORY [LAST_E=74] [THREADS=4]");fs::path dir=argv[1];int last=argc>2?std::stoi(argv[2]):74,threads=argc>3?std::stoi(argv[3]):4;
 input::init();auto start=std::chrono::steady_clock::now();std::vector<Rows> eq;std::vector<int> off;int cols=0;for(int e=71;e<=last;e++){off.push_back(cols);eq.push_back(read_unknown(dir/("E"+std::to_string(e)+".bin")));cols+=eq.back()[0].size();}
 std::vector<DegreeCertificate> bounds;int bound=0;for(int e=1;e<(int)eq.size();e++){bounds.push_back(degree_certificate(eq[0],eq[e]));bound=std::max(bound,bounds.back().bound);std::cout<<"res(71,"<<71+e<<") degree <= "<<bounds.back().bound<<"\n";}
 int nodes=1;std::vector<int> divisors;for(int d=1;d<=kfield::N;d++)if(kfield::N%d==0&&d>bound)divisors.push_back(d);if(divisors.empty())throw std::runtime_error("coefficient field lacks enough nodes");nodes=*std::min_element(divisors.begin(),divisors.end());
 F root=F::code(kfield::primitive).pow(kfield::N/nodes);std::cout<<"nodes="<<nodes<<" columns="<<cols<<"\n"<<std::flush;
 Rows coeff(nodes,std::vector<F>(cols));for(int e=0;e<(int)eq.size();e++)for(int i=0;i<(int)eq[e].size();i++)for(int j=0;j<(int)eq[e][0].size();j++)coeff[i][off[e]+j]=eq[e][i][j];
 auto values=fdft(coeff,root,threads);coeff.clear();coeff.shrink_to_fit();std::cout<<"coefficient evaluation complete\n"<<std::flush;
 int count=eq.size()-1;Rows rv(nodes,std::vector<F>(count));std::atomic<int> next(0),done(0);std::mutex mx;
 auto work=[&]{for(;;){int lo=next.fetch_add(64);if(lo>=nodes)break;for(int i=lo;i<std::min(nodes,lo+64);i++){
  std::vector<Poly> ps;for(int e=0;e<(int)eq.size();e++)ps.emplace_back(std::vector<F>(values[i].begin()+off[e],values[i].begin()+off[e]+eq[e][0].size()));
  for(int e=1;e<(int)eq.size();e++)rv[i][e-1]=fixed_resultant(ps[0],ps[e],eq[0][0].size()-1,eq[e][0].size()-1);
 }int d=done.fetch_add(64)+64;if(d%8192==0){std::lock_guard<std::mutex> l(mx);std::cout<<"resultant nodes "<<std::min(d,nodes)<<"/"<<nodes<<"\n"<<std::flush;}}};
 std::vector<std::thread> pool;for(int i=0;i<threads;i++)pool.emplace_back(work);for(auto& t:pool)t.join();values.clear();values.shrink_to_fit();
 auto rcoeff=fdft(rv,root.inv(),threads);rv.clear();rv.shrink_to_fit();F iv=F(nodes).inv();std::vector<Poly> res(count);
 for(int e=0;e<count;e++){
  res[e].c.resize(nodes);for(int h=0;h<nodes;h++){F z=rcoeff[h][e]*iv;if(h>bounds[e].bound&&z)throw std::runtime_error("resultant degree tail failed");res[e].c[h]=z;}res[e].trim();
  write_rows(dir/("Res71_"+std::to_string(e+72)+".bin"),Rows{res[e].c});std::cout<<"Res71,"<<72+e<<" actual degree="<<res[e].deg()<<"\n"<<std::flush;
  for(int cc:{31,102,399,12345}){F H=F::code(cc);auto a=eval_bivar(eq[0],H),b=eval_bivar(eq[e+1],H);F z=fixed_resultant(a,b,eq[0][0].size()-1,eq[e+1][0].size()-1);if(z!=res[e].eval(H))throw std::runtime_error("off-grid resultant mismatch");if(cc==31&&z!=sylvester_resultant(a,b,eq[0][0].size()-1,eq[e+1][0].size()-1))throw std::runtime_error("Sylvester check");}
 }
 std::ofstream meta(dir/"resultants_summary.json");meta<<"{\"H_nodes\":"<<nodes<<",\"H_generator\":"<<root<<",\"first_equation\":71,\"resultants\":[";
 for(int e=0;e<count;e++){if(e)meta<<",";meta<<"{\"second_equation\":"<<e+72<<",\"actual_degree\":"<<res[e].deg()<<",\"degree_certificate\":";write_degree(meta,bounds[e]);meta<<"}";}meta<<"],\"tails_zero\":true,\"off_grid_checks\":4,\"sylvester_checks_per_resultant\":1,\"scope\":\"fixed q, global H; no square decision yet\"}\n";
 std::cout<<"DONE seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"\n"<<std::flush;return 0;
}catch(std::exception&e){std::cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
