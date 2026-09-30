#!/usr/bin/env python3
"""Exact audit and additional results, over F25; Python standard library only.
Run beside verify_epsilon_counterexample.py. No point sampling or floating point.
The geometric implications are proved in AUDIT.md.
"""
from __future__ import annotations
import json
from pathlib import Path
import verify_epsilon_counterexample as f


def field_sum(xs):
    out = 0
    for x in xs:
        out = f.add(out, x)
    return out


def rank(rows):
    a = [row[:] for row in rows]
    r = 0
    for j in range(len(a[0])):
        pivot = next((i for i in range(r, len(a)) if a[i][j]), None)
        if pivot is None:
            continue
        a[r], a[pivot] = a[pivot], a[r]
        scalar = f.inv(a[r][j])
        a[r] = [f.mul(scalar, x) for x in a[r]]
        for i in range(len(a)):
            if i != r:
                scalar = a[i][j]
                a[i] = [f.sub(x, f.mul(scalar, y)) for x,y in zip(a[i], a[r])]
        r += 1
    return r


def transpose(a):
    return [list(row) for row in zip(*a)]


def matrix_product(a,b):
    return [[field_sum(f.mul(x,y) for x,y in zip(row,col))
             for col in zip(*b)] for row in a]


def derivative(p):
    return f.trim([f.mul(i % 5, p[i]) for i in range(1,len(p))])


