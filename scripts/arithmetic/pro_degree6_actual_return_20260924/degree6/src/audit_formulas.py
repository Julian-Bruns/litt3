"""Symbolic audits of the algebra used in REPORT.md (not a model search)."""
import sympy as sp

def zero_mod5(expr):
 num=sp.fraction(sp.cancel(expr))[0]
 symbols=sorted(num.free_symbols,key=str)
 if symbols:
  if not sp.Poly(num,*symbols,modulus=5).is_zero:raise AssertionError(num)
 elif num%5:raise AssertionError(num)

def run():
 D,eta,C1,p,a=sp.symbols('D eta C1 p a')
 C1value=D*eta*(p-a)
 X2=4*eta*C1/D-3*a*eta**2
 zero_mod5(X2.subs(C1,C1value)-eta**2*(4*p+3*a))
 zero_mod5((2*C1/D+2*p*eta-X2/eta).subs(C1,C1value))
 print('PASS symbolic: local first and second jet formulas')
 b0,b1,d0,d1=sp.symbols('b0 b1 d0 d1')
 zero_mod5(((d1*b0-d0*b1)/b0**2)*((d0*b1-d1*b0)/b1**2)+(d1/b1-d0/b0)**2)
 print('PASS symbolic: genus-one two-end Mobius derivative identity')
 rho,eps,p=sp.symbols('rho eps p')
 aa,bb,cc,dd,ee,ff,hh,ii,jj,kk=sp.symbols('aa bb cc dd ee ff hh ii jj kk')
 b0v=aa/(2*rho);b2v=hh/(2*eps);b1v=jj/(2*eps)-p*hh/(4*eps)
 c_actual=2*rho*b1v+p*b0v/rho
 e_actual=2*rho*b2v+p*b1v/rho+b0v/rho-p**2*b0v/(4*rho**3)
 T=rho/eps;N=p/2;V=N/rho**2
 zero_mod5(c_actual-(T*jj-T*N*hh+V*aa))
 zero_mod5(e_actual-(T*hh+V*c_actual+(1/(2*rho**2)+V**2)*aa))
 d0v=eps*ff/(2*rho);d2v=bb/2;d1v=ii/2-p*bb/4
 d_actual=(2*rho*d1v+p*d0v/rho)/eps
 k_actual=2*d0v+p*d1v+(rho**2-p**2/4)*d2v
 zero_mod5(d_actual-(T*ii-T*N*bb+V*ff))
 zero_mod5(k_actual-(ff/T+N*ii+(rho**2/2+N**2)*bb))
 print('PASS symbolic: all four genus-zero global two-jet equations')
 Delta,Tn,Un,V=sp.symbols('Delta Tn Un V')
 Tv=Tn/Delta;Uv=Un/Delta;Nv=Uv/Tv;qv=Nv/V
 p3=2*ee*Delta*Un-2*hh*Tn*Un-2*cc*Delta*Un*V-2*aa*Delta*Un*V**2-aa*Delta*Tn*V
 p4=2*kk*Tn**2*V-2*ff*Delta*Tn*V-2*ii*Tn*Un*V-2*bb*Un**2*V-bb*Tn*Un
 zero_mod5(2*Uv*Delta**2*(ee-Tv*hh-V*cc-V**2*aa-aa/(2*qv))-p3)
 zero_mod5(2*Tv**2*V*Delta**2*(kk-ff/Tv-Nv*ii-(qv/2+Nv**2)*bb)-p4)
 print('PASS symbolic: denominator clearing to the two cubics')
 x,y=sp.symbols('x y');P=sp.symbols('p0:4');Q=sp.symbols('q0:4')
 B=[[0]*3 for _ in range(3)]
 for i in range(1,4):
  for j in range(i):
   z=P[i]*Q[j]-P[j]*Q[i]
   for r in range(i-j):B[i-1-r][j+r]+=z
 lhs=(x-y)*sum(B[i][j]*x**i*y**j for i in range(3) for j in range(3))
 rhs=sum(P[i]*x**i for i in range(4))*sum(Q[i]*y**i for i in range(4))-sum(P[i]*y**i for i in range(4))*sum(Q[i]*x**i for i in range(4))
 if sp.expand(lhs-rhs)!=0:raise AssertionError('Bezout identity')
 print('PASS symbolic: Bezout matrix identity over the integers')

if __name__=='__main__':run()
