// Rectangular parameter bounds for the short-coordinate residue
// circuit of Tr(t*x^j*delta(Lambda)/eta), j=0,1,2.
// This runs no earlier trace calculation. The coordinate difference has
// zero quadratic trace; the endpoint correction is linear in G2.
#define MULTIPLIED_BOUND_LIBRARY
#include "degree140_multiplied_trace_bounds_20260929.cpp"
#undef main
namespace inversebound {
using namespace multipliedbound;
BS bp(BS a,int n){return n<0?pow(inverse(a),-n):pow(a,n);}
Polar polar(const BP&sp,const BP&ds,const BS&tt,const BS&dt,const BS&B,const BP&ph,int n){
 BP nn=padd(BP{dt},pscale(sp,B));
 std::array<BP,5> dd{BP{times(pow(tt,2),pow(B,2))},pscale(nn,times(tt,B)),padd(ppow(nn,2),pscale(ds,times(tt,B))),pmul(nn,ds),ppow(ds,2)};
 Polar out;int k=4-2*n;
 for(int j=0;j<k;j++){
  BP cj;for(int i=0;i<=std::min(j,4);i++)if(binomial(-n-1,j-i))cj=padd(cj,pscale(pmul(dd[i],ppow(sp,j-i)),bp(tt,-n-1-j+i)));
  out.hp=padd(out.hp,part(cj,ppow(ph,k-j)));out.pieces.push_back({cj,k-j});
 }return out;
}
std::array<std::vector<B>,3> profiles(){
 S yu0=infinitytrace::yunit();BS yu=constant_series(yu0),y=shift(yu,-10),om=constant_series(scal(infinitytrace::shift(infinitytrace::inverse(infinitytrace::pow(yu0,2)),16),4)),df=inverse(om);
 std::array<BS,4> gs;for(int i=0;i<4;i++)for(auto&t:family[i])if(t.c)gs[i]=plus(gs[i],times(mono(-3*t.i,bound::mon(t.h,t.w)),pow(y,t.j)));
 gs[0]=force(gs[0],-32,bound::mon(1,0));gs[1]=force(gs[1],-46,bound::mon());gs[2]=force(gs[2],-57,bound::mon(0,1));
 BS a=shift(gs[0],35),b=shift(gs[1],46),c=shift(gs[2],57),rho=mono(0,bound::mon(0,1));
 for(int n=1;n<CAP;n*=2){int old=CAP;CAP=std::min(old,2*n);BS ax=cut(a,CAP),bx=cut(b,CAP),cx=cut(c,CAP);BS fun=plus(plus(times(ax,pow(rho,2)),times(bx,rho)),cx);rho=plus(rho,quotient(fun,plus(times(ax,rho),bx)));rho=cut(rho,CAP,true);CAP=old;}
 rho.prec=std::min({CAP,a.prec,b.prec,c.prec});rho.trim();rho=force(rho,0,bound::mon(0,1));BS zs=shift(rho,-11),zl=force(plus(quotient(gs[1],gs[0]),zs),-14,bound::mon(-1,0));
 BS tf=bound::polynomial(T),tt=pow(tf,3),dt=times(deriv(tt),df),B=pow(bound::polynomial(A),2),bo=bound::polynomial(Poly{18,20,20,15}),y5=fifth(y);
 BS aa=quotient(gs[0],pow(y,2)),bb=quotient(plus(gs[1],times(bo,gs[0])),pow(y,3));
 BS cc=quotient(plus(plus(gs[2],times(bo,gs[1])),times(pow(bo,2),gs[0])),pow(y,4));
 BS ee=quotient(plus(plus(gs[3],times(bo,gs[2])),plus(times(pow(bo,2),gs[1]),times(pow(bo,3),gs[0]))),y5);
 BP sp{ee,cc,bb,aa},ds,ph(6);ph[0]=quotient(plus(bound::polynomial(Q),fifth(bo)),y5);ph[5]=bound::mono(0);for(auto&s:sp)ds.push_back(times(deriv(s),df));
 std::array<Polar,2> ps{polar(sp,ds,tt,dt,B,ph,0),polar(sp,ds,tt,dt,B,ph,1)};
 std::array<std::vector<bound::B>,3> out;for(int j=0;j<3;j++)out[j].resize(j+4);
 for(int i=0;i<2;i++){
  BS z=i?zs:zl,phi=quotient(plus(fifth(z),bound::polynomial(Q)),y5);phi=force(phi,i?-7:-20,i?bound::mon():bound::mon(-5,0));
  BS ss=quotient(plus(plus(times(gs[0],pow(z,3)),times(gs[1],pow(z,2))),plus(times(gs[2],z),gs[3])),y5);
  BS lam=plus(quotient(ss,phi),quotient(tt,pow(phi,2)));lam=force(lam,i?-7:-4,i?bound::mon(0,-3,1):bound::mon(3,0));
  BS eta=quotient(plus(gs[1],times(gs[0],z)),pow(y,3));eta=force(eta,-16,bound::mon());BS ei=inverse(eta),wb=quotient(plus(z,bo),y),li=inverse(lam);
  BS val=times(times(times(ei,pow(deriv(lam),2)),df),times(li,tf));
  for(int n=0;n<=5;n++){
   BS pol;
   if(n<2){pol=peval(ps[n].hp,wb);for(auto&[c,k]:ps[n].pieces)pol=plus(pol,quotient(peval(c,wb),pow(phi,k)));pol=times(times(times(pol,ei),om),tf);}
   for(int j=0;j<3;j++)if(n<(int)out[j].size())out[j][n]=add(out[j][n],add(val.at(3*j-1),pol.at(3*j-1)));
   val=times(val,li);
  }
 }
 // The closed endpoint correction is affine-linear in h, w powers -4..11.
 return out;
}
}
int main(int argc,char**argv){try{
 if(argc!=3&&argc!=4)return 2;bool endpoints=argc==4&&std::stoi(argv[3]);exact::loadfield(argv[1]);criticaltrace::load(argv[2]);CAP=160;auto p=inversebound::profiles();
 if(endpoints){bound::B b=bound::mon();b.hi[0]=1;b.lo[1]=-4;b.hi[1]=11;for(auto&o:p)o[0]=bound::add(o[0],b);}
 std::cout<<"{\"includes_closed_endpoint_bound\":"<<(endpoints?"true":"false")<<",\"coefficient_bounds\":[";bool comma=false;int mh=0,mq=0;
 for(int j=0;j<3;j++)for(size_t n=0;n<p[j].size();n++){
  auto b=p[j][n];if(b.zero)continue;if(comma)std::cout<<',';comma=true;int ah=std::max(0,-b.lo[0]),ap=std::max(0,-b.lo[2]);
  int qmin=b.lo[1]-b.hi[0]+int(n)+1,qmax=b.hi[1]-b.lo[0]+int(n)+1,aq=std::max(0,(2-qmin)/3);
  int dh=ah+b.hi[0]+ap+b.hi[2],dq=(3*aq+qmax)/3+7*(ap+b.hi[2]);mh=std::max(mh,dh);mq=std::max(mq,dq);
  std::cout<<"{\"j\":"<<j<<",\"n\":"<<n<<",\"lo\":["<<b.lo[0]<<','<<b.lo[1]<<','<<b.lo[2]<<"],\"hi\":["<<b.hi[0]<<','<<b.hi[1]<<','<<b.hi[2]<<"],\"denominator_H_q_Psi\":["<<ah<<','<<aq<<','<<ap<<"],\"numerator_bidegree\":["<<dh<<','<<dq<<"]}";
 }
 std::cout<<"],\"maximum_H\":"<<mh<<",\"maximum_q\":"<<mq<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
