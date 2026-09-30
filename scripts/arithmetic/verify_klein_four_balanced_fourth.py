#!/usr/bin/env python3
"""Independent relative-field replay of the balanced fourth-trace exclusion.

Use F25[z]/f7, the explicit quadratic resultant formula, elementary Euclid,
and retained complete root lists. No resultants, factorization or root finder
are called. The producer uses the absolute degree-fourteen field and NTL.
"""
import argparse
import json
from pathlib import Path
from sage.all import GF, PolynomialRing


def main(path):
    data = json.loads(path.read_text())
    B = PolynomialRing(GF(5), 'b'); b = B.gen()
    F = GF(25, 'b', modulus=b*b-b-3); b = F.gen()
    code = lambda n: F(n % 5) + F(n//5)*b
    Z = PolynomialRing(F, 'z')
    f7 = Z([code(c) for c in [4,22,7,20,21,7,24,1]])
    K = Z.quotient(f7, 'z'); z = K.gen()
    assert f7.is_irreducible() and z**29 == 1 and z != 1
    decode = lambda row: sum((K(c)*z**j for j,c in enumerate(row)), K.zero())
    assert decode([1,1,0,0,4,3,3,1,1,3,1,2,1,1]) == K(b)
    kap, u, ub, a = map(lambda c: K(code(c)), [17,8,24,12])
    q = 5**7
    assert u**q == ub and u*ub == 4 and u*u == a
    P = PolynomialRing(K, 'N'); N = P.gen()
    R = PolynomialRing(K, 'E'); E = R.gen()
    bar = lambda h: P([c**q for c in h.list()])

    def gcd(f,g):
        while g:
            f,g = g,f%g
        return f/f.leading_coefficient()

    def power_mod(x,n,f):
        r = f.parent().one()
        while n:
            if n&1:r = (r*x)%f
            x=(x*x)%f;n//=2
        return r

    covered=set(); total_candidates=0
    for row in data['cases']:
        j=row['phase']; phi=z**j
        orbit={j*pow(25,i,29)%29 for i in range(7)}
        assert not covered.intersection(orbit); covered.update(orbit)
        if j:
            ep=(kap*phi**5-kap**q)/(1-phi**(-8))
            assert ep**(q+1)!=1
        else:assert kap!=kap**q
        aa=1-phi**18
        bb=(1-N)**4*(ub*phi**12-u)
        cc=(1-N)**4*(u*N*phi**25-ub)+N**5*kap-kap**q*phi**25
        if not j:
            resultant=cc*bar(cc)-N*bb*bar(bb)
        else:
            # Coefficients of norm-compatible quadratic, then its fifth power
            # reduced by aa*E^5+bb*E+cc. Resultant via a 2x2 identity.
            A=bar(cc)*bb
            B=bar(bb)*N*bb+bar(cc)*cc-aa*(aa**q)*N**5
            C=bar(bb)*N*cc
            D=A**5*bb**2
            J=2*A**5*bb*cc-aa*B**5*bb
            H=A**5*cc**2-aa*B**5*cc+aa**2*C**5
            resultant=(A*H-C*D)**2-(A*J-B*D)*(B*H-C*J)
        assert resultant and resultant.degree()==row['resultant_degree']
        g=P(gcd(resultant,power_mod(N,q,resultant)-N))
        assert g == P([decode(c) for c in row['field_norm_gcd_coefficients']])
        roots=[decode(c) for c in row['norms']]
        product=P.one()
        for nv in roots:
            assert nv**q==nv
            product*=N-nv
        assert product==g and len(set(roots))==len(roots)
        seen=0
        for nv in roots:
            if nv in [0,1]:continue
            f=R(aa)*E**5+R(bb(nv))*E+R(cc(nv))
            assert f
            h=R(gcd(f,power_mod(E,q+1,f)-nv))
            witnesses=[x for x in row['candidates'] if decode(x['norm'])==nv]
            product=R.one()
            for witness in witnesses:
                ep=decode(witness['epsilon']); product*=E-ep
                assert ep and ep**(q+1)==nv
                yb=(kap*phi**5-ep*(1-phi**(-8))-nv*kap**q)/(1-nv)
                y=yb**q; x=phi**8-ep*kap+ep*y
                assert ep*(1-x**q)==kap*phi**5-yb
                assert ep*(kap-y)==phi**8-x
                r0=ep*a+4-u*(ep*x**625-yb**5)
                r1=a*phi**17+4*ep*phi**4-u*(x**(q*625)-ep*y**5)
                assert [not bool(r0),not bool(r1)]==witness['fourth_zero']
                assert r0 or r1
                seen+=1
            assert product==h
        assert seen==len(row['candidates']) and row['survivors']==[]
        total_candidates+=seen
        print('PASS phase',j,'resultant degree',resultant.degree(),
              'norm gcd',g.degree(),'complete candidate count',seen,flush=True)
    assert covered==set(range(29)) and total_candidates==4
    print('PASS: all balanced phases and all nonzero epsilon in F_(5^14) excluded.')
    print('Unbalanced endpoints and the original common-cover problems are not decided.')


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('certificate',type=Path)
    main(p.parse_args().certificate)
