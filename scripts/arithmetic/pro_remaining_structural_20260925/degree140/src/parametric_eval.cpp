#include "fast.hpp"
#include <chrono>
#include <iomanip>
#ifdef _OPENMP
#include <omp.h>
#endif
using namespace exact;
std::array<std::array<Poly,7>,141> rp;
F leadconst;
Poly readp(std::istream&i){int n;i>>n;Poly p(n);for(auto&x:p)i>>x;p.trim();return p;}
// resultant with actual degrees, including constants.
F resactual(Poly a,Poly b){if(a.empty()||b.empty())return 0;F z=1;while(b.deg()>0){int m=a.deg(),n=b.deg();auto qr=divmod(a,b);if(qr.second.empty())return 0;int d=qr.second.deg();z=mul(z,power(b.back(),m-d));if((m*n)&1)z=neg(z);a=b;b=qr.second;}return mul(z,power(b[0],a.deg()));}
F resfixed(const Poly&a,const Poly&b,int m,int n){if(a.empty()||b.empty())return 0;if(a.deg()>m||b.deg()>n)throw std::runtime_error("degree exceeds declaration");if(a.deg()<m&&b.deg()<n)return 0;F z=resactual(a,b);if(a.deg()<m){z=mul(z,power(b.back(),m-a.deg()));if(((m-a.deg())*n)&1)z=neg(z);}if(b.deg()<n)z=mul(z,power(a.back(),n-b.deg()));return z;}
std::array<Poly,3> errors(F r){
 std::array<Poly,74> rr;F rn=inv(power(r,3)),r3=power(r,3),lc=inv(leadconst);
 for(int n=0;n<74;n++){rr[n].resize(7);for(int l=0;l<7;l++)rr[n][l]=mul(mul(eval(rp[n][l],r),rn),lc);rr[n].trim();rn=mul(rn,r3);}
 if(rr[0]!=Poly{1})throw std::runtime_error("monic normalization failed");
 std::array<Poly,71> j;j[0]=Poly{1};
 for(int n=1;n<=70;n++){Poly s;for(int i=1;i*2<n;i++)s=s+scale(j[i]*j[n-i],2);if(n%2==0)s=s+j[n/2]*j[n/2];j[n]=scale(rr[n]-s,3);}
 std::array<Poly,3> es;
 for(int n=71;n<=73;n++){Poly s;for(int i=n-70;i*2<n;i++)s=s+scale(j[i]*j[n-i],2);if(n%2==0&&n/2<=70)s=s+j[n/2]*j[n/2];es[n-71]=rr[n]-s;}
 return es;
}
int main(int argc,char**argv){try{
 if(argc<5){std::cerr<<"parametric_eval FIELD_DATA COEFFICIENTS COUNT OUTPREFIX [N]\n";return 2;}
 loadfield(argv[1]);std::ifstream in(argv[2]);in>>leadconst;
 for(int n=0;n<=140;n++)for(int l=0;l<7;l++)rp[n][l]=readp(in);
 int count=std::stoi(argv[3]),N=argc>5?std::stoi(argv[5]):48828;
 if(390624%N)throw std::runtime_error("N does not divide |K^*|");F omega=EX[390624/N];
 std::array<int,3>deg{47,47,48};auto first=errors(1);for(int i=0;i<3;i++)deg[i]=first[i].deg();
 std::cerr<<"declared lambda degrees "<<deg[0]<<' '<<deg[1]<<' '<<deg[2]<<"; N="<<N<<"; omega="<<omega<<'\n';
 std::vector<F> out(3*count);int bad=0;auto start=std::chrono::steady_clock::now();
 #pragma omp parallel for schedule(dynamic,16)
 for(int i=0;i<count;i++){
  F r=power(omega,i);auto e=errors(r);
  if(e[0].deg()>deg[0]||e[1].deg()>deg[1]||e[2].deg()>deg[2]){
   #pragma omp atomic
   bad++;
   continue;
  }
  out[i]=resfixed(e[0],e[1],deg[0],deg[1]);out[count+i]=resfixed(e[0],e[2],deg[0],deg[2]);out[2*count+i]=resfixed(e[1],e[2],deg[1],deg[2]);
  if(i%2048==0){
   #pragma omp critical
   std::cerr<<"evaluated index "<<i<<" / "<<count<<'\n';
  }
 }
 if(bad)throw std::runtime_error("higher lambda-degree specializations: "+std::to_string(bad));
 std::ofstream(std::string(argv[4])+".bin",std::ios::binary).write((char*)out.data(),4*out.size());
 std::ofstream meta(std::string(argv[4])+"_meta.json");meta<<"{\"N\":"<<N<<",\"count\":"<<count<<",\"omega\":"<<omega<<",\"lambda_degrees\":["<<deg[0]<<','<<deg[1]<<','<<deg[2]<<"],\"indices\":[71,72,73],\"pairs\":[[0,1],[0,2],[1,2]],\"r_degree_bounds\":[426,432,438],\"all_declared_degree_checks_passed\":true}\n";
 auto end=std::chrono::steady_clock::now();std::cerr<<"all evaluations finished in "<<std::chrono::duration<double>(end-start).count()<<" seconds\n";
 }catch(const std::exception&e){std::cerr<<"ERROR "<<e.what()<<'\n';return 1;}}
