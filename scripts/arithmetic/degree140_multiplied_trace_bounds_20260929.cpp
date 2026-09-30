// Reuse the previously proved rectangular-support arithmetic, without
// executing the previous positive-trace calculation.
#define main previous_positive_bound_driver
#include "degree140_trace_degree_bounds_20260929.cpp"
#undef main
namespace multipliedbound {
using namespace bound;
using BP=std::vector<BS>;
BP padd(BP a,const BP&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=plus(a[i],b[i]);return a;}
BP pscale(BP a,const BS&b){for(auto&x:a)x=times(x,b);return a;}
BP pmul(const BP&a,const BP&b){if(a.empty()||b.empty())return {};BP c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=plus(c[i+j],times(a[i],b[j]));return c;}
BS peval(const BP&a,const BS&x){BS o;for(int i=(int)a.size()-1;i>=0;i--)o=plus(times(o,x),a[i]);return o;}
BP ppow(BP a,int n){BP out{bound::mono(0)};while(n){if(n&1)out=pmul(out,a);n>>=1;if(n)a=pmul(a,a);}return out;}
BP part(BP a,const BP&b){if(a.size()<b.size())return {};BP out(a.size()-b.size()+1);for(int i=(int)out.size()-1;i>=0;i--){out[i]=a[i+b.size()-1];for(size_t j=0;j+1<b.size();j++)a[i+j]=plus(a[i+j],times(out[i],b[j]));}return out;}
int binomial(int n,int k){int64_t b=1;for(int j=1;j<=k;j++)b=b*(n-j+1)/j;return ((b%5)+5)%5;}
struct Polar{std::vector<std::pair<BP,int>> pieces;BP hp;};
std::array<std::vector<B>,3> profiles(bool companion=false){
 S yu0=infinitytrace::yunit();BS yu=constant_series(yu0),y=shift(yu,-10),om=constant_series(scal(infinitytrace::shift(infinitytrace::inverse(infinitytrace::pow(yu0,2)),16),4)),df=inverse(om);
 std::array<BS,4> gs;for(int i=0;i<4;i++)for(auto&t:family[i])if(t.c)gs[i]=plus(gs[i],times(mono(-3*t.i,bound::mon(t.h,t.w)),pow(y,t.j)));
 gs[0]=force(gs[0],-32,bound::mon(1,0));gs[1]=force(gs[1],-46,bound::mon());gs[2]=force(gs[2],-57,bound::mon(0,1));
 BS a=shift(gs[0],35),b=shift(gs[1],46),c=shift(gs[2],57),rho=mono(0,bound::mon(0,1));
 for(int n=1;n<CAP;n*=2){int old=CAP;CAP=std::min(old,2*n);BS ax=cut(a,CAP),bx=cut(b,CAP),cx=cut(c,CAP);BS fun=plus(plus(times(ax,pow(rho,2)),times(bx,rho)),cx);rho=plus(rho,quotient(fun,plus(times(ax,rho),bx)));rho=cut(rho,CAP,true);CAP=old;}
 rho.prec=std::min({CAP,a.prec,b.prec,c.prec});rho.trim();rho=force(rho,0,bound::mon(0,1));BS zs=shift(rho,-11),zl=force(plus(quotient(gs[1],gs[0]),zs),-14,bound::mon(-1,0));
 BS y5=fifth(y),tf=bound::polynomial(T),tt=pow(tf,3),dt=times(deriv(tt),df),bp=pow(bound::polynomial(A),2),bo=bound::polynomial(Poly{18,20,20,15});
 BS aa=quotient(gs[0],pow(y,2)),bb=quotient(plus(gs[1],times(bo,gs[0])),pow(y,3));
 BS cc=quotient(plus(plus(gs[2],times(bo,gs[1])),times(pow(bo,2),gs[0])),pow(y,4));
 BS ee=quotient(plus(plus(gs[3],times(bo,gs[2])),plus(times(pow(bo,2),gs[1]),times(pow(bo,3),gs[0]))),y5);
 BP sp{ee,cc,bb,aa},ds;for(auto&s:sp)ds.push_back(times(deriv(s),df));auto s2=pmul(sp,sp),s3=pmul(s2,sp);
 auto nh=padd(padd(pscale(s3,pow(bp,2)),pscale(s2,times(dt,bp))),pscale(pmul(sp,ds),times(tt,bp)));BP hp(5);BS ti2=inverse(pow(tt,2));for(int j=0;j<5;j++)hp[j]=j+5<(int)nh.size()?times(nh[j+5],ti2):BS();
 std::array<Polar,3> pol;
 if(companion){
  BP ph(6);ph[0]=quotient(plus(bound::polynomial(Q),fifth(bo)),y5);ph[5]=bound::mono(0);
  BP nn=padd(BP{dt},pscale(sp,bp));
  std::array<BP,5> dd{BP{times(pow(tt,2),pow(bp,2))},pscale(nn,times(tt,bp)),padd(ppow(nn,2),pscale(ds,times(tt,bp))),pmul(nn,ds),ppow(ds,2)};
  for(int n=0;n<3;n++)for(int j=0;j<5-2*n;j++){
   BP cj;for(int i=0;i<=std::min(j,4);i++)if(binomial(-n-1,j-i))cj=padd(cj,pscale(pmul(dd[i],ppow(sp,j-i)),inverse(pow(tt,n+1+j-i))));
   pol[n].hp=padd(pol[n].hp,part(cj,ppow(ph,5-2*n-j)));pol[n].pieces.push_back({cj,5-2*n-j});
  }
 }
 std::array<std::vector<B>,3> out;for(int j=0;j<3;j++)out[j].resize(companion?(j?15:14):12+j);
 for(int i=0;i<2;i++){
  BS z=i?zs:zl,phi=quotient(plus(fifth(z),bound::polynomial(Q)),y5);phi=force(phi,i?-7:-20,i?bound::mon():bound::mon(-5,0));
  BS ss=quotient(plus(plus(times(gs[0],pow(z,3)),times(gs[1],pow(z,2))),plus(times(gs[2],z),gs[3])),y5);
  BS lam=plus(quotient(ss,phi),quotient(tt,pow(phi,2)));lam=force(lam,i?-7:-4,i?bound::mon(0,-3,1):bound::mon(3,0));
  BS eta=quotient(plus(gs[1],times(gs[0],z)),pow(y,3));eta=force(eta,-16,bound::mon());BS wb=quotient(plus(z,bo),y);
  if(companion){
   BS factor=pow(tf,4);std::array<BS,3> pss;
   for(int n=0;n<3;n++){pss[n]=peval(pol[n].hp,wb);for(auto&[c,d]:pol[n].pieces)pss[n]=plus(pss[n],quotient(peval(c,wb),pow(phi,d)));pss[n]=times(times(times(pss[n],eta),om),factor);}
   BS li=inverse(lam),omg=times(times(times(times(eta,inverse(phi)),pow(deriv(lam),2)),df),times(li,factor));
   for(int n=0;n<=14;n++){for(int j=0;j<3;j++)if(n<(int)out[j].size()){B v=omg.at(3*j-1);if(n<3)v=add(v,pss[n].at(3*j-1));out[j][n]=add(out[j][n],v);}omg=times(omg,li);}
   continue;
  }
  BS dS=times(deriv(ss),df),np=plus(dt,times(bp,ss)),pi=inverse(phi);
  BS c2=plus(times(bp,dS),quotient(pow(np,2),tt)),c3=quotient(times(np,plus(times(ss,np),times(tt,dS))),pow(tt,2));
  BS ps0=plus(plus(plus(times(times(tt,pow(bp,2)),pow(pi,4)),times(times(bp,dt),pow(pi,3))),plus(times(c2,pow(pi,2)),times(c3,pi))),peval(hp,wb));
  BS ps1=plus(times(pow(bp,2),pow(pi,2)),quotient(times(times(bp,np),pi),tt));BS common=times(times(eta,om),tf);ps0=times(ps0,common);ps1=times(ps1,common);
  BS li=inverse(lam),omg=times(times(times(eta,pow(deriv(lam),2)),df),times(li,tf));
  for(int n=0;n<=13;n++){
   for(int j=0;j<3;j++)if(n<(int)out[j].size()){B v=omg.at(3*j-1);if(n==0)v=add(v,ps0.at(3*j-1));if(n==1)v=add(v,ps1.at(3*j-1));out[j][n]=add(out[j][n],v);}
   omg=times(omg,li);
  }
 }
 // G2*(G3-3L0G2)^2 has h-degree<=3 and w exponents -12..33.
 B endpoint=bound::mon();endpoint.lo[0]=0;endpoint.hi[0]=3;endpoint.lo[1]=-12;endpoint.hi[1]=33;
 if(companion){endpoint.hi[0]=4;endpoint.lo[1]=-16;endpoint.hi[1]=44;}
 for(auto&o:out)o[0]=add(o[0],endpoint);return out;
}
}
#ifndef MULTIPLIED_BOUND_LIBRARY
int main(int argc,char**argv){try{
 if(argc!=3&&argc!=4)return 2;bool companion=argc==4&&std::stoi(argv[3]);exact::loadfield(argv[1]);criticaltrace::load(argv[2]);CAP=companion?220:160;auto p=multipliedbound::profiles(companion);
 std::cout<<"{\"coefficient_bounds\":[";bool comma=false;int mh=0,mq=0;
 for(int j=0;j<3;j++)for(size_t n=0;n<p[j].size();n++){
  auto b=p[j][n];if(b.zero)continue;if(comma)std::cout<<',';comma=true;int ah=std::max(0,-b.lo[0]),ap=std::max(0,-b.lo[2]);
  int qmin=b.lo[1]-b.hi[0]+int(n)-(companion?0:1),qmax=b.hi[1]-b.lo[0]+int(n)-(companion?0:1),aq=std::max(0,(2-qmin)/3);
  int dh=ah+b.hi[0]+ap+b.hi[2],dq=(3*aq+qmax)/3+7*(ap+b.hi[2]);mh=std::max(mh,dh);mq=std::max(mq,dq);
  std::cout<<"{\"j\":"<<j<<",\"n\":"<<n<<",\"lo\":["<<b.lo[0]<<','<<b.lo[1]<<','<<b.lo[2]<<"],\"hi\":["<<b.hi[0]<<','<<b.hi[1]<<','<<b.hi[2]<<"],\"denominator_H_q_Psi\":["<<ah<<','<<aq<<','<<ap<<"],\"numerator_bidegree\":["<<dh<<','<<dq<<"]}";
 }
 std::cout<<"],\"maximum_H\":"<<mh<<",\"maximum_q\":"<<mq<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
#endif
