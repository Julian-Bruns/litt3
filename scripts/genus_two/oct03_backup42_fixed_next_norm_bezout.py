"""Five actual fixed origins: exact next-norm/primitive Bezout gate.

No endpoint census or Groebner calculation. A unit gcd excludes roots
over every algebraic extension, not merely the displayed finite field.
"""
import json, signal, time
from pathlib import Path
from sage.all import GF, PolynomialRing
signal.alarm(6)
started=time.process_time()
P=PolynomialRing(GF(5),'r'); rr=P.gen()
K=GF(125,name='r',modulus=rr**3-3*rr**2-rr-1); r=K.gen()
W=PolynomialRing(K,'x'); x=W.gen()
values={'infinity':r**2+4,'0':4*r**2+r+3,'1':3*r**2+3,
        '2':r**2+2*r+1,'3':r**2+2*r+3}
def encode(f):
    return [[int(v) for v in K(c).polynomial().list()]+[0]*(3-len(K(c).polynomial().list()))
            for c in f.list()]
rows=[]
for origin,Q in values.items():
    A=1+3*x+4*x**2+2*x**3+x**4+Q*(2-x-2*x**2+2*x**3-2*x**4)+Q**2*(-2*x+x**2-2*x**3+x**4)+Q**3*x**4
    B=x*(1-Q)*(3*x**4-(1+3*Q)*x**3-x**2+4)-4
    g,u,v=A.xgcd(B)
    assert A*u+B*v==g
    rows.append({'origin':origin,'Q':str(Q),'gcd':str(g),
                 'A':encode(A),'B':encode(B),'u':encode(u),'v':encode(v)})
out={'field_modulus':'r^3-3r^2-r-1','basis':'1,r,r^2',
     'polynomial_coefficients':'ascending powers of x; each field entry ascending basis coordinates',
     'rows':rows,'all_unit':all(row['gcd']=='1' for row in rows),
     'cpu_seconds':time.process_time()-started}
dest=Path('/Users/julian/Documents/litt3-computation-data/oct03_backup42_differential_shape')
dest.mkdir(parents=True,exist_ok=True)
(dest/'fixed_next_norm_bezout.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'all_unit':out['all_unit'],'gcds':[(z['origin'],z['gcd']) for z in rows],
                  'cpu_seconds':out['cpu_seconds']}))
