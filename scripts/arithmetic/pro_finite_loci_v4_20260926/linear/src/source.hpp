#pragma once
#include "poly.hpp"
namespace input {
inline Poly x,A,Q,B0,L0,t;
inline F alpha,eps,eta,Ca,Cd;
inline const std::vector<int> roots={9,14,2514,7367,20130,104315,139659,154113,281660,364472};
inline const std::vector<int> qr={10149,287131,206388,98115,363438,222658,366267,256870,262368,151691};
inline const std::vector<int> qp={118020,113341,133780,96788,248365,389423,152600,227317,132264,310452};
inline void init(){
 kfield::init();x=Poly::mon(1);alpha=F::code(25);
 P=Poly::codes({11,22,18,5,19,20,15,16,9,22,1});
 A=Poly::codes({1,21,14,22,13});Q=Poly::codes({0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24});
 B0=Poly::codes({8,14,19,2,10,19,3,24,18,16});L0=Poly::codes({18,20,20,15});
 t=A.exactdiv((x-Poly(alpha))*F::code(13));
 eps=F::code(24)+F::code(4)*alpha+F::code(23)*alpha.pow(3);
 eta=F::code(11)+F::code(18)*alpha.pow(2)+F::code(20)*alpha.pow(3);
 Cd=F::code(3)+F::code(10)*alpha+alpha.pow(2)+F::code(14)*alpha.pow(3);
 Ca=F::code(18)+F::code(14)*alpha+F::code(10)*alpha.pow(2)+F::code(19)*alpha.pow(3);
}
}
struct Source{std::array<Curve,4> g;};
struct Coord{int n,i,j;};
inline std::vector<Coord> coordinates(){std::vector<Coord> c;for(int n=0;n<4;n++)for(auto [i,j]:monomials(std::vector<int>{14,46,57,70}[n]))c.push_back({n,i,j});return c;}
inline Source source_from_vector(const std::vector<F>& v){Source s;auto cc=coordinates();if(v.size()!=cc.size())throw std::runtime_error("source vector length");for(size_t k=0;k<v.size();k++)s.g[cc[k].n]+=Curve::mon(cc[k].i,cc[k].j,v[k]);s.g[0]=s.g[0]*Curve::mon(0,2);return s;}
inline Source operator+(Source a,const Source& b){for(int i=0;i<4;i++)a.g[i]+=b.g[i];return a;}
inline Source operator*(const Source& a,F c){Source s;for(int i=0;i<4;i++)s.g[i]=a.g[i]*c;return s;}
inline std::array<Curve,6> original_N(const Source& s,F r){std::array<Curve,6> N;N[0]=Curve(input::x-Poly(r));for(int i=0;i<4;i++)N[i+2]=s.g[i];N[5]+=N[0]*input::Q;return N;}
inline int binom(int n,int k){if(k<0||k>n)return 0;int b=1;for(int i=1;i<=k;i++)b=b*(n-i+1)/i;return b;}
inline void append_mod(std::vector<F>& out,const Poly& a,const Poly& mod){Poly r=a%mod;for(int i=0;i<mod.deg();i++)out.push_back(r[i]);}
inline std::vector<F> constraints(const Source& s,F r){
 using namespace input;
 std::vector<F> out;auto N=original_N(s,r);
 for(int j=1;j<=5;j++){
  Curve val;for(int i=0;i<=j;i++)val+=N[i]*(-B0).pow(j-i)*F(binom(5-i,j-i));
  for(int c=0;c<3;c++){int e=std::max(0,(j-c+2)/3);append_mod(out,val.c[c],P.pow(e));}
 }
 Poly QL=Q-L0.pow(5);
 for(int j=0;j<=4;j++){
  Curve val;
  for(int i=0;i<=5-j;i++)val+=N[i]*(-L0).pow(5-i-j)*F(binom(5-i,j));
  val=val*QL;
  if(j==0)val+=Curve::mon(0,1)*P.pow(3)*t.pow(3);
  for(int c=0;c<3;c++)append_mod(out,val.c[c],t.pow(5-j));
 }
 // Equation (3): the only extra high-pole constraints not imposed by the atlas.
 Curve high=N[5]*Q+Curve::mon(0,1)*P.pow(3)*t.pow(3);
 // Atlas gives pole at most 127, so slots 126 and 127 are exhaustive.
 out.push_back(high.c[0][42]);out.push_back(high.c[1][39]);
 // Equation (4), D2(r,0)=0.
 Curve d2=s.g[0].divide_y(2);out.push_back(d2.c[0].eval(r));
 return out;
}
struct RREF {std::vector<std::vector<F>> rows;std::vector<int> piv,free;bool consistent=true;};
inline RREF rref(std::vector<std::vector<F>> mat,int n){
 RREF r;int row=0;
 for(int col=0;col<n;col++){
  int p=row;while(p<(int)mat.size()&&!mat[p][col])p++;
  if(p==(int)mat.size()){r.free.push_back(col);continue;}
  std::swap(mat[p],mat[row]);F inv=mat[row][col].inv();for(int k=col;k<(int)mat[row].size();k++)mat[row][k]*=inv;
  for(int i=0;i<(int)mat.size();i++)if(i!=row&&mat[i][col]){F a=mat[i][col];mat[i][col]=F();for(int k=col+1;k<(int)mat[i].size();k++)mat[i][k]-=a*mat[row][k];}
  r.piv.push_back(col);row++;
 }
 for(int i=row;i<(int)mat.size();i++)if(mat[i].size()>size_t(n)&&mat[i][n])r.consistent=false;
 r.rows=std::move(mat);return r;
}
struct AffineSpace{
 F r;std::vector<F> particular;std::vector<std::vector<F>> basis;int rank=0,nrow=0;
 Source base;std::vector<Source> dirs;
};
inline AffineSpace reconstruct(F r){
 auto coords=coordinates();int n=coords.size();Source s0;auto c0=constraints(s0,r);int m=c0.size();
 std::vector<std::vector<F>> mat(m,std::vector<F>(n+1));
 for(int i=0;i<m;i++)mat[i][n]=-c0[i];
 for(int j=0;j<n;j++){std::vector<F> v(n);v[j]=F(1);auto c=constraints(source_from_vector(v),r);for(int i=0;i<m;i++)mat[i][j]=c[i]-c0[i];}
 auto rr=rref(mat,n);if(!rr.consistent)throw std::runtime_error("inconsistent source system");
 AffineSpace sp;sp.r=r;sp.nrow=m;sp.rank=rr.piv.size();sp.particular.resize(n);
 for(size_t i=0;i<rr.piv.size();i++)sp.particular[rr.piv[i]]=rr.rows[i][n];
 for(int j:rr.free){std::vector<F> v(n);v[j]=F(1);for(size_t i=0;i<rr.piv.size();i++)v[rr.piv[i]]=-rr.rows[i][j];sp.basis.push_back(v);}
 sp.base=source_from_vector(sp.particular);for(auto v:sp.basis)sp.dirs.push_back(source_from_vector(v));
 for(F c:constraints(sp.base,r))if(c)throw std::runtime_error("source particular check failed");
 for(auto d:sp.dirs){auto c=constraints(sp.base+d,r);for(F a:c)if(a)throw std::runtime_error("source direction check failed");}
 return sp;
}
inline std::vector<F> top_coordinates(const Source& s){Curve d2=s.g[0].divide_y(2);return {d2.c[1][1],s.g[2].c[0][19],s.g[2].c[2][12],s.g[3].c[2][16]};}
inline void write_vector(std::ostream& o,const std::vector<F>& v){o<<"[";for(size_t j=0;j<v.size();j++){if(j)o<<",";o<<v[j];}o<<"]";}
inline void write_source(std::ostream& o,const Source& s){o<<"[";for(int j=0;j<4;j++){if(j)o<<",";o<<"[";for(int c=0;c<3;c++){if(c)o<<",";write_vector(o,s.g[j].c[c].c);}o<<"]";}o<<"]";}
