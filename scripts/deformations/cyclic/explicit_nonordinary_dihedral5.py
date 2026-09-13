#!/usr/bin/env sage-python
"""Actual D10 covers and degree-five quotients of the obstructed F625 pair.

Uses every etale double of the explicit genus-two pair with nonzero W3
obstruction, then the elliptic anti-invariant Artin--Schreier direction.
Only characteristic-five Hodge ranks are calculated; no full tower is assumed.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
from itertools import combinations
import json
from math import comb
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix
from scripts.deformations.backup_heisenberg_defect import CurveAlgebra


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',required=True)
    args=ap.parse_args()
    start=time.monotonic()
    prime=GF(5);P=PolynomialRing(prime,'T');T=P.gen()
    small=GF(625,name='t',modulus=T**4+4*T**3+T**2+4*T+3)
    t0=small.gen()
    k,embed=small.extension(4,'a',map=True)
    t=embed(t0);degree=int(k.degree())
    encode=lambda x:[int(k(x).polynomial()[i]) for i in range(degree)]
    Q=PolynomialRing(small,'u');u=Q.gen()
    h0=4*t0+3
    A=(u-t0)*(u-h0)**2/(4+4*t0)
    encode_small=lambda x:[int(small(x).polynomial()[i]) for i in range(4)]
    points=[small(0),small(1),small(2),small(3),t0,None]
    results=[]
    for i,j in combinations(range(6),2):
        R=u-points[i]
        if points[j] is not None:R*=u-points[j]
        base=CurveAlgebra(k,t,[encode_small(c) for c in R],[encode_small(c) for c in A])
        const=matrix(k,6,6,lambda ii,jj:base.split(
            base.scale(base.frob(base.mono(*base.basis[jj])),base.A))[0][ii],
            implementation='generic')
        assert const[:3,:3].rank()==2
        H=base.split(base.frob(base.mono(2,-1)),tangent=False)[0][2]
        assert H
        C=PolynomialRing(k,'c');c=C.gen()
        lam=(H*c**4-1).roots(multiplicities=False)[0]
        chi=base.mono(2,-1,lam)
        co,fu,tail=base.split(base.add(base.frob(chi),base.neg(chi)),tangent=False)
        assert not any(co)
        fo=base.neg(tail)
        assert base.add(fu,base.neg(fo))==base.add(base.frob(chi),base.neg(chi))
        assert all(int(e)>=0 for lp in fu for e in lp.dict())
        assert all(2*int(e)+base.poles[comp]<=0 for comp,lp in enumerate(fo) for e in lp.dict())
        # The original double involution fixes v and negates kappa,ell.
        sign=(1,-1,-1,1)
        invol=lambda value:tuple(sign[ii]*lp for ii,lp in enumerate(value))
        assert invol(chi)==base.neg(chi) and invol(fu)==base.neg(fu)
        chpow=[base.one];fpow=[base.one]
        for _ in range(4):
            chpow.append(base.mul(chpow[-1],base.neg(chi)))
            fpow.append(base.mul(fpow[-1],fu))
        def reduce(vec):
            vec=list(vec);answer={}
            for power in range(4,-1,-1):
                cs,aff,inf=base.split(vec[power])
                for jj,cc in enumerate(cs):
                    if cc:answer[6*power+jj]=cc
                if base.nonzero(inf):
                    for lower in range(power):
                        correction=base.scale(base.mul(inf,chpow[power-lower]),k(comb(power,lower)))
                        vec[lower]=base.add(vec[lower],base.neg(correction))
            return answer
        columns=[]
        for power in range(5):
            for component,exponent in base.basis:
                leading=base.scale(base.frob(base.mono(component,exponent)),base.A)
                vec=[base.scale(base.mul(leading,fpow[power-lower]),k(comb(power,lower)))
                     if lower<=power else base.zero for lower in range(5)]
                columns.append(reduce(vec))
        psi=matrix(k,30,30,{(row,col):v for col,cs in enumerate(columns) for row,v in cs.items()},
                   implementation='generic',sparse=False)
        signs=[sign[component]*(-1)**power for power in range(5) for component,exponent in base.basis]
        sigma=matrix(k,30,30,lambda ii,jj:
            k(comb(jj//6,ii//6)) if ii%6==jj%6 and ii//6<=jj//6 else k(0),
            implementation='generic')
        tau=matrix.diagonal(k,signs)
        assert sigma**5==1 and tau*sigma*tau==sigma**4
        assert psi*sigma==sigma*psi and psi*tau==tau*psi
        invariant=[ii for ii,s in enumerate(signs) if s==1]
        assert len(invariant)==15
        quotient=psi.matrix_from_rows_and_columns(invariant,invariant)
        assert not any(psi[ii,jj] for ii in invariant for jj in range(30) if jj not in invariant)
        row=dict(pair=[i,j],double_defect=6-int(const.rank()),closure_defect=30-int(psi.rank()),
            degree5_defect=15-int(quotient.rank()),elliptic_Hasse=encode(H),AS_scale=encode(lam),
            R=[encode_small(c) for c in R],A=[encode_small(c) for c in A],
            shift=base.encode(chi,encode),affine_rhs=base.encode(fu,encode),
            infinity_rhs=base.encode(fo,encode),
            hodge_matrix=[[encode(v) for v in row] for row in psi.rows()],
            quotient_basis=invariant,seconds=time.monotonic()-start)
        results.append(row)
        print(json.dumps({key:row[key] for key in ['pair','double_defect','closure_defect',
                            'degree5_defect','seconds']}),flush=True)
    output=dict(status='PASS',field_modulus=[int(v) for v in k.modulus()],parameter=encode(t),
        covers=results,seconds=time.monotonic()-start,
        scope='Actual D10-Galois closures and non-Galois degree5 quotients; no higher-Witt continuation asserted.')
    Path(args.output).write_text(json.dumps(output,indent=2)+'\n')


if __name__=='__main__':main()
