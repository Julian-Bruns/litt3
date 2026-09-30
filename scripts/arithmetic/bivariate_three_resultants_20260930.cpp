// Reconstruct Res_H(f0,f1), Res_H(f0,f2) inside their proved degree boxes.
// Every sampled H-degree is retained. Skipped leading drops are recovered
// by global polynomial interpolation, not deleted from the zero locus.
#include "degree140_trace_engine_20260929.hpp"
#include <fstream>
#include <array>
using namespace exact;
struct Term{int h,q;F c;};
F resultant(Poly a,Poly b){
 F out=1;while(b.deg()>0){int m=a.deg(),n=b.deg();if(a.empty())return 0;auto r=divmod(a,b).second;if(r.empty())return 0;int k=r.deg();out=mul(out,power(b.back(),m-k));if((m*n)&1)out=neg(out);a=std::move(b);b=std::move(r);}
 if(b.empty())return 0;return mul(out,power(b[0],a.deg()));
}
Poly newton_interpolation(const std::vector<F>&xs,Poly dd){
 int n=xs.size();if((int)dd.size()!=n)throw std::runtime_error("sample length mismatch");
 for(int k=1;k<n;k++)for(int i=n-1;i>=k;i--)dd[i]=divide(sub(dd[i],dd[i-1]),sub(xs[i],xs[i-k]));
 Poly out{dd.back()};for(int k=n-2;k>=0;k--){Poly next(out.size()+1);F a=neg(xs[k]);for(size_t i=0;i<out.size();i++){next[i]=add(next[i],mul(a,out[i]));next[i+1]=add(next[i+1],out[i]);}next[0]=add(next[0],dd[k]);next.trim();out=std::move(next);}return out;
}
int main(int argc,char**argv){try{
 if(argc!=4)throw std::runtime_error("usage: resultants FIELD POLYNOMIAL_TXT OUTPUT_PREFIX");
 loadfield(argv[1]);std::ifstream in(argv[2]);int count;in>>count;if(count!=3)throw std::runtime_error("need three inputs");
 std::vector<F> abs_to_tower(390625);for(int i=1;i<390625;i++)abs_to_tower[i]=add(i%5,mul(25,abs_to_tower[i/5]));
 std::array<std::vector<Term>,3> pp;std::array<int,3> dh,dq;int mq=0;
 for(int k=0;k<3;k++){int n;in>>dh[k]>>dq[k]>>n;mq=std::max(mq,dq[k]);pp[k].resize(n);for(auto&t:pp[k]){int c;in>>t.h>>t.q>>c;t.c=abs_to_tower.at(c);}}
 if(!in)throw std::runtime_error("incomplete polynomial input");std::array<int,2> bounds{dh[0]*dq[1]+dh[1]*dq[0],dh[0]*dq[2]+dh[2]*dq[0]};int needed=std::max(bounds[0],bounds[1])+1;
 auto specialize=[&](F q){std::vector<F> pows(mq+1,1);for(int i=1;i<=mq;i++)pows[i]=mul(pows[i-1],q);std::array<Poly,3>a;for(int k=0;k<3;k++){a[k].resize(dh[k]+1);for(auto&t:pp[k])a[k][t.h]=add(a[k][t.h],mul(t.c,pows[t.q]));a[k].trim();}return a;};
 std::vector<F> xs;std::array<Poly,2> ys;int skipped=0;auto start=std::chrono::steady_clock::now();F nextq=0;
 for(;nextq<390625&&(int)xs.size()<needed;nextq++){
  auto p=specialize(nextq);bool ok=true;for(int k=0;k<3;k++)ok&=p[k].deg()==dh[k];if(!ok){skipped++;continue;}
  xs.push_back(nextq);for(int k=0;k<2;k++)ys[k].push_back(resultant(p[0],p[k+1]));
  if(xs.size()%2000==0)std::cerr<<"samples "<<xs.size()<<'/'<<needed<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
 }
 if((int)xs.size()!=needed)throw std::runtime_error("not enough distinct valid interpolation points");std::string pre=argv[3];
 {std::ofstream f(pre+"_samples.bin",std::ios::binary);int n=needed;f.write((char*)&n,4);f.write((char*)xs.data(),4*xs.size());for(auto&y:ys)f.write((char*)y.data(),4*y.size());}
 std::array<Poly,2> rs;for(int k=0;k<2;k++){rs[k]=newton_interpolation(xs,ys[k]);if(rs[k].deg()>bounds[k])throw std::runtime_error("resultant degree exceeds bound");std::cerr<<"interpolated "<<k<<" degree "<<rs[k].deg()<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';}
 int checks=0;for(F q=nextq;q<390625&&checks<2;q++){auto p=specialize(q);bool ok=true;for(int k=0;k<3;k++)ok&=p[k].deg()==dh[k];if(!ok)continue;for(int k=0;k<2;k++)if(eval(rs[k],q)!=resultant(p[0],p[k+1]))throw std::runtime_error("off-grid resultant mismatch");checks++;}
 if(checks!=2)throw std::runtime_error("missing off-grid checks");
 auto eg=xgcd(rs[0],rs[1]);if(rs[0]*eg[1]+rs[1]*eg[2]!=eg[0])throw std::runtime_error("Bezout mismatch");
 std::ofstream out(pre+".json");out<<"{\"status\":\"exact_resultants_and_gcd\",\"scope\":\"necessary projected leading degeneration; not a scale decision\",\"degree_bounds\":["<<bounds[0]<<','<<bounds[1]<<"],\"degrees\":["<<rs[0].deg()<<','<<rs[1].deg()<<"],\"samples\":"<<needed<<",\"skipped_degree_drops\":"<<skipped<<",\"off_grid_checks\":2,\"gcd_degree\":"<<eg[0].deg()<<",\"resultants\":[";jsonpoly(out,rs[0]);out<<',';jsonpoly(out,rs[1]);out<<"],\"gcd\":";jsonpoly(out,eg[0]);out<<",\"bezout\":[";jsonpoly(out,eg[1]);out<<',';jsonpoly(out,eg[2]);out<<"],\"calculation_cores\":1,\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
 std::cout<<"gcd degree "<<eg[0].deg()<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<'\n';
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
