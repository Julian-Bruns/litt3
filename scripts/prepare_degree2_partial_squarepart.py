#!/usr/bin/env python3
"""Eliminate a few triangular N coefficients, retaining the leading-unit guard.

This is exact open-chart transport, not a coefficient specialization. It
measures whether limited elimination avoids the dense full R substitution.
"""
import argparse,hashlib,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from export_polynomial_macaulay import export_system

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('out',type=Path)
p.add_argument('--eliminate-n',type=int,default=2)
p.add_argument('--full-degree',type=int,default=1)
p.add_argument('--groebner',action='store_true');p.add_argument('--seconds',type=int,default=180)
args=p.parse_args();start=time.monotonic();raw=args.source.read_bytes();data=json.loads(raw)
K=GF(5**data['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
R=PolynomialRing(K,data['variables'],order='degrevlex');names=list(data['variables'])
eq=[R({tuple(e):K(c) for e,c in f}) for f in data['equations']]
original=list(eq);lead=max((s for s in names if s.startswith('l') and s[1:].isdigit()),key=lambda s:int(s[1:]))
li=names.index(lead);vi=names.index('lead_inv');guard=R.gen(li)*R.gen(vi)-1
assert guard in eq
def normalize(f):
    result={}
    for exponent,c in f.dict().items():
        e=list(exponent);n=min(e[li],e[vi]);e[li]-=n;e[vi]-=n;e=tuple(e)
        result[e]=result.get(e,K.zero())+c
    return R(result)

images=list(R.gens());steps=[];removed=[]
targets=sorted((s for s in names if s.startswith('n') and s[1:].isdigit()),key=lambda s:-int(s[1:]))
for name in targets[:args.eliminate_n]:
    variable=R(name);i=names.index(name);candidates=[]
    for j,f in enumerate(eq):
        if f.degree(variable)!=1:continue
        coefficient=f.derivative(variable);terms=coefficient.dict()
        if len(terms)!=1:continue
        exponent,c=next(iter(terms.items()))
        if any(v for n,v in enumerate(exponent) if n!=li):continue
        power=int(exponent[li]);inverse=(c**-1)*R.gen(vi)**power
        assert normalize(coefficient*inverse)==1
        at_zero=R.hom([R.zero() if n==i else g for n,g in enumerate(R.gens())],R)(f)
        solution=normalize(-at_zero*inverse)
        candidates.append((len(solution.dict()),j,solution,coefficient))
    if not candidates:break
    _,j,solution,coefficient=min(candidates,key=lambda t:(t[0],t[1]))
    change=R.hom([solution if n==i else g for n,g in enumerate(R.gens())],R)
    assert normalize(change(eq[j]))==0
    eq=[normalize(change(f)) for f in eq if f!=guard]
    eq=[f for f in eq if f];eq.append(guard)
    images=[normalize(change(f)) for f in images]
    removed.append(name)
    steps.append(dict(variable=name,pivot_index=j,coefficient=str(coefficient),
                      solution=str(solution),terms=sum(len(f.dict()) for f in eq),
                      maximum_degree=int(max(f.total_degree() for f in eq))))
    print(json.dumps(steps[-1]),flush=True)

kept=[n for n,name in enumerate(names) if name not in removed]
target=PolynomialRing(K,[names[n] for n in kept],order='degrevlex')
def project(f):
    assert all(not e[n] for e in f.dict() for n,name in enumerate(names) if name in removed)
    return target({tuple(e[n] for n in kept):c for e,c in f.dict().items()})
target_eq=[project(f) for f in eq]
complete=R.hom(images,R)
assert all(normalize(complete(f))==0 or normalize(complete(f)) in eq for f in original if f!=guard)
export_system(target,target_eq,args.out,c_degree=0,field_only=True,
              full_degree=args.full_degree,eliminate_linear=False)
encode=lambda f:[[list(e),[int(v) for v in c.polynomial().list()]] for e,c in sorted(f.dict().items())]
provenance=dict(source=str(args.source.resolve()),source_sha256=hashlib.sha256(raw).hexdigest(),
    original_variables=names,target_variables=target.variable_names(),
    reconstruction=[encode(project(f)) for f in images],steps=steps,
    guard='leading(L)*lead_inv-1',
    scope='Exact elimination using only powers of the recorded leading unit; no original solutions discarded')
(args.out/'partial_elimination.json').write_text(json.dumps(provenance,indent=2)+'\n')
summary=dict(variables=target.ngens(),equations=len(target_eq),
    terms=sum(len(f.dict()) for f in target_eq),
    maximum_degree=int(max(f.total_degree() for f in target_eq)),
    construction_seconds=time.monotonic()-start)
print(json.dumps(summary),flush=True)
if args.groebner:
    started=time.monotonic();alarm(args.seconds)
    try:
        basis=list(target.ideal(target_eq).groebner_basis(algorithm='libsingular:slimgb'))
        summary.update(status='complete',unit=basis==[target.one()],basis_size=len(basis))
        (args.out/'groebner_basis.txt').write_text('\n'.join(map(str,basis))+'\n')
    except AlarmInterrupt:summary.update(status='time_limit',unit=None)
    finally:cancel_alarm()
    summary['groebner_seconds']=time.monotonic()-started
    (args.out/'groebner_result.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary),flush=True)
