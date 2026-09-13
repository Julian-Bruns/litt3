#!/usr/bin/env sage-python
"""Compare every saved matrix/cover coefficient under the specified embedding."""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--small',required=True)
    ap.add_argument('--large',required=True)
    ap.add_argument('--output',required=True)
    args=ap.parse_args()
    small=json.loads(Path(args.small).read_text())
    large=json.loads(Path(args.large).read_text())
    pol=PolynomialRing(GF(5),'z')
    k=GF(5**12,name='b',modulus=pol(small['field_modulus']))
    K,embed=k.extension(5,'c',map=True)
    assert [int(v) for v in K.modulus()]==large['field_modulus']
    def field_eq(a,b):
        assert embed(k(a))==K(b)
    field_eq(small['alpha'],large['alpha'])
    checked=1
    for key in ['case','plane','central','as_plane_coefficients','central_complement']:
        assert small[key]==large[key]
    def algebra_eq(a,b):
        nonlocal checked
        assert len(a)==len(b)==4
        for x,y in zip(a,b):
            assert set(x)==set(y)
            for i in x:field_eq(x[i],y[i]);checked+=1
    for key in ['chi1','chi2','kappa']:
        algebra_eq(small['gluing'][key],large['gluing'][key])
    for key in ['affine_rhs','infinity_rhs']:
        for a,b in zip(small[key],large[key]):algebra_eq(a,b)
    large_cols={r['column']:r for r in large['columns']}
    for row in small['columns']:
        other=large_cols[row['column']]
        assert row['monomial']==other['monomial']
        assert set(row['entries'])==set(other['entries'])
        for i,co in row['entries'].items():
            field_eq(co,other['entries'][i]);checked+=1
    result=dict(status='PASS',columns=len(small['columns']),coefficients_checked=checked,
        small=args.small,large=args.large,
        small_sha256=hashlib.sha256(Path(args.small).read_bytes()).hexdigest(),
        large_sha256=hashlib.sha256(Path(args.large).read_bytes()).hexdigest())
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result))


if __name__=='__main__':main()
