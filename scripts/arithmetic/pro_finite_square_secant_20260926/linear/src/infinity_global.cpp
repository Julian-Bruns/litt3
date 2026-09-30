// Exact certificates excluding H=infinity, for every allowed q.
// XP is a polynomial in x; each coefficient is a polynomial in q modulo MOD.
#define RESIDUAL_LIBRARY
#include "residual.cpp"
using XP=std::vector<Poly>;
Poly MOD;
Poly qm(Poly p){return mod(p,MOD);} Poly qa(Poly a,Poly b){return qm(a+b);} Poly qs(Poly a,Poly b){return qm(a-b);} Poly qt(Poly a,Poly b){return qm(a*b);} Poly qscale(Poly a,F b){return qm(scale(a,b));}
Poly qi(Poly a){auto[g,u,v]=xgcd(a,MOD);if(g!=Poly{1})throw std::runtime_error("quotient inverse nonunit");return qm(u);}
void xt(XP&a){while(!a.empty()&&a.back().empty())a.pop_back();}
XP xc(const Poly&p){XP z;for(F a:p)z.push_back(a?Poly{a}:Poly{});xt(z);return z;}
XP xm(XP a){for(auto &c:a)c=qm(c);xt(a);return a;}
XP xa(XP a,const XP&b){a.resize(std::max(a.size(),b.size()));for(unsigned i=0;i<b.size();i++)a[i]=qa(a[i],b[i]);xt(a);return a;}
XP xx(const XP&a,const XP&b){if(a.empty()||b.empty())return{};XP c(a.size()+b.size()-1);for(unsigned i=0;i<a.size();i++)for(unsigned j=0;j<b.size();j++)c[i+j]=qa(c[i+j],qt(a[i],b[j]));xt(c);return c;}
XP xs(XP a,F z){for(auto&c:a)c=qscale(c,z);xt(a);return a;}
XP xp(XP a,int n){XP b=xc({1});while(n){if(n&1)b=xx(b,a);a=xx(a,a);n>>=1;}return b;}
XP xf(const XP&a){if(a.empty())return{};XP b(5*a.size()-4);for(unsigned i=0;i<a.size();i++)b[5*i]=qm(frob(a[i]));xt(b);return b;}

