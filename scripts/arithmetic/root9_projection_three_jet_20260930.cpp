// Degree-certified projection from three Euler jets at every nonzero
// field value. No large jet evaluation table is stored in memory.
#include "resultant_three_jet_20260930.hpp"
#include "dft.hpp"
#include <omp.h>
#include <atomic>
#include <mutex>
#include <unistd.h>
using namespace exact;
using namespace jetresultant;
struct Term {int h,q;F c;};
using Jets=std::array<Poly,3>;
inline Poly reconstruct(const Jets&values,F omega){
 constexpr int N=390624;Jets b;F ni=inv(N%5);for(int j=0;j<3;j++)b[j]=scale(Poly(dft(values[j],inv(omega))),ni);
 std::array<std::array<std::array<F,3>,3>,5> matrices;
 for(int r=0;r<5;r++){
  std::array<std::array<F,6>,3>M{};for(int s=0;s<3;s++){int k=(r+s*(N%5))%5;M[0][s]=1;M[1][s]=k;M[2][s]=(k*(k+4)*3)%5;M[s][s+3]=1;}
  for(int j=0;j<3;j++){int i=j;while(i<3&&!M[i][j])i++;if(i==3)throw std::runtime_error("singular Euler-jet interpolation");std::swap(M[i],M[j]);F z=inv(M[j][j]);for(int k=0;k<6;k++)M[j][k]=mul(M[j][k],z);for(int i=0;i<3;i++)if(i!=j){F c=M[i][j];for(int k=0;k<6;k++)M[i][k]=sub(M[i][k],mul(c,M[j][k]));}}
  for(int i=0;i<3;i++)for(int j=0;j<3;j++)matrices[r][i][j]=M[i][j+3];
 }
 Poly p(3*N);for(int r=0;r<N;r++)for(int s=0;s<3;s++)for(int j=0;j<3;j++)p[r+s*N]=add(p[r+s*N],mul(matrices[r%5][s][j],b[j][r]));p.trim();return p;
}
inline void interpolation_controls(){
 // The 3x3 reconstruction depends only on exponents modulo N and5.
 constexpr int N=390624;
 for(int r=0;r<5;r++){int k[3]={r,(r+N)%5,(r+2*N)%5};F det=mul(mul(sub(k[1],k[0]),sub(k[2],k[0])),mul(sub(k[2],k[1]),3));if(!det)throw std::runtime_error("Euler interpolation determinant failed");}
}
int main(int argc,char**argv){try{
 if(argc<2)throw std::runtime_error("usage: jet_projection FIELD [INPUT OUTPUT qpower0 qpower1 bound0 bound1 [max_nodes]]");
 loadfield(argv[1]);controls();interpolation_controls();std::cerr<<"three-jet resultant, degree-drop, Weierstrass and split-root controls passed\n";
 if(argc==2)return 0;if(argc!=9&&argc!=10)throw std::runtime_error("wrong argument count");
 std::ifstream in(argv[2]);int count;in>>count;if(count!=3)throw std::runtime_error("need three equations");
 std::vector<F>cv(390625);for(int i=1;i<390625;i++)cv[i]=add(i%5,mul(25,cv[i/5]));
 std::array<std::vector<Term>,3> pp;std::array<int,3>dh,dq;int mq=0;
 for(int i=0;i<3;i++){int n;in>>dh[i]>>dq[i]>>n;mq=std::max(mq,dq[i]);pp[i].resize(n);for(auto&t:pp[i]){int code;in>>t.h>>t.q>>code;t.c=cv.at(code);}}
 if(!in)throw std::runtime_error("truncated polynomial input");
 const int N=390624;std::array<int,2>qpower{std::stoi(argv[4]),std::stoi(argv[5])},bound{std::stoi(argv[6]),std::stoi(argv[7])};
 int maxnodes=std::stoi(argv[8]);if(maxnodes<=0||maxnodes>N)maxnodes=N;
 if(std::max(bound[0],bound[1])>=3*N)throw std::runtime_error("three jets do not meet the bound");
 uint64_t hash=1469598103934665603ULL;{std::ifstream f(argv[2],std::ios::binary);char c;while(f.get(c)){hash^=(unsigned char)c;hash*=1099511628211ULL;}}
 std::array<uint64_t,7>key{0x52394a4554335631ULL,hash,N,uint64_t(qpower[0]),uint64_t(qpower[1]),uint64_t(bound[0]),uint64_t(bound[1])};
 std::string pre=argv[3],cp=pre+"_jets.bin";std::array<Jets,2> ys;for(auto&v:ys)for(auto&w:v)w.resize(N);std::vector<unsigned char>complete(N);int restored=0;size_t valid=sizeof(key);
 {std::ifstream f(cp,std::ios::binary);if(f){std::array<uint64_t,7>old;f.read((char*)old.data(),sizeof(old));if(!f||old!=key)throw std::runtime_error("checkpoint input mismatch");int node;std::array<F,6>v;while(f.read((char*)&node,4)){if(node<0||node>=N)throw std::runtime_error("invalid node checkpoint");if(!f.read((char*)v.data(),sizeof(v)))break;for(int k=0;k<2;k++)for(int j=0;j<3;j++)ys[k][j][node]=v[3*k+j];if(!complete[node]){complete[node]=1;restored++;}valid+=4+sizeof(v);}}}
 if(restored&&truncate(cp.c_str(),valid))throw std::runtime_error("cannot trim checkpoint tail");std::ofstream checkpoint(cp,restored?std::ios::binary|std::ios::app:std::ios::binary|std::ios::trunc);if(!restored)checkpoint.write((char*)key.data(),sizeof(key));checkpoint.flush();
 omp_set_num_threads(std::min(2,omp_get_max_threads()));auto start=std::chrono::steady_clock::now();std::atomic<int>done{restored},failed{0};std::atomic<unsigned long>preps{0},changes{0},nilzeros{0};std::mutex mutex;
 std::cerr<<"restored "<<restored<<" nodes; running to "<<maxnodes<<"; threads "<<omp_get_max_threads()<<'\n';
 #pragma omp parallel for schedule(dynamic,16)
 for(int node=0;node<maxnodes;node++){
  if(complete[node]||failed.load())continue;
  try{
   F q=EX[node];std::vector<F>powers(mq+1,1);for(int j=1;j<=mq;j++)powers[j]=mul(powers[j-1],q);
   std::array<JP,3> a;
   for(int k=0;k<3;k++){
    std::vector<std::array<F,5>> bins(dh[k]+1);for(auto&t:pp[k])bins[t.h][t.q%5]=add(bins[t.h][t.q%5],mul(t.c,powers[t.q]));
    a[k].resize(dh[k]+1);for(int i=0;i<=dh[k];i++)for(int r=0;r<5;r++){F b=bins[i][r];a[k][i].c[0]=add(a[k][i].c[0],b);a[k][i].c[1]=add(a[k][i].c[1],mul(r,b));a[k][i].c[2]=add(a[k][i].c[2],mul((r*(r+4)*3)%5,b));}
   }
   std::array<F,6>values;
   for(int k=0;k<2;k++){
    Counters cc;J z=resultant(a[0],a[k+1],dh[0],dh[k+1],&cc);preps+=cc.preparations;changes+=cc.coordinate_changes;nilzeros+=cc.nilpotent_zero;
    int r=(5-qpower[k]%5)%5;J divisor;divisor.c={1,F(r),F((r*(r+4)*3)%5)};z*=J(inv(power(q,qpower[k])))*divisor;
    for(int j=0;j<3;j++)values[3*k+j]=ys[k][j][node]=z.c[j];
   }
   {std::lock_guard<std::mutex>lock(mutex);checkpoint.write((char*)&node,4);checkpoint.write((char*)values.data(),sizeof(values));if(!checkpoint)throw std::runtime_error("checkpoint write failed");complete[node]=1;}
   int n=++done;if(n%1000==0||n==maxnodes){std::lock_guard<std::mutex>lock(mutex);checkpoint.flush();std::cerr<<"nodes "<<n<<'/'<<maxnodes<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<" preparations "<<preps.load()<<'\n';}
  }catch(const std::exception&e){failed++;std::lock_guard<std::mutex>lock(mutex);std::cerr<<"node "<<node<<" ERROR "<<e.what()<<'\n';}
 }
 if(failed)throw std::runtime_error("projection has failed nodes");checkpoint.flush();
 if(maxnodes<N){std::cerr<<"bounded performance prefix retained; no projection claim\n";return 0;}
 F omega=EX[1];for(int p:{2,3,13,313})if(power(omega,N/p)==1)throw std::runtime_error("nonprimitive transform root");
 std::array<Poly,2>rs;
 for(int k=0;k<2;k++){rs[k]=reconstruct(ys[k],omega);if(rs[k].deg()>bound[k])throw std::runtime_error("projection exceeds proved bound");std::ofstream f(pre+"_resultant_"+std::to_string(k)+".bin",std::ios::binary);int n=rs[k].size();f.write((char*)&n,4);f.write((char*)rs[k].data(),4*rs[k].size());std::cerr<<"reconstructed "<<k<<" degree "<<rs[k].deg()<<'\n';}
 std::ofstream out(pre+".json");out<<"{\"status\":\"exact_three_jet_projection\",\"scope\":\"necessary parameter projection, not a common-cover decision\",\"degree_bounds\":["<<bound[0]<<','<<bound[1]<<"],\"degrees\":["<<rs[0].deg()<<','<<rs[1].deg()<<"],\"removed_q_powers\":["<<qpower[0]<<','<<qpower[1]<<"],\"nodes\":"<<N<<",\"Euler_jets\":3,\"Weierstrass_preparations_in_new_nodes\":"<<preps.load()<<",\"coordinate_changes_in_new_nodes\":"<<changes.load()<<",\"nilpotent_zero_reductions_in_new_nodes\":"<<nilzeros.load()<<",\"calculation_cores\":"<<omp_get_max_threads()<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
