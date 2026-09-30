#!/usr/bin/env python3
"""Standard-library check of the complete finite fourth-root certificate.

No Sage/Singular call. Checks ideal equality, Buchberger pairs, the exact
standard-monomial set, and both polynomial unit witnesses.
"""
import argparse
import hashlib
import json
import time
from array import array
from collections import deque
from itertools import permutations
from pathlib import Path

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--certificate',required=True)
ap.add_argument('--source',required=True)
ap.add_argument('--output',required=True)
args=ap.parse_args()
start=time.monotonic()
path=Path(args.certificate);doc=json.loads(path.read_text())
source=Path(args.source)
assert hashlib.sha256(source.read_bytes()).hexdigest()==doc['input_sha256']
raw=json.loads(source.read_text())
assert doc['field_modulus']==[3,4,1,4,1]
digits=[tuple((x//5**i)%5 for i in range(4)) for x in range(625)]
code=lambda ds:sum((int(x)%5)*5**i for i,x in enumerate(ds))
add=[array('H',(code(tuple(a+b for a,b in zip(digits[x],digits[y])))
                 for y in range(625))) for x in range(625)]
neg=[code(tuple(-a for a in d)) for d in digits]
def rawmul(x,y):
    a=digits[x];b=digits[y];c=[0]*7
    for i in range(4):
        for j in range(4):c[i+j]+=a[i]*b[j]
    for i in range(6,3,-1):
        z=c[i]%5
        for j,m in enumerate((3,4,1,4)):c[i-4+j]-=z*m
    return code(c[:4])
for primitive in range(2,625):
    powers=[1];v=primitive
    while v!=1 and len(powers)<625:
        powers.append(v);v=rawmul(v,primitive)
    if len(powers)==624 and v==1:break
else:raise AssertionError('no primitive element')
logs=[-1]*625
for i,v in enumerate(powers):logs[v]=i
mul=lambda a,b:0 if not a or not b else powers[(logs[a]+logs[b])%624]
inv=lambda a:powers[(-logs[a])%624] if a else (_ for _ in ()).throw(ZeroDivisionError())
zero=(0,0,0,0)
order=lambda e:(sum(e),tuple(-x for x in reversed(e)))
def decode(rows):
    out={tuple(t['exponents']):code(t['coefficient']) for t in rows}
    assert all(out.values()) and len(out)==len(rows)
    return out
def accum(out,ex,c):
    value=add[out.get(ex,0)][c]
    if value:out[ex]=value
    else:out.pop(ex,None)
def plus(a,b):
    out=dict(a)
    for ex,c in b.items():accum(out,ex,c)
    return out
def times(a,b):
    out={}
    for ex,c in a.items():
        for ey,d in b.items():accum(out,tuple(x+y for x,y in zip(ex,ey)),mul(c,d))
    return out
def combination(coeffs,gens):
    out={}
    for a,b in zip(coeffs,gens):out=plus(out,times(a,b))
    return out
def derivative(poly,axis,frobenius=False):
    out={};step=5 if frobenius else 1
    for ex,c in poly.items():
        if ex[axis]<step:continue
        if frobenius and ex[axis]%5:
            raise AssertionError('unexpected mixed ordinary odd power')
        n=(ex[axis]//step)%5
        if n:out[tuple(a-(step if i==axis else 0) for i,a in enumerate(ex))]=mul(n,c)
    return out
def determinant(rows):
    out={};n=len(rows)
    for perm in permutations(range(n)):
        sign=4 if sum(perm[i]>perm[j] for i in range(n) for j in range(i+1,n))%2 else 1
        term={zero:sign}
        for i,j in enumerate(perm):term=times(term,rows[i][j])
        out=plus(out,term)
    return out
def divide(a,bs):
    out=dict(a);rem={}
    while out:
        ex=max(out,key=order);c=out[ex]
        for lm,lc,b in bs:
            if all(x>=y for x,y in zip(ex,lm)):
                shift=tuple(x-y for x,y in zip(ex,lm));scale=neg[mul(c,inv(lc))]
                for ey,d in b.items():accum(out,tuple(x+y for x,y in zip(shift,ey)),mul(scale,d))
                break
        else:rem[ex]=out.pop(ex)
    return rem
gens=[decode(p) for p in doc['input_equations']]
expected=[]
for row in raw['polynomials']:
    p={}
    for t in row:
        e=t['exponents'];assert e[0]%5==e[1]%5==0
        p[(e[0]//5,e[1]//5,e[2],e[3])]=code(t['coefficient'])
    expected.append(p)
assert gens==expected
ordinary_jac=[[derivative(e,j) for j in range(4)] for e in gens]
frob_jac=[[derivative(e,j,frobenius=(j>=2)) for j in range(4)] for e in gens]
assert determinant(ordinary_jac)==decode(doc['jacobian_determinant'])
assert determinant(frob_jac)==decode(doc['frobenius_linear_determinant'])
positive_det=determinant([row[:2] for row in ordinary_jac[:2]])
negative_det=determinant([row[2:] for row in ordinary_jac[2:]])
assert len(negative_det)==1 and zero in negative_det
assert times(positive_det,negative_det)==decode(doc['jacobian_determinant'])
print('Reconstructed ordinary and Frobenius Jacobians: PASS',flush=True)
gb=[decode(p) for p in doc['groebner_basis']]
for b,cs in zip(gb,doc['basis_in_input']):
    assert combination([decode(c) for c in cs],gens)==b
lead=[(max(b,key=order),b[max(b,key=order)],b) for b in gb]
assert all(not divide(e,lead) for e in gens)
print('Mutual ideal inclusions: PASS',flush=True)
pairs=0;skipped=0
for i,(lm,lc,b) in enumerate(lead):
    for ln,ld,c in lead[:i]:
        pairs+=1
        if all(min(x,y)==0 for x,y in zip(lm,ln)):
            skipped+=1;continue
        common=tuple(max(x,y) for x,y in zip(lm,ln));s={}
        for mon,coeff,poly,sign in [(lm,lc,b,1),(ln,ld,c,4)]:
            shift=tuple(x-y for x,y in zip(common,mon));scale=mul(sign,inv(coeff))
            for ex,d in poly.items():accum(s,tuple(x+y for x,y in zip(shift,ex)),mul(scale,d))
        assert not divide(s,lead),(i,pairs)
    if i and i%6==0:print('Buchberger rows:',i,'of',len(lead),flush=True)
for axis in range(4):
    assert any(lm[axis]>0 and all(lm[j]==0 for j in range(4) if j!=axis)
               for lm,lc,b in lead)
seen={zero};queue=deque([zero])
while queue:
    e=queue.popleft()
    for j in range(4):
        ne=tuple(x+(i==j) for i,x in enumerate(e))
        if ne in seen or any(all(x>=y for x,y in zip(ne,lm)) for lm,lc,b in lead):continue
        seen.add(ne);queue.append(ne)
given=[decode(m) for m in doc['standard_monomials']]
assert all(len(m)==1 and next(iter(m.values()))==1 for m in given)
assert seen=={next(iter(m)) for m in given} and len(seen)==375
for label,detkey,witnesskey in [
        ('Jacobian','jacobian_determinant','jacobian_unit_witness'),
        ('Frobenius block','frobenius_linear_determinant','frobenius_unit_witness')]:
    determinant=decode(doc[detkey])
    assert combination([decode(c) for c in doc[witnesskey]],gens+[determinant])=={zero:1}
    print(label,'unit witness: PASS',flush=True)
out={'status':'PASS independent polynomial certificate:375 smooth geometric roots',
     'certificate_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
     'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
     'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
     'groebner_basis_count':len(gb),'critical_pairs':pairs,
     'product_criterion_pairs':skipped,'standard_monomials':len(seen),
     'jacobian_and_frobenius_unit_witnesses':True,
     'jacobians_reconstructed_from_input':True,
     'seconds':time.monotonic()-start,
     'scope':'Checks the finite polynomial scheme; uses the accepted complete integral obstruction as input.'}
Path(args.output).write_text(json.dumps(out,indent=2)+'\n')
print(out['status'],'seconds:',out['seconds'],flush=True)
