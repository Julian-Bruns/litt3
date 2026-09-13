#!/usr/bin/env python3
"""Transport and track the COMPLETE pole guards on the reduced degree84 chart.

The guarded system has finite etale rank<=2 by the audited geometric
theorem. This script merely gives exact polynomial identities; no exclusion.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse,hashlib,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing
from sage.libs.singular.function import singular_function
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from scripts.atlases.algebra.sparse_polynomial_substitution import SparsePolynomialTransport

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('full_source',type=Path);p.add_argument('guarded_source',type=Path)
p.add_argument('affine_source',type=Path);p.add_argument('reduced_source',type=Path)
p.add_argument('out',type=Path);p.add_argument('--seconds',type=int,default=120)
p.add_argument('--basis-rows',type=int,default=185);args=p.parse_args()
args.out.mkdir(exist_ok=False);start=time.monotonic()
load=lambda path:json.loads(path.read_text())
full=load(args.full_source);old=load(args.guarded_source);aff=load(args.affine_source);reduced=load(args.reduced_source)
assert old['variables'][:len(full['variables'])]==full['variables']==aff['original_variables']
assert aff['variables']==reduced['variables']
for key in ('field_degree','field_modulus'):
    assert full[key]==old[key]==aff[key]==reduced[key]
for f,g in zip(full['equations'],old['equations']):
    assert {tuple(e):c for e,c in f}=={tuple(e[:len(full['variables'])]):c for e,c in g}
    assert all(not any(e[len(full['variables']):]) for e,c in g)
assert len(old['equations'])==len(full['equations'])+5
newnames=old['variables'][len(full['variables']):]
assert newnames==['pole1_inv','pole2_inv','pole3_inv','polealpha_inv','polesf_inv']
k=GF(5**full['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(full['field_modulus']))
R=PolynomialRing(k,old['variables'],order='degrevlex')
S=PolynomialRing(k,reduced['variables']+newnames,order='degrevlex')
Ra=PolynomialRing(k,full['variables'],order='degrevlex')
decode=lambda ring,f:ring({tuple(e):k(c) for e,c in f})
encode=lambda f:[[list(e),list(map(int,c.polynomial().list()))] for e,c in f.dict().items()]
subs={name:decode(Ra,f) for name,f in aff['substitutions'].items()}
images=[S(subs[name]) if name in subs else S(name) for name in old['variables']]
transport=SparsePolynomialTransport(R,S,images)
base=[S({tuple(e)+(0,)*len(newnames):k(c) for e,c in f}) for f in reduced['equations']]
basis=base[:args.basis_rows]
result=dict(status='running',theorem='triangle237_small_solution_algebra',
    scope='Exact guarded coefficient system of rank<=2; emptiness unresolved')
alarm(args.seconds)
try:
    guards=[transport(decode(R,f)) for f in old['equations'][len(full['equations']):]]
    report=dict(stage='guards_transported',terms=[len(f.dict()) for f in guards],
                degrees=[int(f.total_degree()) for f in guards],seconds=time.monotonic()-start)
    print(json.dumps(report),flush=True)
    bound=max(int(f.total_degree()) for f in guards)
    Q,rem=singular_function('division')(S.ideal(guards),S.ideal(basis),bound)
    rem=[S(f) for f in rem]
    for j,f in enumerate(guards):assert f==rem[j]+sum(Q[i,j]*b for i,b in enumerate(basis))
    rawsource=dict(prime=5,field_degree=full['field_degree'],field_modulus=full['field_modulus'],
        variables=list(S.variable_names()),equations=[encode(f) for f in base+guards],
        guarded_original=str(args.guarded_source.resolve()),
        guarded_original_sha256=hashlib.sha256(args.guarded_source.read_bytes()).hexdigest(),
        affine_source=str(args.affine_source.resolve()),
        affine_source_sha256=hashlib.sha256(args.affine_source.read_bytes()).hexdigest(),
        reduced_source=str(args.reduced_source.resolve()),
        reduced_source_sha256=hashlib.sha256(args.reduced_source.read_bytes()).hexdigest())
    rawpath=args.out/'guard_source.json';rawpath.write_text(json.dumps(rawsource,separators=(',',':'))+'\n')
    one=encode(S.one());weights=[[[i,one]] for i in range(len(base))]
    weights+=[[[len(base)+j,one]]+[[i,encode(-Q[i,j])] for i in range(len(basis)) if Q[i,j]] for j in range(len(guards))]
    cert=dict(variables=list(S.variable_names()),field_degree=full['field_degree'],field_modulus=full['field_modulus'],
        equations=[encode(f) for f in base+rem],polynomial_multipliers=weights,
        source=str(rawpath.resolve()),source_sha256=hashlib.sha256(rawpath.read_bytes()).hexdigest())
    (args.out/'guard_identities.json').write_text(json.dumps(cert,separators=(',',':'))+'\n')
    output={key:rawsource[key] for key in ('prime','field_degree','field_modulus','variables')}
    output.update(equations=cert['equations'],provenance=str((args.out/'guard_identities.json').resolve()),
                  scope=result['scope'])
    (args.out/'source.json').write_text(json.dumps(output,separators=(',',':'))+'\n')
    result.update(status='complete',guard_terms_before=report['terms'],guard_terms_after=[len(f.dict()) for f in rem],
                  variables=S.ngens(),equations=len(base)+len(rem),total_terms=sum(len(f.dict()) for f in base+rem),
                  multiplier_terms=sum(len(w) for row in weights for _,w in row))
except AlarmInterrupt:result['status']='time_limit_no_verdict'
finally:
    cancel_alarm();result['seconds']=time.monotonic()-start
    (args.out/'result.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)
if result['status']!='complete':raise SystemExit(3)
