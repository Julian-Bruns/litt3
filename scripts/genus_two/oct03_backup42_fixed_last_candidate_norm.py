"""The sole candidate left by the exact five-origin A/B gcd gate.

Actual origin1 uses q=-(alpha+1)/(alpha-1), alpha=r-1.
No parameter enumeration; evaluate the original full norm exactly.
"""
import json, time, signal
from pathlib import Path
from sage.all import GF, PolynomialRing
signal.alarm(6)
started=time.process_time()
P=PolynomialRing(GF(5),'r'); rr=P.gen()
K=GF(125,name='r',modulus=rr**3-3*rr**2-rr-1); r=K.gen()
q=-r/(r-2); b=q*(r+1)
assert q**-4==3*r**2+3
W=PolynomialRing(K,'w'); w=W.gen()
phi=w**5+q*w**4-w-q
U=w**3+b*w**2+4*b/q**3*w+1/q+3*b/q**2
F=(U,W.one()); Z=(3*q*w**2,W.one())
def add(x,y,sign=1): return tuple(x[i]+sign*y[i] for i in range(2))
def scale(x,c): return tuple(c*v for v in x)
def mul(x,y):
    return (x[0]*y[0]+4*q*phi*x[1]*y[1],x[0]*y[1]+x[1]*y[0])
def delta(x):
    return (4*q*(phi*x[1].derivative()+3*phi.derivative()*x[1]),x[0].derivative())
def power(x,n):
    out=(W.one(),W.zero())
    for _ in range(n): out=mul(out,x)
    return out
DF=delta(F)
g=add(scale(add(mul(DF,DF),mul(F,delta(DF))),1/(4*q)),mul(power(F,2),Z),-1)
dh=delta(mul(F,g)); tau=4*q**3/b
res=add(add(scale(mul(dh,dh),1/(4*q)),power(g,3),-1),scale(power(F,7),tau),-1)
normF=U**2-4*q*phi
out={'field_modulus':'r^3-3r^2-r-1','q':str(q),'b':str(b),'x':str(b/q),
     'representation':'E+vO, v=a*y, a^2=4q; dh=a*h',
     'tau':str(tau),'g':[str(v) for v in g],'dh':[str(v) for v in dh],
     'full_norm_residual':[str(v) for v in res],
     'nonzero_coefficients':{f'{i}:{j}':str(v) for i in range(2) for j,v in enumerate(res[i]) if v},
     'norm_F':str(normF),'norm_F_repeated_gcd':str(normF.gcd(normF.derivative())),
     'cpu_seconds':time.process_time()-started}
dest=Path('/Users/julian/Documents/litt3-computation-data/oct03_backup42_differential_shape')
dest.mkdir(parents=True,exist_ok=True)
(dest/'fixed_last_candidate_norm.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
