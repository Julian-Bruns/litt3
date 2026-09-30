#include "root9_trace_support_20260930.hpp"
namespace root9bound {
using BP=std::vector<BS>;
BP pa(BP a,const BP&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=plus(a[i],b[i]);return a;}
BP ps(BP a,const BS&b){for(auto&c:a)c=times(c,b);return a;}
BP pm(const BP&a,const BP&b){if(a.empty()||b.empty())return {};BP c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=plus(c[i+j],times(a[i],b[j]));return c;}
BP pp(BP a,int n){BP b{mono(0)};while(n){if(n&1)b=pm(b,a);n>>=1;if(n)a=pm(a,a);}return b;}
BS pe(const BP&a,const BS&x){BS r;for(int i=(int)a.size()-1;i>=0;i--)r=plus(times(r,x),a[i]);return r;}
BS power_series(BS a,int n){return n<0?pow(inverse(a),-n):pow(a,n);}
std::vector<std::vector<B>> profiles(const std::vector<std::pair<int,int>>&fs){
 S yu0=infinitytrace::yunit();BS yu=constant_series(yu0),y=shift(yu,-10),om=constant_series(infinitytrace::scal(infinitytrace::shift(infinitytrace::inverse(infinitytrace::pow(yu0,2)),16),4)),df=inverse(om);
 std::array<BS,4> gs;
 for(int i=0;i<4;i++)for(auto&t:root9trace::numerator[i])gs[i]=plus(gs[i],times(mono(-3*t.i,mon(t.h,t.w-4,0,-1)),pow(y,t.j)));
 gs[0]=force(gs[0],-33,mon(1));gs[1]=force(gs[1],-46,mon());gs[2]=force(gs[2],-57,mon(0,1));
 BS a=shift(gs[0],35),b=shift(gs[1],46),c=shift(gs[2],57),rho=mono(0,mon(0,1));
 for(int n=1;n<CAP;n*=2){int old=CAP;CAP=std::min(old,2*n);BS ax=cut(a,CAP),bx=cut(b,CAP),cx=cut(c,CAP);rho=plus(rho,quotient(plus(plus(times(ax,pow(rho,2)),times(bx,rho)),cx),plus(times(ax,rho),bx)));rho=cut(rho,CAP,true);CAP=old;}
 rho.prec=std::min({CAP,a.prec,b.prec,c.prec});rho.trim();rho=force(rho,0,mon(0,1));
 BS zs=shift(rho,-11),zl=force(plus(quotient(gs[1],gs[0]),zs),-13,mon(-1));
 BS y5=fifth(y),v=polynomial(root9trace::V),tf=polynomial(T),tt=quotient(pow(tf,3),v),dt=times(deriv(tt),df),bp=pow(polynomial(A),2),bo=polynomial(Poly{18,20,20,15});
 BS aa=quotient(gs[0],times(pow(y,2),v)),bb=quotient(plus(gs[1],times(bo,gs[0])),times(pow(y,3),v));
 BS cc=quotient(plus(plus(gs[2],times(bo,gs[1])),times(pow(bo,2),gs[0])),times(pow(y,4),v));
 BS ee=quotient(plus(plus(gs[3],times(bo,gs[2])),plus(times(pow(bo,2),gs[1]),times(pow(bo,3),gs[0]))),times(y5,v));
 BP sp{ee,cc,bb,aa},ds;for(auto&s:sp)ds.push_back(times(deriv(s),df));
 BP sp2=pp(sp,2),sp3=pm(sp2,sp),nh=pa(pa(ps(sp3,pow(bp,2)),ps(sp2,times(dt,bp))),ps(pm(sp,ds),times(tt,bp)));
 BP hp(5);for(int j=0;j<5;j++)if(j+5<(int)nh.size())hp[j]=times(nh[j+5],power_series(tt,-2));
 std::vector<std::vector<B>> out;int maxn=0;for(auto[ix,iy]:fs){int n=(17+3*ix+10*iy)/4;maxn=std::max(maxn,n);out.push_back(std::vector<B>(n+1));}
 for(int i=0;i<2;i++){
  BS z=i?zs:zl,phi=quotient(plus(fifth(z),polynomial(Q)),y5);phi=force(phi,i?-7:-15,i?mon():mon(-5));
  BS ss=quotient(plus(plus(times(gs[0],pow(z,3)),times(gs[1],pow(z,2))),plus(times(gs[2],z),gs[3])),times(y5,v));
  BS lam=plus(quotient(ss,phi),quotient(tt,pow(phi,2)));lam=force(lam,-4,i?mon(0,-3,1,-1):mon(3));
  BS eta=force(quotient(plus(gs[1],times(gs[0],z)),pow(y,3)),-16,mon()),ei=inverse(eta),wb=quotient(plus(z,bo),y);
  BS dS=times(deriv(ss),df),np=plus(dt,times(bp,ss)),pi=inverse(phi);
  BS c2=plus(times(bp,dS),quotient(pow(np,2),tt)),c3=quotient(times(np,plus(times(ss,np),times(tt,dS))),pow(tt,2));
  BS ps0=plus(plus(plus(times(times(tt,pow(bp,2)),pow(pi,4)),times(times(bp,dt),pow(pi,3))),plus(times(c2,pow(pi,2)),times(c3,pi))),pe(hp,wb));
  BS ps1=plus(times(pow(bp,2),pow(pi,2)),quotient(times(times(bp,np),pi),tt));BS common=times(times(ei,om),times(tf,v));ps0=times(ps0,common);ps1=times(ps1,common);
  BS li=inverse(lam),val=times(times(times(ei,pow(deriv(lam),2)),df),times(li,times(tf,v)));
  for(int n=0;n<=maxn;n++){
   BS pol;if(n==0)pol=ps0;if(n==1)pol=ps1;std::array<BS,3> ys{plus(val,pol),times(plus(val,pol),y),times(plus(val,pol),pow(y,2))};
   for(size_t j=0;j<fs.size();j++)if(n<(int)out[j].size())out[j][n]=add(out[j][n],ys[fs[j].second].at(3*fs[j].first-1));
   val=times(val,li);
  }
 }
 B ep;for(auto&t:root9trace::numerator[0])ep=add(ep,mon(t.h,t.w-4,0,-1));for(auto&o:out)o[0]=add(o[0],ep);
 return out;
}
}
int main(int argc,char**argv){try{
 if(argc!=3)throw std::runtime_error("usage: bounds FIELD SOURCE");exact::loadfield(argv[1]);root9trace::load(argv[2]);infinitytrace::CAP=160;
 std::vector<std::pair<int,int>> fs{{0,0},{1,0},{2,0},{3,0},{0,1},{4,0},{1,1}};auto p=root9bound::profiles(fs);
 std::cout<<"{\"scope\":\"rigorous rectangular overbounds for new root9 traces\",\"coefficient_bounds\":[";bool comma=false;int mh=0,mq=0;
 for(size_t j=0;j<p.size();j++)for(size_t n=0;n<p[j].size();n++){
  auto b=p[j][n];if(b.zero)continue;int ah=std::max(0,-b.lo[0]),ap=std::max(0,-b.lo[2]),ad=std::max(0,-b.lo[3]);
  int qlo=b.lo[1]+b.lo[0]+int(n)+1-fs[j].second,qhi=b.hi[1]+b.hi[0]+int(n)+1-fs[j].second,aq=std::max(0,(2-qlo)/3);
  int bh=ah+b.hi[0]+3*(ap+b.hi[2]),bq=(3*aq+qhi)/3+8*(ap+b.hi[2])+ad+b.hi[3];mh=std::max(mh,bh);mq=std::max(mq,bq);
  if(comma)std::cout<<',';comma=true;std::cout<<"{\"j\":"<<j<<",\"n\":"<<n<<",\"lo\":[";
  for(int k=0;k<4;k++){if(k)std::cout<<',';std::cout<<b.lo[k];}std::cout<<"],\"hi\":[";for(int k=0;k<4;k++){if(k)std::cout<<',';std::cout<<b.hi[k];}
  std::cout<<"],\"denominator_H_q_Psi_D\":["<<ah<<','<<aq<<','<<ap<<','<<ad<<"],\"numerator_bidegree\":["<<bh<<','<<bq<<"]}";
 }
 std::cout<<"],\"maximum_H\":"<<mh<<",\"maximum_q\":"<<mq<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
