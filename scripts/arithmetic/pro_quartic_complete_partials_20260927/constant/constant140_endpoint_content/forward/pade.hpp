#pragma once
// Exact two-auxiliary-variable presentation over the coefficient ring K[mu].
// The formulas are ring identities and are proved over the full localized base.
#include "square_engine.hpp"
using Lin=std::array<Poly,3>; // 1,U,V
using Quad=std::array<Poly,6>; // 1,U,V,U^2,U*V,V^2
inline Lin ladd(const Lin&a,const Lin&b){Lin z;for(int i=0;i<3;i++)z[i]=a[i]+b[i];return z;}
inline Lin lscale(const Lin&a,const Poly&b){Lin z;for(int i=0;i<3;i++)z[i]=a[i]*b;return z;}
inline Quad lproduct(const Lin&a,const Lin&b){Quad z;z[0]=a[0]*b[0];z[1]=a[0]*b[1]+a[1]*b[0];z[2]=a[0]*b[2]+a[2]*b[0];z[3]=a[1]*b[1];z[4]=a[1]*b[2]+a[2]*b[1];z[5]=a[2]*b[2];return z;}
inline Poly leval(const Lin&a,const Poly&U,const Poly&V){return a[0]+a[1]*U+a[2]*V;}
inline Poly qeval(const Quad&a,const Poly&U,const Poly&V){return a[0]+a[1]*U+a[2]*V+a[3]*U*U+a[4]*U*V+a[5]*V*V;}
struct PadeModel{XP b;std::array<Lin,6>u;std::vector<Lin>linear;std::array<Quad,5>quadratic;std::vector<int>row_exponents;};
inline PadeModel pade(const XP&a){if(!(atXP(a,0)==Poly(1)))throw std::runtime_error("pade requires constant coefficient 1");PadeModel m;XP a2=mulXP(a,a,141),a3=mulXP(a2,a,141);m.b=mulXP(a3,frobeniusXP(a2,5,141),141);m.u[0][0]=Poly(1);m.u[1][1]=Poly(1);m.u[2][2]=Poly(1);
for(int k=3;k<=5;k++){Lin s;for(int i=0;i<k;i++)s=ladd(s,lscale(m.u[i],atXP(m.b,25*(k-i))));m.u[k]=lscale(s,Poly(4));}
for(int n=71;n<=140;n++){if(n==75||n==100||n==125)continue;Lin s;for(int i=0;i<=5;i++)s=ladd(s,lscale(m.u[i],atXP(m.b,n-25*i)));m.linear.push_back(s);m.row_exponents.push_back(n);}
for(int n=1;n<=5;n++)for(int i=0;i<=n;i++)for(int j=0;j<=n-i;j++){int k=n-i-j;auto z=lproduct(m.u[j],m.u[k]);Poly c=frob(atXP(a,i),25);for(int e=0;e<6;e++)m.quadratic[n-1][e]=m.quadratic[n-1][e]+c*z[e];}
if(m.linear.size()!=67)throw std::runtime_error("linear row count");return m;}
inline std::vector<Poly> canonical_pade_equations(const XP&a){auto m=pade(a);Poly A1=frob(atXP(a,1),25),A2=frob(atXP(a,2),25),U=scale(A1,2),V=A1*A1+scale(A2,2);std::vector<Poly>out;for(auto&r:m.linear)out.push_back(leval(r,U,V));for(auto&q:m.quadratic)out.push_back(qeval(q,U,V));if(!out[67].zero()||!out[68].zero())throw std::runtime_error("canonical auxiliary equations");return out;}
