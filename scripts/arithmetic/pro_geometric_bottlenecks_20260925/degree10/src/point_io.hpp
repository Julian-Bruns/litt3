#ifndef DEGREE10_POINT_IO_HPP
#define DEGREE10_POINT_IO_HPP
#include "algebra.hpp"
using namespace alg;
struct Fam {int cid=0;F r=0;vector<array<int,3>> vars;vector<F> particular;vector<vector<F>> directions;};
// Plain whitespace interchange: cid r n; n variable triples; affine vector; 7 directions.
inline Fam readfam(const string&path){ifstream in(path);if(!in)throw runtime_error("cannot open "+path);Fam f;int n;in>>f.cid>>f.r>>n;f.vars.resize(n);for(auto&v:f.vars)in>>v[0]>>v[1]>>v[2];f.particular.resize(n);for(auto&c:f.particular)in>>c;f.directions.assign(7,vector<F>(n));for(auto&d:f.directions)for(auto&c:d)in>>c;if(!in)throw runtime_error("truncated family file");return f;}
struct Pt {array<Ar,6> N;Ar D2;F k=0;};
inline Pt point(const Fam&f,const vector<F>&z,bool origin=true){Pt p;vector<F>w(f.particular.size());if(origin){w=f.particular;p.N[0][0]=f.cid?Poly{neg(f.r),1}:Poly{1};}for(int i=0;i<7;i++)for(size_t j=0;j<w.size();j++)w[j]=add(w[j],mul(z[i],f.directions[i][j]));for(size_t j=0;j<w.size();j++)if(w[j]){auto v=f.vars[j];if(v[0]==6)p.k=w[j];else if(v[0]==2)p.D2=aa(p.D2,ax(v[1],v[2],w[j]));else p.N[v[0]]=aa(p.N[v[0]],ax(v[1],v[2],w[j]));}p.N[2]=am(ax(0,2),p.D2);return p;}
inline vector<Ar> fpoly(const Pt&p,const Poly&t){vector<Ar> F(11);for(int i=0;i<6;i++){F[10-i]=aa(F[10-i],p.N[i]);F[5-i]=aa(F[5-i],ap(p.N[i],Q));}F[0]=aa(F[0],ac(ap(ax(0,10),pp(t,3)),p.k));return F;}
// Homogeneous binary quadratic norm: resultants via a 2 by 2 companion recurrence.
// h_j = a^(j-1) Z^j mod (a Z^2+b Z+c) = u_j Z+v_j for j>=1.
// For n=10, R = (c U^2-b UV+a V^2)/a^9 with
// a^9 F mod D = U Z+V.  The exact divisions are in the integral domain.
inline Ar resultant_quadratic(const vector<Ar>&F,const Ar&a,const Ar&b,const Ar&c){
 // Instead of division in k(X), calculate homogeneous resultant directly using
 // the 2x2 multiplication matrix M for aZ, with M^2+bM+ac=0.
 // M=[[0,-ac],[1,-b]].  det(sum F_i a^(n-i) M^i) / a^n = Res(D,F).
 int n=F.size()-1;
 vector<Ar> apow(n+1);apow[0]=ax(0,0);for(int i=1;i<=n;i++)apow[i]=am(apow[i-1],a);
 Ar acv=am(a,c),u,v=ax(0,0),U,V;
 for(int i=0;i<=n;i++){
  Ar ff=am(F[i],apow[n-i]);U=aa(U,am(ff,u));V=aa(V,am(ff,v));
  Ar un=as(v,am(b,u)),vn=ac(am(acv,u),4);u=un;v=vn;
 }
 Ar numerator=aa(as(am(V,V),am(b,am(U,V))),am(acv,am(U,U)));
 // divide by a^n in k[x,y]/(y^3-P) using its cubic adjugate.
 // a is general; use rational norm quotient.
 Ar an=apow[n];
 Ar adj;
 adj[0]=ps(pm(an[0],an[0]),pm(pm(an[1],an[2]),P));
 adj[1]=ps(pm(pm(an[2],an[2]),P),pm(an[0],an[1]));
 adj[2]=ps(pm(an[1],an[1]),pm(an[0],an[2]));
 return adiv(am(numerator,adj),norm(an));
}
// A much smaller subresultant recurrence avoiding high a powers via homogeneous
// resultant specialized to a quadratic. b,c arbitrary ring elements. The resultant
// is determinant of Sylvester matrix, evaluated by a subset DP (size 12).
inline Ar resultant_dp(const vector<Ar>&F,const array<Ar,3>&D){
 constexpr int m=2,n=10,N=12;
 // Expand along the two F rows first. Their 2-column minors multiply the
 // complementary maximal minors of the banded quadratic block.
 // Sylvester determinant via general subset DP, keeping only nonzero entries.
 vector<Ar> dp(1<<N);dp[0]=ax(0,0);
 for(int mask=0;mask<(1<<N);mask++){
  if(az(dp[mask]))continue;
  int row=__builtin_popcount((unsigned)mask);
  if(row==N)continue;
  for(int j=0;j<N;j++)if(!(mask>>j&1)){
   Ar e;
   if(row<2){int idx=n-(j-row);if(idx>=0&&idx<=n)e=F[idx];}
   else {int idx=m-(j-(row-2));if(idx>=0&&idx<=m)e=D[idx];}
   if(az(e))continue;
   int sign=__builtin_popcount((unsigned)(mask>>(j+1)))%2;
   Ar w=am(dp[mask],e);if(sign)w=ac(w,4);dp[mask|(1<<j)]=aa(dp[mask|(1<<j)],w);
  }
 }
 return dp.back();
}
inline Poly residual(const Pt&p,const Poly&t,bool lin,F r){
 if(az(p.N[2]))throw runtime_error("zero quadratic leading coefficient");
 auto F=fpoly(p,t);
 auto res=resultant_dp(F,{p.N[4],ac(p.N[3],2),ac(p.N[2],3)});
 Poly den=pm(pp(P,40),pp(t,15));if(lin)den=pm(den,pp(Poly{neg(r),1},3));
 return exact(norm(res),den);
}
// Square over the algebraic closure: normalize leading coefficient, then the
// monic root exists over the coefficient field iff the polynomial is a geometric square.
inline pair<bool,Poly> squaretest(const Poly&R){if(R.empty()||deg(R)%2)return {false,{}};Poly f=monic(R);int m=deg(f)/2;Poly j(m+1);j[m]=1;for(int d=1;d<=m;d++){F z=coeff(f,2*m-d);for(int a=m-d+1;a<=m-1;a++)z=sub(z,mul(j[a],j[2*m-d-a]));j[m-d]=mul(z,3);}return {pm(j,j)==f,j};}
#endif
