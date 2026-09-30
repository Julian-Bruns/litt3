// Independent sextic/Hensel calculation for the fixed data in data/input.json.
// Executed at precision 12; its pinned output is certificates/exploration.json.
#include "series.hpp"
#include <fstream>
#include <chrono>
using namespace d55;
const std::vector<int> AP={1,21,14,22,13}, PP={11,22,18,5,19,20,15,16,9,22,1};
const std::vector<int> LS={21,19,20,22}, JA={0,21,5,21}, JB={0,1,10,6}, JM={2,11,4,4};
const std::vector<int> weights={2,3,0,1,3,1,0,3,2,3,2,1,2,2,2,3,1,0,1,1,0,1,3,2,2,2,1,2,3};
struct EP {F root,L,a,b,m;EP(F r,F l):root(r),L(l),a(eval(JA,r)*l.pow(4)),b(eval(JB,r)*l.pow(8)),m(eval(JM,r)*l.pow(5)) {}};
int main(int argc,char**argv){try{
init_field();int n=argc>1?std::stoi(argv[1]):12;if(n<5 || n>128) throw std::runtime_error("precision must be between 5 and 128");int N=n+2;
F alpha=F::basis(7),j=F::code(7),zeta=ordinary(45685)+ordinary(35188)*j;
std::cerr<<"field initialized; zeta^29="<<zeta.pow(29)<<"\n";
if(zeta.pow(29)!=F(1)||zeta==F(1))throw std::runtime_error("zeta order");
F chi=F(2)*F::code(22),half=F(3);
std::vector<EP>Z,I;Z.emplace_back(alpha,eval(LS,alpha));F az=alpha.pow(625);Z.emplace_back(az,eval(LS,az));F ai=alpha.pow(25);I.emplace_back(ai,zeta.pow(2)*eval(LS,ai));ai=alpha.pow(15625);I.emplace_back(ai,zeta.pow(2)*eval(LS,ai));
auto av=[&](const std::vector<EP>&a,F EP::*f){return (a[0].*f+a[1].*f)*half;};
auto moment=[&](int a){F z;for(int i=0;i<29;i++)z+=F(weights[i])*zeta.pow(((i*a)%29+29)%29);return z;};
F en=av(I,&EP::m)+chi*moment(-6),ed=av(Z,&EP::b)+chi*moment(-2),eps=en/ed,ei=eps.inv();
if(eps*(av(Z,&EP::m)+chi*moment(6))!=av(I,&EP::b)+chi*moment(2))throw std::runtime_error("trace identity 2");
std::cerr<<"epsilon="<<eps<<"\n";
Ser T(N),U(N);
for(int k=0;k<N;k++) T[k]=-chi*(moment(-k)-ei*moment(-k-4));
T[0]=av(Z,&EP::root);T[1]=av(Z,&EP::a);T[2]+=ei*av(I,&EP::m);T[3]+=ei*av(I,&EP::L);
U[0]=av(Z,&EP::L);U[1]=av(Z,&EP::m);U[2]=ei*(av(I,&EP::a)-chi*(eps*moment(5)-moment(1)));
U[3]=ei*(av(I,&EP::root)-chi*(eps*moment(4)-moment(0)));
for(int k=4;k<N;k++) U[k]=-chi*(moment(7-k)-ei*moment(3-k));
if(T[2]!=av(Z,&EP::b))throw std::runtime_error("zero endpoint b trace");
// K_s(Y) = a4*s*Y^4 + a3*eps^-1*s^4*Y^3 + ... .
std::vector<Ser>K(5,Ser(N));for(int i=0;i<5;i++){int v=13-3*i;if(v<N)K[i][v]=F::code(AP[i])*ei.pow(4-i);}
Ser KU(N),KpU(N),KW(N),KV(N);for(int i=0;i<5;i++){
 KU=add(KU,mul(K[i],spow(U,i,N),N),N);
 if(i>=1)KpU=add(KpU,scale(mul(K[i],spow(U,i-1,N),N),F(i)),N);
 if(i>=2)KW=add(KW,scale(mul(K[i],spow(U,i-2,N),N),F(i*(i-1)/2)),N);
 if(i>=3)KV=add(KV,scale(mul(K[i],spow(U,i-3,N),N),F(i==3?1:4)),N);
}
Ser AT=peval(AP,T,N),ATp(N),AW(N),AV(N);
for(int i=1;i<5;i++)ATp=add(ATp,scale(spow(T,i-1,N),F::code(AP[i])*F(i)),N);
for(int i=2;i<5;i++)AW=add(AW,scale(spow(T,i-2,N),F::code(AP[i])*F(i*(i-1)/2)),N);
AV=scale(T,F(4)*F::code(AP[4]));AV[0]+=F::code(AP[3]);
RP DD(4,Ser(N)),NN(2,Ser(N)),WW(3,Ser(N)),QQ(5,Ser(N));
DD[0]=AV;DD[3]=neg(KV);NN[0]=neg(ATp);NN[1]=KpU;WW[0]=AW;WW[2]=neg(KW);QQ[0]=sc(F::code(AP[4]),N);QQ[4]=neg(K[4]);
RP FF=rpadd(rpadd(rpmul(RP{sub(AT,KU,N)},rpmul(DD,DD,N),N),rpmul(WW,rpmul(NN,DD,N),N),N),rpmul(QQ,rpmul(NN,NN,N),N),N);
for(auto &ss:FF)if(!ss[0].zero())throw std::runtime_error("F not divisible by s");
RP G=FF;for(auto &ss:G){ss.erase(ss.begin());ss.resize(n);}
F u0=(Z[0].root-Z[1].root)*half, r0=(Z[0].L-Z[1].L)/(Z[0].root-Z[1].root);
Ser rr=sc(r0,n);F constant=rpeval(G,rr,1)[0],jac=rpeval(rpderiv(G),rr,1)[0];
std::cerr<<"G(0,r0)="<<constant<<"\nJ="<<jac<<"\n";
if(!constant.zero())throw std::runtime_error("endpoint not on G");
if(jac.zero())throw std::runtime_error("multiple branch");
for(int prec=1;prec<n;){int m=std::min(2*prec,n);rr=sub(rr,div(rpeval(G,rr,m),rpeval(rpderiv(G),rr,m),m),m);prec=m;}
if(firstnonzero(rpeval(G,rr,n))!=-1)throw std::runtime_error("Hensel residual");
Ser hh=div(rpeval(NN,rr,n),rpeval(DD,rr,n),n);
if(hh[0]!=u0*u0)throw std::runtime_error("h0");
Ser uu=sc(u0,n);for(int prec=1;prec<n;){int m=std::min(2*prec,n);uu=scale(add(uu,div(hh,uu,m),m),half);prec=m;}
if(firstnonzero(sub(mul(uu,uu,n),hh,n))!=-1)throw std::runtime_error("sqrt residual");
Ser XX=add(T,uu,n),YY=add(U,mul(rr,uu,n),n);
std::cerr<<"X1 checks "<<(XX[0]==Z[0].root)<<","<<(XX[1]==Z[0].a)<<","<<(XX[2]==Z[0].b)<<" Y checks "<<(YY[0]==Z[0].L)<<","<<(YY[1]==Z[0].m)<<"\n";
Ser PX=peval(PP,XX,n),Phat(n);for(int i=0;i<=10;i++)Phat=add(Phat,shift(scale(spow(YY,i,n),F::code(PP[i])*eps.pow(i)),30-3*i,n),n);
Ser YD=sub(shift(deriv(YY),1,n),scale(YY,F(3)),n);
Ser lhs=scale(mul(spow(YD,3,n),spow(PX,2,n),n),eps.pow(20));
Ser rhs=mul(spow(deriv(XX),3,n),spow(Phat,2,n),n);
Ser residual=sub(lhs,rhs,n-1);int first=firstnonzero(residual);
if(first!=3)throw std::runtime_error("expected nonzero tensor coefficient at order three");
std::cerr<<"tensor differential first nonzero="<<first<<"\n";if(first>=0)std::cerr<<"obstruction="<<residual[first]<<"\n";
// Also verify both signs of the first identity directly.
for(int sg:{1,-1}){Ser X=add(T,scale(uu,F(sg)),n),Y=add(U,scale(mul(rr,uu,n),F(sg)),n),KY(n);for(int i=0;i<5;i++)KY=add(KY,mul(K[i],spow(Y,i,n),n),n);if(firstnonzero(sub(peval(AP,X,n),KY,n))!=-1)throw std::runtime_error("quartic residual");}
std::ofstream out("certificates/exploration.json");out<<"{\n\"precision\":"<<n<<",\n\"epsilon\":"<<eps<<",\n\"r0\":"<<r0<<",\n\"hensel_jacobian\":"<<jac<<",\n\"T\":"<<json(resize(T,n))<<",\n\"U\":"<<json(resize(U,n))<<",\n\"ratio\":"<<json(rr)<<",\n\"h\":"<<json(hh)<<",\n\"X\":"<<json(XX)<<",\n\"Y\":"<<json(YY)<<",\n\"differential_residual\":"<<json(residual)<<",\n\"first_nonzero\":"<<first<<"\n}\n";
std::cout<<"completed precision "<<n<<", tensor obstruction at "<<first<<"\n";
return 0;}catch(const std::exception&e){std::cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
