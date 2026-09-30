#include "io.hpp"
int main(int argc,char**argv){try{F::init();string dir=argc>1?argv[1]:"evidence";PF P=coded({11,22,18,5,19,20,15,16,9,22,1}),A=coded({1,21,14,22,13}),Q=coded({0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24}),L=coded({18,20,20,15});CF::P=P;CL::P=lift(P);PF t=A.exact(PF({-F::raw(25),F(1)})*F::raw(13)),M=(Q-ppow(L,5)).exact(ppow(t,3));auto G=readsource(dir+"/source.txt");
 CL aa=G[0]*LP(3),b=(G[1]-CL(lift(L))*G[0]*LP(3))*LP(2),c=G[2]-CL(lift(L))*G[1]*LP(2)+CL(lift(ppow(L,2)))*G[0]*LP(3),d=G[3]-CL(lift(L))*G[2]+CL(lift(ppow(L,2)))*G[1]-CL(lift(ppow(L,3)))*G[0];CL cc,ell,mdn=CL(lift(M))*d+lift(CF::mon(0,10));for(int j=0;j<3;j++){cc.a[j]=c.a[j].exact(lift(t));ell.a[j]=mdn.a[j].exact(lift(ppow(t,2)));}
 F zeta;for(int i=2;i<25;i++)if(fpow(F::raw(i),3)==F(1)){zeta=F::raw(i);break;}cerr<<"zeta code "<<zeta<<"\n";
 for(int rc:{145049,211895,211959}){F r=F::raw(rc),pr=P.eval(r),mr=M.eval(r);assert(!t.eval(r));assert(pr&&mr&&t.deriv().eval(r));
  // Every local coefficient has cubic weight one. Divide by w and substitute q=P(r)/v^3.
  auto local=[&](const CL&g){LP s;for(int j=0;j<3;j++){LP val=g.a[j].eval(LP(r));for(auto[e,c]:val.a){assert(e[2]==0&&e[3]==0);int a=e[0],we=e[1]-a+j-1;assert(we%3==0);s.put({a,j-we,0,0},c*fpow(pr,we/3));}}return s;};
  LP al=local(aa),bl=local(b),cl=local(cc),dl=local(d),el=local(ell);assert(dl==LP::mon({0,1,0,0},-fpow(pr,3)/mr));
  LP J=frob(bl)*el-dl*frob(cl)+LP(F(2)*mr)*lpow(bl,4)*lpow(cl,2);LP Jn=monic_laurent(J);
  LP Jprime;for(auto[e,c]:Jn.a)Jprime.put(e,c*fpow(zeta,e[1]));Jprime=monic_laurent(Jprime);
  stats("endpoint "+to_string(rc)+" B",bl);stats("C",cl);stats("ell",el);stats("J",Jn);stats("Jprime",Jprime);
  ofstream out(dir+"/endpoint_"+to_string(rc)+".txt");out<<"ENDPOINT_V1 H v unused unused\n"<<rc<<" "<<pr<<" "<<mr<<" "<<zeta<<"\n";for(auto p:{al,bl,cl,dl,el,J,Jn,Jprime})saveLP(out,p);
 }
 }catch(exception&e){cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
