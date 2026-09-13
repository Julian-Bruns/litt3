#!/usr/bin/env python3
"""Independently replay every cofactor substitution using plain Python.

This proves the recorded polynomial transport and inverse guard, not the
geometric cofactor theorem or the necessity of the source equations.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse, hashlib, json, time
from pathlib import Path
from scripts.atlases.algebra.exact_polynomial_field import ExactPolynomialField

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('transformed',type=Path)
p.add_argument('receipt',type=Path)
args=p.parse_args();start=time.monotonic()
raw=args.source.read_bytes();out_raw=args.transformed.read_bytes()
src=json.loads(raw);out=json.loads(out_raw)
assert out['source_sha256']==hashlib.sha256(raw).hexdigest()
assert out['source_variables']==src['variables']
for key in ('prime','field_degree','field_modulus'):assert src[key]==out[key]
field=ExactPolynomialField(src['field_modulus']);d=field.degree
n=len(out['variables']);zero=(0,)*n;one=(1,)+(0,)*(d-1)
products=0
def decode(poly,arity):
    result={}
    for e,c in poly:
        assert len(e)==arity and all(type(v) is int and v>=0 for v in e)
        assert len(c)<=d and all(type(v) is int and 0<=v<5 for v in c)
        e=tuple(e);assert e not in result
        c=field.reduce(c);assert any(c);result[e]=c
    return result
def add(target,poly,scale=one):
    for e,c in poly.items():
        c=field.multiply(c,scale);old=target.get(e,(0,)*d)
        new=tuple((a+b)%5 for a,b in zip(old,c))
        if any(new):target[e]=new
        else:target.pop(e,None)
    return target
def multiply(a,b):
    global products
    result={}
    for ea,ca in a.items():
        for eb,cb in b.items():
            e=tuple(x+y for x,y in zip(ea,eb));c=field.multiply(ca,cb)
            old=result.get(e,(0,)*d);new=tuple((x+y)%5 for x,y in zip(old,c))
            if any(new):result[e]=new
            else:result.pop(e,None)
            products+=1
    return result
images=[decode(f,n) for f in out['substitution_images']]
assert len(images)==len(src['variables'])
powers=[{0:{zero:one},1:f} for f in images]
def power(i,e):
    if e not in powers[i]:powers[i][e]=multiply(power(i,e-1),images[i])
    return powers[i][e]
expected=[]
for row,f in enumerate(src['equations']):
    result={}
    for e,c in decode(f,len(images)).items():
        term={zero:c}
        for i,exponent in enumerate(e):
            if exponent:term=multiply(term,power(i,exponent))
        add(result,term)
    if result and result not in expected:expected.append(result)
    if row%40==0:print(json.dumps(dict(rows=row+1,products=products,seconds=time.monotonic()-start)),flush=True)
lead=decode(out['cofactor_lead'],n)
i=out['variables'].index('lead_inv');e=tuple(int(j==i) for j in range(n))
guard=multiply({e:one},lead);add(guard,{zero:one},(4,)+(0,)*(d-1))
if guard not in expected:expected.append(guard)
actual=[decode(f,n) for f in out['equations']]
assert actual==expected,'transport/row order/guard mismatch'
receipt=dict(status='independent_cofactor_transport_PASS',source_sha256=hashlib.sha256(raw).hexdigest(),
    transformed_sha256=hashlib.sha256(out_raw).hexdigest(),rows=len(actual),
    expanded_products=products,seconds=time.monotonic()-start,
    scope='Exact substitution and inverse guard; geometric cofactor coverage separately required')
with args.receipt.open('x') as f:json.dump(receipt,f,indent=2);f.write('\n')
print(json.dumps(receipt),flush=True)
