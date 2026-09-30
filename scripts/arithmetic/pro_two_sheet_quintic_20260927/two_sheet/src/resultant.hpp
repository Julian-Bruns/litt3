#pragma once
#include "algebra.hpp"
// Polynomial identity for fixed-degree Res_{10,2}(f,aZ^2+bZ+c),
// f=lambda(Z^5+Q)^2+(Z^5+Q)(2aZ^3+3bZ^2+cZ+d)+T0.
// Returned in ascending lambda order. Valid without dividing by a or b.
template<class C> array<C,3> critical_resultant(C a,C b,C c,C d,C Q,C T0){
 C a2=a*a,a3=a2*a,a4=a2*a2,a5=a4*a,a6=a3*a3,a7=a5*a2,a8=a4*a4,a10=a5*a5;
 C b2=b*b,b3=b2*b,b4=b2*b2,b5=b4*b,b6=b3*b3,b8=b4*b4,b10=b5*b5;
 C c2=c*c,c3=c2*c,c4=c2*c2,c5=c4*c;
 C V=b3-a*b*c+C(2)*a2*d;
 C NS=a3*d*d-a2*b*c*d+a2*c3+a*b3*d+C(2)*a*b2*c2;
 C K0=-C(2)*a2*c4+C(2)*a*b2*c3-b5*d-C(2)*b4*c2;
 C TU0=C(2)*a7*c4-C(2)*a6*b2*c3-a5*b5*d+C(2)*a5*b4*c2+a4*b6*c-a3*b8;
 C T=c5-b5*Q+a5*Q*Q;
 return {a2*T*NS+T0*(TU0+Q*a8*V)+a10*T0*T0,
 T*(K0+Q*a3*V)+T0*(b10-C(2)*a5*c5-C(2)*Q*a5*b5+C(2)*Q*Q*a10),T*T};
}
