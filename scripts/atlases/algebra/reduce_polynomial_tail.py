#!/usr/bin/env python3
"""Divide tail rows by a fixed prefix, exporting explicit row identities."""
import argparse,hashlib,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix
from sage.libs.singular.function import singular_function
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('out',type=Path)
p.add_argument('--prefix',type=int,required=True)
p.add_argument('--explicit',action='store_true',help='Use ordered global leading-term division, without a standard-basis computation')
args=p.parse_args()
args.out.mkdir(exist_ok=False);raw=args.source.read_bytes();s=json.loads(raw);start=time.monotonic()
K=GF(5**s['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(s['field_modulus']))
R=PolynomialRing(K,s['variables'],order='degrevlex')
eq=[R({tuple(e):K(c) for e,c in f}) for f in s['equations']]
prefix,tail=eq[:args.prefix],eq[args.prefix:];assert prefix and tail
if args.explicit:
    Q=matrix(R,len(prefix),len(tail));rems=[]
    leads=[(tuple(g.lm().exponents()[0]),g.lc()) for g in prefix]
    for j,f in enumerate(tail):
        remaining=f;remainder=R.zero();steps=0
        while remaining:
            e=tuple(remaining.lm().exponents()[0]);c=remaining.lc()
            for i,(de,dc) in enumerate(leads):
                if all(x>=y for x,y in zip(e,de)):
                    factor=R({tuple(x-y for x,y in zip(e,de)):c/dc})
                    Q[i,j]+=factor;remaining-=factor*prefix[i];break
            else:
                term=R({e:c});remainder+=term;remaining-=term
            steps+=1
            assert steps<2000000,'division operation cap'
        rems.append(remainder)
        print(json.dumps(dict(stage='explicit_division',row=j,steps=steps,terms=len(remainder.dict()),
                             seconds=time.monotonic()-start)),flush=True)
else:
    Q,rems=singular_function('division')(R.ideal(tail),R.ideal(prefix),max(int(f.total_degree()) for f in tail))
rems=list(map(R,rems));assert Q.nrows()==len(prefix) and Q.ncols()==len(tail)
enc=lambda f:[[list(e),list(map(int,c.polynomial().list()))] for e,c in f.dict().items()]
one=enc(R.one());rows=list(prefix);weights=[[[i,one]] for i in range(len(prefix))]
for j,(f,r) in enumerate(zip(tail,rems)):
    assert f==r+sum(Q[i,j]*b for i,b in enumerate(prefix))
    if r:
        rows.append(r);weights.append([[len(prefix)+j,one]]+[[i,enc(-Q[i,j])] for i in range(len(prefix)) if Q[i,j]])
payload={k:s[k] for k in ('field_degree','field_modulus','variables')}
payload.update(source=str(args.source.resolve()),source_sha256=hashlib.sha256(raw).hexdigest(),
               equations=[enc(f) for f in rows],polynomial_multipliers=weights,
               scope='Exact polynomial division identities; independent replay required')
(args.out/'identities.json').write_text(json.dumps(payload,separators=(',',':'))+'\n')
out={k:s[k] for k in ('prime','field_degree','field_modulus','variables')}
out.update(equations=payload['equations'],provenance=str((args.out/'identities.json').resolve()))
(args.out/'source.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
print(json.dumps(dict(rows=len(rows),terms=sum(len(f.dict()) for f in rows),
                     remainder_degrees=[int(f.total_degree()) for f in rems],
                     seconds=time.monotonic()-start)))
