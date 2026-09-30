#pragma once
#include "pair_kernel.hpp"
struct Generic {
 int dx=0,dy=0,den=0;K Y,X,Z,S,T;bool nonsingular=false;
};
// A=E_Q/eta, B=C_Q/eta, C=C_H/eta, D=E_H/eta, W=A*D-B*C.
// Bars below are applied to K coefficients only.
inline Generic first_residual(const F&A,const F&B,const F&C,const F&D,const F&W){
 Generic r;r.dy=sub(C.c[3].norm(),B.c[3].norm());r.dx=sub(A.c[1].norm(),D.c[1].norm());
 if(!r.dx||!r.dy)return r;
 r.nonsingular=true;r.den=mul(r.dx,r.dy);
 K dy(r.dy,0),dx(r.dx,0),dd(r.den,0);
 r.Y=B.c[3]*W.c[3].bar()-C.c[3].bar()*W.c[3];
 K R=dy*W.c[1]+B.c[1]*r.Y.bar()+C.c[1]*r.Y;
 r.X=A.c[1].bar()*R-D.c[1]*R.bar();
 r.Z=dd*W.c[2]-A.c[2]*r.X-D.c[2]*r.X.bar()+dx*(B.c[2]*r.Y.bar()+C.c[2]*r.Y);
 return r;
}
inline void second_residual(Generic&r,const F&A,const F&B,const F&C,const F&D,const F&W){
 if(!r.nonsingular)throw std::runtime_error("singular generic formula");
 K dx(r.dx,0),dd(r.den,0);
 r.S=dd*W.c[0]-A.c[0]*r.X-D.c[0]*r.X.bar()+dx*(B.c[0]*r.Y.bar()+C.c[0]*r.Y);
 r.T=dd*r.S+K(sub(r.X.norm(),mul(mul(r.dx,r.dx),r.Y.norm())),0);
}
inline std::pair<K,K> moments(const Generic&r){
 if(!r.nonsingular)throw std::runtime_error("singular moments");
 return {r.X/K(r.den,0),r.Y/K(r.dy,0)};
}
inline void pk(K z){std::cout<<'['<<z.a<<','<<z.b<<']';}
inline void pf(F z){std::cout<<'[';for(int i=0;i<4;++i){if(i)std::cout<<',';pk(z.c[i]);}std::cout<<']';}