def main():
    f.main()
    # Independent exhaustive checks of the small field's ring laws.
    for a in range(25):
        for b in range(25):
            for c in range(25):
                assert f.mul(a,f.add(b,c)) == f.add(f.mul(a,b),f.mul(a,c))
                assert f.mul(a,f.mul(b,c)) == f.mul(f.mul(a,b),c)

    # Frobenius on the basis e_i=x^i/y, i=4..9, d_j=x^j/y^2, j=7..9.
    Fed = []
    for i in range(4,10):
        quotient, remainder = f.pdiv(f.monomial(5*i), f.ppow(f.P,2))
        r, ell = f.pdiv(remainder, f.P)
        assert len(ell) <= 10
        Fed.append([f.coeff(r,j) for j in range(7,10)])
    assert Fed == [[15,4,11],[1,10,6],[11,0,17],
                   [21,21,2],[20,14,20],[19,23,24]]
    F = [[0]*9 for _ in range(9)]
    for i in range(6):
        for j in range(3):
            F[6+j][i] = Fed[i][j]
    for j in range(3):
        for i in range(6):
            F[i][6+j] = f.coeff(f.K_expected[j],i+4)
    assert rank(F) == 6
    F2 = matrix_product(F, [[f.power(x,5) for x in row] for row in F])
    assert rank(F2) == 6

    # alpha=[B/y]=beta+[12]F(d7)+[7]F(d8)+[21]F(d9).
    beta = [0]*4 + [7,4,12,14,6,17]
    ss_coeff = [12,7,21]
    stable_poly = [0]
    for a,k in zip(ss_coeff,f.K_expected):
        stable_poly = f.padd(stable_poly,f.pscale(k,a))
    assert f.psub(f.psub(f.B,beta),stable_poly) == f.B[:4]
    beta_vec = beta[4:] + [0]*3
    assert all(field_sum(f.mul(a,f.power(b,5)) for a,b in zip(row,beta_vec)) == 0
               for row in F)
    assert beta_vec != [0]*9

    # Explicit Frobenius splitting of beta, and its nonzero regular differential.
    beta5 = [0]*(5*(len(beta)-1)+1)
    for i,a in enumerate(beta):
        beta5[5*i] = f.power(a,5)
    C, rem = f.pdiv(beta5, f.ppow(f.P,2))
    R,L = f.pdiv(rem,f.P)
    assert len(R) <= 7 and len(L) <= 10
    assert f.padd(f.padd(f.pmul(f.ppow(f.P,2),C),f.pmul(f.P,R)),L) == beta5
    omega = f.padd(f.pmul(f.P,derivative(C)),
                  f.pscale(f.pmul(derivative(f.P),C),f.inv(3)))
    assert omega == [20,21,24,18,10,21]

    # Phi=x*q(T)+r(T)+y*l(T)+[24]*T7^5.
    # A form term is (coefficient, variable_index_i, variable_index_j),
    # where index 0,1,2 means T7,T8,T9.
    q = [(2,0,1),(18,0,2),(18,1,1),(6,1,2),(16,2,2)]
    r = [(16,0,1),(15,1,1),(23,1,2),(20,2,2)]
    lin = [12,24,23]
    qd,rd = [0],[0]
    for a,i,j in q:
        qd = f.padd(qd,f.pscale(f.monomial(14+i+j),a))
    for a,i,j in r:
        rd = f.padd(rd,f.pscale(f.monomial(14+i+j),a))
    polynomial_quadratic = f.padd(f.pmul([0,1],qd),rd)
    linear_polynomial = [0]*7 + lin
    N = f.psub(f.psub(f.pmul(f.psub(f.B,linear_polynomial),f.ppow(f.P,3)),
                     f.pmul(polynomial_quadratic,f.ppow(f.P,2))),
               f.pscale(f.monomial(35),24))
    assert len(N) == 35 # ord_O(N/y^10)=100-3*34=-2.

    gradients = []
    for j in range(3):
        a = f.pscale(f.P,lin[j])
        for c,i,k in q:
            if i == j:
                a = f.padd(a,f.pscale(f.monomial(8+k),c))
            if k == j:
                a = f.padd(a,f.pscale(f.monomial(8+i),c))
        for c,i,k in r:
            if i == j:
                a = f.padd(a,f.pscale(f.monomial(7+k),c))
            if k == j:
                a = f.padd(a,f.pscale(f.monomial(7+i),c))
        gradients.append(a)
        assert len(a) <= 8 # ord_O(a/y^2)>=20-3*7=-1.
    assert gradients == [[4,3,19,21,1,9,13,20],
                         [3,1,8,17,2,13,21,6],
                         [17,9,15,12,13,18,6,4]]

    # q(c)=0 on c^[25]=Mc implies c=0: its M-orbit spans all quadrics.
    Q = [[0]*3 for _ in range(3)]
    for a,i,j in q:
        if i == j:
            Q[i][i] = f.add(Q[i][i],a)
        else:
            Q[i][j] = Q[j][i] = f.div(a,2)
    orbit=[]
    for _ in range(6):
        orbit.append([Q[i][j] for i in range(3) for j in range(i,3)])
        Q = matrix_product(matrix_product(transpose(f.M),Q),f.M)
    assert rank(orbit) == 6

    data={
        'field':'codes c0+5*c1, a^2=a+3',
        'Frobenius_matrix_column_convention':F,
        'rank_F':rank(F),'rank_F2':rank(F2),
        'beta_numerator':beta,'stable_coefficients':ss_coeff,
        'beta_fifth_power_splitting':{'C':C,'R':R,'L':L},
        'omega_beta_polynomial':omega,
        'new_lift':{'q_terms':q,'r_terms':r,'linear':lin,'T7_fifth_coefficient':24},
        'N':N,'gradient_numerators':gradients,
        'q_orbit':orbit,'q_orbit_rank':rank(orbit),
        'cover_degree':15625,'new_divisor_degree':15624,
        'new_divisor':'h^*O minus the point with W7=W8=W9=0'
    }
    out=Path(__file__).with_name('audit_coefficients.json')
    out.write_text(json.dumps(data,indent=2)+'\n')
    print('PASS: Frobenius rank 6, stable image rank 6, nilpotent kernel rank 3.')
    print('PASS: explicit beta decomposition, F(beta)=0, and nonzero regular differential.')
    print('PASS: exact polynomial identity for the degree-(n-1) lift.')
    print('PASS: quadratic orbit rank 6; the new lift needs one extra pole on exactly n-1 sheets.')
    print('Wrote',out.name)

if __name__ == '__main__':
    main()
