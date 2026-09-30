// Exact determinant interpolation in a proved rectangular support box.
// Input coefficients use absolute base-5 alpha-polynomial coding; field
// arithmetic uses the project's independent tower-coded lookup tables.
#include "degree140_trace_engine_20260929.hpp"
#include <fstream>
#include <array>
#include <algorithm>
using namespace exact;
struct Term{int h,q;F c;};
std::vector<F> vi(const std::vector<F>&xs){
 Poly all{1};for(F x:xs)all=all*Poly{neg(x),1};Poly der=derivative(all);int n=xs.size();std::vector<F> out(n*n);
 for(int j=0;j<n;j++){Poly l=pdivide(all,Poly{neg(xs[j]),1});F den=inv(eval(der,xs[j]));for(int i=0;i<n;i++)out[i*n+j]=mul(l.coef(i),den);}return out;
}
int main(int argc,char**argv){try{
 if(argc!=4)throw std::runtime_error("usage: determinant FIELD MATRIX_TXT OUTPUT_PREFIX");
 loadfield(argv[1]);std::ifstream in(argv[2]);int dim,bh,bq;in>>dim>>bh>>bq;if(dim!=3)throw std::runtime_error("only3x3 supported");
 std::vector<F> abs_to_tower(390625);for(int i=1;i<390625;i++)abs_to_tower[i]=add(i%5,mul(25,abs_to_tower[i/5]));
 std::array<std::vector<Term>,9> p;int mh=0,mq=0;size_t terms=0;
 for(auto&f:p){int n;in>>n;f.resize(n);terms+=n;for(auto&t:f){int code;in>>t.h>>t.q>>code;t.c=abs_to_tower.at(code);mh=std::max(mh,t.h);mq=std::max(mq,t.q);}}
 if(!in)throw std::runtime_error("incomplete matrix");int nh=bh+1,nq=bq+1;if(nh>390625||nq>390625)throw std::runtime_error("grid exceeds field");
 std::vector<F> hs(nh),qs(nq);for(int i=0;i<nh;i++)hs[i]=i;for(int i=0;i<nq;i++)qs[i]=i;
 std::vector<F> vals(size_t(nh)*nq),temp(vals.size()),out(vals.size());auto start=std::chrono::steady_clock::now();
 for(int iq=0;iq<nq;iq++){
  std::vector<F> qp(mq+1,1);for(int i=1;i<=mq;i++)qp[i]=mul(qp[i-1],qs[iq]);
  std::array<Poly,9> hp;for(int k=0;k<9;k++){hp[k].resize(mh+1);for(auto&t:p[k])hp[k][t.h]=add(hp[k][t.h],mul(t.c,qp[t.q]));hp[k].trim();}
  for(int ih=0;ih<nh;ih++){
   std::array<F,9>a;for(int k=0;k<9;k++)a[k]=eval(hp[k],hs[ih]);
   vals[size_t(ih)*nq+iq]=add(sub(mul(a[0],sub(mul(a[4],a[8]),mul(a[5],a[7]))),mul(a[1],sub(mul(a[3],a[8]),mul(a[5],a[6])))),mul(a[2],sub(mul(a[3],a[7]),mul(a[4],a[6]))));
  }
 }
 auto vh=vi(hs),vq=vi(qs);
 for(int iq=0;iq<nq;iq++)for(int r=0;r<nh;r++){F z=0;for(int i=0;i<nh;i++)z=add(z,mul(vh[r*nh+i],vals[size_t(i)*nq+iq]));temp[size_t(r)*nq+iq]=z;}
 for(int ih=0;ih<nh;ih++)for(int r=0;r<nq;r++){F z=0;for(int i=0;i<nq;i++)z=add(z,mul(vq[r*nq+i],temp[size_t(ih)*nq+i]));out[size_t(ih)*nq+r]=z;}
 std::string pre=argv[3];{std::ofstream f(pre+"_coefficients.bin",std::ios::binary);f.write((char*)out.data(),4*out.size());}
 int ah=-1,aq=-1;size_t nt=0;for(int h=0;h<nh;h++)for(int q=0;q<nq;q++)if(out[size_t(h)*nq+q]){ah=std::max(ah,h);aq=std::max(aq,q);nt++;}
 // Two new off-grid checks detect conversion/index mistakes. The support
 // bound, not these checks, makes the reconstruction a global identity.
 for(int k=0;k<2;k++){
  F hh=10001+k,qq=20003+k;std::array<F,9>a{};for(int i=0;i<9;i++)for(auto&t:p[i])a[i]=add(a[i],mul(t.c,mul(power(hh,t.h),power(qq,t.q))));
  F actual=add(sub(mul(a[0],sub(mul(a[4],a[8]),mul(a[5],a[7]))),mul(a[1],sub(mul(a[3],a[8]),mul(a[5],a[6])))),mul(a[2],sub(mul(a[3],a[7]),mul(a[4],a[6]))));
  F got=0;for(int h=nh-1;h>=0;h--){F line=0;for(int q=nq-1;q>=0;q--)line=add(mul(line,qq),out[size_t(h)*nq+q]);got=add(mul(got,hh),line);}if(actual!=got)throw std::runtime_error("off-grid determinant mismatch");
 }
 std::ofstream js(pre+".json");js<<"{\"status\":\"exact_determinant_reconstructed\",\"grid\":["<<nh<<','<<nq<<"],\"degree_bound\":["<<bh<<','<<bq<<"],\"actual_degrees\":["<<ah<<','<<aq<<"],\"terms\":"<<nt<<",\"input_terms\":"<<terms<<",\"off_grid_checks\":2,\"calculation_cores\":1,\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
 std::cout<<"completed "<<nt<<" terms in "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<" seconds\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
