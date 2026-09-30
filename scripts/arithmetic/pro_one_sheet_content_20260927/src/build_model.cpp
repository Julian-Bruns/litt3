#include "sparse.hpp"
int main(int argc,char**argv){try{
 if(argc<3){std::cerr<<"usage: build_model input.txt Ehat.txt [norm.txt]\n";return 2;}initfield(nullptr);std::ifstream in(argv[1]);assert(in);int np,nt;in>>np;std::vector<U>P(np);for(U&c:P)in>>c;in>>nt;std::vector<U>t(nt);for(U&c:t)in>>c;initP(P);std::string name;
 Poly a=read_poly(in,name),b=read_poly(in,name),c=read_poly(in,name),d=read_poly(in,name),Q=read_poly(in,name),T=read_poly(in,name);
 Poly a2=a*a,a3=a2*a,a4=a2*a2,a5=pow5(a),b2=b*b,b3=b2*b,b4=b2*b2,b5=pow5(b),c2=c*c,c3=c2*c,c4=c2*c2,c5=pow5(c);
 Poly J=c5-b5*Q+a5*(Q*Q);stats("J",J);
 Poly TU=(a5*Q).scale(2)-b5,TS=a3*b3-a4*b*c+(a5*d).scale(2);
 Poly K=(b4*c2).scale(3)+(a*b2*c3).scale(2)+(a2*c4).scale(3)-b5*d+Q*TS;stats("K",K);
 Poly V=a3*(d*d)-a2*b*c*d+a*b3*d+(a*b2*c2).scale(2)+a2*c3;stats("V",V);
 Poly co2=J*J;stats("D2_raw",co2);
 Poly co1=J*K+T*(TU*TU-(a5*J).scale(2));stats("D1_raw",co1);
 Poly co0=a2*J*V+T*(TU*TS-a5*K)+(a5*a5)*(T*T);stats("D0_raw",co0);
 std::vector<U>t5(5*(t.size()-1)+1);for(size_t i=0;i<t.size();i++)t5[5*i]=kpow(t[i],5);
 co0=divx(co0,t5);co1=divx(co1,t5);co2=divx(co2,t5);
 stats("Ehat0",co0);stats("Ehat1",co1);stats("Ehat2",co2);
 Poly E=co0+co1.shift(0,0,0,0,1)+co2.shift(0,0,0,0,2);std::ofstream out(argv[2]);write_poly(out,"Ehat",E);out.close();stats("Ehat",E);
 if(argc>=4){std::array<Poly,3>cpt;for(auto [m,c]:E.t)cpt[ky(m)].put(key(kx(m),0,kh(m),kq(m),kmu(m)),c);Poly Pq;for(int i=0;i<int(P.size());i++)if(P[i])Pq.put(key(i,0,0,-1),P[i]);
  Poly NN=powp(cpt[0],3);stats("norm_first",NN);NN+=Pq*powp(cpt[1],3);stats("norm_second",NN);NN+=(Pq*Pq)*powp(cpt[2],3);stats("norm_third",NN);NN=NN-(Pq*cpt[0]*cpt[1]*cpt[2]).scale(3);NN=NN.shift(0,0,0,-28);stats("R",NN);std::ofstream nr(argv[3]);write_poly(nr,"R",NN);
 }
 return 0;
 }catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
