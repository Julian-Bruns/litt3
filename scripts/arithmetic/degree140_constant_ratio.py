#!/usr/bin/env python3
"""Exact continuation on an entire constant-v ratio fiber, all H and scales.

This is NOT a global nonzero-pivot certificate. It reuses the returned exact
residual engine, retaining every parameter on the chosen q-fiber. Output and
compiled arithmetic are placed outside the research repository.
"""
import argparse
from fractions import Fraction
import json
import math
import os
from pathlib import Path
import subprocess
import sys
import numpy as np


def assignment(weights):
    """Integer Hungarian dual: u_i+v_j<=a_ij, equality on matching."""
    a = weights.tolist()
    n = len(a)
    u, v, p, way = ([0]*(n+1) for _ in range(4))
    for i in range(1, n+1):
        p[0] = i
        j0 = 0
        dist, used = [10**12]*(n+1), [False]*(n+1)
        while True:
            used[j0] = True
            i0 = p[j0]
            delta, j1 = 10**12, 0
            for j in range(1, n+1):
                if not used[j]:
                    cur = a[i0-1][j-1]-u[i0]-v[j]
                    if cur < dist[j]:
                        dist[j], way[j] = cur, j0
                    if dist[j] < delta:
                        delta, j1 = dist[j], j
            for j in range(n+1):
                if used[j]:
                    u[p[j]] += delta
                    v[j] -= delta
                else:
                    dist[j] -= delta
            j0 = j1
            if not p[j0]:
                break
        while j0:
            j1 = way[j0]
            p[j0] = p[j1]
            j0 = j1
    match = [0]*n
    for j in range(1, n+1):
        match[p[j]-1] = j-1
    assert all(u[i+1]+v[j+1] <= a[i][j] for i in range(n) for j in range(n))
    assert all(u[i+1]+v[match[i]+1] == a[i][match[i]] < 10**8 for i in range(n))
    return u[1:], v[1:], match


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('package', type=Path)
    ap.add_argument('output', type=Path)
    ap.add_argument('--q', type=int, default=1)
    args = ap.parse_args()
    root, out = args.package.resolve(), args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    sys.path[:0] = [str(root/'src'), str(root/'prior/src')]
    import exact as E
    from atlas import fixed_data
    from cube_chart import evaluate as cube_evaluate
    from fast import Fast
    from interpolation import interp_vec
    from verify_support import (at_tensor, coefficient_polys, load, readpoly,
                                specialize_sparse, write_resultant_input,
                                check_dual_bounds)
    cxx = os.environ.get('CXX', '/opt/homebrew/opt/llvm/bin/clang++')
    table = out/'field.bin'
    if not table.exists():
        subprocess.run([cxx, '-O3', '-std=c++17', str(root/'prior/src/field_tables.cpp'), '-o', str(out/'field_tables')], check=True)
        subprocess.run([str(out/'field_tables'), str(table)], check=True)
    for name in ['fast_exact', 'interpolate_fast_resultants', 'bezout_fast', 'boundary_candidates', 'verify_coefficients']:
        target = out/(name+'.so' if name == 'fast_exact' else name)
        if not target.exists():
            extra = ['-shared', '-fPIC'] if name == 'fast_exact' else []
            subprocess.run([cxx, '-O3', '-std=c++17', *extra, str(root/f'src/{name}.cpp'), '-o', str(target)], check=True)
    E.init(table)
    fast = Fast(out/'fast_exact.so', table)
    P, A, Q, B, L, t, Ct = fixed_data()
    cube = load(root/'prior/data/cube_constant.json')
    q = args.q
    assert q
    psi = specialize_sparse(cube['Psi'], q)
    assert len(psi) == 2 and psi[0]
    psi_monic = E.scale(psi, E.F.I(int(psi[-1])))
    if q == 1:
        tensor = np.load(root/'data/constant_q1_residual.npy')
    else:
        points = np.arange(37, dtype=np.int32)
        vals = np.stack([fast.residual(cube_evaluate(cube, int(h), q), None,
                                      E.scale(P, E.F.I(q)), E.scale(t, q)) for h in points])
        tensor = interp_vec(points, vals)
    assert tensor.shape == (37, 7, 141)
    # Full coefficient reconstruction, including H=0; no point search.
    for h in range(37):
        expected = fast.residual(cube_evaluate(cube, h, q), None,
                                 E.scale(P, E.F.I(q)), E.scale(t, q))
        assert np.array_equal(at_tensor(tensor, h), expected)
    np.save(out/'residual.npy', tensor)
    assert not np.any(tensor[:, 1:, 140])
    lead = E.mul(E.poly([0]*9+[1]), E.power(psi, 3))
    lc = E.poly(tensor[:, 0, 140])
    factor = E.F.M(int(lc[-1]), E.F.I(int(lead[-1])))
    assert np.array_equal(lc, E.scale(lead, factor))
    inds = np.argwhere(tensor)
    assert all(4*int(mu) <= 3*(140-int(x)) for h, mu, x in inds)
    low = min(Fraction(int(h)-9, 140-int(x)) for h, mu, x in inds if x != 140)
    high = max(Fraction(int(h)-(len(lc)-1), 140-int(x)) for h, mu, x in inds if x != 140)
    shift = math.ceil(-74*low)
    powerpsi = 189  # sqrt(B)=B^63 mod T^125, lc contains psi^3.
    bound = math.ceil(shift+powerpsi+74*high)
    print('Complete tensor bounds:', low, high, 'clearing degree', bound, flush=True)
    points = np.array([h for h in range(1, 390625) if E.evaluate(psi, h)][:bound+1], np.int32)
    vals = []
    for h in points:
        h = int(h)
        fac = E.F.M(E.F.P(h, shift), E.F.P(int(E.evaluate(psi, h)), powerpsi))
        vals.append(E.F.mul(fast.formal74(at_tensor(tensor, h)), fac))
    coeffs = interp_vec(points, np.stack(vals))
    errors, raw_errors = [], []
    for i, index in enumerate(range(71, 75)):
        coeff = coeffs[:, i, :]
        raw_terms = [[int(h), int(m), int(coeff[h, m])] for h, m in np.argwhere(coeff)]
        raw_errors.append(dict(index=index, removed=0, degree_H=max(z[0] for z in raw_terms),
                               degree_mu=max(z[1] for z in raw_terms), terms=raw_terms))
        polys = [E.poly(coeff[:, m]) for m in range(max(z[1] for z in raw_terms)+1)]
        nonzero = [p for p in polys if len(p)]
        hrem = min(int(np.flatnonzero(p)[0]) for p in nonzero)
        prem = min(fast.valuation(p, psi_monic) for p in nonzero)
        divisor = E.mul(E.poly([0]*hrem+[1]), E.power(psi_monic, prem))
        reduced = []
        for p in polys:
            if not len(p):
                reduced.append(p)
            else:
                qq, rr = fast.divrem(p, divisor)
                assert not len(rr)
                reduced.append(qq)
        terms = [[h, m, int(c)] for m, p in enumerate(reduced) for h, c in enumerate(p) if c]
        row = dict(index=index, degree_H=max(z[0] for z in terms), degree_mu=max(z[1] for z in terms),
                   H_removed=hrem, psi_removed=prem, terms=terms)
        errors.append(row)
        print('Formal coefficient', index, 'degrees', row['degree_H'], row['degree_mu'],
              'removed allowed units', hrem, prem, flush=True)
    record = dict(q=q, Psi=psi.tolist(), clearing_H=shift, clearing_psi=powerpsi,
                  clearing_degree_bound=bound, H0_slope=str(low), Hinf_slope=str(high), errors=errors)
    (out/'coefficients.json').write_text(json.dumps(record)+'\n')
    # Independent delivered coefficient verifier, on the unstripped polynomials.
    import struct
    raw = out/'tensor.bin'
    with raw.open('wb') as f:
        f.write(struct.pack('=i', len(tensor)))
        f.write(np.ascontiguousarray(tensor, dtype=np.int32).tobytes())
    inp = out/'coefficients.input'
    with inp.open('w') as f:
        f.write(f'1 {bound} {shift} {powerpsi} {len(psi)} '+ ' '.join(map(str, psi))+'\n4\n')
        for e in raw_errors:
            f.write(f'{e["index"]} 0 {len(e["terms"])} {e["degree_H"]} {e["degree_mu"]}\n')
            for row in e['terms']:
                f.write(' '.join(map(str, row))+'\n')
    subprocess.run([str(out/'verify_coefficients'), str(table), str(raw), str(inp)], check=True)
    for j in [1, 3]:
        f, g = errors[0], errors[j]
        m, n = f['degree_mu'], g['degree_mu']
        arrays = [coefficient_polys(f)[::-1], coefficient_polys(g)[::-1]]
        bounds = []
        for kind in ['H', 'degree', 'psi']:
            mat = np.full((m+n, m+n), 10**8, np.int64)
            for group, rows, offset in [(arrays[0], n, 0), (arrays[1], m, n)]:
                weights = []
                for p in group:
                    if not len(p): value = 10**8
                    elif kind == 'H': value = int(np.flatnonzero(p)[0])
                    elif kind == 'degree': value = -(len(p)-1)
                    else: value = fast.valuation(p, psi_monic)
                    weights.append(value)
                for i in range(rows):
                    mat[offset+i, i:i+len(weights)] = weights
            u, v, matching = assignment(mat)
            sign = -1 if kind == 'degree' else 1
            b = dict(sign=sign, bound=sign*(sum(u)+sum(v)), row_duals=u, column_duals=v, matching=matching)
            if kind == 'psi': b['factor'] = psi_monic.tolist()
            bounds.append(b)
        degree = bounds[1]['bound']-bounds[0]['bound']-bounds[2]['bound']
        cert = dict(fixed_degrees=[m,n], bounds=bounds, interpolation_point_count=degree+1)
        lo, hi, factors, checked_degree = check_dual_bounds(cert, f, g, fast)
        assert checked_degree == degree
        stem = out/f'G71_{71+j}'
        Path(str(stem)+'.bounds.json').write_text(json.dumps(cert)+'\n')
        source = Path(str(stem)+'.input')
        write_resultant_input(source, f, g, lo, hi, factors)
        subprocess.run([str(out/'interpolate_fast_resultants'), str(table), str(source), str(stem), 'compute'], check=True)
    subprocess.run([str(out/'bezout_fast'), str(table), str(out/'G71_72.poly'), str(out/'G71_74.poly'), str(out/'bezout')], check=True)
    gcd = readpoly(out/'bezout.gcd')
    result = dict(status='partial', q=q, resultant_gcd_degree=len(gcd)-1,
                  scope='One entire constant-v q-fiber, not the global chart')
    if len(gcd) == 1:
        result['status'] = 'excluded_all_geometric_H_mu'
    else:
        cin = out/'candidates.input'
        with cin.open('w') as f:
            f.write('4\n')
            for e in errors:
                polys = coefficient_polys(e)
                f.write(str(len(polys))+'\n')
                for p in polys:
                    f.write(str(len(p))+' '+' '.join(map(str,p))+'\n')
        subprocess.run([str(out/'boundary_candidates'), str(table), str(out/'bezout.gcd'), str(cin), str(out/'candidates')], check=True)
        result['candidate_parts'] = [str(p) for p in out.glob('candidates.part*')]
        result['status'] = 'candidate_certificates_require_review'
    (out/'result.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result), flush=True)


if __name__ == '__main__':
    main()
