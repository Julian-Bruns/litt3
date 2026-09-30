#!/usr/bin/env sage -python
"""Exact dormant tangents on all two-step double covers of the backup.

The basis and cover enumeration passed their bounded audit, 2026-09-16.
Requires Sage. Output is required outside the research workspace.
"""
from itertools import combinations
from pathlib import Path
from collections import Counter
import argparse
import json
import time
from sage.all import GF, PolynomialRing, matrix, prod


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output",type=Path,required=True)
    parser.add_argument("--pairs",type=int,default=15)
    args = parser.parse_args()
    assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[2])
    start=time.monotonic()
    K=GF(5**30,"b")
    R=PolynomialRing(K,"s"); s=R.gen(); Frac=R.fraction_field()
    alpha=(s**3+s+1).roots()[0][0]
    f=s*(s-1)*(s-2)*(s-3)*(s-alpha)
    a0,a1,a2,a3,a4=[f[i] for i in range(5)]
    W=s**2+3*a4*s+3*a3
    V=-a2+(a4+2*s)*W
    psi=2*a0-2*a1*s+a2*W-V*W
    tau=psi.roots()[0][0]
    wt=W(tau); vt=V(tau)
    potential=2*(f.derivative()/f)**2-f.derivative(2)/f+(2*s**3+tau*s**2+wt*s+vt)/f
    assert potential.derivative(2)==3*potential**2
    branches=[K(0),K(1),K(2),K(3),alpha,None]
    encode=lambda a: [int(c) for c in K(a).polynomial().list()]
    rows=[]
    for pair_number,(i,j) in enumerate(combinations(range(6),2)):
        if pair_number>=args.pairs: break
        a,b=branches[i],branches[j]
        coordinate=Frac(a+s**2) if b is None else Frac((b*s**2-a)/(s**2-1))
        pulled=f(coordinate)
        P=R.one()
        for h,e in list(pulled.numerator().factor())+list(pulled.denominator().factor()):
            if e%2: P*=h
        P=P.monic()
        assert P.degree()==8 and P.gcd(P.derivative())==1
        roots=P.roots()
        assert len(roots)==8 and all(e==1 for _,e in roots)
        root_values=[a for a,_ in roots]
        assert all(a**(125**2)==a for a in root_values)
        derivative=coordinate.derivative()
        r=potential(coordinate)*derivative**2+2*(derivative.derivative()/derivative)**2+2*derivative.derivative(2)/derivative
        assert (r*P**2).denominator()==1
        assert r.derivative(2)==3*r**2
        choices=[()]
        choices+=list(combinations(range(8),2))
        choices+=[sset for sset in combinations(range(8),4) if 0 in sset]
        assert len(choices)==64
        results=[]
        for subset in choices:
            B=R(prod(s-root_values[z] for z in subset))
            d=len(subset)
            common=P**2*B**2
            logs=[B.derivative()/(2*B)-P.derivative()/P,
                  -B.derivative()/(2*B)-P.derivative()/(2*P)]
            dimensions=[5-d//2,1+d//2]
            blocks=[]
            for logarithm,ncols in zip(logs,dimensions):
                rho=logarithm.derivative()+logarithm**2-r
                images=[]
                for power in range(ncols):
                    v=s**power
                    image=common*(v.derivative(2)+2*logarithm*v.derivative()+rho*v)
                    assert image.denominator()==1
                    images.append(R(image))
                nrows=max(int(image.degree()) for image in images)+1
                mat=matrix(K,nrows,ncols,lambda ii,jj:images[jj][ii])
                rank=mat.rank()
                block={"dimension":ncols,"rank":int(rank)}
                if rank==ncols:
                    pivot_rows=list(mat.transpose().pivots())
                    minor=mat.matrix_from_rows(pivot_rows).det()
                    assert minor
                    block.update(pivot_rows=[int(z) for z in pivot_rows],minor=encode(minor))
                else:
                    kernel=mat.right_kernel().basis()
                    assert all(mat*v==0 for v in kernel)
                    block["kernel"]=[[encode(z) for z in v] for v in kernel]
                blocks.append(block)
            defect=sum(b["dimension"]-b["rank"] for b in blocks)
            results.append({"subset":list(subset),"defect":defect,"blocks":blocks})
        rows.append({"first_pair":[i,j],"hyperelliptic_polynomial":[encode(z) for z in P.list()],
                     "branch_roots":[encode(z) for z in root_values],"twists":results})
        print("first double",i,j,"defects",dict(Counter(t["defect"] for t in results)),
              "seconds",round(time.monotonic()-start,2),flush=True)
    record={"status":"complete_exact_calculation","field_modulus":[int(z) for z in K.modulus().list()],
            "alpha":encode(alpha),"tau":encode(tau),"first_doubles":rows,
            "seconds":time.monotonic()-start,
            "scope":"One dormant root, all 64 two-torsion twists on each selected double. Other roots follow only after proving Frobenius conjugacy of the cover data."}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(record,indent=2)+"\n")
    print("total",sum(len(r["twists"]) for r in rows),"nonzero",
          sum(t["defect"]>0 for r in rows for t in r["twists"]),flush=True)


if __name__=="__main__":
    main()
