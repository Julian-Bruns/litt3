#!/usr/bin/env -S sage -python
"""Order-six diagnostic from a saved fiber, not a generic certificate."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing, PowerSeriesRing, matrix, vector

signal.alarm(6)
out=Path('../litt3-computation-data/oct03_wild140_shift_one_completion_gate')
old=json.loads((out/'receipt.json').read_text())
R=PolynomialRing(GF(5),names=('Q','B','S','T'));Q,B,S,T=R.gens()
Rw=PolynomialRing(R,'w');w=Rw.gen();l=3+2*Q+2*T
A=w**3+l*w**2+B*w-B*(l-T)+3*T*l**2+Q*T**3
Phi=w**5+Q*w**4+S;bb=w-T
odd=(A**3+3*A*Phi*bb**2)*Phi**2
rows=[R(odd[j]) for j in (14,9,4)];N=-(A**2-Phi*bb**2)
Rq=PolynomialRing(GF(5),'q');q=Rq.gen()
RF=PolynomialRing(GF(5),names=('B','S','Z','Q'),order='lex')
BF,SF,ZF,QF=RF.gens();fiber=[RF(p) for p in old['cartier_basis']]
bexpr=Rq(str(BF-fiber[0]).replace('Q','q'))
sexpr=Rq(str(SF-fiber[1]).replace('Q','q'))
results=[]
for old_entry in old['results']:
    f=Rq(old_entry['modulus']);F=GF(5**f.degree(),name='a',modulus=f)
    a=F.gen();b=bexpr(a);s=sexpr(a);base=(a,b,s,F(1))
    jac=matrix(F,[[row.derivative(v)(*base) for v in (Q,B,S)] for row in rows])
    K=PolynomialRing(F,'w');ww=K.gen()
    n0=K([co(*base) for co in N.list()]);d0=n0.gcd(n0.derivative()).monic()
    entry={'field_degree':int(f.degree()),'norm_gcd_degree':int(d0.degree())}
    if d0.gcd(d0.derivative()).degree() or n0%d0**2:
        entry['double_factor_slice']=False;results.append(entry);continue
    e0=n0//d0**2
    assert d0.gcd(e0)==1
    columns=[2*d0*e0*ww**j for j in range(d0.degree())]
    columns += [d0**2*ww**j for j in range(e0.degree())]
    lin=matrix(F,[[co[i] for co in columns] for i in range(7)])
    PS=PowerSeriesRing(F,'e',default_prec=8);eps=PS.gen()
    KW=PolynomialRing(PS,'w');wx=KW.gen()
    pars=[PS(a),PS(b),PS(s)];ds=KW(d0);es=KW(e0)
    last=0
    for order in range(1,7):
        point=(*pars,1+eps)
        residual=vector(F,[row(*point)[order] for row in rows])
        delta=jac.solve_right(-residual)
        pars=[u+delta[j]*eps**order for j,u in enumerate(pars)]
        point=(*pars,1+eps)
        assert all(not any(row(*point)[j] for j in range(order+1)) for row in rows)
        ns=KW([co(*point) for co in N.list()]);difference=ns-ds**2*es
        rhs=vector(F,[difference[i][order] for i in range(7)])
        try:
            change=lin.solve_right(rhs)
        except ValueError:
            break
        ds+=sum(change[j]*eps**order*wx**j for j in range(d0.degree()))
        es+=sum(change[j+d0.degree()]*eps**order*wx**j for j in range(e0.degree()))
        assert all(not any((ns-ds**2*es)[i][j] for j in range(order+1)) for i in range(7))
        last=order
    entry.update({'double_factor_slice':True,'persistent_through_order':int(last),
                  'parameter_series':[str(u) for u in pars],
                  'double_factor_series':[str(u) for u in ds.list()]})
    results.append(entry)
signal.alarm(0)
(out/'hensel_receipt.json').write_text(json.dumps(results,indent=2)+'\n')
print(json.dumps([{k:v for k,v in r.items() if k not in ('parameter_series','double_factor_series')}
                  for r in results]))