void printxp(std::ostream&o,const XP&p){o<<'[';for(unsigned i=0;i<p.size();i++){if(i)o<<',';printpoly(o,p[i]);}o<<']';}
int main(int argc,char**argv){try{initdata();std::string dest=argc>1?argv[1]:"data";
 for(unsigned ix=0;ix<ROOTS.size();ix++){
  F r=ROOTS[ix];auto c=parametrize(r);
  auto get=[&](const Bi&n){Poly ans(2);for(auto[e,k]:n.t)if(e.first==2){assert(e.second>=0&&e.second<=3&&e.second%3==0);ans[e.second/3]=k;}trim(ans);return ans;};
  Poly u=get(c.kernelnum[0]),v=get(c.kernelnum[1]);assert(gcd(u,v)==Poly{1});
  std::array<XP,4>s;std::array<Poly,4>at;
  for(int k=5;k<=6;k++)for(int i=0;i<4;i++){assert(c.c.s[k][i].a[0].empty());assert(c.c.s[k][i].a[1].empty());}
  for(int i=0;i<4;i++)for(int j=0;j<3;j++)for(const auto &co:c.num[i][j])for(auto [e,z]:co.t)assert(e.first<=2);
  for(int i=0;i<4;i++){
   auto k1=quo(c.c.s[5][i].a[2],Poly{neg(r),1}),k2=quo(c.c.s[6][i].a[2],Poly{neg(r),1});
   at[i]=scale(u,eval(k1,r))+scale(v,eval(k2,r));
   s[i].resize(std::max(k1.size(),k2.size()));for(unsigned j=0;j<s[i].size();j++)s[i][j]=scale(u,coeff(k1,j))+scale(v,coeff(k2,j));xt(s[i]);
  }
  auto a=at[0],b=at[1],cc=at[2],d=at[3];F Qr=eval(Q,r);
  Poly V_at=scale(frob(a),mul(Qr,Qr))+scale(frob(b),Qr)+scale(frob(cc),2);
  Poly Vroot(2);for(int i=0;i<2;i++)Vroot[i]=fpow(coeff(V_at,5*i),78125);trim(Vroot);assert(frob(Vroot)==V_at);
  Poly K_at=power(a,2)*power(d,2)+a*b*cc*d+scale(power(b,3)*d,2)+scale(power(b,2)*power(cc,2),2)+scale(a*power(cc,3),2);
  assert(deg(a)==1&&deg(Vroot)==1&&deg(K_at)==4);
  Poly E=a*K_at;E=scale(E,inv(E.back()));assert(gcd(E,diff(E))==Poly{1});assert(gcd(E,Vroot)==Poly{1});
  F qv=neg(divi(Vroot[0],Vroot[1]));
  F av=eval(a,qv),bv=eval(b,qv),cv=eval(cc,qv),dv=eval(d,qv);
  F Wv=add(fpow(bv,5),mul(2,mul(fpow(av,5),Qr))),Kv=eval(K_at,qv);
  F z0=fpow(neg(Qr),78125),Sz0=add(add(mul(av,fpow(z0,3)),mul(bv,fpow(z0,2))),add(mul(cv,z0),dv));
  assert(add(add(mul(3,mul(av,fpow(z0,2))),mul(2,mul(bv,z0))),cv)==0);
  F Q2=mul(3,mul(eval(diff(P),r),fpow(eval(A,r),2)));
  assert(av&&Wv&&Kv&&Sz0&&Q2);
  // At all other q, the v-order is odd unless E(q)=0.
  // All five geometric roots of E are handled at once in its etale quotient.
  MOD=E;auto A0=xm(s[0]),B=xm(s[1]),C=xm(s[2]),D=xm(s[3]);auto Qx=xc(Q);
  XP VV=xa(xa(xx(xf(A0),xp(Qx,2)),xx(xf(B),Qx)),xs(xf(C),2));
  XP KK=xa(xa(xa(xa(xx(xp(A0,2),xp(D,2)),xx(xx(xx(A0,B),C),D)),xs(xx(xp(B,3),D),2)),xs(xx(xp(B,2),xp(C,2)),2)),xs(xx(A0,xp(C,3)),2));
  XP M=xx(xx(xx(xx(xc({neg(r),1}),xc(tp)),A0),VV),KK);
  assert(M.size()==97);Poly lc=M.back();auto[glc,ilc,slc]=xgcd(lc,E);assert(glc==Poly{1});assert(ilc*lc+slc*E==Poly{1});
  XP reversed=M;for(auto&co:reversed)co=qt(co,ilc);std::reverse(reversed.begin(),reversed.end());assert(reversed[0]==Poly{1});
  XP j(49);j[0]={1};for(int m=1;m<=48;m++){Poly t;for(int i=1;i<m;i++)t=qa(t,qt(j[i],j[m-i]));j[m]=qscale(qs(reversed[m],t),3);}
  XP jj=xx(j,j);Poly error49=qs(reversed[49],jj[49]);auto[ge,be,ce]=xgcd(error49,E);assert(ge==Poly{1});assert(be*error49+ce*E==Poly{1});
  std::ofstream o(dest+"/infinity_global_"+std::to_string(r)+".json");
  o<<"{\"r\":"<<r<<",\"u_q\":";printpoly(o,u);o<<",\"v_q\":";printpoly(o,v);o<<",\"a_at_r_q\":";printpoly(o,a);o<<",\"V_at_r_fifth_root_q\":";printpoly(o,Vroot);o<<",\"K_at_r_q\":";printpoly(o,K_at);o<<",\"E_q\":";printpoly(o,E);
  o<<",\"qV_case\":{\"q\":"<<qv<<",\"a_at_r\":"<<av<<",\"W_at_r\":"<<Wv<<",\"K_at_r\":"<<Kv<<",\"critical_root\":"<<z0<<",\"S_at_critical_root\":"<<Sz0<<",\"Q_local_quadratic_coefficient\":"<<Q2<<",\"slow_v_order\":23,\"equal_v_order\":21}";
  o<<",\"exception_algebra_certificate\":{\"degree_x\":96,\"M_coefficients_mod_E\":";printxp(o,M);o<<",\"leading_bezout\":[";printpoly(o,ilc);o<<',';printpoly(o,slc);o<<"],\"square_error_index\":49,\"square_error_mod_E\":";printpoly(o,error49);o<<",\"error_bezout\":[";printpoly(o,be);o<<',';printpoly(o,ce);o<<"]}}\n";
  std::cout<<"PASS all-q H-infinity r="<<r<<" E-degree=5 squarefree; leading x-degree=96 unit; square-error49 unit; qV="<<qv<<" slow/equal orders=23/21\n";
 }
 return 0;}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
