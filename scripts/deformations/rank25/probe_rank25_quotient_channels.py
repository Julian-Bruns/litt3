#!/usr/bin/env sage-python
"""All31 actual quotient operators of an audited rank125 free presentation.

The quotient is induced by the norm embedding of the original subgroup,
in the SAME source/target regular basis. No separate Schur basis is used
when computing the ordinary kernel-to-cokernel channel.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing, matrix

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('input',type=Path)
p.add_argument('--output',type=Path,required=True)
p.add_argument('--limit',type=int,default=31)
args=p.parse_args(); raw=args.input.read_bytes(); data=json.loads(raw)
assert data['status']=='complete' and len(data['columns'])==6
P=PolynomialRing(GF(5),'a')
k=GF(5**(len(data['field_modulus'])-1),'a',modulus=P(data['field_modulus']),impl='pari_ffelt')
a=k.gen(); dec=lambda c:sum(k(x)*a**i for i,x in enumerate(c))
Q=PolynomialRing(k,['u','v']); u,v=Q.gens()
R=Q.quotient([u**5,v**5],names=['e1','e2']); e1,e2=R.gens()
ix3=list(itertools.product(range(5),repeat=3))
ix2=list(itertools.product(range(5),repeat=2)); pos={e:i for i,e in enumerate(ix2)}
columns=[[dec(c) for c in col] for col in data['columns']]
vectors=[v for v in itertools.product(range(5),repeat=3)
         if any(v) and next(x for x in v if x)==1]
assert len(vectors)==31
records=[]; start=time.monotonic()
for vector in vectors[:args.limit]:
    pivot=next(i for i,c in enumerate(vector) if c)
    rest=[i for i in range(3) if i!=pivot]
    maps=[]
    for i in range(3):
        coeff=[(int(i==j)-vector[j]*int(i==pivot))%5 for j in rest]
        maps.append((1+e1)**coeff[0]*(1+e2)**coeff[1]-1)
    assert all(sum(vector[i]*(int(i==j)-vector[j]*int(i==pivot)) for i in range(3))%5==0 for j in rest)
    monomials=[maps[0]**x*maps[1]**y*maps[2]**z for x,y,z in ix3]
    entries=[[sum(columns[col][6*n+row]*monomials[n] for n in range(125))
              for col in range(6)] for row in range(6)]
    terms=[[entries[i][j].lift().dict() for j in range(6)] for i in range(6)]
    M=matrix(k,150,150,0,implementation='generic')
    for ab in ix2:
        for i in range(6):
            for j in range(6):
                for cd,c in terms[i][j].items():
                    ef=tuple(ab[h]+cd[h] for h in range(2))
                    if max(ef)<5:
                        M[6*pos[ef]+i,6*pos[ab]+j]+=c
    r1=int(M.rank())
    FM=matrix(k,150,150,[c**5 for c in M.list()],implementation='generic')
    r2=int((M*FM).rank())
    ordinary=150-2*r1+r2
    item=dict(subgroup_line=list(vector),defect=150-r1,rank=r1,second_rank=r2,
              ordinary_kernel_to_cokernel_rank=ordinary)
    records.append(item)
    result=dict(status='complete' if len(records)==31 else 'partial',input_sha256=hashlib.sha256(raw).hexdigest(),
                scope='Actual characteristic-five quotient operators only; no higher-Witt statement',
                parameter=data['parameter'],field_modulus=data['field_modulus'],planes=records,
                seconds=time.monotonic()-start)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(item),flush=True)
print('SECONDS',time.monotonic()-start,flush=True)
