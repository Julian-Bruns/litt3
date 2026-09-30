#!/usr/bin/env python3
"""Verify the new small exact evidence. This is not a geometric existence search."""
from __future__ import annotations
import argparse
from itertools import combinations_with_replacement
import json
from pathlib import Path
import platform
import ff25 as F
from branch_resultant import certificate

ROOT=Path(__file__).resolve().parents[1]

def cyclotomic_check() -> dict:
    # One irreducible factor of Phi_29 over F_5, coefficients ascending.
    f=[1,2,4,0,4,4,3,1,3,4,4,0,4,2,1]
    other=[1,4,4,2,2,4,0,3,0,4,2,2,4,4,1]
    assert F.pmul(f,other)==[1]*29
    def power(a,n):
        r=[1]
        while n:
            if n&1:r=F.pdivmod(F.pmul(r,a),f)[1]
            a=F.pdivmod(F.pmul(a,a),f)[1];n//=2
        return r
    checks=[]
    for d in (2,7,14):
        r=F.psub(power([0,1],5**d),[0,1])
        g,s,t=F.xgcd(f,r)
        assert F.padd(F.pmul(s,f),F.pmul(t,r))==g
        assert g==([1] if d<14 else f)
        checks.append({'exponent':d,'remainder':r,'gcd':g,'bezout_f':s,'bezout_remainder':t})
    residues={pow(5,i,29) for i in range(14)}
    squares={i*i%29 for i in range(1,29)}
    assert residues==squares and 2 not in squares
    assert residues|{2*r%29 for r in residues}==set(range(1,29))
    one=(1,)+(0,)*13;zero=(0,)*14;nodes=[one]
    for _ in range(1,29):
        a=[0]+list(nodes[-1][:-1]);c=nodes[-1][-1]
        nodes.append(tuple((a[i]-c*f[i])%5 for i in range(14)))
    assert len(set(nodes))==29
    def add(a,b):return tuple((x+y)%5 for x,y in zip(a,b))
    sums={0:{zero}}
    sizes={}
    for r in range(1,5):
        values=set()
        for inds in combinations_with_replacement(range(29),r):
            z=zero
            for i in inds:z=add(z,nodes[i])
            values.add(z)
        sums[r]=values;sizes[str(r)]=len(values)
    overlaps=[]
    for r in range(3):
        for s in range(5):
            if r==s:continue
            n=len(sums[r]&sums[s])
            assert n==0
            overlaps.append({'left_length':r,'right_length':s,'intersection_size':n})
    return {
      'purpose':'independent bounded arithmetic check of the theoretically proved short-sum lemma; NOT an endpoint-pair or curve search',
      'factor_Phi29':f,'complementary_factor':other,
      'irreducibility_checks':checks,
      'frobenius_orbit_is_quadratic_residue_set':True,
      'nonresidue_used_in_proof':2,
      'numbers_of_distinct_multiset_sums':sizes,
      'cross_length_intersections':overlaps,
      'positive_convolution_terms':20,'negative_convolution_terms':16,
      'required_negative_mass':20,
    }

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--reference',type=Path)
    args=ap.parse_args()
    endpoint=json.loads((ROOT/'input/endpoint.json').read_text())
    # Use the literal rows, also checking agreement with the archive input.
    P=[11,22,18,5,19,20,15,16,9,22,1];A=[1,21,14,22,13]
    assert endpoint['P']==P and endpoint['A']==A
    out={'python_version':platform.python_version(),
         'stationary_resultant':certificate(P,A),
         'cyclotomic_sum_check':cyclotomic_check(),
         'status':'PARTIAL / EXISTENCE UNRESOLVED',
         'degrees_newly_excluded':[],
         'admissible_examples_constructed':0,
         'expanded_pair_sum_resultant_computed':False,
         'geometric_branch_candidates_enumerated':False}
    if args.reference:
        ref=json.loads(args.reference.read_text())
        ref.pop('python_version',None)
        out_without_version=dict(out);out_without_version.pop('python_version',None)
        assert ref==out_without_version,'reference evidence mismatch'
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,indent=2,sort_keys=True)+'\n')
    print('PASS: H=P^2*(A-prime)^3, degree 29, leading coefficient [16]')
    print('PASS: canonical B normal-basis determinant [23]')
    print('PASS: exact 73-term stationary norm, weighted-degree bound, R0(A,H)=0')
    print('PASS: Phi_29 factorization, irreducibility, QR/Frobenius partition')
    print('PASS: 40,919 nonempty short multisets; all recorded cross-length intersections empty')
    print('PROVED IN REPORT: branch-support eliminant nonzero, including repeated endpoint labels')
    print('NOT EXPANDED: the large pair-sum resultant; NOT SEARCHED: geometric branch curves')
    print('LEGACY STAGE: finiteness alone did not exclude a degree; see verify_moments.py for the new n=14 result')
    if args.reference:print('PASS: recomputed new evidence agrees with reference')
    print('Wrote',args.output)

if __name__=='__main__':main()
