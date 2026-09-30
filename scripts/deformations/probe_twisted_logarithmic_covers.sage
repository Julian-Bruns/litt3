#!/usr/bin/env sage -python
"""Explore all fifteen nontrivial two-torsion Cartier blocks on the backup.

No BT group existence is inferred from a solution of these cubic equations.
Output is a scoped algebra experiment, pending geometric integration.
"""
import argparse
import itertools
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--output',type=Path,required=True)
args=ap.parse_args()
root=Path(__file__).resolve().parents[2]
if args.output.resolve().is_relative_to(root):
    ap.error('Write generated data outside the workspace')
B=PolynomialRing(GF(5),'a'); a0=B.gen()
k=GF(125,name='a',modulus=a0**3+a0+1); a=k.gen()
R=PolynomialRing(k,names=('q0','q1','c','inv'),order='degrevlex')
q0,q1,c,iv=R.gens()
P=PolynomialRing(R,'x'); x=P.gen()
f=x
for b in (k(0),k(1),k(2),k(3),a): f*=1+(4-b)*x
roots=[k(0)]+[(b-4)**-1 for b in (k(0),k(1),k(2),k(3),a)]
out={'field':'F125','base_sextic':str(f),'results':[]}
for index,(aa,bb) in enumerate(itertools.combinations(roots,2)):
    start=time.monotonic(); d=(x-aa)*(x-bb); rest=f//d; ell=q0+q1*x
    even=d*ell**3*rest**2+3*ell*c*c*rest**3
    odd=3*d**3*ell**2*c+d*d*c**3*rest
    cubics=[even[4],even[9],odd[4]]
    eq=[cubics[i]-(q0,q1,c)[i]**5 for i in range(3)]
    jac=matrix(R,3,3,[g.derivative(v) for g in cubics for v in (q0,q1,c)])
    determinant=jac.det()
    charts=[]
    for variable in (q0,q1,c):
        ideal=R.ideal(eq+[determinant,iv*variable-1])
        gb=ideal.groebner_basis()
        charts.append({'chart':str(variable),'empty':list(gb)==[R.one()],
                       'dimension':int(ideal.dimension()),
                       'basis':[str(g) for g in gb]})
    row={'index':index,'branch_pair':[str(aa),str(bb)],
         'cubics':[str(g) for g in cubics],'bad_nonzero_charts':charts,
         'seconds':time.monotonic()-start}
    out['results'].append(row)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print(index,row['branch_pair'],'bad empty',[r['empty'] for r in charts],
          'seconds',row['seconds'],flush=True)
