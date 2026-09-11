#!/usr/bin/env python3
"""Standard-library polynomial-field primal/dual replay, without a huge matrix.

For duals every original equation/multiplier/field-basis row is checked.
For primals the complete polynomial combination is accumulated directly.
Only the recorded bounded polynomial span is certified. The geometric
dictionary and any source substitutions remain separate prerequisites.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source',type=Path)
    parser.add_argument('certificate',type=Path)
    parser.add_argument('--kind',choices=['primal','dual','consequence','polynomial_primal'],required=True)
    parser.add_argument('--receipt',type=Path)
    parser.add_argument('--arithmetic',choices=['packed','slow'],default='packed')
    args=parser.parse_args();start=time.monotonic()
    source_bytes=args.source.read_bytes();data=json.loads(source_bytes)
    d=data['field_degree'];mod=data['field_modulus']
    assert data['prime']==5 and len(mod)==d+1 and mod[-1]==1
    def reduce(v):
        v=list(v)
        for i in range(len(v)-1,d-1,-1):
            c=v[i]%5
            for j in range(d):v[i-d+j]=(v[i-d+j]-c*mod[j])%5
        return tuple((v+[0]*d)[:d])
    cache={}
    def shifted(c,j):
        key=(tuple(c),j)
        if key not in cache:cache[key]=reduce([0]*j+list(c))
        return cache[key]
    def slow_multiply(a,b):
        v=[0]*(2*d-1)
        for i,c in enumerate(a):
            if c:
                for j,e in enumerate(b):v[i+j]+=c*e
        return reduce(v)
    if args.arithmetic=='packed':
        from exact_polynomial_field import ExactPolynomialField
        field=ExactPolynomialField(mod)
        multiply=lambda a,b:field.multiply(tuple(a),tuple(b))
    else:multiply=slow_multiply
    polys=data['equations'];neq=len(polys);rows=terms=0
    if args.kind=='dual':
        certificate=args.certificate.read_bytes()
        assert len(certificate)==data['columns'] and all(c<5 for c in certificate)
        assert certificate[-1]!=0
        index={tuple(m):i for i,m in enumerate(data['monomials'])}
        nc=len(certificate);target=data['original_target_column']
        def swap(i):return nc-1 if i==target else target if i==nc-1 else i
        base_rows=[]
        for f in polys:
            for j in range(d):
                base_rows.append([(tuple(e),k,c) for e,a in f
                                  for k,c in enumerate(shifted(a,j)) if c])
        bases={e for row in base_rows for e,j,c in row}
        for mult in data['multipliers']:
            locations={e:index[tuple(a+b for a,b in zip(e,mult))]*d for e in bases}
            values={(e,j):certificate[swap(locations[e]+j)] for e in bases for j in range(d)}
            for row in base_rows:
                assert sum(c*values[e,j] for e,j,c in row)%5==0,('dual row',rows)
                terms+=len(row);rows+=1
        assert rows==data['rows'] and terms==data['nonzeros']
    else:
        certificate=args.certificate.read_bytes();cert=json.loads(certificate)
        assert cert['source_sha256']==hashlib.sha256(source_bytes).hexdigest()
        result={};seen=set()
        if args.kind=='polynomial_primal':
            weighted_rows=[(int(i),tuple(e),c) for i,w in cert['polynomial_multipliers'] for e,c in w]
            assert all(0<=i<neq and len(e)==len(data['variables'])
                and all(isinstance(x,int) and x>=0 for x in e) for i,e,c in weighted_rows)
        else:
            assert all(0<=row<len(data['multipliers'])*neq for row,c in cert['coefficients'])
            weighted_rows=[(row%neq,tuple(data['multipliers'][row//neq]),c) for row,c in cert['coefficients']]
        for equation,mult,coeff in weighted_rows:
            row=(equation,mult)
            assert row not in seen
            assert len(coeff)<=d and all(0<=c<5 for c in coeff)
            seen.add(row)
            for exponent,a in polys[equation]:
                exponent=tuple(x+y for x,y in zip(exponent,mult))
                value=result.setdefault(exponent,[0]*d)
                product=multiply(coeff,a)
                for j,c in enumerate(product):value[j]=(value[j]+c)%5
                terms+=1
            rows+=1
        if args.kind in ('primal','polynomial_primal'):
            target=(0,)*len(data['variables'])
            assert result[target]==[1]+[0]*(d-1)
            assert all(e==target or not any(v) for e,v in result.items())
        else:
            expected={tuple(e):reduce(c) for e,c in cert['polynomial']}
            result={e:tuple(c) for e,c in result.items() if any(c)}
            assert result==expected
    receipt=dict(status='independent_field_certificate_replay_pass',kind=args.kind,
        arithmetic=args.arithmetic,
        rows_checked=rows,terms_checked=terms,source_sha256=hashlib.sha256(source_bytes).hexdigest(),
        certificate_sha256=hashlib.sha256(certificate).hexdigest(),seconds=time.monotonic()-start,
        scope='Recorded bounded polynomial span; geometric dictionary and substitutions separately required')
    if args.receipt:
        with args.receipt.open('x') as f:json.dump(receipt,f,indent=2);f.write('\n')
    print(json.dumps(receipt,indent=2),flush=True)


if __name__=='__main__':main()
