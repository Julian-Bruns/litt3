#!/usr/bin/env python3
"""Find a small unit subsystem using a previously computed candidate basis.

This is discovery only. Original-equation identities are required separately.
Every exported subsystem is an exact subset of its source rows.
"""
import argparse, hashlib, json, time
from pathlib import Path
from sage.all import GF, PolynomialRing
from cysignals.alarm import alarm, cancel_alarm, AlarmInterrupt

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('low_source',type=Path)
p.add_argument('basis',type=Path);p.add_argument('out',type=Path)
p.add_argument('--seconds',type=int,default=120)
args=p.parse_args();args.out.mkdir(exist_ok=False);start=time.monotonic()
raw=args.source.read_bytes();src=json.loads(raw)
low=json.loads(args.low_source.read_text());bs=json.loads(args.basis.read_text())
K=GF(5**src['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(src['field_modulus']))
R=PolynomialRing(K,src['variables'],order='degrevlex')
decode=lambda f:R({tuple(e):K(c) for e,c in f})
eq=list(map(decode,src['equations']));leq=list(map(decode,low['equations']))
gb=list(map(decode,bs['equations']))
assert bs['source_sha256']==hashlib.sha256(args.low_source.read_bytes()).hexdigest()
assert all(f in eq for f in leq)
result=dict(status='running',scope='Candidate discovery; independent provenance still required')
alarm(args.seconds)
try:
    rem=[]
    for i,f in enumerate(eq):
        r=f.reduce(gb)
        if r:rem.append((len(r.dict()),int(r.total_degree()),i,r))
    rem.sort(key=lambda v:v[:3])
    result['nonzero_remainders']=len(rem)
    print(json.dumps(dict(stage='remainders',seconds=time.monotonic()-start,
          low_rows=len(leq),basis_rows=len(gb),degrees=sorted(set(int(g.total_degree()) for g in gb)),
          easiest=[dict(terms=n,degree=d,index=i) for n,d,i,_ in rem[:12]])),flush=True)
    selected=[eq.index(f) for f in leq]
    for n,d,i,r in rem:
        test=list(R.ideal(gb+[r]).groebner_basis(algorithm='libsingular:slimgb'))
        print(json.dumps(dict(stage='test',index=i,unit=(test==[R.one()]),
                             basis_size=len(test),seconds=time.monotonic()-start)),flush=True)
        selected.append(i)
        if test==[R.one()]:
            payload=dict(prime=src['prime'],field_degree=src['field_degree'],field_modulus=src['field_modulus'],
                variables=src['variables'],equations=[src['equations'][j] for j in selected],
                parent_source=str(args.source.resolve()),parent_source_sha256=hashlib.sha256(raw).hexdigest(),
                selected_original_indices=selected,scope='Exact subset; unit candidate requires identity')
            (args.out/'source.json').write_text(json.dumps(payload,separators=(',',':'))+'\n')
            result.update(status='unit_candidate',rows=len(selected),terms=sum(len(src['equations'][j]) for j in selected))
            break
        gb=test
    else:result['status']='nonunit_candidate'
except (AlarmInterrupt,KeyboardInterrupt):result['status']='time_limit_no_verdict'
finally:
    cancel_alarm();result['seconds']=time.monotonic()-start
    (args.out/'result.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)
