#define PARAMETRIZE_LIBRARY
#include "parametrize.cpp"
#include "rational_jets.hpp"
Rat fullF6(const RationalChart&s,int n=7){DEN=s.den;dpowers.clear();
 RJet a=rjscale(rationalize(at_infinity(s.num[0],35,n),1),3),b=rjscale(rationalize(at_infinity(s.num[1],46,n),1),2),c=rationalize(at_infinity(s.num[2],57,n),1);assert(a[0].zero());assert(b[0].d==0&&b[0].n==Bi(mul(2,eps)));
 RJet rho(n);rho[0]=scale(c[0],neg(inv(mul(2,eps))));
 for(int i=1;i<n;i++){auto eq=rjadd(rjadd(rjmul(a,rjmul(rho,rho,n),n),rjmul(b,rho,n),n),c,n);rho[i]=scale(eq[i],neg(inv(mul(2,eps))));}
 auto eq=rjadd(rjadd(rjmul(a,rjmul(rho,rho,n),n),rjmul(b,rho,n),n),c,n);for(auto&x:eq)assert(x.zero());
 BiFun qfun;qfun[0].resize(Q.size());for(unsigned i=0;i<Q.size();i++)qfun[0][i]=Bi(Q[i]);RJet qq=rationalize(at_infinity(qfun,57,n),0);
 RJet L=rjadd(qq,rjshift(rjpow(rho,5,n),2,n),n);
 RJet M=rjadd(rationalize(at_infinity(s.num[3],70,n),1),rjshift(rjadd(rjmul(a,rjpow(rho,3,n),n),rjscale(rjmul(b,rjpow(rho,2,n),n),2),n),2,n),n);
 auto r=rjmul(L,M,n);
 auto tt=power(tp,3);auto yy=powtrunc(Yseries(n),10,n);
 RJet T(n);for(unsigned i=0;i<tt.size();i++){int st=27-3*int(i);if(st<0)throw std::runtime_error("bad t pole");for(unsigned k=0;k<yy.size()&&st+int(k)<n;k++)if(st+int(k)>=0)T[st+k]=T[st+k]+Rat(mul(tt[i],yy[k]));}
 r=rjadd(r,T,n);for(int i=0;i<6;i++)assert(r[i].zero());return r[n-1]; // n=7 gives F6; n=8 gives F7.
}
#ifndef PSI_LIBRARY
int main(int argc,char**argv){try{initdata();std::string dest=argc>1?argv[1]:"data";for(F root:ROOTS){auto c=parametrize(root);auto f=fullF6(c);assert(f.d<=2);Bi psi=toHq(shift(f.n*dpow(2-f.d),0,3));int degH=-1,minq=10000,maxq=-1;for(auto[e,cc]:psi.t){degH=std::max(degH,e.first);minq=std::min(minq,e.second);maxq=std::max(maxq,e.second);}assert(degH==3);assert(minq>=0);
 Poly leading(maxq+1);for(auto[e,cc]:psi.t)if(e.first==3)leading[e.second]=cc;trim(leading);unsigned ix=std::find(ROOTS.begin(),ROOTS.end(),root)-ROOTS.begin();assert(eval(leading,QBOUND[ix])==0);assert(eval(leading,QPIVOT[ix])==0);
 auto lc=leading;int qpower=0;while(coeff(lc,0)==0){lc=shift(lc,-1);qpower++;}auto divonce=[&](F v){int n=0;Poly factor={neg(v),1};while(!lc.empty()&&mod(lc,factor).empty()){lc=quo(lc,factor);n++;}return n;};int np=divonce(QPIVOT[ix]),nb=divonce(QBOUND[ix]);assert(deg(lc)==0);
 std::ofstream o(dest+"/psi_"+std::to_string(root)+".json");o<<"{\"r\":"<<root<<",\"denominator\":\"q*(q-qpivot)^2\",\"Psi_H_q\":";printbi(o,psi);o<<",\"leading_H_coefficient\":";printpoly(o,leading);o<<",\"factorization\":{\"unit\":"<<lc[0]<<",\"q_multiplicity\":"<<qpower<<",\"qpivot_multiplicity\":"<<np<<",\"qboundary_multiplicity\":"<<nb<<"}}\n";
 std::cout<<"PASS symbolic F0..F5=0 r="<<root<<" F6 denominator power="<<f.d<<" Psi H-degree="<<degH<<" q-degree="<<maxq<<" terms="<<psi.t.size()<<" leading-H factors q^"<<qpower<<" pivot^"<<np<<" boundary^"<<nb<<'\n';}return 0;}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
#endif
