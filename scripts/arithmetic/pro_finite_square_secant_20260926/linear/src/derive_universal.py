import sympy as s, json, sys
from pathlib import Path
a,b,c,d,Q,T,l,v=s.symbols('a b c d Q T l v')
vs=(a,b,c,d,Q,T,l,v)
def mod(p):return s.Poly(s.expand(p),vs, modulus=5).as_expr()
u=[s.Integer(2),b]
for i in range(2,9): u.append(mod(b*u[-1]+3*a*c*u[-2]))
Ts=b**3+3*a*b*c+a*a*d
V=a**5*Q**2+b**5*Q+2*c**5
W=b**5+2*a**5*Q
trace=mod(u[8]+b*u[7]+a*c*u[6]+a*a*d*u[5]+2*Q*a**5*Ts)
cross=mod(2*W*Ts-trace)
Ns=a*a*d*d+a*b*c*d+2*b**3*d+2*b*b*c*c+2*a*c**3
R2=mod(4*v*v*V**2)
R1=mod(4*v*(s.cancel(V*cross/a**2)+T*(W**2-2*a**5*V)))
R0=mod(4*(a**3*V*Ns+a**3*T*trace+a**10*T*T))
print('trace=',trace);print('cross=',cross)
print('R1 terms=',len(s.Poly(R1,vs).terms()),'R0 terms=',len(s.Poly(R0,vs).terms()))
R=mod(R2*l*l+R1*l+R0)
out={'variables':[str(x) for x in vs], 'terms':[[list(e),int(co)%5] for e,co in s.Poly(R,vs,modulus=5).terms()], 'formula':str(R)}
destination = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parents[1] / 'data'
destination.mkdir(parents=True, exist_ok=True)
(destination/'universal_resultant.json').write_text(json.dumps(out,indent=2)+'\n')
# Verify symbolically by reducing the Sylvester norm; no generic-only assertion.
# Powers p_n in the quotient g, expressed with denominator a^n.
symvars=(a,b,c,d,Q,T,l,v)
red=[(s.Integer(0),s.Integer(1)),(s.Integer(1),s.Integer(0))]
# x^n=(L_n x + C_n)/a^(n-1), for n>=1
for n in range(2,11):
 L,C=red[-1];red.append((mod(b*L+a*C),mod(3*c*L)))
f=[mod(l*v*Q*Q+Q*d+T), Q*c,Q*b,Q*a,0,mod(2*l*v*Q+d),c,b,a,0,l*v]
M=N=0
for n,fn in enumerate(f):
 if n==0:N=mod(N+fn*a**9)
 else:
  L,C=red[n]
  M=mod(M+fn*L*a**(10-n))
  N=mod(N+fn*C*a**(10-n))
identity=mod(4*(a*N*N+b*M*N+2*c*M*M)-a**9*R)
assert identity==0, identity
print('PASS: universal fixed-degree resultant identity (symbolic over F5).')
