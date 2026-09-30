#!/usr/bin/env sage-python
"""Independently check the saved invariant exclusions at the prime five.

Uses reduction of the reconstructed quartic itself in every residue factor,
when its coefficients are integral and its discriminant is a unit. This
does not assume that reduction of the defining number-field polynomial is
square-free. The exact characteristic-zero verification is separate.
"""
from sage.all import QQ, GF, PolynomialRing
from sage.schemes.hyperelliptic_curves.invariants import igusa_clebsch_invariants
from pathlib import Path
import argparse
import json


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('directory', type=Path)
    args = ap.parse_args()
    R = PolynomialRing(QQ, names=('a0', 'a1', 'a2', 'a3'))
    a0, a1, a2, a3 = R.gens()
    P = PolynomialRing(R, 'x'); x = P.gen()
    universal = igusa_clebsch_invariants(x*(x**4/4+a3*x**3+a2*x**2+a1*x+a0))
    S = PolynomialRing(GF(5), 't'); t = S.gen()
    target = t**3+2*t**2+2*t+2
    reports = []
    for file in sorted(args.directory.glob('factor_[0-9][0-9].json')):
        data = json.loads(file.read_text())
        coefficients = [QQ(c) for c in data['polynomial']]
        lead = coefficients[-1]
        coefficients = [c/lead for c in coefficients]
        rows = [[QQ(c) for c in row] for row in data['source_quartic']]
        integral = all(c.denominator()%5 for c in coefficients)
        integral = integral and all(c.denominator()%5 for row in rows for c in row)
        entry = {'file': file.name, 'integral_power_basis': bool(integral), 'residues': []}
        if integral:
            f = S(coefficients)
            for factor, multiplicity in f.factor():
                K = GF(5**factor.degree(), name='theta', modulus=factor) if factor.degree()>1 else GF(5)
                theta = K.gen() if factor.degree()>1 else -factor[0]/factor[1]
                values = [sum(K(c)*theta**i for i,c in enumerate(row)) for row in rows]
                def ev(poly):
                    value = K.zero()
                    for powers, coefficient in poly.dict().items():
                        term = K(coefficient)
                        for a, exponent in zip(values, powers):
                            term *= a**exponent
                        value += term
                    return value
                i2, i4, i6, i10 = [ev(p) for p in universal]
                record = {'residue_degree': int(factor.degree()), 'multiplicity': int(multiplicity),
                          'discriminant_unit': bool(i10)}
                if i10:
                    j = i4**5/i10**2
                    record['backup_polynomial_value_nonzero'] = bool(j**3+2*j**2+2*j+2)
                    assert record['backup_polynomial_value_nonzero']
                entry['residues'].append(record)
        reports.append(entry)
        print(json.dumps(entry), flush=True)
    result = {'method': 'direct mod-five evaluation in every power-basis residue field', 'factors': reports}
    (args.directory/'independent_mod5_check.json').write_text(json.dumps(result, indent=2)+'\n')


if __name__ == '__main__':
    main()
