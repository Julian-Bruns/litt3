"""Fresh fixed-origin next norm coefficients after the concrete R error.

One Laurent coefficient engine, no Groebner computation or endpoint census.
Represent functions as E+s O, s=a*y, a^2=4q, and use delta=a*partial.
"""
import json, time, signal
from pathlib import Path
from sage.all import GF, LaurentPolynomialRing, PolynomialRing
signal.alarm(25)
started=time.process_time()
R=LaurentPolynomialRing(GF(5),names=('q','b')); q,b=R.gens()
W=PolynomialRing(R,'w'); w=W.gen()
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
dh=delta(mul(F,g))
# h=dh/a; squares therefore divide by 4q.
diff=add(scale(mul(dh,dh),1/(4*q)),power(g,3),-1)
tau=diff[0][21]
f7=power(F,7)
indices=((0,20),(0,19),(0,18),(1,18),(1,17),(1,16),(1,15),(1,14))
P=PolynomialRing(GF(5),names=('q','b'))
def description(c):
    shift=tuple(max(0,-min((e[i] for e in c.dict()),default=0)) for i in range(2))
    polynomial=P(c*q**shift[0]*b**shift[1])
    return {'coefficient':str(c),'clear_q_power':shift[0],'clear_b_power':shift[1],
            'cleared_factor':str(polynomial.factor()) if polynomial else '0'}
out={'representation':'E+sO, s=a*y, a^2=4q',
     'tau':description(tau),
     'next_coefficients':{f'{i}:{j}':description(diff[i][j]-tau*f7[i][j]) for i,j in indices},
     'cpu_seconds':time.process_time()-started}
dest=Path('/Users/julian/Documents/litt3-computation-data/oct03_backup42_differential_shape')
dest.mkdir(parents=True,exist_ok=True)
(dest/'fixed_next_norm_coefficients.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
