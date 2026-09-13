#!/usr/bin/env python3
"""Exact necessary geometric backup-factor tests at arbitrary 5-adic precision.

Applies to a certified full unit-root polynomial over F5^342 of an ordinary
eight-dimensional abelian variety. All nine possible cyclotomic twist orders
are retained; passing is inconclusive. No finite-field isogeny is presumed.
"""
import argparse,json
from pathlib import Path

WEIL=[15625,-1000,182,-8,1]
CYCLOTOMIC={1:[-1,1],2:[1,1],3:[1,1,1],4:[1,0,1],
            5:[1,1,1,1,1],6:[1,-1,1],8:[1,0,0,0,1],
            10:[1,-1,1,-1,1],12:[1,0,-1,0,1]}


def evaluate(f,x):
    a=0
    for c in reversed(f):a=a*x+c
    return a


def hensel_root(residue,digits):
    root=residue;mod=5;derivative=[i*c for i,c in enumerate(WEIL)][1:]
    assert evaluate(WEIL,root)%5==0 and evaluate(derivative,root)%5
    for _ in range(1,digits):
        carry=(evaluate(WEIL,root)//mod)%5
        delta=-carry*pow(evaluate(derivative,root),-1,5)%5
        root+=mod*delta;mod*=5
        assert evaluate(WEIL,root)%mod==0
    return root


def multiply(a,b,mod):
    out=[0]*(len(a)+len(b)-1)
    for i,c in enumerate(a):
        for j,d in enumerate(b):out[i+j]=(out[i+j]+c*d)%mod
    return out


def remainder(a,b,mod):
    a=[c%mod for c in a];assert b[-1]==1
    while len(a)>=len(b):
        c=a[-1];shift=len(a)-len(b)
        for i,d in enumerate(b):a[i+shift]=(a[i+shift]-c*d)%mod
        while a and not a[-1]:a.pop()
    return a


def filters(digits):
    mod=5**digits;roots=[hensel_root(r,digits) for r in [1,2]]
    units=[pow(r,114,mod) for r in roots];tests=[]
    for order,phi in CYCLOTOMIC.items():
        degree=len(phi)-1
        factors=[[c*pow(u,degree-i,mod)%mod for i,c in enumerate(phi)] for u in units]
        tests.append(dict(order=order,polynomial=multiply(*factors,mod)))
    return dict(digits=digits,modulus=mod,backup_unit_roots=roots,
                backup_frobenius342_unit_roots=units,tests=tests)


def sieve(coefficients,digits):
    data=filters(digits);mod=data['modulus']
    assert len(coefficients)==9 and coefficients[-1]%mod==1 and coefficients[0]%5
    for test in data['tests']:
        test['remainder']=remainder(coefficients,test['polynomial'],mod)
        test['divides']=not test['remainder']
    data['passing_orders']=[t['order'] for t in data['tests'] if t['divides']]
    data['geometric_backup_factor_excluded']=not data['passing_orders']
    return data


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('input',type=Path)
    p.add_argument('output',type=Path);args=p.parse_args();data=json.loads(args.input.read_text())
    assert data['status']=='complete' and data['field_degree']==342
    result=sieve(data['coefficients'],data['digits'])
    result['source']=str(args.input.resolve())
    result['scope']='Necessary geometric factor sieve on certified unit-root polynomial; passing is inconclusive'
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result))
