#!/usr/bin/env sage-python
"""Necessary good-reduction test for exactly reconstructed triangle models.

The polynomial of a weight-zero invariant is made primitive over ZZ before
reduction. Every integral specialization of any conjugate must be a root of
that reduced polynomial, even when the displayed source equation is bad.
A coprime result excludes the backup; a common root is not an isomorphism.
"""
from sage.all import QQ, ZZ, GF, PolynomialRing, NumberField, gcd, lcm
from sage.schemes.hyperelliptic_curves.invariants import igusa_clebsch_invariants
from pathlib import Path
import argparse
import json
import time


def primitive(poly):
    coefficients=poly.list()
    denominator=lcm([c.denominator() for c in coefficients])
    integers=[ZZ(c*denominator) for c in coefficients]
    content=gcd(integers)
    return PolynomialRing(ZZ,'J')([c//content for c in integers])


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('directory',type=Path)
    args=ap.parse_args();root=args.directory
    # Universal formulas are small for a sextic with roots at zero and infinity.
    R=PolynomialRing(QQ,names=('a0','a1','a2','a3'))
    a0,a1,a2,a3=R.gens();P=PolynomialRing(R,'x');x=P.gen()
    quartic=x**4/4+a3*x**3+a2*x**2+a1*x+a0
    universal=igusa_clebsch_invariants(x*quartic)
    assert universal[3]==a0**2*quartic.discriminant()/16
    assert all(c.denominator()%5 for p in universal for c in p.coefficients())
    target_ring=PolynomialRing(GF(5),'J');J=target_ring.gen()
    target=J**3+2*J**2+2*J+2
    assert target.is_irreducible()
    reports=[]
    for file in sorted(root.glob('factor_[0-9][0-9].json')):
        started=time.time();data=json.loads(file.read_text())
        T=PolynomialRing(QQ,'t');f=T([QQ(c) for c in data['polynomial']])
        K=NumberField(f,'theta',check=False);theta=K.gen()
        F=[T([QQ(c) for c in row])(theta) for row in data['source_quartic']]
        assert len(F)==5 and F[4]==QQ(1)/4
        evaluate=R.hom(F[:4],K)
        i2,i4,i6,i10=[evaluate(p) for p in universal]
        assert i10!=0
        j=i4**5/i10**2
        polynomial=primitive(j.minpoly())
        reduction=target_ring(polynomial)
        common=reduction.gcd(target)
        report={'file':file.name,'field_degree':int(f.degree()),
                'invariant':'I4^5/I10^2',
                'minimal_polynomial_ascending':[str(c) for c in polynomial.list()],
                'reduction_ascending':[int(c) for c in reduction.list()],
                'target_gcd_ascending':[int(c) for c in common.list()],
                'backup_excluded':common.degree()==0,
                'seconds':time.time()-started}
        reports.append(report)
        print(file.name,'field degree',f.degree(),'invariant degree',polynomial.degree(),
              'mod5',reduction.factor(),'backup gcd',common,flush=True)
    result={'target_ascending':[int(c) for c in target.list()],
            'all_models_excluded':bool(reports) and all(r['backup_excluded'] for r in reports),
            'factors':reports,
            'scope':'Necessary invariant test on verified explicit models. Completeness is separate.'}
    (root/'invariant_reduction.json').write_text(json.dumps(result,indent=2)+'\n')


if __name__=='__main__':main()
