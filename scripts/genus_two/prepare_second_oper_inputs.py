#!/usr/bin/env python3
"""Repack the established actual quintics for a second-ancestry question.

This checks only the new packing and supplied base-point identities. It
does not recompute the Frobenius model or solve the requested new fiber.
The finite-field helper is the preserved returned arithmetic certificate.
"""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--quintics', type=Path, required=True)
    ap.add_argument('--field-helper', type=Path, required=True)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    root = Path(__file__).resolve().parents[2]
    if args.output.resolve().is_relative_to(root):
        raise ValueError('Generated data belongs outside the research tree.')
    spec = importlib.util.spec_from_file_location('exact_field', args.field_helper)
    ff = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(ff)
    original = json.loads(args.quintics.read_text())
    psi = [63, 81, 75, 53, 6, 1]
    points = [[55, 82, 104, 115, 87], [67, 74, 82, 45, 60],
              [19, 60, 68, 13, 18], [1]]
    exponents = [(5-r-t-u, u, t, r) for r in range(6)
                 for t in range(6-r) for u in range(6-r-t)]
    assert len(exponents) == 56 and len(set(exponents)) == 56
    rows, grouped = [], []
    for j, entries in enumerate(original['absolute_quintics_before_fifth_power']):
        sparse = {tuple(e): c for e, c in entries}
        assert len(sparse) == len(entries)
        assert all(sum(e) == 5 and 0 <= c < 125 for e, c in entries)
        row = [sparse.get(e, 0) for e in exponents]
        assert {e: c for e, c in zip(exponents, row) if c} == sparse
        result = []
        for e, c in zip(exponents, row):
            term = [c]
            for point, power in zip(points, e):
                term = ff.pdivmod(ff.pmul(term, ff.ppowmod(point, power, psi)), psi)[1]
            result = ff.padd(result, term)
        assert ff.pdivmod(result, psi)[1] == [], (j, result)
        rows.append(row)
        for r in range(6):
            grouped.append({'j': j, 'r': r,
                            'codes': [c for e, c in zip(exponents, row) if e[3] == r]})
    out = dict(
        field='F5[alpha]/(alpha^3+alpha+1)',
        field_code='a0+5*a1+25*a2 represents a0+a1*alpha+a2*alpha^2',
        map_convention='Absolute normalized Frobenius is z -> (Q_j(z)^5)_j.',
        exponent_order=exponents, quintic_rows=rows, grouped_rows=grouped,
        psi=psi, bol_point_polynomials=points,
        checks={'repacking_exact': True, 'all_five_actual_base_points': True},
        source_sha256=hashlib.sha256(args.quintics.read_bytes()).hexdigest(),
        helper_sha256=hashlib.sha256(args.field_helper.read_bytes()).hexdigest(),
        script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest())
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(out, indent=2)+'\n')
    print('PASS: all 224 coefficients repacked exactly; Q_j(z(T))=0 mod psi.')
    print('This is an input check, not a second-ancestry result.')


if __name__ == '__main__':
    main()
