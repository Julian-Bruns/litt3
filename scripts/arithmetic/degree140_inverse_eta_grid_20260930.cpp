#include "degree140_inverse_eta_short_20260930.hpp"
// New exact grid for w*Tr(t*x^j*delta(Lambda)/eta)(w*mu).
#include <omp.h>
#include <atomic>
#include <mutex>
#include <set>
#include <array>
#include <cstdint>
#include <unistd.h>
using namespace infinitytrace;
struct CB {int j,n,dh,dq,dp,bh,bq;};
F psi(F H,F q){return add(eval(Poly{89654,311173,214299,163299,315361,33043,356725,245794},q),mul(H,mul(q,add(299833,mul(232505,q)))));}
std::vector<F> vandermonde_inverse(const std::vector<F>&xs){
 Poly all{1};for(F x:xs)all=all*Poly{neg(x),1};Poly der=derivative(all);int n=xs.size();std::vector<F> v(n*n);
 for(int j=0;j<n;j++){Poly l=pdivide(all,Poly{neg(xs[j]),1});F den=inv(eval(der,xs[j]));for(int i=0;i<n;i++)v[i*n+j]=mul(l.coef(i),den);}return v;
}
int main(int argc,char**argv){try{
 if(argc!=7&&argc!=8){std::cerr<<"usage: global_grid FIELD FAMILY BOUNDS_TEXT OUTPUT_PREFIX H_COUNT Q_COUNT [COMPANION]\n";return 2;}
 bool companion=argc==8&&std::stoi(argv[7]);
 // The user limits all calculations to two CPU cores in aggregate.
 omp_set_num_threads(std::min(2,omp_get_max_threads()));
 exact::loadfield(argv[1]);criticaltrace::load(argv[2]);std::ifstream bd(argv[3]);int nc;bd>>nc;std::vector<CB> cs(nc);for(auto&b:cs)bd>>b.j>>b.n>>b.dh>>b.dq>>b.dp>>b.bh>>b.bq;
 int nh=std::stoi(argv[5]),nq=std::stoi(argv[6]);std::vector<F> hs,qs,ws;for(int i=1;i<=nh;i++)hs.push_back(i);std::set<F> seen;
 for(F w=2;w<390625&&int(qs.size())<nq;w++){
  F q=power(w,3);if(q==1||q==15383||seen.count(q)||!eval(Poly{89654,311173,214299,163299,315361,33043,356725,245794},q))continue;
  bool ok=true;for(F H:hs)if(!psi(H,q)){ok=false;break;}if(!ok)continue;seen.insert(q);qs.push_back(q);ws.push_back(w);
 }
 if(int(qs.size())!=nq)throw std::runtime_error("not enough open grid points");
 std::string pre=argv[4];std::ofstream meta(pre+"_grid.json");meta<<"{\"H\":";jsonpoly(meta,Poly(hs));meta<<",\"q\":";jsonpoly(meta,Poly(qs));meta<<",\"w\":";jsonpoly(meta,Poly(ws));meta<<",\"coefficient_count\":"<<nc<<",\"layout\":\"coefficient,H,q; int32 little-endian\"}\n";meta.close();
 std::vector<F> vals((size_t)nc*nh*nq);std::vector<unsigned char> complete(nq,0);
 // Append only completed columns. A partial final record is ignored on resume.
 // The mathematical input and grid dimensions are part of the checkpoint key.
 uint64_t fingerprint=1469598103934665603ULL;
 for(int ai:{2,3}){std::ifstream f(argv[ai],std::ios::binary);char c;while(f.get(c)){fingerprint^=(unsigned char)c;fingerprint*=1099511628211ULL;}}
 for(F z:hs){fingerprint^=z;fingerprint*=1099511628211ULL;}for(F z:qs){fingerprint^=z;fingerprint*=1099511628211ULL;}
 std::array<uint64_t,6> key{0x4956455441534831ULL,(uint64_t)nh,(uint64_t)nq,(uint64_t)nc,(uint64_t)companion,fingerprint};
 std::string cpname=pre+"_columns.bin";size_t record_bytes=4+4*(size_t)nc*nh,valid_bytes=sizeof(key);int restored=0;
 {std::ifstream cp(cpname,std::ios::binary);if(cp){std::array<uint64_t,6> old;cp.read((char*)old.data(),sizeof(old));if(!cp||old!=key)throw std::runtime_error("checkpoint input mismatch");
  std::vector<F> col((size_t)nc*nh);int iq;while(cp.read((char*)&iq,4)){if(iq<0||iq>=nq)throw std::runtime_error("bad checkpoint column");if(!cp.read((char*)col.data(),4*col.size()))break;for(int k=0;k<nc;k++)for(int ih=0;ih<nh;ih++)vals[((size_t)k*nh+ih)*nq+iq]=col[(size_t)k*nh+ih];if(!complete[iq]){complete[iq]=1;restored++;}valid_bytes+=record_bytes;}
 }}
 // A previous interrupted write may leave a partial last record.
 if(restored){if(truncate(cpname.c_str(),valid_bytes))throw std::runtime_error("checkpoint truncate failed");}
 std::ofstream checkpoint(cpname,restored?std::ios::binary|std::ios::app:std::ios::binary|std::ios::trunc);
 if(!restored)checkpoint.write((char*)key.data(),sizeof(key));checkpoint.flush();
 std::atomic<int> done{restored},failed{0};std::mutex em;auto start=std::chrono::steady_clock::now();
 std::cerr<<"restored "<<restored<<" columns; calculation_threads "<<omp_get_max_threads()<<'\n';
 #pragma omp parallel
 {
  CAP=160;
  #pragma omp for schedule(dynamic,1)
  for(int iq=0;iq<nq;iq++){
   if(failed.load()||complete[iq])continue;
   try{F w=ws[iq],q=qs[iq];for(int ih=0;ih<nh;ih++){
    F H=hs[ih],ps=psi(H,q);auto pp=inverseetashort::profiles(divide(H,w),w);
    for(int k=0;k<nc;k++){auto b=cs[k];F z=mul(pp[b.j].coef(b.n),power(w,b.n+1));z=mul(z,mul(power(H,b.dh),mul(power(q,b.dq),power(ps,b.dp))));vals[((size_t)k*nh+ih)*nq+iq]=z;}
   }std::vector<F> col((size_t)nc*nh);for(int k=0;k<nc;k++)for(int ih=0;ih<nh;ih++)col[(size_t)k*nh+ih]=vals[((size_t)k*nh+ih)*nq+iq];{std::lock_guard<std::mutex>l(em);checkpoint.write((char*)&iq,4);checkpoint.write((char*)col.data(),4*col.size());checkpoint.flush();if(!checkpoint)throw std::runtime_error("checkpoint write failed");}
   }catch(const std::exception&e){failed++;std::lock_guard<std::mutex>l(em);std::cerr<<"ERROR q_index "<<iq<<": "<<e.what()<<'\n';}
   int n=++done;if(n%20==0||n==nq){std::lock_guard<std::mutex>l(em);std::cerr<<"evaluated "<<n<<'/'<<nq<<" q columns; seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';}
  }
 }
 if(failed)throw std::runtime_error("grid has failed cells");
 {std::ofstream out(pre+"_values.bin",std::ios::binary);out.write((char*)vals.data(),4*vals.size());}
 auto vh=vandermonde_inverse(hs),vq=vandermonde_inverse(qs);std::vector<F> temp(vals.size()),out(vals.size());
 #pragma omp parallel for schedule(dynamic,1)
 for(int k=0;k<nc;k++)for(int iq=0;iq<nq;iq++)for(int r=0;r<nh;r++){
  F z=0;for(int i=0;i<nh;i++)z=add(z,mul(vh[r*nh+i],vals[((size_t)k*nh+i)*nq+iq]));temp[((size_t)k*nh+r)*nq+iq]=z;
 }
 std::cerr<<"H interpolation complete; seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 #pragma omp parallel for schedule(dynamic,1)
 for(int k=0;k<nc;k++)for(int h=0;h<nh;h++){
  bool any=false;for(int i=0;i<nq;i++)any|=temp[((size_t)k*nh+h)*nq+i]!=0;if(!any)continue;
  for(int r=0;r<nq;r++){F z=0;for(int i=0;i<nq;i++)z=add(z,mul(vq[r*nq+i],temp[((size_t)k*nh+h)*nq+i]));out[((size_t)k*nh+h)*nq+r]=z;}
 }
 {std::ofstream data(pre+"_coefficients.bin",std::ios::binary);data.write((char*)out.data(),4*out.size());}
 std::ofstream report(pre+"_summary.json");report<<"{\"status\":\"complete\",\"grid\":["<<nh<<','<<nq<<"],\"profiles\":"<<nh*nq<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<",\"coefficients\":[";
 for(int k=0;k<nc;k++){int ah=-1,aq=-1,nt=0;for(int h=0;h<nh;h++)for(int q=0;q<nq;q++)if(out[((size_t)k*nh+h)*nq+q]){ah=std::max(ah,h);aq=std::max(aq,q);nt++;}auto b=cs[k];if(ah>b.bh||aq>b.bq)throw std::runtime_error("proved degree bound exceeded");if(k)report<<',';report<<"{\"j\":"<<b.j<<",\"n\":"<<b.n<<",\"denominator_H_q_Psi\":["<<b.dh<<','<<b.dq<<','<<b.dp<<"],\"bidegree\":["<<ah<<','<<aq<<"],\"terms\":"<<nt<<"}";}
 report<<"]}\n";std::cerr<<"global coefficient interpolation complete\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
