#!/usr/bin/env python3
"""Test a partial quadratic-subideal basis against the FULL degree84 equations.

Prototype only: exported residuals need tracked basis provenance before use
as accepted consequences. All original equations are retained after exact
affine transport; no passport equation is silently dropped.
"""
import argparse,json,time,hashlib
from pathlib import Path
from sage.all import GF,PolynomialRing
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from sparse_polynomial_substitution import SparsePolynomialTransport

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('full_source',type=Path);p.add_argument('affine_source',type=Path)
p.add_argument('basis',type=Path);p.add_argument('out',type=Path)
p.add_argument('--seconds',type=int,default=120);args=p.parse_args()
args.out.mkdir(exist_ok=False);started=time.monotonic()
full=json.loads(args.full_source.read_text());aff=json.loads(args.affine_source.read_text())
partial=json.loads(args.basis.read_text())
k=GF(5**full['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(full['field_modulus']))
R=PolynomialRing(k,len(full['variables']),names=full['variables'],order='degrevlex')
S=PolynomialRing(k,len(aff['variables']),names=aff['variables'],order='degrevlex')
decode=lambda ring,f:ring({tuple(e):k(c) for e,c in f})
assert full['variables']==aff['original_variables'] and aff['variables']==partial['variables']
subs={name:decode(R,f) for name,f in aff['substitutions'].items()}
images=[S(subs.get(name,R.gen(i))) for i,name in enumerate(full['variables'])]
transport=SparsePolynomialTransport(R,S,images)
basis=[decode(S,f) for f in partial['equations']]
equations=[decode(R,f) for f in full['equations']]
result=dict(status='running',scope='Partial native basis prototype; no accepted unit/exclusion',
    full_source=str(args.full_source.resolve()),affine_source=str(args.affine_source.resolve()),
    candidate_basis=str(args.basis.resolve()),basis_size=len(basis),rows=[])
alarm(args.seconds)
try:
    residuals=[]
    for i,f in enumerate(equations):
        g=transport(f);h=g.reduce(basis)
        result['rows'].append(dict(index=i,original_terms=len(f.dict()),
            transported_terms=len(g.dict()),reduced_terms=len(h.dict()),
            reduced_degree=int(h.total_degree()) if h else -1))
        if h:residuals.append(h)
        if i%20==0:print(json.dumps(dict(stage='residual',index=i,
            seconds=time.monotonic()-started,terms=len(h.dict()))),flush=True)
    result.update(status='complete',residual_equations=len(residuals),
        transported_terms=sum(r['transported_terms'] for r in result['rows']),
        reduced_terms=sum(r['reduced_terms'] for r in result['rows']),
        has_nonzero_constant=any(f.total_degree()==0 for f in residuals))
    encode=lambda f:[[list(e),list(map(int,c.polynomial().list()))] for e,c in f.dict().items()]
    (args.out/'candidate_source.json').write_text(json.dumps(dict(
        prime=5,field_degree=full['field_degree'],field_modulus=full['field_modulus'],
        variables=aff['variables'],equations=[encode(f) for f in basis+residuals],
        scope=result['scope']),separators=(',',':'))+'\n')
except AlarmInterrupt:result['status']='time_limit_no_verdict'
finally:
    cancel_alarm();result['seconds']=time.monotonic()-started
    (args.out/'result.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='rows'}),flush=True)
