// Project three bivariate equations by two exact H-resultants.
// A full multiplicative-group DFT avoids quadratic Newton interpolation.
// All specialized leading drops are included using fixed-degree resultants.
#include "degree140_trace_engine_20260929.hpp"
#include "dft.hpp"
#include <fstream>
#include <array>
using namespace exact;
struct Term{int h,q;F c;};
F actual_resultant(Poly a,Poly b){
 F out=1;while(b.deg()>0){int m=a.deg(),n=b.deg();if(a.empty())return 0;auto r=divmod(a,b).second;if(r.empty())return 0;int k=r.deg();out=mul(out,power(b.back(),m-k));if((m*n)&1)out=neg(out);a=std::move(b);b=std::move(r);}
 if(b.empty())return 0;return mul(out,power(b[0],a.deg()));
}
F fixed_resultant(const Poly&a,const Poly&b,int m,int n){
 if(a.empty()||b.empty())return 0;int da=m-a.deg(),db=n-b.deg();
 if(da<0||db<0)throw std::runtime_error("degree exceeds input bound");
 if(da&&db)return 0;F r=actual_resultant(a,b);
 if(da){r=mul(r,power(b.back(),da));if((da*n)&1)r=neg(r);}
 if(db)r=mul(r,power(a.back(),db));return r;
}
int main(int argc,char**argv){try{
 if(argc!=4)throw std::runtime_error("usage: projected_dft FIELD POLYNOMIAL_TEXT OUTPUT_PREFIX");
 loadfield(argv[1]);std::ifstream in(argv[2]);int count;in>>count;if(count!=3)throw std::runtime_error("need three inputs");
 std::vector<F> cv(390625);for(int i=1;i<390625;i++)cv[i]=add(i%5,mul(25,cv[i/5]));
 std::array<std::vector<Term>,3> pp;std::array<int,3>dh,dq;int mq=0;
 for(int k=0;k<3;k++){int n;in>>dh[k]>>dq[k]>>n;mq=std::max(mq,dq[k]);pp[k].resize(n);for(auto&t:pp[k]){int c;in>>t.h>>t.q>>c;t.c=cv.at(c);}}
 if(!in)throw std::runtime_error("incomplete polynomial input");
 std::array<int,2> bounds{dh[0]*dq[1]+dh[1]*dq[0],dh[0]*dq[2]+dh[2]*dq[0]};
 const int N=390624;F omega=EX[1];for(int p:{2,3,13,313})if(power(omega,N/p)==1)throw std::runtime_error("nonprimitive DFT root");
 if(std::max(bounds[0],bounds[1])>=N)throw std::runtime_error("degree bound requires extension field");
 auto specialize=[&](F q){std::vector<F>pw(mq+1,1);for(int i=1;i<=mq;i++)pw[i]=mul(pw[i-1],q);std::array<Poly,3>a;for(int k=0;k<3;k++){a[k].resize(dh[k]+1);for(auto&t:pp[k])a[k][t.h]=add(a[k][t.h],mul(t.c,pw[t.q]));a[k].trim();}return a;};
 uint64_t hash=1469598103934665603ULL;{std::ifstream f(argv[2],std::ios::binary);char c;while(f.get(c)){hash^=(unsigned char)c;hash*=1099511628211ULL;}}
 std::array<uint64_t,3>key{0x50524f4a44465431ULL,hash,N};std::string pre=argv[3],cp=pre+"_samples.bin";std::array<Poly,2>ys{Poly(N),Poly(N)};int restored=0;
 {std::ifstream f(cp,std::ios::binary);if(f){std::array<uint64_t,3>old;f.read((char*)old.data(),sizeof(old));if(!f||old!=key)throw std::runtime_error("checkpoint inputs changed");std::array<F,2>v;while(restored<N&&f.read((char*)v.data(),sizeof(v))){for(int k=0;k<2;k++)ys[k][restored]=v[k];restored++;}}}
 std::fstream checkpoint(cp,std::ios::binary|std::ios::in|std::ios::out);if(!checkpoint){std::ofstream create(cp,std::ios::binary);create.write((char*)key.data(),sizeof(key));create.close();checkpoint.open(cp,std::ios::binary|std::ios::in|std::ios::out);}
 checkpoint.seekp(sizeof(key)+size_t(restored)*8);auto start=std::chrono::steady_clock::now();int drops=0;
 std::cerr<<"restored "<<restored<<" samples; bounds "<<bounds[0]<<','<<bounds[1]<<"; one core\n";
 for(int i=restored;i<N;i++){
  auto a=specialize(EX[i]);for(int k=0;k<3;k++)drops+=a[k].deg()<dh[k];std::array<F,2>v;
  for(int k=0;k<2;k++)v[k]=ys[k][i]=fixed_resultant(a[0],a[k+1],dh[0],dh[k+1]);
  checkpoint.write((char*)v.data(),sizeof(v));
  if((i+1)%5000==0||i+1==N){checkpoint.flush();if(!checkpoint)throw std::runtime_error("checkpoint write failed");std::cerr<<"samples "<<i+1<<'/'<<N<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';}
 }
 std::array<Poly,2> rs;F ni=inv(N%5);
 for(int k=0;k<2;k++){
  rs[k]=scale(Poly(dft(ys[k],inv(omega))),ni);rs[k].trim();if(rs[k].deg()>bounds[k])throw std::runtime_error("DFT exceeds proved degree bound");
  auto a=specialize(0);if(rs[k].coef(0)!=fixed_resultant(a[0],a[k+1],dh[0],dh[k+1]))throw std::runtime_error("zero-parameter check failed");
  std::ofstream f(pre+"_resultant_"+std::to_string(k)+".bin",std::ios::binary);int n=rs[k].size();f.write((char*)&n,4);f.write((char*)rs[k].data(),4*rs[k].size());
  std::cerr<<"interpolated "<<k<<" degree "<<rs[k].deg()<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 }
 std::ofstream out(pre+".json");out<<"{\"status\":\"exact_projected_resultants\",\"scope\":\"necessary projected common-zero support, not an actual-cover decision\",\"degree_bounds\":["<<bounds[0]<<','<<bounds[1]<<"],\"degrees\":["<<rs[0].deg()<<','<<rs[1].deg()<<"],\"DFT_size\":"<<N<<",\"omega\":"<<omega<<",\"leading_drops_in_new_samples\":"<<drops<<",\"zero_parameter_checks\":2,\"calculation_cores\":1,\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
