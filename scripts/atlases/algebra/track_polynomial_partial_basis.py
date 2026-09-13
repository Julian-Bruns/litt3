#!/usr/bin/env python3
"""Bounded Singular liftstd with explicit original-equation provenance.

Every returned basis row is checked as a polynomial identity before export.
The output is a partial basis, never an assertion of full ideal stability.
"""
import argparse,json,hashlib,time
from pathlib import Path
from sage.all import GF,PolynomialRing,singular
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt

p=argparse.ArgumentParser(description=__doc__);p.add_argument('source',type=Path)
p.add_argument('out',type=Path);p.add_argument('--degree-bound',type=int,default=3)
p.add_argument('--seconds',type=int,default=180)
p.add_argument('--external-replay',action='store_true',
    help='Export exact multiplier rows, then require independent replay instead of repeating slow Sage expansion')
args=p.parse_args()
args.out.mkdir(exist_ok=False);raw=args.source.read_bytes();data=json.loads(raw);start=time.monotonic()
k=GF(5**data['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
R=PolynomialRing(k,len(data['variables']),names=data['variables'],order='degrevlex')
equations=[R({tuple(e):k(c) for e,c in f}) for f in data['equations']]
result=dict(status='running',source=str(args.source.resolve()),
    source_sha256=hashlib.sha256(raw).hexdigest(),degree_bound=args.degree_bound,
    scope='Tracked partial standard basis; no ideal stability or exclusion')
alarm(args.seconds)
try:
    original=singular(R.ideal(equations))
    singular.eval('degBound='+str(args.degree_bound)+'; option(redSB); option(redTail);')
    print(json.dumps(dict(stage='tracked_basis_started',seconds=time.monotonic()-start)),flush=True)
    singular.eval('matrix trackedTransform; ideal trackedBasis=liftstd('+original.name()+',trackedTransform);')
    basis=[R(f) for f in singular('trackedBasis').sage().gens()]
    transform=singular('trackedTransform').sage()
    assert transform.nrows()==len(equations) and transform.ncols()==len(basis)
    print(json.dumps(dict(stage='tracked_basis_returned',rows=len(basis),
                         seconds=time.monotonic()-start)),flush=True)
    encode=lambda f:[[list(e),list(map(int,c.polynomial().list()))] for e,c in f.dict().items()]
    witnesses=[]
    for j,f in enumerate(basis):
        weights=[R(transform[i,j]) for i in range(len(equations))]
        if not args.external_replay:
            assert sum(w*g for w,g in zip(weights,equations))==f
        witnesses.append([[i,encode(w)] for i,w in enumerate(weights) if w])
    payload=dict(variables=data['variables'],field_degree=data['field_degree'],
        field_modulus=data['field_modulus'],source=str(args.source.resolve()),
        source_sha256=result['source_sha256'],degree_bound=args.degree_bound,
        equations=[encode(f) for f in basis],polynomial_multipliers=witnesses,
        all_identities_replayed_in_original_ring=not args.external_replay,
        scope='Exact partial-basis row identities; independent standard-library replay pending')
    (args.out/'basis.json').write_text(json.dumps(payload,separators=(',',':'))+'\n')
    result.update(status='complete',basis_size=len(basis),basis_terms=sum(len(f.dict()) for f in basis),
        multiplier_terms=sum(len(f) for row in witnesses for _,f in row),unit=(basis==[R.one()]))
except AlarmInterrupt:result['status']='time_limit_no_verdict'
except Exception as e:
    result.update(status='implementation_error_no_verdict',error=repr(e))
    raise
finally:
    cancel_alarm();singular.quit();result['seconds']=time.monotonic()-start
    (args.out/'result.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)
