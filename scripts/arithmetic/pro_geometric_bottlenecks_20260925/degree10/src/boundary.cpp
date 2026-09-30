#include "point_io.hpp"
using namespace alg;
struct Leading {F c2,b46,b45,c57,c56,n68,s125,s124,prefactor;};
Leading leading(const Pt&p,const Poly&t,bool lin){
 Leading r;r.c2=lin?coeff(p.D2[1],1):coeff(p.D2[0],4);
 r.b46=coeff(p.N[3][1],12);r.b45=coeff(p.N[3][0],15);r.c57=coeff(p.N[4][0],19);r.c56=coeff(p.N[4][2],12);r.n68=coeff(p.N[5][2],16);
 F z=div(mul(2,r.c57),r.b46);
 auto fp=fpoly(p,t);F c124=coeff(fp[0][1],38);
 r.s125=add(mul(mul(8,p.k),alg::pow(z,5)),mul(24,add(div(mul(r.c57,r.c57),r.b46),r.n68)));
 r.s124=add(c124,mul(24,add(mul(r.b45,mul(z,z)),mul(r.c56,z))));
 r.prefactor=mul(3,mul(alg::pow(r.c2,3),alg::pow(r.b46,8)));
 return r;
}
int main(int argc,char**argv){try{
 init();if(argc<3)throw runtime_error("usage boundary data_dir output.json");string dir=argv[1];Poly t=scale(exact(A,Poly{neg(25),1}),inv(13));Ar ker=ap(ax(0,2),pm(P,pp(t,2)));std::mt19937 rng(20260925);
 ofstream out(argv[2]);out<<"{\"checks\":[";bool comma=false;vector<pair<Pt,Poly>> examples;
 F E=add(add(24,mul(4,25)),mul(23,alg::pow(25,3)));
 for(int cid=0;cid<=10;cid++){
  Fam f=readfam(dir+"/space_"+to_string(cid)+".txt");
  // Two reproducible parameter choices; these test identities, not existence.
  for(int iteration=0;iteration<2;iteration++){
   vector<F>z(7);for(F&a:z)a=rng()%q;z[6]=1+iteration;
   Pt p=point(f,z);if(pole(p.D2)!=(cid?13:12))throw runtime_error("unexpected failure of open");
   if(coeff(p.N[3][1],12)!=mul(E,p.k))throw runtime_error("fixed N3 coefficient");
   auto r=leading(p,t,cid);Poly R=residual(p,t,cid,f.r);
   if(coeff(R,144)!=alg::pow(mul(r.prefactor,r.s125),3)){cerr<<"cid="<<cid<<" actual="<<coeff(R,144)<<" predicted="<<alg::pow(mul(r.prefactor,r.s125),3)<<" c2="<<r.c2<<" B="<<r.b46<<" c57="<<r.c57<<" n68="<<r.n68<<" S="<<r.s125<<" pref="<<r.prefactor<<"\n";throw runtime_error("top coefficient identity");}
   F shift=neg(alg::div(r.s125,24));p.N[5]=aa(p.N[5],ac(ker,shift));
   auto rr=leading(p,t,cid);if(rr.s125)throw runtime_error("boundary shift");Poly RR=residual(p,t,cid,f.r);
   if(coeff(RR,143)!=alg::pow(mul(rr.prefactor,rr.s124),3))throw runtime_error("next coefficient identity");
   if(comma)out<<",";comma=true;out<<"{\"case\":"<<cid<<",\"parameters\":";jpoly(out,z);out<<",\"boundary_shift\":"<<shift<<",\"initial_degree\":"<<deg(R)<<",\"boundary_degree\":"<<deg(RR)<<"}";
  }
  // Produce an exact degree <=142 point, by fixing the y-free direction,
  // solving the coefficient-124 condition linearly in a y^2 direction, then
  // killing coefficient 125 by the kernel direction.
  vector<F>base(7);base[0]=1;base[6]=1;Pt p=point(f,base);auto r=leading(p,t,cid);
  int hidx=cid?2:1;vector<F>dd(7);dd[hidx]=1;Pt d=point(f,dd,false);
  F z11=div(mul(2,r.c57),r.b46);F delta=mul(24,mul(coeff(d.N[4][2],12),z11));
  if(!delta)throw runtime_error("no boundary solving direction");F h=neg(div(r.s124,delta));base[hidx]=h;p=point(f,base);r=leading(p,t,cid);
  if(r.s124)throw runtime_error("second boundary not solved");F shift=neg(alg::div(r.s125,24));p.N[5]=aa(p.N[5],ac(ker,shift));r=leading(p,t,cid);
  if(r.s125||r.s124)throw runtime_error("boundary conditions not both zero");
  if(!p.k||pole(p.D2)!=(cid?13:12))throw runtime_error("constructed degree-drop point not open");
  Poly R=residual(p,t,cid,f.r);if(deg(R)>142)throw runtime_error("degree did not drop twice");
  cout<<"case="<<cid<<" exact double-boundary degree="<<deg(R)<<" square="<<squaretest(R).first<<" H_parameter="<<h<<" N5_shift="<<shift<<"\n";
  ofstream ex(dir+"/boundary_"+to_string(cid)+".json");ex<<"{\"case\":"<<cid<<",\"base_parameters\":";jpoly(ex,base);ex<<",\"N5_kernel_shift\":"<<shift<<",\"kappa\":"<<p.k<<",\"D2\":";jar(ex,p.D2);ex<<",\"N\":[";for(int i=0;i<6;i++){if(i)ex<<",";jar(ex,p.N[i]);}ex<<"],\"R0\":";jpoly(ex,R);ex<<",\"square\":"<<(squaretest(R).first?"true":"false")<<"}\n";
 }
 vector<F>zz(7);zz[6]=1;Pt kpt=point(readfam(dir+"/space_0.txt"),zz,false);F d124=coeff(fpoly(kpt,t)[0][1],38);
 out<<"],\"E\":"<<E<<",\"d124\":"<<d124<<"}\n";
 cout<<"22 initial and 22 boundary leading-coefficient checks pass. E="<<E<<" d124="<<d124<<"\n";
 }catch(exception&e){cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
