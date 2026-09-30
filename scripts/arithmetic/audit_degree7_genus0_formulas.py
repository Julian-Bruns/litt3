#!/usr/bin/env python3
"""Symbolic characteristic-five audit for the rational degree-seven model."""
import sympy as S
def zero(expr,label):
    p=S.cancel(expr).as_numer_denom()[0]
    if p!=0:
        q=S.Poly(p,*sorted(p.free_symbols,key=str),domain=S.QQ).clear_denoms()[1]
        assert all(int(c)%5==0 for c in q.coeffs()),label
    print('PASS',label)
z,r,T,u,l,v,m,eps=S.symbols('z r T u l v m eps',nonzero=True)
a,b,c,d,e,f,h,i,j,k=S.symbols('a b c d e f h i j k')
rho=eps*T
bp=a/(2*rho)+(c-u*a)*z/(2*rho)+(j-l*h)*z*z/(2*eps)+h*z**3/(2*eps)
dp=f/(2*T)+(k-l*i+(l*l-m)*b)*z/2+(i-l*b)*z*z/2+b*z**3/2
F0=rho*(1+u*z+v*z*z);Fi=1+l/z+m/z**2
coef=lambda x,n:S.expand(x).coeff(z,n)
zero(coef(2*bp*F0,2)-(T*(j-l*h)+u*c+(v-u*u)*a),'rational first double-zero jet')
zero(coef(2*dp*F0/eps,1)-(T*(k-l*i+(l*l-m)*b)+u*f),'rational other zero jet')
zero(coef(2*dp*Fi/z**3,-2)-k,'rational infinity double jet')
x,W=S.symbols('x W',nonzero=True)
rr=x*x/(r*r)
uu=(1-W)/r;ll=r*(1-rr*W)
mm=(x*x-ll*ll+4*r*ll-r*r)/2
vv=(1/rr-1+4*r*uu-r*r*uu*uu)/(2*r*r)
zero(coef(F0**2*(z-r)**2,2).subs({rho:x/r,u:uu,v:vv,eps:x/(r*T)})-1,'monic quadratic numerator')
E0=2*eps*r*r*e*x*x-2*r*(j-r*h)*x**3-2*eps*r*c*x*x-eps*r*r*a
E1=-2*h*x**5+2*eps*(r*c-a)*x*x;E2=3*eps*a*x*x
D0=2*eps*r**3*d-2*r*r*(k-r*i)*x+r*r*b*x**3-2*eps*r*r*f
D1=2*(r*r*b-r*i)*x**3+2*eps*r*r*f;D2=-3*b*x**5
zero(2*eps*r*r*x*x*(e-(x/(eps*r)*(j-ll*h)+uu*c+(vv-uu*uu)*a))-(E0+E1*W+E2*W*W),'first quadratic W equation')
zero(2*eps*r**3*(d-(x/(eps*r)*(k-ll*i+(ll*ll-mm)*b)+uu*f))-(D0+D1*W+D2*W*W),'second quadratic W equation')
dp_contact=f/(2*T)+(d-u*f)*z/(2*T)+(i-l*b)*z*z/2+b*z**3/2
contact=eps*(f-r**7*a)*W+x**3*(b-r**7*h)*W+r*(eps*(d-r**7*c)+x*(i-r**7*j))
zero((2*T*(dp_contact-r**7*eps*bp)).subs(z,r).subs({T:x/(eps*r),u:uu,l:ll})*eps-contact,'linear W contact equation')
zero((z*z+(2*l-2*r)*z+rho*rho*r*r).subs(z,r).subs({l:ll,eps:x/(r*T)})-(r*r+x*x*(1-2*W)),'quadratic numerator at common pole')
jp,ep=S.symbols('jp ep')
ar=r**3*(jp-eps*ep)
eb=(eps*bp).subs(z,r).subs({T:x/(eps*r),u:uu,l:ll})
hc=4*x*x*r**4*(jp-eps*ep)**2-(r*r+x*x*(1-2*W))*(eps*(a*W+c*r)+j*r*x+x**3*h*W)**2
zero(4*x*x*(ar*ar-(r*r+x*x*(1-2*W))*eb*eb)/r**2-hc,'opposite-sheet polynomial')
print('All rational-model symbolic checks passed; arithmetic coverage is a separate requirement.')
