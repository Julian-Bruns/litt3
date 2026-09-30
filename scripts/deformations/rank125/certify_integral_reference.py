#!/usr/bin/env python3
"""Check and retain the original rank125 integral-reference executions."""
import argparse
import hashlib
import itertools
import json
import os
from pathlib import Path

from certify_cubic_base_reference import ROOT, DATA_ROOT, code, mul, neg, power, poly_mul, add, without_timings


def certify(paths):
    runs=[json.loads(p.read_text()) for p in paths]
    assert [r['infinity_branch'] for r in runs]==[1,-1]
    assert [r['frobenius_variant'] for r in runs]==[0,1]
    assert [r['series_workspace'] for r in runs]==[2200,2600]
    F=[1];Q=[1]
    for root in (0,1,2,3,5):
        F=poly_mul(F,[neg(root),1])
    for root in (1,2,5):
        Q=poly_mul(Q,[neg(root),1])
    for run in runs:
        assert run['modulus']==3125
        for name,h in run['source_sha256'].items():
            assert hashlib.sha256(Path(__file__).with_name(name).read_bytes()).hexdigest()==h
        for i,(c,terms) in enumerate(zip([3,1,2],[[(1,31)],[(1,24),(2,118)],[(1,112),(2,43)]])):
            g=run['generators'][i];square=poly_mul(Q,Q) if i==0 else poly_mul(F,F)
            expected=[0]*6
            for h,b in terms:
                scalar=mul(c,power(b,5))
                for j,x in enumerate(square[5*h:]):
                    expected[j]=add(expected[j],mul(scalar,x))
            actual={d:code(a) for d,a in g['affine_FU_polynomial']}
            assert actual=={d:x for d,x in enumerate(expected) if x}
            assert pow(g['constant_a'],4,3125)==1 and (g['constant_a']*c)%5==1
            assert g['FO_residue_valuation']==g['RO_residue_valuation']==1
            assert g['checks_modulus']==3125 and g['checks_exclusive_precision']>=40
            assert g['root_precision']>=1823 and g['frobenius_precision']>=1751
    # The changed base Frobenius leaves the chosen affine coordinate
    # roots fixed. The changed infinity branch has the exact parity below.
    for i,(pos,minus) in enumerate(zip(runs[0]['generators'],runs[1]['generators'])):
        for j,(a,b) in enumerate(zip(pos['affine_root_parts_through_30'],minus['affine_root_parts_through_30'])):
            sign=(-1)**(j+1) if i==0 else 1
            expected=[[e,[(sign*x)%3125 for x in coeff]] for e,coeff in a]
            assert expected==b,(i,j,'branch parity')
    unseen=set(itertools.product(range(5),repeat=3));orbits=[]
    while unseen:
        first=min(unseen);v=first;orbit=[]
        while v not in orbit:
            orbit.append(v);v=((3*v[0])%5,v[1],(2*v[2])%5)
        assert v==first
        unseen.difference_update(orbit);orbits.append(orbit)
    assert sum(len(o)==1 for o in orbits)==5 and sum(len(o)==4 for o in orbits)==30
    return {'theorem_id':'rank125_integral_reference','statement_version':1,
        'scope':'Actual original-cover integral reference charts only; no moving Hodge comparison',
        'independent_small_checks':{'all_three_original_FU_polynomials':True,'Teichmuller_constants':True,
            'both_branch_root_parities':True,'source_hashes_match':True,
            'constant_algebra_fixed_orbits':5,'constant_algebra_quartic_orbits':30},
        'constant_algebra_orbits':orbits,
        'whole_coordinate_definition':'Original affine etale algebra embedded by its unique marked Hensel roots; finite saved windows do not define the tails',
        'receipt_inputs':[{'path':os.path.relpath(p,ROOT),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in paths],
        'executions':[without_timings(r) for r in runs],
        'checker_sources':{p.name:hashlib.sha256(p.read_bytes()).hexdigest()
            for p in (Path(__file__),Path(__file__).with_name('certify_cubic_base_reference.py'))},
        'audit':'Research/audits/RANK125_INTEGRAL_ETALE_REFERENCE_AUDIT_2026_09_14.md'}


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,default=DATA_ROOT/'certificates/rank125_integral_reference.json')
    args=ap.parse_args()
    paths=[DATA_ROOT/'computations'/name for name in
           ('rank125_etale_reference_mod3125.json','rank125_etale_reference_mod3125_other.json')]
    result=certify(paths)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: integral-reference receipts, independent characters, branch parities and35 factor orbits')


if __name__=='__main__':
    main()
