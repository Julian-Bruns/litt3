// Exact bivariate first-square-equation construction on one fixed q fibre.
// H and mu remain geometric indeterminates. This is not a global decision.
#include "../src/residual.hpp"
#include "io_dft.hpp"
#include <thread>
#include <atomic>
constexpr int HH=1248, MM=78, EQS=7, MAXT=77;
F c_coefficient(const std::vector<F>& a2,const std::vector<F>& a3,int n){
 F out;for(int i=0;25*i<=n;i++)for(int j=0;25*i+5*j<=n;j++)out+=a2[i].pow(25)*a2[j].pow(5)*a3[n-25*i-5*j];return out;
}
int main(int argc,char** argv){try{
 if(argc<3)throw std::runtime_error("usage: fibre_equations ROOT_CODE OUTPUT_DIR [THREADS]");
 int rr=std::stoi(argv[1]),threads=argc>3?std::stoi(argv[3]):4;fs::path dir=argv[2];fs::create_directories(dir);
 input::init();auto cr=cramer(reconstruct(F::code(rr)));F w=F::code(101),q=w.pow(3);if(q==cr.pivot)throw std::runtime_error("pivot");
 auto start=std::chrono::steady_clock::now();
 F zh=F::code(kfield::primitive).pow(kfield::N/78);Rows rv(78,std::vector<F>(987));F H(1);
 for(int h=0;h<78;h++){auto s=evaluate_source(cr,H,w);auto r=residual(s,F::code(rr));F wp(1);for(int m=0;m<7;m++){for(int x=0;x<141;x++)rv[h][m*141+x]=r.c[m][x]*wp;wp*=w;}H*=zh;}
 auto rc=dft(rv,zh.inv());for(auto& row:rc)for(auto& a:row)a/=F(78);
 for(int h=73;h<78;h++)for(F a:rc[h])if(a)throw std::runtime_error("H interpolation tail");rc.resize(73);write_rows(dir/"R_H.bin",rc);
 // These explicit support checks certify the degree bounds for the subsequent interpolation.
 for(int h=0;h<73;h++)for(int m=0;m<7;m++)for(int t=0;t<=140;t++)if(rc[h][m*141+140-t]){
  if(h+3*t<9||h-3*t>21||3*t<4*m)throw std::runtime_error("weighted support bound");
 }
 F rh=F::code(kfield::primitive).pow(kfield::N/HH),rm=zh;
 Rows Hcoeff(HH,std::vector<F>(7*(MAXT+1)));
 for(int h=0;h<73;h++)for(int l=0;l<7;l++)for(int t=0;t<=MAXT;t++)Hcoeff[h][l*(MAXT+1)+t]=rc[h][l*141+140-t];
 auto Hv=dft(Hcoeff,rh);Hcoeff.clear();Hcoeff.shrink_to_fit();
 std::vector<F> hs(HH),ms(MM);hs[0]=ms[0]=F(1);for(int i=1;i<HH;i++)hs[i]=hs[i-1]*rh;for(int i=1;i<MM;i++)ms[i]=ms[i-1]*rm;
 Rows evalues(HH,std::vector<F>(MM*EQS));std::atomic<int> next(0),done(0);std::mutex mx;bool failed=false;std::string err;
 auto worker=[&]{try{for(;;){int h=next++;if(h>=HH)break;Rows rows(MM,std::vector<F>(EQS));
  for(int m=0;m<MM;m++){
   std::vector<F> a(MAXT+1),a2(MAXT+1),a3(MAXT+1);
   for(int t=0;t<=MAXT;t++){F z;for(int l=6;l>=0;l--)z=z*ms[m]+Hv[h][l*(MAXT+1)+t];a[t]=z;}
   for(int i=0;i<=MAXT;i++)for(int j=i;i+j<=MAXT;j++){F z=a[i]*a[j];if(i!=j)z*=F(2);a2[i+j]+=z;}
   for(int i=0;i<=MAXT;i++)for(int j=0;i+j<=MAXT;j++)a3[i+j]+=a[i]*a2[j];
   for(int e=0;e<EQS;e++){int n=71+e;rows[m][e]=c_coefficient(a2,a3,n)/hs[h].pow(567-3*n);}
  }
  auto coef=dft(rows,rm.inv());for(int m=0;m<MM;m++)for(int e=0;e<EQS;e++){
   F z=coef[m][e]/F(MM);if(m>(3*(71+e))/4&&z)throw std::runtime_error("mu interpolation tail");evalues[h][m*EQS+e]=z;
  }
  if(++done%156==0){std::lock_guard<std::mutex> lock(mx);std::cout<<"r="<<rr<<" H nodes "<<done<<"/"<<HH<<"\n"<<std::flush;}
 }}catch(std::exception& ex){std::lock_guard<std::mutex> lock(mx);failed=true;err=ex.what();}};
 std::vector<std::thread> pool;for(int j=0;j<threads;j++)pool.emplace_back(worker);for(auto& t:pool)t.join();if(failed)throw std::runtime_error(err);
 auto ec=dft(evalues,rh.inv());for(auto& row:ec)for(auto& a:row)a/=F(HH);
 std::ofstream meta(dir/"equations_summary.json");meta<<"{\"r\":"<<rr<<",\"w\":"<<w<<",\"q\":"<<q<<",\"equations\":[";
 for(int e=0;e<EQS;e++){
  int n=71+e,bound=756+6*n,lo=HH,hi=-1,ml=-1;long long terms=0;
  for(int h=0;h<HH;h++)for(int m=0;m<MM;m++)if(ec[h][m*EQS+e]){if(h>bound)throw std::runtime_error("equation H tail");lo=std::min(lo,h);hi=std::max(hi,h);ml=std::max(ml,m);terms++;}
  if(hi<0)throw std::runtime_error("unexpected zero first equation");Rows out(hi-lo+1,std::vector<F>(ml+1));for(int h=lo;h<=hi;h++)for(int m=0;m<=ml;m++)out[h-lo][m]=ec[h][m*EQS+e];
  write_rows(dir/("E"+std::to_string(n)+".bin"),out);
  if(e)meta<<",";meta<<"{\"n\":"<<n<<",\"H_unit_exponent\":"<<567-3*n+lo<<",\"H_degree\":"<<hi-lo<<",\"mu_degree\":"<<ml<<",\"terms\":"<<terms<<"}";
  std::cout<<"E"<<n<<" divided by H^"<<567-3*n+lo<<" degrees "<<hi-lo<<","<<ml<<" terms="<<terms<<"\n"<<std::flush;
 }
 meta<<"],\"weighted_support_and_interpolation_tails\":true,\"scope\":\"fixed q, all geometric H and mu; first seven necessary equations only\"}\n";
 std::cout<<"DONE seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"\n";
 return 0;
}catch(std::exception& e){std::cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
