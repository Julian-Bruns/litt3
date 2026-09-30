#!/usr/bin/env sage -python
"""Factor every first-height determinantal resultant in the Rosenhain pencil.

Exact symbolic calculation over F5(T); no finite parameter sampling.
"""
import argparse
import hashlib
import json
from pathlib import Path
from itertools import combinations
import time
from sage.all import *
from pointed_frobenius_polynomial import build_polynomial_blocks


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[2])
    start=time.monotonic()
    P=PolynomialRing(GF(5),'T');T=P.gen();k=P.fraction_field()
    R=PolynomialRing(k,'u');u=R.gen();branches=[k(0),k(1),k(2),k(3),k(T)]
    F=prod(u-a for a in branches)
    twists=[R(1)]+[u-a for a in branches]
    twists += [(u-a)*(u-b) for i,a in enumerate(branches) for b in branches[i+1:]]
    L=PolynomialRing(k,names=['l0','l1','l2']);ls=L.gens()
    records=[];all_factors=set()
    for label,twist in enumerate(twists):
        for part,block in enumerate(build_polynomial_blocks(F,twist,5)):
            matrices=block['matrices'];n=matrices[0].ncols()
            if not n:continue
            M=sum((ls[i]*matrices[i].change_ring(L) for i in range(3)),zero_matrix(L,n+2,n))
            powers=[tuple(e) for e in IntegerVectors(n,3)]
            minors=[M.matrix_from_rows(rows).det() for rows in combinations(range(n+2),n)]
            coefficient=matrix(k,[[g.monomial_coefficient(prod(ls[i]**e[i] for i in range(3))) for e in powers] for g in minors])
            determinant=coefficient.det();assert determinant.denominator()==1 and determinant
            determinant=P(determinant)
            factors=[(f.monic(),int(e)) for f,e in determinant.factor()]
            all_factors.update(f for f,e in factors)
            record=dict(torsion=label,block=part,columns=n,degree=determinant.degree(),
                        determinant=str(determinant),factors=[(str(f),e) for f,e in factors])
            records.append(record)
            print(label,part,'degree',determinant.degree(),'factors',record['factors'],flush=True)
    singular=T*(T-1)*(T-2)*(T-3)
    hasse=3*T**4+2*T**3+3*T**2+2*T+3
    residual=[f for f in all_factors if singular%f]
    ordinary_failures=[f for f in residual if hasse%f]
    # Put the five fixed branch points at F5.  The affine group of that
    # set has invariant A=(z^5-z)^4, where z=1/(T+1).
    Z=PolynomialRing(GF(5),'z');z=Z.gen();zfrac=Z.fraction_field()
    bad=P(prod(ordinary_failures)).monic()
    assert bad.degree()==60 and len(ordinary_failures)==20
    assert all(f.degree()==3 and f.is_irreducible() for f in ordinary_failures)
    transported=Z(z**60*bad(zfrac(1)/z-1))
    A=(z**5-z)**4
    assert transported==1+2*A**2+4*A**3
    AA=PolynomialRing(GF(5),'A');a=AA.gen()
    bad_orbit=a**3+3*a**2+4
    good_orbit=a**3+2*a**2+4*a+4
    assert bad_orbit*good_orbit==a**6+a+1
    assert bad_orbit.is_irreducible() and good_orbit.is_irreducible()
    assert hasse==3*(T+1)**4
    k125=GF(125,'b');tt=PolynomialRing(k125,'T').gen()
    alpha=(tt**3+tt+1).roots(multiplicities=False)[0]
    zz=1/(alpha+1);aa=(zz**5-zz)**4
    assert good_orbit(aa)==0 and bad_orbit(aa)!=0
    invariant=dict(coordinate='z=1/(T+1)',affine_invariant='A=(z^5-z)^4',
                   bad_polynomial=str(bad_orbit),good_cubic_polynomial=str(good_orbit),
                   transported_squarefree_product=str(transported),
                   norm_identity='A^6+A+1=(A^3+3*A^2+4)*(A^3+2*A^2+4*A+4)',
                   backup_in_good_orbit=True,ordinary_bad_parameters=60,
                   complete_cubic_orbit_sizes=[20]*6)
    receipt=dict(kind='symbolic_first_height_rosenhain_family',
                 source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                 blocks=records,residual_factors=sorted(map(str,residual)),
                 ordinary_failure_factors=sorted(map(str,ordinary_failures)),
                 residual_squarefree_product=str(prod(residual)),
                 invariant_description=invariant,
                 hasse_determinant=str(hasse),seconds=round(time.monotonic()-start,2),
                 status='exact_experiment_pending_geometric_interpretation')
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
    print('Residual factors',receipt['residual_factors'],flush=True)
    print('Ordinary failure factors',receipt['ordinary_failure_factors'],flush=True)


if __name__=='__main__':main()
