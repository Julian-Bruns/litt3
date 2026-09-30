#!/usr/bin/env python3
"""Supplementary exact checks for the completed theoretical proof.

Python standard library only. These check identities and finite-dimensional
recurrence matrices, not maps or unrestricted geometric coefficients.
The proof for arbitrary geometric a,b is in REPORT.md, not inferred from
checking their F5 values here.
"""
from math import comb
from hashlib import sha256
import json

P = 5

def trim(a):
    a = [x % P for x in a]
    while a and not a[-1]:
        a.pop()
    return a

def mul(a, b):
    out = [0] * max(0, len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i+j] = (out[i+j] + x*y) % P
    return trim(out)

def power(a, n):
    out = [1]
    for _ in range(n):
        out = mul(out, a)
    return out

def rank(rows):
    if not rows:
        return 0
    rows = [[v % P for v in row] for row in rows]
    r, nc = 0, len(rows[0])
    for c in range(nc):
        pivot = next((j for j in range(r, len(rows)) if rows[j][c]), None)
        if pivot is None:
            continue
        rows[r], rows[pivot] = rows[pivot], rows[r]
        inv = pow(rows[r][c], -1, P)
        rows[r] = [(v*inv) % P for v in rows[r]]
        for j in range(len(rows)):
            if j != r and rows[j][c]:
                factor = rows[j][c]
                rows[j] = [(u-factor*v) % P for u, v in zip(rows[j], rows[r])]
        r += 1
        if r == len(rows):
            break
    return r

def recurrence_matrix(s, a, b):
    rows = []
    for j in range(s + 1):
        row = [0] * (s + 1)
        row[j] = b*(j-s)**2 % P
        if j < s:
            row[j+1] = a*(j+1)**2 % P
        rows.append(row)
    return rows

def matrix_vector(rows, vector):
    return [sum(x*y for x,y in zip(row, vector)) % P for row in rows]

def verify():
    # u=eta*t^16/r0^17, u'/u=3/t; g0=4*t*(u-1).
    r_exponent = 13 * pow(12, -1, P) % P
    u_exponent = (16 - 17*r_exponent) % P
    assert r_exponent == 4 and u_exponent == 3
    first = u_exponent
    second = u_exponent*(u_exponent-1)*pow(2,-1,P) % P
    g1 = pow(r_exponent,-1,P)*first % P
    g2_times_c = pow(r_exponent,-1,P)*(first+second) % P
    assert (g1, g2_times_c) == (2,4)

    # R=A/h+B+...: (2R+g0 R')_0=2B-4A/c.
    # For Q=lambda*t^7*R2(1/t), Res(Q)=-lambda*c^9*A2;
    # its finite part is lambda*c^8*A2*(2-1-7)=Res(Q)/c.
    assert (2-1-7) % P == -1 % P
    assert (2-1) % P == 1   # P(c)=Res(R1)/c.

    # In the pole-polynomial equation, the b-coefficient on C_j is
    # j(j-1)+(3s+1)j-4s^2=(j-s)^2 in characteristic five.
    coefficient_cases = 0
    for s in range(30):
        for j in range(s+1):
            assert (j*(j-1)+(3*s+1)*j-4*s*s-(j-s)**2) % P == 0
            assert ((j+1)*j+(j+1)-(j+1)**2) % P == 0
            coefficient_cases += 1

    phi = [[comb(r,j)**2 % P for j in range(r+1)] for r in range(5)]
    assert phi[3] == mul(power([1,-1],2),[1,1])
    assert phi[4] == power([1,-1],4)
    # Phi_2 has nonzero discriminant; only degrees <=2 could be squarefree.
    assert (phi[2][1]**2-4*phi[2][0]*phi[2][2]) % P == 2

    digest = sha256()
    dimensions = []
    cases = 0
    # The active pole set is a subset of mu_29, so degrees 0..29 cover
    # every possible size. This is only an independent algebra sanity check.
    for s in range(30):
        r = s % P
        for rho in range(1,P):
            rows = recurrence_matrix(s,1,-rho)
            basis = []
            for k in range((s-r)//P+1):
                vec = [0]*(s+1)
                for j in range(r+1):
                    vec[P*k+j] = phi[r][j]*pow(rho,j,P) % P
                assert not any(matrix_vector(rows,vec))
                basis.append(vec)
            nullity = s+1-rank(rows)
            assert rank(basis) == len(basis) == nullity
            digest.update(bytes([s,rho,nullity]))
            for vec in basis:
                digest.update(bytes(vec))
            cases += 1
            dimensions.append((s,rho,nullity))
        for a,b in [(1,0),(0,1)]:
            rows = recurrence_matrix(s,a,b)
            allowed = [j for j in range(s+1)
                       if (j % P == 0 if b == 0 else (j-s) % P == 0)]
            assert s+1-rank(rows) == len(allowed)
            for j in allowed:
                vec = [0]*(s+1)
                vec[j] = 1
                assert not any(matrix_vector(rows,vec))
            cases += 1
            digest.update(bytes([s,a,b,len(allowed)]))

    return {
        'scope': 'Supplementary exact algebra checks, NOT a search for maps and NOT a proof-assistant certificate.',
        'common_infinity': {'r_logarithmic_exponent':r_exponent,
                            'u_logarithmic_exponent':u_exponent,
                            'g0_linear_coefficient':g1,
                            'c_times_g0_quadratic_coefficient':g2_times_c},
        'transport_finite_part_coefficient':(2-1-7) % P,
        'coefficient_identity_cases':coefficient_cases,
        'phi_coefficients_ascending':phi,
        'phi3_factorization':'(1-u)^2(1+u)',
        'phi4_factorization':'(1-u)^4',
        'recurrence_degrees_checked':[0,29],
        'recurrence_parameter_cases':cases,
        'basis_and_nullity_checks':'passed',
        'enumeration_sha256':digest.hexdigest(),
        'arbitrary_geometric_parameters':'Handled by the symbolic proof in REPORT.md; not by this finite F5 check.'
    }

if __name__ == '__main__':
    print(json.dumps(verify(),indent=2))
