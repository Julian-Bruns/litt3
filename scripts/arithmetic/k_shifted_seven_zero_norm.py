#!/usr/bin/env python3
"""Actual cubic-norm identities forced by a seven-zero section.

Reconstruct the complete coefficient matrix of
  (y*C*U+B*V)^3 + (A*U+y^2*D*V)^3 = (A*B-P*C*D)*G.
The left side is the C3 orbit product. G is in the already computed
seven-dimensional invariant space H0(Sym3(F^*K)(3O)). A true candidate
must satisfy this identity, including all finite and infinity zeros.
This script prepares the two charts in the two-dimensional character
part; it does not infer existence from a polynomial solution.
"""
import argparse
import hashlib
import json
from math import factorial
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, prod


def compositions(n, length):
    if length == 1:
        yield (n,)
    else:
        for j in range(n+1):
            for tail in compositions(n-j, length-1):
                yield (j,)+tail


def multinomial(e):
    n = factorial(sum(e))
    for i in e:
        n //= factorial(i)
    return n


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('sections', type=Path)
    ap.add_argument('net_sections', type=Path)
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--chart', type=int, choices=(0, 1), required=True)
    args = ap.parse_args()
    source = json.loads(args.sections.read_text())['sections']
    net = json.loads(args.net_sections.read_text())['sections']
    assert len(source) == len(net) == 7
    k = GF(25, 'a', modulus=PolynomialRing(GF(5), 'v')([2, 4, 1]))
    a = k.gen()
    decode = lambda c: k(c % 5)+(c//5)*a
    encode = lambda c: int(c.polynomial()[0])+5*int(c.polynomial()[1])
    R = PolynomialRing(k, 'x')
    x = R.gen()
    P = R([decode(c) for c in (11,22,18,5,19,20,15,16,9,22,1)])
    def read(section, index, residue):
        terms = section['affine'][index]
        assert all(r == residue and m >= 0 for r, m, c in terms)
        return sum(decode(c)*x**m for r, m, c in terms)
    C = [read(s, 0, 1) for s in source[:5]]
    B = [read(s, 5, 0) for s in source[:5]]
    A = [read(s, 0, 0) for s in source[5:]]
    D = [read(s, 5, 2) for s in source[5:]]
    G = [[read(s, i, r) for i, r in zip((0,5,10,15),(0,2,1,0))] for s in net]
    H = [[A[j]*B[i]-P*C[i]*D[j] for j in range(2)] for i in range(5)]
    assert all(h.degree() <= 7 for row in H for h in row)
    names = ['b'+str(i) for i in range(5)]+['d0','d1']+['g'+str(i) for i in range(7)]
    monomials, columns = [], []
    for e in compositions(3, 5):
        row = [R.zero() for _ in range(4)]
        row[0] = multinomial(e)*P*prod(c**i for c, i in zip(C,e))
        row[3] = multinomial(e)*prod(b**i for b, i in zip(B,e))
        for j in range(5):
            if not e[j]:
                continue
            f = list(e); f[j] -= 1
            row[1] += 3*multinomial(f)*B[j]*prod(c**i for c,i in zip(C,f))
            row[2] += 3*multinomial(f)*C[j]*prod(b**i for b,i in zip(B,f))
        monomials.append(e+(0,)*9); columns.append(row)
    for e in compositions(3, 2):
        row = [R.zero() for _ in range(4)]
        row[0] = multinomial(e)*prod(v**i for v,i in zip(A,e))
        row[3] = multinomial(e)*P**2*prod(v**i for v,i in zip(D,e))
        for j in range(2):
            if not e[j]:
                continue
            f = list(e); f[j] -= 1
            row[1] += 3*multinomial(f)*D[j]*prod(v**i for v,i in zip(A,f))
            row[2] += 3*multinomial(f)*P*A[j]*prod(v**i for v,i in zip(D,f))
        monomials.append((0,)*5+e+(0,)*7); columns.append(row)
    for i in range(5):
        for j in range(2):
            for v in range(7):
                e = [0]*14; e[i] = e[5+j] = e[7+v] = 1
                monomials.append(tuple(e)); columns.append([-H[i][j]*f for f in G[v]])
    assert len(columns) == 109
    rows = [(i,m) for i in range(4) for m in range(1+max(int(c[i].degree()) for c in columns))]
    full = matrix(k, [[c[i][m] for c in columns] for i,m in rows])
    reduced = full.echelon_form()
    rank = full.rank()
    # Check the polynomial expansion at geometric coefficient values,
    # independently by direct cubes and polynomial multiplication.
    for shift in range(4):
        values = [a**(i+shift)+k(i%5) for i in range(14)]
        cc, bb, aa, dd = [sum(v*f for v,f in zip(values[lo:hi],fs))
                          for lo,hi,fs in ((0,5,C),(0,5,B),(5,7,A),(5,7,D))]
        gg = [sum(values[7+j]*G[j][i] for j in range(7)) for i in range(4)]
        hh = aa*bb-P*cc*dd
        direct = [P*cc**3+aa**3, 3*(cc**2*bb+aa**2*dd),
                  3*(cc*bb**2+P*aa*dd**2), bb**3+P**2*dd**3]
        direct = [f-hh*g for f,g in zip(direct,gg)]
        expanded = [sum(prod(v**e for v,e in zip(values,mon))*col[i]
                        for mon,col in zip(monomials,columns)) for i in range(4)]
        assert direct == expanded
    kept = names[:5]+(['d0'] if args.chart == 1 else [])+names[7:]
    S = PolynomialRing(k, kept, order='degrevlex')
    values = [S(n) for n in names[:5]]
    values += [S('d0'), S.one()] if args.chart == 1 else [S.one(), S.zero()]
    values += [S(n) for n in names[7:]]
    mon = [prod(v**e for v,e in zip(values,es)) for es in monomials]
    equations = [sum(c*m for c,m in zip(row,mon)) for row in reduced[:rank]]
    equations = [f for f in equations if f]
    receipt = {'status': 'PREPARED', 'scope': 'Necessary exact norm identities for a genuine degree-zero subline of F^*K(O). No locus decision.',
               'chart': args.chart, 'variables': kept, 'equations': [str(f) for f in equations],
               'coefficient_matrix_shape': list(full.dimensions()), 'coefficient_rank': int(rank),
               'norm_columns_rank': int(full[:,:39].rank()),
               'wedge_net_columns_rank': int(full[:,39:].rank()),
               'coefficient_monomials': monomials,
               'reduced_coefficient_rows': [[encode(c) for c in row] for row in reduced[:rank]],
               'direct_expansion_checks': 4,
               'input_hashes': [hashlib.sha256(p.read_bytes()).hexdigest() for p in (args.sections,args.net_sections)]}
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    print('PREPARED chart', args.chart, 'rank', rank, 'norm rank', receipt['norm_columns_rank'],
          'product rank', receipt['wedge_net_columns_rank'], 'variables',len(kept),'equations',len(equations),flush=True)


if __name__ == '__main__':
    main()
