#!/usr/bin/env sage -python
"""Exploratory all-geometric pointed tests on finite-field family classes.

Select one parameter per affine branch-invariant/Frobenius orbit. The
existing polynomial blocks and audited weak-Popov operations are reused.
This is a structural diagnostic, not a certified new endpoint theorem.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import *
from pointed_frobenius_polynomial import build_polynomial_blocks


def insert(basis,row,R):
    row=list(row)
    while any(row):
        degree=max(v.degree() for v in row)
        j=max(i for i,v in enumerate(row) if v.degree()==degree)
        if basis[j] is None:
            c=row[j].leading_coefficient()
            basis[j]=[v/c for v in row]
            return
        old=basis[j]
        old_degree=old[j].degree()
        if degree<old_degree:
            c=row[j].leading_coefficient()
            basis[j]=[v/c for v in row]
            row=old
            continue
        multiplier=(row[j].leading_coefficient()/old[j].leading_coefficient())*R.gen()**(degree-old_degree)
        row=[v-multiplier*w for v,w in zip(row,old)]


def check_block(block):
    M0,M1,M2=block['matrices'];k=M0.base_ring();n=M0.ncols()
    if not n:return dict(columns=0,pass_all=True)
    chosen=list(M0.transpose().pivots())
    if len(chosen)<n:return dict(columns=n,pass_all=False,failure='[1,0,0]',rank=len(chosen))
    extras=[i for i in range(n+2) if i not in chosen]
    inv=M0.matrix_from_rows(chosen).inverse()
    assert M0.matrix_from_rows(chosen)*inv==identity_matrix(k,n)
    A=inv*M1.matrix_from_rows(chosen);B=inv*M2.matrix_from_rows(chosen)
    low=M0.matrix_from_rows(extras)
    C=M1.matrix_from_rows(extras)-low*A;D=M2.matrix_from_rows(extras)-low*B
    rows=[];moving=D
    for power in range(n):
        rows.extend(moving.rows())
        if len(rows)>=n and matrix(k,rows).rank()==n:break
        moving=moving*B
    inf=matrix(k,rows).rank()
    if inf<n:return dict(columns=n,pass_all=False,failure='infinity',rank=inf)
    R=PolynomialRing(k,'z');z=R.gen()
    operator=A.change_ring(R)+z*B.change_ring(R)
    moving=C.change_ring(R)+z*D.change_ring(R)
    basis=[None]*n
    for power in range(n):
        for row in moving.rows():insert(basis,row,R)
        degrees=[int(v[j].degree()) for j,v in enumerate(basis) if v is not None]
        if len(degrees)==n and not any(degrees):
            return dict(columns=n,pass_all=True,power=power,infinity_rank=inf)
        if power+1<n:moving=moving*operator
    return dict(columns=n,pass_all=False,failure='nonunit observation module',
                rank=len(degrees),pivot_degree_sum=sum(degrees),infinity_rank=inf)


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--field-degree',type=int,required=True)
    ap.add_argument('--height',type=int,required=True)
    ap.add_argument('--limit',type=int,default=0)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    root=Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    k=GF(5**args.field_degree,'b');U=PolynomialRing(k,'u');u=U.gen()
    def code(a):return sum(int(c)*5**i for i,c in enumerate(a.polynomial().list()))
    representatives={}
    for z in k:
        if z in [k(i) for i in range(5)]:continue
        invariant=(z**5-z)**4
        orbit=[invariant**(5**j) for j in range(args.field_degree)]
        key=min(map(code,orbit))
        if key not in representatives:representatives[key]=(1/z-1,invariant)
    records=[];started=time.monotonic()
    receipt=dict(kind='exploratory_pointed_family_orbits',field_degree=args.field_degree,
                 field_modulus=str(k.modulus()),height=args.height,
                 total_orbit_representatives=len(representatives),records=records,
                 source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                 builder_sha256=hashlib.sha256(Path(__file__).with_name('pointed_frobenius_polynomial.py').read_bytes()).hexdigest(),
                 status='exploratory; not promoted to a new theorem')
    for number,(key,(t,invariant)) in enumerate(sorted(representatives.items())):
        if args.limit and number>=args.limit:break
        branch=[k(0),k(1),k(2),k(3),t]
        F=prod(u-a for a in branch)
        twists=[U(1)]+[u-a for a in branch]+[(u-a)*(u-b) for i,a in enumerate(branch) for b in branch[i+1:]]
        results=[];all_good=True
        for label,twist in enumerate(twists):
            for part,block in enumerate(build_polynomial_blocks(F,twist,5**args.height)):
                out=check_block(block);out.update(torsion=label,block=part);results.append(out)
                if not out['pass_all']:
                    all_good=False;break
            if not all_good:break
        rec=dict(orbit=number,invariant_code=key,invariant=str(invariant),parameter=str(t),
                 parameter_minpoly=str(t.minpoly()),pass_all=all_good,blocks=results,
                 seconds=round(time.monotonic()-started,2))
        records.append(rec)
        args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
        print(number,'of',len(representatives),'A',key,'pass',all_good,
              'blocks',len(results),'seconds',rec['seconds'],flush=True)
    receipt['completed_requested_orbits']=True
    args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')


if __name__=='__main__':main()
