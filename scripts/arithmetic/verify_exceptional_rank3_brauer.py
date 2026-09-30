#!/usr/bin/env python3
"""Elementary cyclotomic replay of the retained character identities."""
import argparse
import hashlib
import json
from pathlib import Path


def trim(a):
    while a and not a[-1]:a.pop()
    return a


def divmod_monic(a,b):
    a=trim(list(a));assert b[-1]==1
    q=[0]*max(0,len(a)-len(b)+1)
    while len(a)>=len(b):
        d=len(a)-len(b);c=a[-1];q[d]=c
        for j,v in enumerate(b):a[d+j]-=c*v
        trim(a)
    return trim(q),a


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('input',type=Path)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    data=json.loads(args.input.read_text());assert data['status']=='PASS'
    numerator=[int(i%3==0) for i in range(19)]
    phi,rem=divmod_monic(numerator,[1]*7)
    assert not rem and len(phi)==13
    assert not divmod_monic([-1]+[0]*20+[1],phi)[1]
    checked=0
    for group in data['results']:
        degrees=group['all_irreducible_degrees']
        assert [i+1 for i,n in enumerate(degrees) if n==3]==[
            row['position'] for row in group['degree_three_rows']]
        for row in group['degree_three_rows']:
            values=row['cyclotomic_21_coefficients']
            assert len(values)==len(group['regular_class_orders'])
            for coeff in values:
                assert len(coeff)==21
                diff=[0]*21
                for i,c in enumerate(coeff):
                    diff[(5*i)%21]+=c
                    diff[(-i)%21]-=c
                assert not divmod_monic(diff,phi)[1]
                checked+=1
    receipt=dict(status='PASS',input_sha256=hashlib.sha256(args.input.read_bytes()).hexdigest(),
                 identities=checked,cyclotomic_polynomial=phi,
                 scope='Literal integer-polynomial replay of all retained fifth-power/dual character-value identities; table completeness remains a cited input.')
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS',checked,'cyclotomic identities')


if __name__=='__main__':main()
