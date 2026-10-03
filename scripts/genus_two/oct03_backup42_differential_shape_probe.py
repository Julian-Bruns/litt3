"""Fresh bounded symbolic moving-origin 42 gate; no Groebner computation."""
import signal
signal.alarm(3)
from sage.all import GF, PolynomialRing
import json
from pathlib import Path

R = PolynomialRing(GF(5), names=('a','q','s','b','n'), order='lex')
a,q,s,b,n = R.gens()
W = PolynomialRing(R, 'w'); w=W.gen()
rel=a*a-4*q
def red(p):
    return W([c.reduce([rel]) for c in p.list()])
phi=w**5+q*w**4+s
def add(x,y): return tuple(red(x[i]+y[i]) for i in range(2))
def neg(x): return tuple(-z for z in x)
def mul(x,y):
    return (red(x[0]*y[0]+phi*x[1]*y[1]),red(x[0]*y[1]+x[1]*y[0]))
def power(x,k):
    z=(W.one(),W.zero())
    for _ in range(k): z=mul(z,x)
    return z
def der(x):
    return (red(phi*x[1].derivative()+3*phi.derivative()*x[1]),x[0].derivative())
F=(w**3+b*w**2,W(a)); D=der(F)
Z=(3*q*w**2+n,W(a))
g=add(add(mul(D,D),mul(F,der(D))),neg(mul(power(F,2),Z)))
h=der(mul(F,g))
delta=add(power(h,2),neg(power(g,3)))
tau=delta[0][21]
res=add(delta,neg(tuple(red(tau*x) for x in power(F,7))))
out={'g':[str(x) for x in g], 'h':[str(x) for x in h], 'tau':str(tau),
     'res_even':{str(j):str(c) for j,c in enumerate(res[0]) if c},
     'res_odd':{str(j):str(c) for j,c in enumerate(res[1]) if c}}
dest=Path('/Users/julian/Documents/litt3-computation-data/oct03_backup42_differential_shape')
dest.mkdir(parents=True,exist_ok=True)
(dest/'moving_shape_receipt.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out))
