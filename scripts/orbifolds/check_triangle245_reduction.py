#!/usr/bin/env sage-python
"""Check all smooth open-chart triangle245 reductions at the prime five.

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
    ap.add_argument('directory', type=Path,help='Verified C3=1 chart with five exact factor files.')
    args = ap.parse_args()
    R = PolynomialRing(QQ, names=('a0', 'a1', 'a2', 'a3'))
    a0, a1, a2, a3 = R.gens()
    P = PolynomialRing(R, 'x'); x = P.gen()
    quartic=x**4/4+a3*x**3+a2*x**2+a1*x+a0
    universal=igusa_clebsch_invariants(x*quartic)
    assert universal[3]==a0**2*quartic.discriminant()/16
    assert all(c.denominator()%5 for p in universal for c in p.coefficients())
    S = PolynomialRing(GF(5), 't')
    reports = []
    files=sorted(args.directory.glob('factor_[0-9][0-9].json'))
    assert len(files)==5
    degrees=[]
    for file in files:
        data = json.loads(file.read_text())
        coefficients = [QQ(c) for c in data['polynomial']]
        degrees.append(len(coefficients)-1)
        lead = coefficients[-1]
        coefficients = [c/lead for c in coefficients]
        rows = [[QQ(c) for c in row] for row in data['source_quartic']]
        assert len(rows)==5 and rows[4]==[QQ(1)/4]
        integral = all(c.denominator()%5 for c in coefficients)
        integral = integral and all(c.denominator()%5 for row in rows for c in row)
        entry = {'file': file.name, 'integral_power_basis': bool(integral), 'residues': []}
        assert integral
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
            i10=ev(universal[3])
            record = {'residue_degree': int(factor.degree()), 'multiplicity': int(multiplicity),
                      'discriminant_unit': bool(i10)}
            assert i10
            if factor.degree()%3:
                record['backup_exclusion']='coefficient-field degree not divisible by3'
            else:
                j = ev(universal[1])**5/i10**2
                record['backup_polynomial_value_nonzero'] = bool(j**3+2*j**2+2*j+2)
                assert record['backup_polynomial_value_nonzero']
            entry['residues'].append(record)
        reports.append(entry)
        print(json.dumps(entry), flush=True)
    assert sorted(degrees)==[2,3,3,6,42]
    assert all(entry['residues'] for entry in reports)
    result = {'status':'PASS','all_open_models_excluded':True,
              'method':'smooth coefficient reductions; orbit-degree or direct invariant exclusion',
              'factors':reports}
    (args.directory/'independent_mod5_check.json').write_text(json.dumps(result, indent=2)+'\n')


if __name__ == '__main__':
    main()
