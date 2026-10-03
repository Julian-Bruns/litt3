#!/usr/bin/env sage
"""Descend and factor the stored degree40 parameter support; no replay."""
import json,time
from pathlib import Path
started=time.monotonic();folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text())
R5=PolynomialRing(GF(5),'t');t=R5.gen()
F8=GF(5**8,'e',modulus=R5(data['field_modulus']));beta8=F8(data['beta_coordinates'])
F25=GF(25,'b',modulus=t*t-t-3);beta=F25.gen();L=PolynomialRing(F25,'lam')
to25={F8(c%5)+F8(c//5)*beta8:F25(c%5)+F25(c//5)*beta for c in range(25)}
product=L([to25[F8(v)] for v in data['product_polynomial']])
assert product.gcd(product.derivative()).degree()==0
factors=list(product.factor())
def code(c):
 cs=c.polynomial().list();return int(cs[0] if cs else 0)+(5*int(cs[1]) if len(cs)>1 else 0)
out={'scope':'Factorization of already stored same-fiber pair necessary support overF25; no actual-source decision.',
     'F25_modulus':[int(c) for c in F25.modulus().list()],'product':[code(c) for c in product],
     'product_degree':int(product.degree()),'squarefree':True,
     'factors':[{'degree':int(f.degree()),'multiplicity':int(m),'polynomial':[code(c) for c in f]} for f,m in factors],
     'seconds':time.monotonic()-started,'sage_version':version()}
(folder/'same_fiber_pair_support_F25.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('PASSdegree',product.degree(),'factors',[(f.degree(),m) for f,m in factors],'seconds',time.monotonic()-started)
