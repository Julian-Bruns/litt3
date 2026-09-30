// Exact fixed-degree Sylvester resultants, including every leading drop.
// Rectangular interpolation uses support bounds from the determinant
// expansion, not guessed degrees or a finite-field solution search.
#include "degree140_trace_engine_20260929.hpp"
#include <fstream>
#include <array>
#include <algorithm>
using namespace exact;
struct Term{int h,q;F c;};
using Coeff=std::vector<Term>;
using BP=std::vector<Coeff>;
struct Task{int a,b,dh,dq;};
std::vector<F> interpolation_inverse(const std::vector<F>&xs){
 Poly all{1};for(F x:xs)all=all*Poly{neg(x),1};Poly der=derivative(all);int n=xs.size();std::vector<F> out(n*n);
 for(int j=0;j<n;j++){Poly l=pdivide(all,Poly{neg(xs[j]),1});F den=inv(eval(der,xs[j]));for(int i=0;i<n;i++)out[i*n+j]=mul(l.coef(i),den);}return out;
}
F fixed_resultant(const std::vector<F>&a,const std::vector<F>&b){
 int m=a.size()-1,n=b.size()-1,d=m+n;std::array<std::array<F,6>,6>mat{};
 if(d>6)throw std::runtime_error("Sylvester matrix exceeds small capacity");
 for(int r=0;r<n;r++)for(int j=0;j<=m;j++)mat[r][r+j]=a[m-j];
 for(int r=0;r<m;r++)for(int j=0;j<=n;j++)mat[n+r][r+j]=b[n-j];
 F det=1;for(int k=0;k<d;k++){
  int r=k;while(r<d&&!mat[r][k])r++;if(r==d)return 0;
  if(r!=k){std::swap(mat[r],mat[k]);det=neg(det);}F pivot=mat[k][k];det=mul(det,pivot);
  for(int i=k+1;i<d;i++){F z=divide(mat[i][k],pivot);if(!z)continue;for(int j=k+1;j<d;j++)mat[i][j]=sub(mat[i][j],mul(z,mat[k][j]));}
 }return det;
}
int main(int argc,char**argv){try{
 if(argc!=4)throw std::runtime_error("usage: small_resultants FIELD INPUT_TEXT OUTPUT_PREFIX");
 loadfield(argv[1]);std::ifstream f(argv[2]);int np,nt;f>>np>>nt;std::vector<BP> pp(np);int mh=0,mq=0;
 std::vector<F> cv(390625);for(int i=1;i<390625;i++)cv[i]=add(i%5,mul(25,cv[i/5]));
 for(auto&p:pp){int n;f>>n;p.resize(n);for(auto&c:p){int k;f>>k;c.resize(k);for(auto&t:c){int z;f>>t.h>>t.q>>z;t.c=cv.at(z);mh=std::max(mh,t.h);mq=std::max(mq,t.q);}}}
 std::vector<Task> tasks(nt);for(auto&t:tasks)f>>t.a>>t.b>>t.dh>>t.dq;if(!f)throw std::runtime_error("incomplete input");
 auto begin=std::chrono::steady_clock::now();std::string pre=argv[3];
 for(int task=0;task<nt;task++){
  auto z=tasks[task];int nh=z.dh+1,nq=z.dq+1;std::vector<F>hs(nh),qs(nq);for(int i=0;i<nh;i++)hs[i]=i;for(int i=0;i<nq;i++)qs[i]=i;
  if(nh>390625||nq>390625)throw std::runtime_error("field too small for rectangle");
  std::vector<F> vals(size_t(nh)*nq),temp(vals.size()),out(vals.size());
  for(int iq=0;iq<nq;iq++){
   std::vector<F> powers(mq+1,1);for(int i=1;i<=mq;i++)powers[i]=mul(powers[i-1],qs[iq]);
   std::array<std::vector<Poly>,2> hp;
   for(int k=0;k<2;k++){auto&p=pp[k?z.b:z.a];hp[k].resize(p.size());for(size_t c=0;c<p.size();c++){hp[k][c].resize(mh+1);for(auto&t:p[c])hp[k][c][t.h]=add(hp[k][c][t.h],mul(t.c,powers[t.q]));hp[k][c].trim();}}
   for(int ih=0;ih<nh;ih++){
    std::array<std::vector<F>,2> a;for(int k=0;k<2;k++){a[k].resize(hp[k].size());for(size_t c=0;c<a[k].size();c++)a[k][c]=eval(hp[k][c],hs[ih]);}
    vals[size_t(ih)*nq+iq]=fixed_resultant(a[0],a[1]);
   }
  }
  auto vh=interpolation_inverse(hs),vq=interpolation_inverse(qs);
  for(int iq=0;iq<nq;iq++)for(int r=0;r<nh;r++){F a=0;for(int i=0;i<nh;i++)a=add(a,mul(vh[r*nh+i],vals[size_t(i)*nq+iq]));temp[size_t(r)*nq+iq]=a;}
  for(int ih=0;ih<nh;ih++)for(int r=0;r<nq;r++){F a=0;for(int i=0;i<nq;i++)a=add(a,mul(vq[r*nq+i],temp[size_t(ih)*nq+i]));out[size_t(ih)*nq+r]=a;}
  int ah=-1,aq=-1;size_t terms=0;for(int h=0;h<nh;h++)for(int q=0;q<nq;q++)if(out[size_t(h)*nq+q]){ah=std::max(ah,h);aq=std::max(aq,q);terms++;}
  for(int k=0;k<2;k++){
   F h=10001+k,q=20003+k;std::array<std::vector<F>,2>a;
   for(int s=0;s<2;s++){auto&p=pp[s?z.b:z.a];a[s].resize(p.size());for(size_t c=0;c<p.size();c++)for(auto&t:p[c])a[s][c]=add(a[s][c],mul(t.c,mul(power(h,t.h),power(q,t.q))));}
   F value=0;for(int i=nh-1;i>=0;i--){F line=0;for(int j=nq-1;j>=0;j--)line=add(mul(line,q),out[size_t(i)*nq+j]);value=add(mul(value,h),line);}
   if(value!=fixed_resultant(a[0],a[1]))throw std::runtime_error("off-grid mismatch");
  }
  std::string p=pre+"_"+std::to_string(task);{std::ofstream o(p+".bin",std::ios::binary);o.write((char*)out.data(),4*out.size());}
  std::ofstream js(p+".json");js<<"{\"pair\":["<<z.a<<','<<z.b<<"],\"grid\":["<<nh<<','<<nq<<"],\"actual_degrees\":["<<ah<<','<<aq<<"],\"terms\":"<<terms<<",\"fixed_degree_sylvester\":true,\"off_grid_checks\":2,\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count()<<"}\n";
  std::cerr<<"resultant "<<task<<" degrees "<<ah<<','<<aq<<" terms "<<terms<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count()<<'\n';
 }
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
