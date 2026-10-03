#!/usr/bin/env python3
"""Reconstruct five small field-separation determinants from the actual two-jets."""
import argparse
import json
from pathlib import Path

from sage.all import GF, PolynomialRing, matrix


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('output', type=Path)
    args = ap.parse_args()
    prime = GF(5)
    ring = PolynomialRing(prime, 'b')
    b = ring.gen()
    base = GF(25, 'b', modulus=b*b-b-3)
    b = base.gen()
    decode = lambda c: base(c % 5)+(c // 5)*b
    code = lambda c: int(base(c)[0])+5*int(base(c)[1])
    ring = PolynomialRing(base, 'a')
    modulus = ring([decode(c) for c in [5, 2, 6, 7, 1]])
    assert modulus.is_irreducible()
    field = base.extension(modulus, 'a')
    a = field.gen()
    roots = [a**(25**i) for i in range(4)]
    ring = PolynomialRing(field, 'x')
    curve = ring([decode(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
    marking = ring([decode(c) for c in [1,21,14,22,13]])
    derivative = marking.derivative()
    second = marking.derivative(2)
    branches = []
    for i, alpha in enumerate(roots):
        assert not marking(alpha) and derivative(alpha) and curve(alpha)
        leading = (3*derivative(alpha)**3*curve(alpha)**2/decode(13)**3)**pow(29,-1,5**8-1)
        slope = decode(13)*leading**4/derivative(alpha)
        next_slope = slope**2*(4*curve.derivative()(alpha)/curve(alpha)+second(alpha)/(2*derivative(alpha)))
        relative_rho = curve(roots[0])**((25**i-1)//3)
        residue = 2*derivative(alpha)/decode(13)*leading**(-10)*relative_rho**2
        branches.append((leading,slope,next_slope,relative_rho,residue))

    def expanded(mat):
        return matrix(base, [[mat[j,i].lift()[r] for i in range(4)]
                             for j in range(mat.nrows()) for r in range(4)])

    def data(mat):
        over_base = expanded(mat)
        return {'rank_over_E': int(mat.rank()),
                'rank_over_B_expanded': int(over_base.rank()),
                'matrix_over_B': [[code(c) for c in row] for row in over_base.rows()],
                'first_row_coefficient_determinant': code(over_base[:4,:].det())}

    record = {'scope': 'Five exact rootwise trace and residue determinants from the actual endpoint two-jets; no phase enumeration.',
              'characters': {}}
    expected = {1:(23,15), 2:(16,4)}
    for character in (1,2):
        weights0 = []
        weights1 = []
        linear = []
        for i, alpha in enumerate(roots):
            _, slope, next_slope, relative_rho, _ = branches[i]
            weights0.append(slope/relative_rho**character)
            weights1.append(slope**2/relative_rho**character)
            linear.append(2*next_slope/slope**2-field(character)*curve.derivative()(alpha)/(3*curve(alpha)))
        constant = matrix(field, [[roots[i]**j*weights0[i] for i in range(4)] for j in range(3)])
        first = matrix(field, [[(roots[i]**j*linear[i]+(j*roots[i]**(j-1) if j else 0))*weights1[i]
                               for i in range(4)] for j in range(3)])
        record['characters'][str(character)] = {'constant':data(constant), 'linear':data(first)}
        assert tuple(record['characters'][str(character)][name]['first_row_coefficient_determinant']
                     for name in ('constant','linear')) == expected[character]
    residues = matrix(base, [[branches[i][4].lift()[r] for i in range(4)] for r in range(4)])
    assert residues.det() == decode(12)
    record['residue_basis_matrix'] = [[code(c) for c in row] for row in residues.rows()]
    record['residue_basis_determinant'] = 12
    record['status'] = 'PASS'
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(record, indent=2)+'\n')
    print('PASS: trace determinants23,15,16,4; residue determinant12. No phase enumeration.')


if __name__ == '__main__':
    main()
