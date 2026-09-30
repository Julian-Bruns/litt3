#!/usr/bin/env python3
"""Exact first-derivative trace ranks and two-label Fourier rigidity.

The coefficient field is unrestricted. The finite calculation concerns only
the fixed four roots and the 29 possible endpoint phases.
"""
import argparse, itertools, json, time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix

def main():
    ap=argparse.ArgumentParser(); ap.add_argument('output',type=Path)
    args=ap.parse_args(); started=time.monotonic()
    F=GF(5); R=PolynomialRing(F,'b'); b=R.gen()
    B=GF(25,'b',modulus=b*b-b-3); b=B.gen()
    dec=lambda c:B(c%5)+B(c//5)*b
    code=lambda c:int(B(c)[0])+5*int(B(c)[1])
    R=PolynomialRing(B,'a'); a=R.gen()
    modulus=R([dec(c) for c in [5,2,6,7,1]])
    assert modulus.is_irreducible()
    E=B.extension(modulus,'a'); a=E.gen(); roots=[a**(25**i) for i in range(4)]
    R=PolynomialRing(E,'x'); x=R.gen()
    P=R([dec(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
    A=R([dec(c) for c in [1,21,14,22,13]])
    c=R([dec(c) for c in [22,7,9,23]])
    encode=lambda z:[code(E(z).lift()[i]) for i in range(4)]
    r={1:[],2:[]}; branches=[]; residue_constants=[]
    for alpha in roots:
        assert A(alpha)==0
        z0=(3*A.derivative()(alpha)**3*P(alpha)**2/dec(13)**3)**pow(29,-1,5**8-1)
        a1=dec(13)*z0**4/A.derivative()(alpha)
        a2=(4*dec(13)*z0**3*c(alpha)-A.derivative(2)(alpha)*a1*a1/2)/A.derivative()(alpha)
        for k in [1,2]:
            r[k].append(2*a2/a1**2-E(k)/3*P.derivative()(alpha)/P(alpha))
        branches.append(dict(root=encode(alpha),z0=encode(z0),a1=encode(a1),a2=encode(a2)))
        root_index=len(branches)-1
        residue_constants.append(2*A.derivative()(alpha)/dec(13)*z0**(-10)*P(roots[0])**(2*((25**root_index-1)//3)))
    residue_matrix=matrix(B,[[v.lift()[j] for v in residue_constants] for j in range(4)])
    assert residue_matrix.det()==dec(12)
    ranks={}
    for k,rows in [(2,6),(1,3)]:
        M=matrix(E,[[alpha**j*r[k][i]+(j*alpha**(j-1) if j else 0)
                     for i,alpha in enumerate(roots)] for j in range(rows)])
        rank=int(M.rank()); assert rank==(4 if k==2 else 3)
        minors=[]
        if k==1:
            for cols in itertools.combinations(range(4),3):
                det=M.matrix_from_columns(cols).det(); assert det
                minors.append(dict(columns=list(cols),det=encode(det)))
        else:
            selected=next(rs for rs in itertools.combinations(range(6),4)
                          if M.matrix_from_rows(rs).det())
            minors.append(dict(rows=list(selected),det=encode(M.matrix_from_rows(selected).det())))
        ranks[str(k)]=dict(rank=rank,matrix=[[encode(z) for z in row] for row in M.rows()],minors=minors)

    S=PolynomialRing(B,'z'); z=S.gen()
    phase_modulus=S([dec(c) for c in [4,22,7,20,21,7,24,1]])
    assert phase_modulus.is_irreducible()
    K=B.extension(phase_modulus,'z'); z=K.gen(); assert z**29==1 and z!=1
    ph=[tuple(code((z**i).lift()[j]) for j in range(7)) for i in range(29)]
    add=[[code(dec(i)+dec(j)) for j in range(25)] for i in range(25)]
    mul=[[code(dec(i)*dec(j)) for j in range(25)] for i in range(25)]
    zz=dec(11); assert zz**3==1 and zz!=1
    zc=code(zz); nc=code(-1/zz**2)
    pairs={}
    for i in range(29):
        for j in range(i,29):
            key=tuple(add[ph[i][k]][ph[j][k]] for k in range(7))
            assert key not in pairs
            pairs[key]=(i,j)
    solutions=[]
    for a0,p0 in pairs.items():
        for a1,p1 in pairs.items():
            a2=tuple(mul[nc][add[a0[k]][mul[zc][a1[k]]]] for k in range(7))
            if a2 in pairs:
                p2=pairs[a2]; assert p0==p1==p2
                solutions.append(p0)
    assert len(solutions)==435

    # xi^4 and xi^8 occupy the two distinct degree14 Frobenius orbits.
    orbit4={4*pow(5,i,29)%29 for i in range(14)}
    orbit8={8*pow(5,i,29)%29 for i in range(14)}
    assert len(orbit4)==len(orbit8)==14 and not orbit4&orbit8
    assert orbit4|orbit8==set(range(1,29))
    result=dict(status='PASS',branches=branches,derivative_ranks=ranks,
                residue_basis_matrix=[[code(c) for c in row] for row in residue_matrix.rows()],residue_basis_determinant=12,
                two_label_pairs=435,two_label_fourier_triples=len(solutions),
                all_fourier_triples_balanced=True,phase_orbits=[sorted(orbit4),sorted(orbit8)],
                seconds=time.monotonic()-started)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS derivative ranks 4,3; all four maximal k=1 minors nonzero; 435 balanced two-label triples; complementary phase orbits',flush=True)

if __name__=='__main__': main()
