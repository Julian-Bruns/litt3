#!/usr/bin/env sage -python
"""Exact universal Prym-line reconstruction of the characteristic-five map.

Checks identities over the full Hudson parameter ring, not parameter samples.
This certifies the algebra in the accompanying human-readable argument;
the moduli and theta identifications are geometric inputs to that proof.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path
import time

from sage.all import *
from probe_pointed_kummer import ducrohet_quintics


def fixed_lines():
    k = GF(5)
    result = []
    for shift, char in itertools.product(range(4), repeat=2):
        if shift == char == 0:
            continue
        mu = k(2 if (shift & char).bit_count() % 2 else 1)
        op = matrix(k, 4, 4)
        for i in range(4):
            op[i, i ^ shift] = mu * (-1)**((i & char).bit_count() % 2)
        assert op * op == identity_matrix(k, 4)
        for sign in (1, -1):
            basis = (op-sign*identity_matrix(k, 4)).right_kernel().basis_matrix().transpose()
            assert basis.ncols() == 2
            result.append((shift, char, sign, basis))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[2]
    assert not args.output.resolve().is_relative_to(root)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    started = time.monotonic()
    k = GF(5)
    A = PolynomialRing(k, names=['a', 'b', 'c', 'd'])
    a,b,c,d = A.gens()
    relation = a*a-b*b-c*c-d*d+b*c*d+4
    R = PolynomialRing(A, names=['x0','x1','x2','x3'])
    x = R.gens()
    K = sum(z**4 for z in x)+2*a*prod(x)
    K += b*(x[0]**2*x[1]**2+x[2]**2*x[3]**2)
    K += c*(x[0]**2*x[2]**2+x[1]**2*x[3]**2)
    K += d*(x[0]**2*x[3]**2+x[1]**2*x[2]**2)
    V = ducrohet_quintics((a,b,c,d),R)
    B = PolynomialRing(A, names=['s','t'])
    s,t = B.gens()
    lines = fixed_lines()
    checks = []
    for shift,char,sign,L in lines:
        sub = [B(L[i,0])*s+B(L[i,1])*t for i in range(4)]
        quartic = B(K(*sub))
        scale = quartic.monomial_coefficient(s**4)
        middle = quartic.monomial_coefficient(s*s*t*t)
        assert quartic == scale*(s**4+t**4)+middle*s*s*t*t
        # scale^3 times the elliptic Verschiebung in the branch coordinates.
        # No division by a parameter is used in this universal verification.
        Q0 = scale**3*s**5+middle*(middle**2+2*scale**2)*s**3*t*t
        Q0 += scale*(middle**2+2*scale**2)*s*t**4
        Q1 = Q0(t,s)
        actual = [B(f(*sub)) for f in V]
        difference = [actual[i]-L[i,0]*Q0-L[i,1]*Q1 for i in range(4)]
        for f in difference:
            assert all(A(coef).reduce([relation]) == 0 for coef in f.coefficients())
        assert scale in [A(1),2+b,2-b,2+c,2-c,2+d,2-d]
        checks.append(dict(shift=shift,character=char,sign=sign,
                           basis=[[int(v) for v in row] for row in L.rows()],
                           quartic_scale=str(scale),quartic_middle=str(middle),
                           restriction_identity=True))

    # The line arrangement is connected, so the scalar of a polynomial lift
    # agreeing projectively with another lift on every line is global.
    graph = Graph()
    graph.add_vertices(range(30))
    for i,j in itertools.combinations(range(30),2):
        if lines[i][3].augment(lines[j][3]).rank() == 3:
            graph.add_edge(i,j)
    assert graph.is_connected()

    # All quintics are detected, not merely an equivariant tuple's first
    # component. Record the fourteen invariant monomials as a cross-check.
    P = PolynomialRing(k, names=['z0','z1','z2','z3'])
    z = P.gens()
    mons = []
    invariant_indices = []
    for exponents in IntegerVectors(5,4):
        mons.append(prod(z[i]**exponents[i] for i in range(4)))
        if all(sum(exponents[i]*((i & ch).bit_count() % 2) for i in range(4)) % 2 == 0
               for ch in range(4)):
            invariant_indices.append(len(mons)-1)
    assert len(mons)==56 and len(invariant_indices)==14
    T = PolynomialRing(k, names=['u','v'])
    u,v = T.gens()
    columns=[]
    for mon in mons:
        column=[]
        for _,_,_,L in lines:
            f=T(mon(*[L[i,0]*u+L[i,1]*v for i in range(4)]))
            column.extend(f.monomial_coefficient(u**(5-j)*v**j) for j in range(6))
        columns.append(column)
    restriction=matrix(k,columns).transpose()
    assert restriction.rank()==56
    assert restriction.matrix_from_columns(invariant_indices).rank()==14
    receipt=dict(kind='universal_quintic_prym_reconstruction',
                 status='exact_symbolic_algebra_pass',
                 source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                 coefficient_ring='F5[a,b,c,d]/(a^2-b^2-c^2-d^2+b*c*d+4)',
                 source_basis='coefficient Frobenius twist; all line basis entries in F5',
                 line_count=30,identities=checks,
                 intersection_graph_edges=graph.size(),intersection_graph_connected=True,
                 invariant_quintic_monomials=[str(mons[i]) for i in invariant_indices],
                 restriction_matrix_shape=list(restriction.dimensions()),restriction_rank=56,
                 invariant_restriction_rank=14,
                 seconds=round(time.monotonic()-started,2))
    args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
    print({key:receipt[key] for key in ['line_count','intersection_graph_edges',
                                       'restriction_rank','seconds']},flush=True)


if __name__=='__main__':
    main()
