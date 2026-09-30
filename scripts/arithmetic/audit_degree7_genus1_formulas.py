#!/usr/bin/env python3
"""Symbolic checks of the new degree-seven genus-one necessary equations."""
import sympy as S
def zero(expr,label):
    num=S.cancel(expr).as_numer_denom()[0]
    if num!=0:
        vs=sorted(num.free_symbols,key=str)
        p=S.Poly(num,*vs,domain=S.QQ).clear_denoms()[1]
        assert all(int(c)%5==0 for c in p.coeffs()),(label,p)
    print('PASS',label)

z,r,T,u,l,v,m,eps=S.symbols('z r T u l v m eps',nonzero=True)
a,b,c,d,e,f,h,i,j,k=S.symbols('a b c d e f h i j k')
rho=eps*T
bp=a/(2*rho)+(j-l*h)*z/(2*eps)+h*z*z/(2*eps)
dp=f/(2*T)+(i-l*b)*z/2+b*z*z/2
F0=rho*(1+u*z+v*z*z)
Fi=z+l+m/z
coef=lambda x,n:S.expand(x).coeff(z,n)
zero(coef(2*bp*F0,1)-(T*(j-l*h)+u*a),'first zero jet')
zero(coef(2*bp*F0,2)-(T*h+u*(T*(j-l*h)+u*a)+(v-u*u)*a),'second zero jet')
zero(coef(2*dp*F0/eps,1)-(T*(i-l*b)+u*f),'other zero jet')
zero(coef(2*dp*Fi/z**3,-2)-(f/T+l*i+(m-l*l)*b),'second infinity jet')
zero(coef(F0**2*(z-r)**2,2)-rho**2*(1-4*r*u+r*r*(u*u+2*v)),'quartic coefficient at zero')
zero(coef(Fi**2*(z-r)**2,2)-(l*l+2*m-4*r*l+r*r),'quartic coefficient at infinity')
contact=(f-r**7*a)+r*T*((i-r**7*j)+(b-r**7*h)*r)-r*T*l*(b-r**7*h)
zero(2*T*(dp.subs(z,r)-r**7*eps*bp.subs(z,r))-contact,'common pole ratio')

en,ed,D,N,Delta,P,Q,RV,RM=S.symbols('en ed D N Delta P Q RV RM',nonzero=True)
tt=P/(Delta*D);ll=Q/P;uu=N/D;ee=en/ed
vv=uu*uu+RV/(a*Delta*D)
mm=ll*ll+RM/(b*P)
compat=(ee*tt)**2*(1-4*r*uu+r*r*(uu*uu+2*vv))-(ll*ll+2*mm-4*r*ll+r*r)
Ln=a*Delta*(D*D-4*r*N*D+3*r*r*N*N)+2*r*r*RV*D
Rn=b*(3*Q*Q-4*r*Q*P+r*r*P*P)+2*RM*P
W=b*en*en*P**4*Ln-a*ed*ed*Delta**3*D**4*Rn
zero(compat*(ed*ed*a*Delta**3*D**4*b*P*P)-W,'cleared quartic obstruction')
Br=r**3*(2*ll-r+(ee*tt)**2*(-2*uu+r*(uu*uu+2*vv)))
jp,ep=S.symbols('jp ep')
ar=r**3*(jp-ee*ep)
eb=(a/tt+(j-ll*h)*r+h*r*r)/2
HN=-2*a*Delta*N*D+r*(3*a*Delta*N*N+2*RV*D)
BN=(2*Q-r*P)*ed**2*a*Delta**3*D**4+en**2*P**3*HN
EB=a*Delta*D+(j*P-h*Q)*r+h*r*r*P
AP=jp*ed-en*ep
W8=4*r**3*a*Delta**3*D**4*P**3*AP**2-BN*EB**2
zero((ar*ar-Br*eb*eb)*(4*ed**2*a*Delta**3*D**4*P**3)-r**3*W8,'cleared opposite-sheet cancellation')

A0,A1,A2,H0,G0,Hin,Gin,Ain,Fin,Lin=S.symbols('A0 A1 A2 H0 G0 Hin Gin Ain Fin Lin')
anum=-r*A0+(A0-r*A1)*z+(A1-r*A2)*z*z+(Gin-r*Hin)*z**3/eps+Hin*z**4/eps
cnum=-r*eps*H0+eps*(H0-r*G0)*z+(Lin-r*Fin)*z*z+(Fin-r*Ain)*z**3+Ain*z**4
zero(anum.subs(z,r)-r**3*(Gin/eps-A2),'first rational residue')
zero(cnum.subs(z,r)-r*r*(Lin-eps*G0),'second rational residue')
zero((cnum-eps*r**7*anum).subs(z,r)/r**2-(eps*(r**8*A2-G0)-(r**8*Gin-Lin)),'epsilon residue equation')
print('All symbolic identities hold in characteristic five on the stated nonzero-denominator charts.')
