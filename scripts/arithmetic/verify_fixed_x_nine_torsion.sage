#!/usr/bin/env sage
"""Verify the two remaining finite calculations for fixed-X nine-torsion.

The shared-fiber test rebuilds the rational Weierstrass locus and its
degree-nine pencils. The double-support test proves two polynomial Bezout
identities over F25[b], so it covers every geometric parameter.

By default both tests run and no files are written. --replay checks the
saved double-support coefficient certificate; --output exports the newly
computed certificates. The original shared-fiber certificate is the
user-supplied Pro package of 2026-09-08, retained locally in Research.
"""
import argparse
import json
from math import comb
from pathlib import Path
from time import monotonic

k = GF(25, 'a', modulus=PolynomialRing(GF(5), 'z')([2,4,1]))
a = k.gen()
R = PolynomialRing(k, 'x')
x = R.gen()
F = (x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6
     +4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+2*a+1)
assert F.gcd(F.derivative()) == 1


def hasse(f, j):
    """Coefficient of t^j in f(x+t), in any characteristic."""
    return f.parent()([comb(i,j)*f[i] for i in range(j,f.degree()+1)])


def shared_fiber():
    # Canonical jets after eliminating 1,x,...,x^5.
    W = matrix(R,3,3,lambda i,j:hasse(F**17,6+i-j)).det()
    W, remainder = W.quo_rem(F**33)
    assert remainder == 0 and W.degree() == 161 and W.gcd(F) == 1
    W = W.monic()
    T = x**6+(a+4)*x**5+(3*a+2)*x**4+(2*a+2)*x**3+x**2+4*a*x+4*a+4
    assert W.gcd(power_mod(x,25**12,W)-x) == T
    assert T.is_irreducible()
    K = k.extension(T,'b')
    b = K.gen()
    # Fix the original certificate's cube root to permit exact comparison.
    c = sum(K(k(v%5)+k(v//5)*a)*b**i
            for i,v in enumerate([14,11,1,24,14,20]))
    assert c**3 == F(b) != 0
    zeta = K(2*a+1)
    assert zeta != 1 and zeta**3 == 1
    points = {(b**(25**i),c**(25**i)*zeta**j)
              for i in range(6) for j in range(3)}
    assert len(points) == 18

    P = PolynomialRing(K,'t')
    t = P.gen()
    ff = P(F(b+t))
    yy = (ff/F(b))**17
    yy = (c*yy).truncate(9)
    assert (yy**3-ff).truncate(9) == 0
    jets = matrix(K,[[yy[i-j] for j in range(3)] for i in (6,7,8)])
    assert jets.rank() == 2
    kernel = jets.right_kernel().basis()[0]
    assert kernel[0] != 0
    C = P(list(kernel/kernel[0]))
    B = (C*yy).truncate(6)
    A = (C*yy**2).truncate(9)
    for j in (1,2):
        ys = zeta**j*yy
        assert (A+B*ys+C*ys**2).truncate(9) == 0
    assert A[0]+B[0]*c+C[0]*c**2 != 0

    checks = []
    product = K.one()
    for i in range(1,6):
        bx,cy = b**(25**i),c**(25**i)
        tt = bx-b
        for j in range(3):
            y = zeta**j*cy
            N = A(tt)+B(tt)*y+C(tt)*y**2
            dN = A.derivative()(tt)+B.derivative()(tt)*y+C.derivative()(tt)*y**2
            E = tt*(3*F(bx)*dN+F.derivative()(bx)*(B(tt)*y+2*C(tt)*y**2))-2*F(bx)*N
            assert E != 0
            checks.append([int(i),int(j),E])
            product *= E
    expected = sum(K(k(v%5)+k(v//5)*a)*b**i
                   for i,v in enumerate([21,14,10,15,13,8]))
    assert product == expected != 0

    def encode(z):
        return [int(k(z[i])[0])+5*int(k(z[i])[1]) for i in range(6)]
    return dict(H=[24,20,1,12,17,9,1], c=encode(c),
                C=[encode(C[i]) for i in range(3)],
                A=[encode(A[i]) for i in range(9)],
                B=[encode(B[i]) for i in range(6)],
                checks=[[i,j,encode(E)] for i,j,E in checks],
                product=encode(product))


def double_support(saved=None):
    # Here x is the parameter b; S=(original x-b)/F(b).
    P = PolynomialRing(R,'S')
    S = P.gen()
    rhs = P([R.one()]+[F**(j-1)*hasse(F,j) for j in range(1,11)])
    if saved is None:
        H = P.one()
        for n in range(1,18):
            H += (rhs[n]-(H**3)[n])/k(3)*S**n
    else:
        H = P((PowerSeriesRing(R,'S',default_prec=18)(rhs.list())**17).list())
    assert (H**3-rhs).truncate(18) == 0
    H2 = (H**2).truncate(18)
    columns = [(H,i) for i in range(6)]+[(H2,i) for i in range(3)]
    J = matrix(R,[[h[n-i] for h,i in columns] for n in range(10,18)])
    minors = [(-1)**j*J.matrix_from_columns([i for i in range(9) if i!=j]).det()
              for j in range(9)]

    def decode(values):
        return R([k(v[0])+k(v[1])*a for v in values])
    if saved is not None:
        assert minors == [decode(v) for v in saved['maximal_minors']]
        bezout = [decode(v) for v in saved['rank_bezout']]
    else:
        gcd = R.zero()
        bezout = [R.zero()]*9
        for j,d in enumerate(minors):
            gcd,left,right = gcd.xgcd(d)
            bezout = [left*v for v in bezout]
            bezout[j] += right
        assert gcd == 1
    assert sum(u*d for u,d in zip(bezout,minors)) == 1
    assert J*vector(R,minors) == 0
    B,C = P(minors[:6]),P(minors[6:])
    A = -(B*H+C*H2).truncate(10)
    assert (A+B*H+C*H2).truncate(18) == 0
    N = A**3+B**3*rhs+C**3*rhs**2-3*A*B*C*rhs
    assert N.truncate(18) == 0 and N.degree() <= 27
    h = [N[i+18] for i in range(10)]
    assert h[9] != 0
    equations = [h[7]*h[9]-h[8]**2,h[6]*h[9]**2-h[8]**3]
    if saved is not None:
        assert equations == [decode(v) for v in saved['ninth_power_equations']]
        u,v = [decode(w) for w in saved['ninth_power_bezout']]
    else:
        gcd,u,v = equations[0].xgcd(equations[1])
        assert gcd == 1
    assert u*equations[0]+v*equations[1] == 1

    def encode(z):
        return [[int(c[0]),int(c[1])] for c in z.list()]
    return dict(maximal_minors=[encode(z) for z in minors],
                rank_bezout=[encode(z) for z in bezout],
                ninth_power_equations=[encode(z) for z in equations],
                ninth_power_bezout=[encode(u),encode(v)],
                generic_rank=8,rank_gcd=1,ninth_power_gcd=1)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--case',choices=['all','shared-fiber','double-support'],default='all')
    parser.add_argument('--replay',action='store_true',
                        help='check the retained double-support coefficients')
    parser.add_argument('--output',type=Path,help='optional JSON certificate export')
    args = parser.parse_args()
    started = monotonic()
    result = {}
    if args.case != 'double-support':
        result['shared_fiber'] = shared_fiber()
    if args.case != 'shared-fiber':
        path = Path(__file__).resolve().parents[2]/'../litt3-computation-data/legacy_workspace_computations/fixed_x_double_support_torsion.json'
        saved = json.loads(path.read_text()) if args.replay else None
        result['double_support'] = double_support(saved)
    if args.output:
        args.output.write_text(json.dumps(result,separators=(',',':'),default=int)+'\n')
    print('PASS: %s (%.2fs)' % (', '.join(result),monotonic()-started))


if __name__ == '__main__':
    main()
