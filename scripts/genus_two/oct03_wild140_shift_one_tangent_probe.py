#!/usr/bin/env -S sage -python
"""New first-order diagnostic on the saved exact fiber; no point census."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector

signal.alarm(5)
out=Path('../litt3-computation-data/oct03_wild140_shift_one_completion_gate')
old=json.loads((out/'receipt.json').read_text())
R=PolynomialRing(GF(5),names=('Q','B','S','T'))
Q,B,S,T=R.gens();Rw=PolynomialRing(R,'w');w=Rw.gen()
l=3+2*Q+2*T
A=w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3
Phi=w**5+Q*w**4+S;bb=w-T
odd=(A**3+3*A*Phi*bb**2)*Phi**2
rows=[R(odd[j]) for j in (14,9,4)]
N=A**2-Phi*bb**2
Rq=PolynomialRing(GF(5),'q');q=Rq.gen()
# The original fiber basis is read, not recomputed.
RF=PolynomialRing(GF(5),names=('B','S','Z','Q'),order='lex')
BF,SF,ZF,QF=RF.gens()
fiber=[RF(p) for p in old['cartier_basis']]
bexpr=Rq(str(BF-fiber[0]).replace('Q','q'))
sexpr=Rq(str(SF-fiber[1]).replace('Q','q'))
results=[]
for old_entry in old['results']:
    f=Rq(old_entry['modulus']);F=GF(5**f.degree(),name='a',modulus=f)
    a=F.gen();b=bexpr(a);s=sexpr(a);point=(a,b,s,F(1))
    assert all(row(*point)==0 for row in rows)
    jac=matrix(F,[[row.derivative(var)(*point) for var in (Q,B,S)] for row in rows])
    dt=vector(F,[-row.derivative(T)(*point) for row in rows])
    tangent=jac.solve_right(dt)
    K=PolynomialRing(F,'w');ww=K.gen()
    norm=K([co(*point) for co in N.list()])
    common=norm.gcd(norm.derivative())
    coefficients=[]
    for co in N.list():
        val=co.derivative(T)(*point)
        val+=sum(co.derivative(var)(*point)*tangent[j]
                 for j,var in enumerate((Q,B,S)))
        coefficients.append(val)
    variation=K(coefficients)
    remainder=variation%common
    results.append({'field_degree':int(f.degree()),'modulus':str(f),
                    'jacobian_nonsingular':bool(jac.det()),
                    'norm_gcd_degree':int(common.degree()),
                    'tangent':[str(x) for x in tangent],
                    'norm_variation_mod_gcd':str(remainder),
                    'first_order_persistent':remainder==0})
signal.alarm(0)
(out/'tangent_receipt.json').write_text(json.dumps(results,indent=2)+'\n')
print(json.dumps([{k:r[k] for k in ('field_degree','norm_gcd_degree','first_order_persistent')}
                  for r in results]))
