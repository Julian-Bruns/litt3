#!/usr/bin/env python3
"""Check the boundary-complete full-nullvector moment eliminant in actual K.

These checks verify algebraic identities and finite-field Frobenius reduction.
They do not enumerate genuine endpoint pairs or decide mixed incidence.
"""
import argparse,json,random,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[3]/'litt3-computation-data/october01_audited_replies/mixed_span_incidence/src'))
from field import K,ksum
from finite import phi
from rank_reconstruction import KBASIS,flat,affine_solve


def mul(*xs):
    ans=K.one
    for x in xs:ans=K.mul(ans,x)
    return ans


def null_constants(a,q,s,X,Y):
    A=ksum((mul(s,phi(X,4)),K.neg(mul(q,phi(X,7))),phi(Y,1),K.neg(mul(a,s,Y))))
    B=ksum((phi(X,11),K.neg(mul(a,s,X)),mul(s,phi(Y,8)),K.neg(mul(q,phi(Y,7)))))
    return A,B


def eliminant(a,q,s,A,B):
    """Return coefficients at ordinary degrees625,125,5,1 and RHS, or I=0."""
    ns=mul(s,phi(s,7));I=K.sub(phi(q,7),mul(a,ns));J=K.sub(ns,K.one)
    L=mul(phi(s,7),K.sub(phi(a,7),q));C=K.sub(mul(phi(s,7),B),phi(A,7))
    assert s!=K.zero and q!=phi(a,7)
    if I==K.zero:
        assert J!=K.zero
        p=K.div(mul(phi(s,7),K.sub(q,phi(a,7))),J)
        c=K.div(K.sub(mul(phi(s,7),A),phi(B,7)),J)
        d=K.div(K.sub(mul(s,phi(B,7)),A),J)
        assert p!=K.zero
        return dict(chart='I=0',p=p,c=c,d=d,bound=25)
    Ji,Li,Ci=(K.div(z,I) for z in (J,L,C))
    c12=K.neg(mul(s,phi(Ji,4)));c11=K.neg(mul(s,phi(Li,4)))
    c1=K.add(K.one,mul(q,phi(Ji,7)));c0=K.sub(mul(q,phi(Li,7)),mul(a,s))
    assert c1==K.div(mul(ns,K.sub(q,phi(a,7))),phi(I,7)) and c1!=K.zero
    assert c0==K.div(mul(s,K.sub(mul(a,phi(a,7),ns),mul(q,phi(q,7)))),phi(I,7))
    rhs=ksum((A,K.neg(mul(s,phi(Ci,4))),mul(q,phi(Ci,7))))
    return dict(chart='I!=0',coefficients=[phi(z,3) for z in (c1,c0,c12,c11)],
                rhs=phi(rhs,3),Ji=Ji,Li=Li,Ci=Ci,bound=625)


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--output',required=True,type=Path);args=ap.parse_args()
    rng=random.Random(801);rand=lambda:K.decode(rng.randrange(1,5**14));counts={}
    for chart in ('generic','J=0','I=0','J=0,nq=na'):
        for sample in range(6):
            a,s,X,Y=(rand() for _ in range(4))
            if chart.startswith('J=0'):s=K.div(s,phi(s,7))
            q=rand()
            if chart=='I=0':q=mul(phi(a,7),s,phi(s,7))
            if chart=='J=0,nq=na':
                z=rand();q=mul(a,K.div(z,phi(z,7)))
            assert q!=phi(a,7)
            A,B=null_constants(a,q,s,X,Y);data=eliminant(a,q,s,A,B)
            T,S=phi(X,4),phi(Y,1)
            if data['chart']=='I=0':
                assert T==K.add(mul(data['p'],phi(T,3)),data['c'])
                assert S==K.add(mul(phi(data['p'],7),phi(S,13)),data['d'])
            else:
                assert X==ksum((data['Ci'],K.neg(mul(data['Ji'],phi(Y,8))),K.neg(mul(data['Li'],phi(Y,7)))))
                assert ksum(mul(c,phi(Y,n)) for c,n in zip(data['coefficients'],(4,3,1,0)))==data['rhs']
                assert data['coefficients'][0]!=K.zero
                if chart=='J=0,nq=na':assert data['coefficients'][1:3]==[K.zero,K.zero]
                # Native power checks verify the literal ordinary polynomial,
                # including the modulo14 Frobenius return used in its derivation.
                assert ksum(mul(c,K.pow(Y,n)) for c,n in zip(data['coefficients'],(625,125,5,1)))==data['rhs']
            counts[chart]=counts.get(chart,0)+1
    # This fixed example prevents an unjustified alternating/skew trace claim
    # based only on the displayed conjugate2x2 coefficient matrix.
    a,q,s=(tuple(x) for x in ([18,3,23,15,23,0,18],
        [20,15,11,10,17,5,16],[21,23,15,4,3,15,21]))
    data=eliminant(a,q,s,K.zero,K.zero)
    cols=[flat(ksum(mul(c,phi(y,n)) for c,n in zip(data['coefficients'],(4,3,1,0)))) for y in KBASIS]
    out=affine_solve(list(map(list,zip(*cols))),[0]*14)
    assert out is not None and len(out[1])==1
    result=dict(status='PASS',checks=counts,field='actual K=F5^14',
        scope='algebraic elimination and finite Frobenius identities only; no genuine-pair or incidence decision',
        generic_root_bound=625,I_zero_root_bound=25,J_zero_equal_norm_root_bound=25,
        arbitrary_coefficient_odd_kernel_example=dict(a=a,q=q,s=s,dimension=1))
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result))


if __name__=='__main__':main()
