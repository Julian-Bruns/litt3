#!/usr/bin/env sage -python
"""Explore a univariate observability test for the pointed matrix pencil.

Research prototype. Exact row-module operations retain polynomial ideals;
there is no saturation or division by a nonunit. Receipts require a
separate mathematical/implementation audit before canonical use.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time
from sage.all import *
from pointed_frobenius_polynomial import build_polynomial_blocks

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--height',type=int,default=2)
parser.add_argument('--torsions',default='0')
parser.add_argument('--restrict-prime',action='store_true')
parser.add_argument('--reduction',choices=['echelon','popov'],default='popov')
parser.add_argument('--output',type=Path,required=True)
args=parser.parse_args()
assert args.height>=1
root=Path(__file__).resolve().parents[2]
assert not args.output.resolve().is_relative_to(root)
args.output.parent.mkdir(parents=True,exist_ok=True)
k=GF(125,'b')
ring=PolynomialRing(k,'u');u=ring.gen()
alpha=(u**3+u+1).roots(multiplicities=False)[0]
F=u*(u-1)*(u-2)*(u-3)*(u-alpha)
branch=[k(0),k(1),k(2),k(3),alpha]
twists=[ring(1)]+[u-c for c in branch]
twists += [(u-c)*(u-d) for i,c in enumerate(branch) for d in branch[i+1:]]
R=PolynomialRing(k,'t');t=R.gen()
started=time.monotonic()
receipt=dict(kind='univariate_observability_prototype',height=args.height,
             restrict_to_prime_field=args.restrict_prime,
             reduction=args.reduction,
             alpha=str(alpha),canonical_field_modulus=str(k.modulus()),
             source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
             builder_sha256=hashlib.sha256((Path(__file__).parent/'pointed_frobenius_polynomial.py').read_bytes()).hexdigest(),
             blocks=[])


def normalized_pencil(block):
    B0,B1,B2=[matrix(k,A.nrows(),A.ncols(),A.list()) for A in block['matrices']]
    n=B0.ncols()
    rows=list(B0.transpose().pivots())
    assert len(rows)==n
    extras=[i for i in range(n+2) if i not in rows]
    U=B0.matrix_from_rows(rows); Uinv=U.inverse()
    assert U*Uinv==Uinv*U==identity_matrix(k,n)
    V=B0.matrix_from_rows(extras)
    A=Uinv*B1.matrix_from_rows(rows)
    B=Uinv*B2.matrix_from_rows(rows)
    C=B1.matrix_from_rows(extras)-V*A
    D=B2.matrix_from_rows(extras)-V*B
    return A,B,C,D


def restrict_scalars(M):
    prime=GF(5)
    result=matrix(prime,3*M.nrows(),3*M.ncols())
    for row in range(M.nrows()):
        for col in range(M.ncols()):
            c=M[row,col]
            if not c:
                continue
            for j in range(3):
                cs=list((c*k.gen()**j).polynomial())
                for i,value in enumerate(cs):
                    result[3*row+i,3*col+j]=value
    return result


def insert_row(basis,row):
    """Enlarge the exact k[t]-row module and keep echelon generators."""
    row=list(row)
    n=len(row)
    for j in range(n):
        while row[j]:
            if basis[j] is None:
                c=row[j].leading_coefficient()
                basis[j]=[v/c for v in row]
                return
            q,r=row[j].quo_rem(basis[j][j])
            if q:
                row=[v-q*w for v,w in zip(row,basis[j])]
            assert row[j]==r
            if r:
                c=r.leading_coefficient()
                old=basis[j]
                basis[j]=[v/c for v in row]
                row=old
            # If r=0, continue to the next pivot. A nonzero remainder
            # replaces the pivot by smaller degree and continues Euclid.


def insert_popov_row(basis,row):
    """Keep distinct rightmost leading positions without degree growth."""
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


for torsion in [int(v) for v in args.torsions.split(',')]:
    assert 0<=torsion<16
    blocks=build_polynomial_blocks(F,twists[torsion],5**args.height)
    for index,block in enumerate(blocks):
        n=block['matrices'][0].ncols()
        if n==0:
            continue
        A,B,C,D=normalized_pencil(block)
        original_n=n
        if args.restrict_prime:
            A,B,C,D=[restrict_scalars(M) for M in [A,B,C,D]]
            n=A.ncols()
        scalar=A.base_ring()
        R=PolynomialRing(scalar,'t');t=R.gen()
        # The missing chart x1=0 is ordinary observability of (B,D).
        obs=[];row=D
        for power in range(n):
            obs.extend(row.rows())
            if len(obs)>=n and matrix(scalar,obs).rank()==n:
                break
            row=row*B
        infinity_rank=matrix(scalar,obs).rank()
        assert infinity_rank==n, ('infinity failure',torsion,index)
        T=A.change_ring(R)+t*B.change_ring(R)
        row=C.change_ring(R)+t*D.change_ring(R)
        basis=[None]*n
        stages=[]
        for power in range(n):
            for v in row.rows():
                (insert_popov_row if args.reduction=='popov' else insert_row)(basis,v)
            degrees=[int(v[j].degree()) for j,v in enumerate(basis) if v is not None]
            full=len(degrees)==n and all(d==0 for d in degrees)
            stages.append(dict(power=power,rank=len(degrees),pivot_degree_sum=sum(degrees)))
            if power%5==0 or full:
                receipt['active']=dict(torsion=torsion,block=index,**stages[-1],seconds=round(time.monotonic()-started,2))
                args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
                print(receipt['active'],flush=True)
            if full:
                break
            row=row*T
        record=dict(torsion=torsion,block=index,columns=original_n,arithmetic_dimension=n,infinity_rank=infinity_rank,
                    whole_row_module=full,stages=stages,seconds=round(time.monotonic()-started,2))
        receipt['blocks'].append(record)
        receipt.pop('active',None)
        args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
        if not full:
            print('NONUNIT MODULE: independent investigation required.',flush=True)
            break
receipt['verdict']='Prototype completed; audit required.'
args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
print(receipt['verdict'],flush=True)
