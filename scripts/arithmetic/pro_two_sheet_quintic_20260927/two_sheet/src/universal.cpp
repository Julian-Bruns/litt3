#include "io.hpp"
CL fifth(const CL&g){CL out;for(int j=0;j<3;j++)for(int i=0;i<=g.a[j].deg();i++)out+=CL::mon(5*i,5*j,frob(g.a[j][i]));return out;}
CL divz(CL g,int n){CL r;for(int j=0;j<3;j++){int k=(j-n)%3;if(k<0)k+=3;int z=(j-n-k)/3;if(z<0)r.a[k]=g.a[j].exact(ppow(CL::P,-z));else r.a[k]=g.a[j]*ppow(CL::P,z);}return r;}
int main(int argc,char**argv){try{F::init();string dir=argc>1?argv[1]:"evidence";PF P=coded({11,22,18,5,19,20,15,16,9,22,1}),A=coded({1,21,14,22,13}),Q0=coded({0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24}),B=coded({8,14,19,2,10,19,3,24,18,16});PF t=A.exact(PF({-F::raw(25),F(1)})*F::raw(13));LP q=LP::var(1);CL::P=lift(P)*q.inverse();auto src=readsource(dir+"/source.txt");array<CL,4>G;for(int k=0;k<4;k++)for(int j=0;j<3;j++)for(int i=0;i<=src[k].a[j].deg();i++){LP cc;for(auto[e,c]:src[k].a[j][i].a){assert(e[2]==0&&e[3]==0);int n=e[1]-e[0]+j-1;assert(n%3==0);cc.put({e[0],n/3,0,0},c);}G[k].a[j]+=PL::mon(i,cc);}
 CL BB(lift(B)),g2=divz(G[0],2),g3=divz(G[1]-BB*G[0]*LP(3),3),g4=divz(G[2]-BB*G[1]*LP(2)+cpow(BB,2)*G[0]*LP(3),4),g5=divz(G[3]-BB*G[2]+cpow(BB,2)*G[1]-cpow(BB,3)*G[0],5),Q=divz(CL(lift(Q0-ppow(B,5))),5);
 CL a=g2*LP(3),b=g3*LP(2),c=g4,d=g5,T0(lift(ppow(t,3))*lpow(q,3));
 CL a2=a*a,a3=a2*a,a4=a2*a2,a5=fifth(a),a6=a3*a3,a7=a5*a2,a8=a4*a4,a10=fifth(a2);
 CL b2=b*b,b3=b2*b,b4=b2*b2,b5=fifth(b),b6=b3*b3,b8=b4*b4,b10=fifth(b2);
 CL c2=c*c,c3=c2*c,c4=c2*c2,c5=fifth(c);
 cerr<<"universal powers constructed\n";
 CL V=b3-a*b*c+a2*d*LP(2),NS=a3*d*d-a2*b*c*d+a2*c3+a*b3*d+a*b2*c2*LP(2);
 CL K0=-a2*c4*LP(2)+a*b2*c3*LP(2)-b5*d-b4*c2*LP(2);
 CL TU0=a7*c4*LP(2)-a6*b2*c3*LP(2)-a5*b5*d+a5*b4*c2*LP(2)+a4*b6*c-a3*b8;
 CL T=c5-b5*Q+a5*Q*Q;
 array<CL,3>D;
 D[2]=T*T;cerr<<"D2 constructed\n";
 D[1]=T*(K0+Q*a3*V)+T0*(b10-a5*c5*LP(2)-Q*a5*b5*LP(2)+Q*Q*a10*LP(2));cerr<<"D1 constructed\n";
 D[0]=a2*T*NS+T0*(TU0+Q*a8*V)+a10*T0*T0;cerr<<"D0 constructed\n";
 ofstream out(dir+"/universal_D.txt");out<<"UNIVERSAL_D_V1 H q unused unused; z^3=P/q; ascending mu\n";size_t total=0;for(int k=0;k<3;k++)for(int j=0;j<3;j++){D[k].a[j].trim();out<<k<<" "<<j<<" "<<D[k].a[j].deg()<<"\n";for(auto&co:D[k].a[j].a){saveLP(out,co);total+=co.a.size();}cerr<<"D mu "<<k<<" z "<<j<<" xdegree "<<D[k].a[j].deg()<<"\n";}cerr<<"D total Laurent terms "<<total<<"\n";
 // Divide D by t^5 on the affine curve before taking the norm.
 ofstream small(dir+"/universal_E.txt");small<<"UNIVERSAL_E_V1 H q unused unused; z^3=P/q; E=D/t^5; ascending mu\n";size_t count=0;for(int k=0;k<3;k++)for(int j=0;j<3;j++){PL e=D[k].a[j].exact(lift(ppow(t,5)));small<<k<<" "<<j<<" "<<e.deg()<<"\n";for(auto&co:e.a){saveLP(small,co);count+=co.a.size();}}cerr<<"E=D/t^5 exact; total terms "<<count<<"\n";
 }catch(exception&e){cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
