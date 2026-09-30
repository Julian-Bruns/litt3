#!/usr/bin/env python3
"""Bounded F25 probe of necessary degree160 local-normality equations.

This is a probe, not an algebraic-closure or atlas-existence certificate.
Run with sage -python. --output should name an external computation artifact.
"""
import argparse
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector


def run():
    k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'z')([2, 4, 1]))
    a = k.gen()
    R = PolynomialRing(k, 'x'); x = R.gen()
    dec = lambda n: k(n % 5) + (n // 5)*a
    enc = lambda c: int(c.polynomial()[0]) + 5*int(c.polynomial()[1])
    P = R([dec(n) for n in [11,22,18,5,19,20,15,16,9,22,1]])
    hs = [R([dec(24),2,1]), R([dec(5),dec(16),0,1]),
          R([dec(5),dec(20),0,0,dec(8),1])]
    op = lambda Q: 3*P*Q.derivative()+P.derivative()*Q
    cols = [op(x**i) for i in range(51)]
    mat = matrix(k, 59, 51, lambda i,j: cols[j][i])
    # Solve only the rank46 independent columns; this fixes one origin.
    piv = mat.pivots()
    assert len(piv) == 46
    independent = mat.matrix_from_columns(piv)
    changes = [P**3*x**(5*i) for i in range(5)]
    assert all(op(c)==0 for c in changes)
    counts = {'all':0, 'simple_disjoint_zeros':0, 'leading_solution':0,
              'leading_nonzero':0, 'finite_dihedral_necessary':0}
    rows=[]
    for u in k:
        for v in k:
            counts['all'] += 1
            h=u*hs[0]+v*hs[1]+hs[2]
            if h.gcd(h.derivative()) != 1 or h.gcd(P) != 1:
                continue
            counts['simple_disjoint_zeros'] += 1
            rhs=3*h**11
            sol=independent.solve_right(vector(k,[rhs[i] for i in range(59)]))
            Q0=sum((sol[j]*x**i for j,i in enumerate(piv)),R.zero())
            assert op(Q0)==rhs
            # Q - c P^3(h')^5 is divisible by h^5, and Q_50=3c.
            h5=h**5
            leads=[q % h5 for q in changes]+[-P**3*h.derivative()**5 % h5]
            leading=matrix(k,26,6,lambda i,j: leads[j][i] if i<25
                           else (changes[j][50] if j<5 else -k(3)))
            target=vector(k,[-(Q0 % h5)[i] for i in range(25)]+[-Q0[50]])
            try:
                cs=leading.solve_right(target)
            except ValueError:
                continue
            counts['leading_solution'] += 1
            assert leading.rank()==6
            c=cs[5]
            if not c:
                continue
            counts['leading_nonzero'] += 1
            Q=Q0+sum((cs[i]*changes[i] for i in range(5)),R.zero())
            T,rem=(Q-c*P**3*h.derivative()**5).quo_rem(h5)
            assert not rem and Q[50]==3*c
            normal=(T*P**2*h.derivative()**5+
                    c*(2*P*h.derivative(2)+3*P.derivative()*h.derivative())**5) % h
            if normal:
                continue
            counts['finite_dihedral_necessary'] += 1
            rows.append({'u':enc(u),'v':enc(v),'c':enc(c),
                         'Q_ascending':[enc(Q[i]) for i in range(51)]})
    return {'counts':counts,'survivors':rows,
            'scope':'F25 necessary-equation probe only; no constant invariant or algebraic-closure elimination.'}


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path)
    args=parser.parse_args()
    result=run(); body=json.dumps(result,indent=2)+'\n'
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(body)
    print(json.dumps(result['counts'],indent=2))
    print('survivors',[(r['u'],r['v'],r['c']) for r in result['survivors']])
