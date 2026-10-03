#!/usr/bin/env python3
"""Exact finite endpoint projection for the all-sector torsion numerator.

Only linear consequences are computed. A numerator is not an actual source.
All arithmetic uses the audited archive's exact finite-field implementation.
"""
import argparse
import json
import sys
from pathlib import Path

import numpy as np

ARCHIVE = Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0, str(ARCHIVE / 'src'))
from exact import Field, Poly, Curve, monomials, B0_CODES, L0_CODES
from cubic_extension import CubicExtension
from endpoint_jets import ENDPOINT_ROOTS


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--work', type=Path, required=True)
    a = ap.parse_args()
    k = Field(a.work / 'cache')
    p = Poly(k)
    C = Curve(k)
    fam = json.loads((a.work / 'data/adapted_family.json').read_text())
    t = fam['t']
    z = p.sub(B0_CODES, L0_CODES)

    def regularize(u, n):
        """Polynomial part of (Z/y)^n*u; remainder pole at O <=17."""
        numer = C.mul(C.polyx(p.power(z, n)), u)
        out = C.zero()
        for r, comp in enumerate(numer):
            quotient, output_r = divmod(r - n, 3)
            if quotient >= 0:
                out[output_r] = p.mul(comp, p.power(C.P, quotient))
            else:
                out[output_r] = p.divmod(comp, p.power(C.P, -quotient))[0]
        return out

    def numerator(a5, a4, rs):
        """Finite-frame coefficient list c0,...,c5; short frame T=w-Z/y."""
        c3 = C.add(regularize(a4, 1), rs[3])
        c2 = C.add(C.neg(C.add(C.scale(regularize(c3, 1), 3), regularize(a4, 2))), rs[2])
        c1 = C.add(C.neg(C.add(C.add(C.scale(regularize(c2, 1), 2), C.scale(regularize(c3, 2), 3)), C.scale(regularize(a4, 3), 4))), rs[1])
        c0 = C.add(C.neg(C.add(C.add(C.add(C.add(regularize(c1, 1), regularize(c2, 2)), regularize(c3, 3)), regularize(a4, 4)), regularize(a5, 5))), rs[0])
        return [c0, c1, c2, c3, a4, a5]

    def short_coeff_clear(cs, j):
        """y^(5-j)*[T^j] U_f(T+Z/y), an affine polynomial."""
        from math import comb
        out = C.zero()
        for h in range(j, 6):
            scalar = comb(h, j) % 5
            if not scalar:
                continue
            term = C.mul(C.polyx(p.power(z, h-j)), cs[h])
            term = C.mul(term, C.power(C.monomial(0, 1), 5-h))
            out = C.add(out, C.scale(term, scalar))
        return out

    def rows(cs):
        out = []
        for j in range(3):
            modulus = p.power(t, 3-j)
            u = short_coeff_clear(cs, j)
            for comp in u:
                rem = p.mod(comp, modulus)
                out.extend(rem + [0]*(len(modulus)-1-len(rem)))
        assert len(out) == 54
        return out

    rlabels = [(j, b, r) for j in range(4) for b, r in monomials(25-j)]
    assert len(rlabels) == 62
    rcolumns = []
    for j,b,r in rlabels:
        rs = [C.zero() for _ in range(4)]
        rs[j] = C.monomial(b,r)
        rcolumns.append(rows(numerator(C.zero(), C.zero(), rs)))
    matrix = np.array(rcolumns, dtype=np.uint32).T
    rr, piv = k.rref(matrix)
    ker, _, _ = k.kernel(matrix)
    assert not np.any(k.matmul(matrix, ker.T))
    _, leftpiv = k.rref(matrix.T)
    cokernel, _, _ = k.kernel(matrix.T)
    assert not np.any(k.matmul(cokernel, matrix))
    assert len(cokernel) == 1
    functional = cokernel[0]
    zero_rs = [C.zero() for _ in range(4)]
    def obstruction(a5,a4):
        vector = np.array(rows(numerator(a5,a4,zero_rs)),dtype=np.uint32)
        return int(k.matmul(functional[None,:],vector[:,None])[0,0])
    vbasis = [C.monomial(b,r) for b,r in monomials(10)]
    # Exact first-moment coordinates from P01, p0=[12]p1+p2+[24]p3+[3]p4.
    s4basis = [C.add(C.const(c),C.monomial(j,0)) for j,c in enumerate([12,1,24,3],1)] + [C.monomial(0,1)]
    mu4basis = [C.monomial(j,0) for j in range(3)]
    relation = {
        'm4_times_v': [[obstruction(C.mul(v,m),C.zero()) for v in vbasis] for m in mu4basis],
        'm4_times_s4': [[obstruction(C.zero(),C.mul(s,m)) for s in s4basis] for m in mu4basis],
        'm5_times_v': [[obstruction(C.zero(),C.mul(v,m)) for v in vbasis] for m in vbasis],
        'v_and_m5_order': ['1','x','x^2','x^3','y'],
        'm4_order': ['1','x','x^2'],
        's4_order': ['p1','p2','p3','p4','py'],
    }
    hv = np.array(relation['m5_times_v'],dtype=np.uint32)
    hs = np.array(relation['m4_times_s4'],dtype=np.uint32)
    assert len(k.rref(hv)[1]) == 4
    assert len(k.rref(hs)[1]) == 3
    assert len(k.rref(hs[:,:3])[1]) == 3
    svker,_,_ = k.kernel(hs)
    vker,_,_ = k.kernel(hv)
    assert len(vker) == 1 and vker[0].tolist() == [0,0,0,0,1]
    relation['exceptional_s4_kernel'] = svker.tolist()
    relation['v_functional_rank'] = 4
    relation['s4_functional_rank'] = 3
    # Evaluate the same global jet incidence on its nine geometric endpoints.
    # All P(endpoint)/6 are cubes in K, so one common extension rho^3=6 suffices.
    e = CubicExtension(k)
    assert k.power(6,130208) != 1
    rho = e.Q
    assert e.power(rho,3) == 6
    zeta = k.power(25,130208)
    assert zeta != 1 and k.power(zeta,3) == 1
    endpoint_rows = []
    for root in ENDPOINT_ROOTS:
        value = p.eval(C.P,root)
        ratio = k.div(value,6)
        assert int(k.log[ratio]) % 3 == 0
        cube = int(k.exp[int(k.log[ratio])//3])
        assert k.power(cube,3) == ratio
        def shift(poly,cut):
            result = []
            for scalar in reversed(poly):
                result = p.add(p.mul(result,[root,1]),[scalar])[:cut]
            return result+[0]*(cut-len(result))
        rhs = p.scale(shift(C.P,3),k.inv(value))
        h = [1]
        for n in range(1,3):
            h.append(k.div(k.sub(rhs[n],p.power(h,3)[n] if n < len(p.power(h,3)) else 0),3))
        assert p.power(h,3)[:3] == p.trim(rhs)
        for sheet in range(3):
            y0 = e.mul(rho,k.mul(cube,k.power(zeta,sheet)))
            block = np.zeros((6,62),dtype=np.uint64)
            offset = 0
            for j in range(3):
                count = 3-j
                component_start = sum(3*(9-3*q) for q in range(j))
                component_size = 9-3*j
                for col in range(62):
                    series = [0]*count
                    for char in range(3):
                        poly = matrix[component_start+char*component_size:component_start+(char+1)*component_size,col].tolist()
                        coeffs = p.mul(shift(poly,count),p.power(h,char))[:count]
                        for n,scalar in enumerate(coeffs):
                            series[n] = e.add(series[n],e.mul(e.power(y0,char),scalar))
                    block[offset:offset+count,col] = series
                offset += count
            endpoint_rows.append(block)
    geometric_matrix = np.vstack(endpoint_rows)
    assert len(e.rref(geometric_matrix)[1]) == len(piv)
    omitted_ranks = []
    for i in range(9):
        remaining = np.vstack(endpoint_rows[:i]+endpoint_rows[i+1:])
        rank = len(e.rref(remaining)[1])
        omitted_ranks.append(rank)
    result = {
        'scope': 'linear necessary numerator incidence; no source or emptiness assertion',
        'all_unconcentrated_endpoint_rows': 54,
        'free_lower_numerator_coordinates': 62,
        'rank': len(piv),
        'kernel_dimension': len(ker),
        'cokernel_dimension': len(cokernel),
        'rlabels': rlabels,
        'pivots': piv,
        'row_pivots': leftpiv,
        'matrix': matrix.tolist(),
        'kernel': ker.tolist(),
        'cokernel': cokernel.tolist(),
        'necessary_bilinear_relation': relation,
        'single_omitted_endpoint_ranks': omitted_ranks,
    }
    (a.work/'data/annihilator_endpoint_projection.json').write_text(json.dumps(result,separators=(',',':'))+'\n')
    print(json.dumps({key: result[key] for key in ('scope','all_unconcentrated_endpoint_rows','free_lower_numerator_coordinates','rank','kernel_dimension','cokernel_dimension')}, indent=2))
    print(json.dumps(relation, indent=2))
    print(json.dumps({'single_omitted_endpoint_ranks':omitted_ranks}))


if __name__ == '__main__':
    main()
