"""Fresh three-scalar hyperelliptic Cartier gate, no endpoint replay.

Independently expand the original orbit cubics, then inspect low-degree
necessary equations. Bulk output is stored outside the research tree.
"""
import json
import time
import sys
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing

started = time.process_time()
R = PolynomialRing(GF(5), names=('a','b','c'))
a,b,c = R.gens()
W = PolynomialRing(R,'x'); x = W.gen()
F = [x**3+a*x**2+b*x+c,
     -x**3+a*x**2-b*x+c,
     c*x**3+b*x**2+a*x+1,
     c*x**3-b*x**2+a*x-1]
G = F[1]*F[2]*F[3]
ks = [R((G**2)[j]) for j in (4,9,14)]
C,d,e,r,s = c*c,2*a*c-b*b,a*a-2*b,a*a+2*b,b*b+2*a*c
claimed = [C*(e*e-2*d)-2*s*e+r,
           -2*(a*(e*e-2*d)+2*(a*b+c)*(d*e-C)+b*c*(d*d+2*C*e)),
           d*d+2*C*e+2*r*C*d+s*C*C]
assert ks == claimed
out = {'result':'PASS original polynomial coefficients',
       'field':'F5', 'variables':['a','b','c'],
       'indices':[4,9,14], 'equations':[str(k) for k in ks],
       'factorizations':[str(k.factor()) for k in ks],
       'necessary_open':'c*(a-b*c) != 0; four cubics squarefree and pairwise coprime',
       'cpu_seconds':time.process_time()-started}
dest=Path(__file__).resolve().parents[3]/'litt3-computation-data'/'oct03_abelian_humbert_cubic_orbit'
dest.mkdir(parents=True,exist_ok=True)
(dest/'original_coefficient_receipt.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
if '--necessary-open' in sys.argv or '--pairwise-open' in sys.argv:
    # Only the SMALL necessary open. Do not introduce the degree-twelve
    # discriminant before understanding the low-degree geometry.
    signal.alarm(90)
    S=PolynomialRing(GF(5),names=('z','a','b','c'),order='degrevlex')
    z,aa,bb,cc=S.gens()
    lift=R.hom([aa,bb,cc],S)
    factor=cc*(aa-bb*cc)
    if '--pairwise-open' in sys.argv:
        # F0 and F1 have a common root precisely when c=a*b,
        # provided c is nonzero. This is an ACTUAL disjointness condition.
        factor *= cc-aa*bb
    ideal=S.ideal([lift(k) for k in ks]+[z*factor-1])
    gb=ideal.groebner_basis()
    result={'necessary_open_dimension':int(ideal.dimension()),
            'basis_count':len(gb),
            'basis_degrees':[int(v.total_degree()) for v in gb],
            'basis':[str(v) for v in gb],
            'cpu_seconds':time.process_time()-started,
            'status':'necessary-open calculation; discriminant not yet imposed'}
    name='pairwise_open_basis.json' if '--pairwise-open' in sys.argv else 'necessary_open_basis.json'
    (dest/name).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='basis'},indent=2))
