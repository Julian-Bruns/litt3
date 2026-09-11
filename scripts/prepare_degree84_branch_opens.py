#!/usr/bin/env python3
"""Retain the remaining ACTUAL pole/branch-disjointness opens.

The audited passport makes C squarefree and C(t)!=0 at all five finite
Weierstrass points. These are necessary opens, not genericity assumptions.
The saved exact c4 substitution and the input's alpha coefficient are checked.
"""
import argparse,json,hashlib,time
from pathlib import Path
from sage.all import GF,PolynomialRing
from export_polynomial_macaulay import export_system

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('c4_source',type=Path);p.add_argument('out',type=Path)
p.add_argument('--guards',choices=['roots','discriminant','both'],default='roots')
p.add_argument('--full-degree',type=int,default=1)
args=p.parse_args();started=time.monotonic();raw=args.source.read_bytes();data=json.loads(raw)
oldraw=args.c4_source.read_bytes();old=json.loads(oldraw)
assert old['field_modulus']==data['field_modulus']
K=GF(5**data['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
R=PolynomialRing(K,data['variables'],order='degrevlex')
equations=[R({tuple(e):K(c) for e,c in f}) for f in data['equations']]
v=R.gens_dict()
candidates=[f for f in equations if f.monomial_coefficient(v['b0']**2*v['b1'])==2
            and f.monomial_coefficient(v['c0']**6*v['c1'])==3]
assert len(candidates)==1
alpha=candidates[0].monomial_coefficient(v['a0']**2*v['c5'])/3
assert alpha**3+alpha+1==0
Old=PolynomialRing(K,old['original_variables'],order='degrevlex')
c4old=Old({tuple(e):K(c) for e,c in old['substitutions']['c4']})
assert set(map(str,c4old.variables()))<=set(data['variables'])
c4=R(c4old)
newnames=[]
if args.guards in ('roots','both'):newnames+=['pole1_inv','pole2_inv','pole3_inv','polealpha_inv']
if args.guards in ('discriminant','both'):newnames+=['polesf_inv']
assert not set(newnames)&set(data['variables'])
S=PolynomialRing(K,list(data['variables'])+newnames,order='degrevlex')
SU=PolynomialRing(S,'u');u=SU.gen()
C=u**6+sum(S(c4 if i==4 else v['c%d'%i])*u**i for i in range(6))
guards=[];descriptions=[]
if args.guards in ('roots','both'):
    for label,root in [('1',K(1)),('2',K(2)),('3',K(3)),('alpha',alpha)]:
        value=C(root);guards.append(S('pole%s_inv'%label)*value-1)
        descriptions.append(dict(open='C('+label+')!=0',value=str(value)))
if args.guards in ('discriminant','both'):
    disc=C.discriminant();guards.append(S('polesf_inv')*disc-1)
    descriptions.append(dict(open='disc(C)!=0',terms=len(disc.dict()),degree=int(disc.total_degree())))
print(json.dumps(dict(stage='actual_opens_constructed',guards=descriptions,
    seconds=time.monotonic()-started)),flush=True)
export_system(S,[S(f) for f in equations]+guards,args.out,c_degree=0,
              full_degree=args.full_degree,field_only=True,eliminate_linear=False)
(args.out/'geometric_open_provenance.json').write_text(json.dumps(dict(
    previous_source=str(args.source.resolve()),source_sha256=hashlib.sha256(raw).hexdigest(),
    c4_source=str(args.c4_source.resolve()),c4_source_sha256=hashlib.sha256(oldraw).hexdigest(),
    c4_substitution=str(c4),alpha=list(map(int,alpha.polynomial().list())),guards=descriptions,
    theorem='triangle237_cofactor_necessary_system',
    scope='Necessary opens for actual squarefree disjoint passport; no exclusion'),indent=2)+'\n')
