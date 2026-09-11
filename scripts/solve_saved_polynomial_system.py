#!/usr/bin/env python3
"""Bounded native Singular experiment on a saved exact polynomial system.

A unit basis is a candidate until the independent polynomial identity
and all geometric substitutions have been replayed.
"""
import argparse,hashlib,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from export_polynomial_macaulay import export_system
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('output',type=Path)
p.add_argument('--algorithm',choices=['std','slimgb'],default='slimgb')
p.add_argument('--seconds',type=int,default=180)
p.add_argument('--degree-bound',type=int,
               help='Singular partial degree bound; a nonunit result is NOT a full basis')
p.add_argument('--linear-export',type=Path,
               help='export a fresh recursively affine-reduced source before solving')
p.add_argument('--prepare-only',action='store_true')
args=p.parse_args();start=time.monotonic();raw=args.source.read_bytes();data=json.loads(raw)
K=GF(5**data['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
R=PolynomialRing(K,len(data['variables']),names=data['variables'],order='degrevlex')
eq=[R({tuple(e):K(c) for e,c in f}) for f in data['equations']]
if args.linear_export:
    export_system(R,eq,args.linear_export,c_degree=0,full_degree=2,field_only=True,eliminate_linear=True)
    (args.linear_export/'previous_source.json').write_text(json.dumps(dict(
        source=str(args.source.resolve()),sha256=hashlib.sha256(raw).hexdigest()),indent=2)+'\n')
    args.source=args.linear_export/'source.json';raw=args.source.read_bytes();data=json.loads(raw)
    R=PolynomialRing(K,len(data['variables']),names=data['variables'],order='degrevlex')
    eq=[R({tuple(e):K(c) for e,c in f}) for f in data['equations']]
result=dict(source=str(args.source.resolve()),source_sha256=hashlib.sha256(raw).hexdigest(),
    variables=R.ngens(),equations=len(eq),terms=sum(len(f.dict()) for f in eq),
    algorithm=args.algorithm,degree_bound=args.degree_bound,status='running',unit=None)
def save():
    result['seconds']=time.monotonic()-start
    args.output.write_text(json.dumps(result,indent=2)+'\n')
save();print(json.dumps(result),flush=True)
if args.prepare_only:
    result['status']='prepared_only';save();raise SystemExit(0)
alarm(args.seconds)
try:
    basis=list(R.ideal(eq).groebner_basis(algorithm='libsingular:'+args.algorithm,
                                         deg_bound=args.degree_bound))
    result.update(status='complete' if args.degree_bound is None else 'bounded_basis_only',
                  basis_size=len(basis),unit=(basis==[R.one()]))
    args.output.with_suffix('.basis.txt').write_text('\n'.join(str(f) for f in basis)+'\n')
    args.output.with_suffix('.basis.json').write_text(json.dumps(dict(
        variables=data['variables'],field_modulus=data['field_modulus'],
        source=str(args.source.resolve()),source_sha256=hashlib.sha256(raw).hexdigest(),
        degree_bound=args.degree_bound,
        equations=[[[list(e),list(map(int,c.polynomial().list()))] for e,c in f.dict().items()]
                   for f in basis],
        scope='Native candidate basis; independent polynomial provenance still required'),
        separators=(',',':'))+'\n')
except AlarmInterrupt:result['status']='time_limit'
finally:cancel_alarm();save()
print(json.dumps(result),flush=True)
