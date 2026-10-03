#!/usr/bin/env sage
"""Independent NTL normalforms and localization support for native target data."""
from sage.all import *
import argparse,numpy as np,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory',type=Path);p.add_argument('--indices',default='0,6,11,15,18,20');a=p.parse_args();d=a.directory;start=time.time();meta=json.loads((d/'metadata.json').read_text());cols=meta.get('module_columns',int(126));K=GF(5**8,name='z',modulus=PolynomialRing(GF(5),'t')(meta['field_modulus']));N=PolynomialRing(K,'eta',implementation='NTL');eta=N.gen();encoded=np.load(d/'small_certificate.npz');code={int(c):K.from_integer(int(c)) for c in np.unique(encoded['basis'])};rows=[[N([code[int(c)] for c in f]) for f in row] for row in encoded['basis']];f=N([K.from_integer(int(c)) for c in encoded['annihilator']]);unit=N.one();indices=[int(i) for i in a.indices.split(',')]
for factor in json.loads((d/'units.json').read_text()):unit*=N([K.from_integer(int(c)) for c in factor])
remaining=f;power=0
while remaining.degree()>0:
    g=remaining.gcd(unit);assert g.degree()>0;remaining//=g;power+=1
assert not unit**power%f
def leading(r):
    candidates=[(p.degree(),i) for i,p in enumerate(r) if p];return max(candidates,default=(-1,-1))
owner={};rowdegrees=[]
for i,r in enumerate(rows):
    degree,position=leading(r)
    rowdegrees.append(degree)
    if position>=0:assert position not in owner;owner[position]=i
assert len(owner)==int(95)+int(3)*meta.get('auxiliaries',int(0))
def normalform(t):
    rem=[N.zero()]*cols
    while True:
        degree,position=leading(t)
        if position<0:return rem
        if position in owner and degree>=rowdegrees[owner[position]]:
            r=rows[owner[position]];q,remainder=t[position].quo_rem(r[position]);assert q;t=[x-q*y for x,y in zip(t,r)]
        else:
            term=t[position][degree]*eta**degree;rem[position]+=term;t[position]-=term
for c in indices:
    t=[N.zero()]*cols;t[6*c]=f;assert not any(normalform(t));print('NTL_TARGET_PASS',c,'SECONDS',time.time()-start,flush=True)
unit_factors=json.loads((d/'units.json').read_text());H=N([K.from_integer(int(c)) for c in unit_factors[0]]);h_squared_relation=(f.monic()==(H**2).monic())
report={'status':'PASS','target_count':len(indices),'target_indices':indices,'weak_popov_nonzero_rows':len(owner),'annihilator_degree':int(f.degree()),'support_unit_power':int(power),'exact_divisibility':'f divides J**power','annihilator_is_scalar_H_squared':bool(h_squared_relation),'seconds':time.time()-start,'scope':'independent polynomial target+support verification; source-row derivation retained in exact native operation stream'};(d/'independent_ntl_verification.json').write_text(json.dumps(report)+'\n');print('NTL_VERIFICATION_PASS',report,flush=True)
