#pragma once
#include "algebra.hpp"
inline Poly A(std::vector<F>{1,21,14,22,13});
inline Poly Q(std::vector<F>{0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24});
inline Poly B0(std::vector<F>{8,14,19,2,10,19,3,24,18,16});
inline Poly L0(std::vector<F>{18,20,20,15});
inline F alpha=25, epsilon=24+4*25+23*15625, eta=11+18*625+20*15625, Cd=3+10*25+625+14*15625;
inline Poly t,M;
using Source=std::array<Curve,4>; // G2,G3,G4,G5
inline Source addsource(const Source&a,const Source&b){Source c;for(int i=0;i<4;i++)c[i]=a[i]+b[i];return c;}
inline Source scalesource(const Source&a,F z){Source c;for(int i=0;i<4;i++)c[i]=scale(a[i],z);return c;}
inline void init_source(){t=scale(exactdiv(A,Poly(std::vector<F>{ff::neg(alpha),1})),ff::inv(13));M=exactdiv(Q-frob(L0),ppow(t,3));if(!(derivative(Q)==P*A*A))throw std::runtime_error("Q derivative identity");if(!rem(Q-frob(B0),P*P).zero())throw std::runtime_error("B0 identity");if(!rem(Q-frob(L0),ppow(A,3)).zero())throw std::runtime_error("L0 identity");if(!(gcd(M,t)==Poly(1)))throw std::runtime_error("M is not a unit modulo t");if(!(gcd(P,derivative(P))==Poly(1))||!(gcd(A,derivative(A))==Poly(1))||!(gcd(P,A)==Poly(1)))throw std::runtime_error("base coprimality");}
inline std::vector<F> constraints(const Source&s,bool affine){auto G2=s[0],G3=s[1],G4=s[2],G5=s[3];std::vector<F>r;Curve b(B0),l(L0);auto append=[&](const Curve&c,int n){for(int j=0;j<3;j++){int k=std::max(0,(n-j+2)/3);Poly v=rem(c.a[j],ppow(P,k));for(int i=0;i<10*k;i++)r.push_back(v.at(i));}};
 append(G3-scale(b*G2,3),3);
 append(G4-scale(b*G3,2)+scale(b*b*G2,3),4);
 append(G5-b*G4+b*b*G3-b*b*b*G2,5);
 Curve c=Curve(M)*(G5-l*G4+l*l*G3-l*l*l*G2);if(affine)c=c+Curve::mon(0,10);
 Curve d=scale(l*l*G2,3)-scale(l*G3,2)+G4;
 for(int j=0;j<3;j++){Poly v=rem(c.a[j],t*t);for(int i=0;i<6;i++)r.push_back(v.at(i));}
 for(int j=0;j<3;j++){Poly v=rem(d.a[j],t);for(int i=0;i<3;i++)r.push_back(v.at(i));}
 Curve high=Curve(Q)*G5;if(affine)high=high+Curve(ppow(t,3))*Curve::mon(0,10);
 r.push_back(high.a[0].at(42));r.push_back(high.a[1].at(39));
 if(r.size()!=149)throw std::runtime_error("constraint length");
 return r;
}
inline std::array<F,4> coordinates(const Source&s){return {s[0].a[2].at(4),s[2].a[0].at(19),s[2].a[2].at(12),s[3].a[2].at(16)};}
inline std::vector<Source> make_affine(std::ostream&log){std::vector<Source>b;for(auto ij:basisL(12)){Source s;s[0]=Curve::mon(ij.first,ij.second+2);b.push_back(s);}for(int g=1;g<4;g++)for(auto ij:basisL(g==1?46:g==2?57:70)){Source s;s[g]=Curve::mon(ij.first,ij.second);b.push_back(s);}int n=b.size();if(n!=155)throw std::runtime_error("155 basis");Source zero;auto rhs=constraints(zero,true);std::vector<std::vector<F>>mat(153,std::vector<F>(n+1));for(int i=0;i<149;i++)mat[i][n]=ff::neg(rhs[i]);for(int j=0;j<n;j++){auto c=constraints(b[j],false);for(int i=0;i<149;i++)mat[i][j]=c[i];auto co=coordinates(b[j]);for(int i=0;i<4;i++)mat[149+i][j]=co[i];}
 auto m0=mat;m0.resize(149);auto raw=solve(m0,n);log<<"source_variables "<<n<<" source_rank "<<raw.rank<<" affine_dimension "<<raw.kernel.size()<<"\n";if(raw.rank!=149)throw std::runtime_error("source rank mismatch");
 auto so=solve(mat,n);if(so.kernel.size()!=2)throw std::runtime_error("kernel !=2");auto decode=[&](const std::vector<F>&v){Source s;for(int i=0;i<n;i++)if(v[i])s=addsource(s,scalesource(b[i],v[i]));return s;};std::vector<Source>out{decode(so.origin)};
 for(int j=0;j<4;j++){auto mm=mat;mm[149+j][n]=1;auto si=solve(mm,n);std::vector<F>v(n);for(int i=0;i<n;i++)v[i]=ff::sub(si.origin[i],so.origin[i]);out.push_back(decode(v));}for(auto v:so.kernel)out.push_back(decode(v));
 for(int k=0;k<7;k++){auto r=constraints(out[k],k==0);for(F v:r)if(v)throw std::runtime_error("affine basis constraint fails");F got=out[k][1].a[1].at(12);if(got!=(k==0?epsilon:0))throw std::runtime_error("epsilon identity fails");if(out[k][1].a[0].at(15)!=ff::mul(Cd,out[k][2].a[0].at(19)))throw std::runtime_error("Cd identity fails");}
 log<<"affine_basis_verified 7 coordinate_rank 4 common_kernel_dimension 2\n";return out;
}
inline void write_affine(const std::string&path,const std::vector<Source>&s){std::ofstream out(path);out<<"CONSTANT140_AFFINE_V1\n";for(auto x:s)for(auto c:x)for(auto p:c.a)writepoly(out,p);}
inline std::vector<Source> read_affine(const std::string&path){std::ifstream in(path);std::string head;in>>head;if(head!="CONSTANT140_AFFINE_V1")throw std::runtime_error("affine header");std::vector<Source>s(7);for(auto &x:s)for(auto &c:x)for(auto &p:c.a)p=readpoly(in);return s;}
inline Poly Yseries(int n){Poly y(1),target;target.v.resize(n);for(int i=0;i<=10;i++)if(30-3*i<n)target.v[30-3*i]=P.at(i);target.trim();for(int i=1;i<n;i++){F v=ff::mul(2,ff::sub(target.at(i),seriespow(y,3,i+1).at(i)));if(v)y=y+Poly::mon(i,v);}return y;}
inline Poly infinity(const Curve&c,int pole,int n){Poly y=Yseries(n),r;for(int j=0;j<3;j++){Poly yp=seriespow(y,j,n);for(int i=0;i<=c.a[j].deg();i++)if(F z=c.a[j].at(i)){int d=pole-3*i-10*j;if(d<0)throw std::runtime_error("negative infinity exponent");if(d<n)r=r+scale(trunc(shift(yp,d),n),z);}}return trunc(r,n);}
inline Poly Fseries(const Source&s,int n=7){Poly aa=scale(infinity(s[0],35,n),3),bb=scale(infinity(s[1],46,n),2),cc=infinity(s[2],57,n);F w=s[2].a[0].at(19);Poly rho(ff::div(ff::mul(2,w),epsilon));if(aa.at(0)||!bb.at(0))throw std::runtime_error("rho pivot");for(int j=1;j<n;j++){F z=(seriesmul(aa,seriespow(rho,2,n),n)+seriesmul(bb,rho,n)+cc).at(j);rho=rho+Poly::mon(j,ff::neg(ff::div(z,bb.at(0))));}if(!trunc(seriesmul(aa,seriespow(rho,2,n),n)+seriesmul(bb,rho,n)+cc,n).zero())throw std::runtime_error("rho solution fails");
 Poly left=infinity(Curve(Q),57,n)+trunc(shift(seriespow(rho,5,n),2),n);
 Poly right=infinity(s[3],70,n)+trunc(shift(seriesmul(aa,seriespow(rho,3,n),n)+scale(seriesmul(bb,seriespow(rho,2,n),n),2),2),n);
 return trunc(seriesmul(left,right,n)+infinity(Curve(ppow(t,3))*Curve::mon(0,10),127,n),n);
}
struct Chart{Source s;F h,w,e,f,k0,k1,F6,det;};
inline Chart chart(const std::vector<Source>&basis,F h,F w){if(!h||!w)throw std::runtime_error("chart h,w zero");F c=ff::mul(Cd,w),z0=ff::div(ff::mul(2,w),epsilon);F e=ff::sub(ff::neg(ff::mul(c,z0)),ff::div(eta,ff::mul(24,z0)));F f=ff::sub(ff::neg(ff::div(ff::mul(w,w),epsilon)),ff::mul(ff::div(8,24),ff::pow(z0,5)));Source s=basis[0];std::array<F,4>co{h,w,e,f};for(int j=0;j<4;j++)s=addsource(s,scalesource(basis[j+1],co[j]));Poly F0=Fseries(s),F1=Fseries(addsource(s,basis[5]))-F0,F2=Fseries(addsource(s,basis[6]))-F0;F det=ff::sub(ff::mul(F1.at(4),F2.at(5)),ff::mul(F1.at(5),F2.at(4)));if(!det)throw std::runtime_error("F4 F5 det zero");F k0=ff::div(ff::sub(ff::mul(F2.at(4),F0.at(5)),ff::mul(F2.at(5),F0.at(4))),det);F k1=ff::div(ff::sub(ff::mul(F1.at(5),F0.at(4)),ff::mul(F1.at(4),F0.at(5))),det);s=addsource(s,addsource(scalesource(basis[5],k0),scalesource(basis[6],k1)));Poly fs=Fseries(s);for(int i=0;i<6;i++)if(fs.at(i))throw std::runtime_error("F0..5 failed");return {s,h,w,e,f,k0,k1,fs.at(6),det};}
inline std::array<Curve,3> compactD(const Source&s){Curve b0(B0);Curve g2=divy(s[0],2),g3=divy(s[1]-scale(b0*s[0],3),3),g4=divy(s[2]-scale(b0*s[1],2)+scale(b0*b0*s[0],3),4),g5=divy(s[3]-b0*s[2]+b0*b0*s[1]-b0*b0*b0*s[0],5);
 Curve a=scale(g2,3),b=scale(g3,2),c=g4,d=g5,q=Curve(exactdiv(Q-frob(B0),P*P))*Curve::mon(0,1),C(ppow(t,3));
 Curve a2=a*a,a3=a2*a,a4=a2*a2,a5=a4*a,b2=b*b,b3=b2*b,b4=b2*b2,b5=b4*b,c2=c*c,c3=c2*c,c4=c2*c2,c5=c4*c;
 Curve E=a*d-b*c,Delta=b2+a*c,T0=c5-q*b5+q*q*a5,U0=scale(q*a5,2)-b5;
 Curve V0=-(d*b5)-scale(c2*b4,2)-scale(a*b2*c3,3)-scale(a2*c4,2)+q*(scale(a5*d,2)-a4*b*c+a3*b3);
 Curve W0=a2*d*d-a*b*c*d+scale(b2*c2,2)+b3*d+a*c3;
 Curve M0=U0*(scale(a*E,2)+b*Delta)-a2*V0;
 std::array<Curve,3>D{a3*(T0*W0+C*M0)+C*C*a5*a5,T0*V0+C*(U0*U0-scale(a5*T0,2)),T0*T0};
 Poly t5=frob(t);for(auto &di:D)di=cdiv(di,t5);return D;
}
inline Poly residual(const std::array<Curve,3>&d,F lambda){return norm(d[0]+scale(d[1],lambda)+scale(d[2],ff::mul(lambda,lambda)));}
inline Poly a0poly(){return Poly(std::vector<F>{89654,311173,214299,163299,315361,33043,356725,245794});}
inline F a1eval(F q){return ff::mul(q,ff::add(299833,ff::mul(232505,q)));}
inline F psieval(F H,F q){return ff::add(eval(a0poly(),q),ff::mul(a1eval(q),H));}
inline bool allowed(F H,F q,F mu){return H&&q&&mu&&q!=15383&&q!=1&&eval(a0poly(),q)&&psieval(H,q);}
inline int first_square_failure(const Poly&R){if(R.deg()!=140)throw std::runtime_error("not degree140");Poly ah;ah.v.resize(141);for(int i=0;i<=140;i++)ah.v[i]=R.at(140-i);F L=ah.at(0);Poly a2=trunc(ah*ah,125),a3=trunc(a2*ah,125);Poly C=trunc(trunc(a3*frob(a2),125)*frob(a2,25),125);for(int m=71;m<=124;m++)if(C.at(m))return m;Poly B=trunc(C,71);Poly late=B*B-scale(ah,ff::pow(L,125));for(int m=125;m<=140;m++)if(late.at(m))return m;return -1;}
