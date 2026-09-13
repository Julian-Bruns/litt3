#!/usr/bin/env python3
"""Replay complete carrier coverage and independent integral factor divisions.

This checks the finite manifest, source linkage, and every exclusion. It
does not replace the geometric carrier/unit-root theorems or matrix replay.
Missing, failed, unsupported, or still-passing cases remain explicitly open.
"""
import argparse
import gzip
import hashlib
import json
import time
from collections import Counter
from pathlib import Path


def load(path):
    raw = path.read_bytes()
    return json.loads(gzip.decompress(raw) if path.suffix == '.gz' else raw)


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def eval_poly(coefficients, x, modulus):
    return sum(c * pow(x, i, modulus) for i, c in enumerate(coefficients)) % modulus


def convolution(a, b, modulus):
    return [sum(a[i] * b[j] for i in range(len(a)) for j in range(len(b))
                if i+j == k) % modulus for k in range(len(a)+len(b)-1)]


def long_remainder(a, b, modulus):
    out = [c % modulus for c in a]
    assert b[-1] % modulus == 1
    for j in range(len(out)-1, len(b)-2, -1):
        lead = out[j]
        for i, c in enumerate(b):
            out[j-len(b)+1+i] = (out[j-len(b)+1+i]-lead*c) % modulus
    out = out[:len(b)-1]
    while out and out[-1] == 0:
        out.pop()
    return out


PHI = {1: [-1, 1], 2: [1, 1], 3: [1, 1, 1], 4: [1, 0, 1],
       5: [1, 1, 1, 1, 1], 6: [1, -1, 1], 8: [1, 0, 0, 0, 1],
       10: [1, -1, 1, -1, 1], 12: [1, 0, -1, 0, 1]}
WEIL = [15625, -1000, 182, -8, 1]


def all_filters(digits):
    """Find root digits by exhaustive five-way lifting, not Newton's formula."""
    roots = [1, 2]
    modulus = 5
    for _ in range(1, digits):
        choices = [[r+modulus*j for j in range(5)
                    if eval_poly(WEIL, r+modulus*j, 5*modulus) == 0] for r in roots]
        assert all(len(c) == 1 for c in choices)
        roots = [c[0] for c in choices]
        modulus *= 5
    units = [pow(r, 114, modulus) for r in roots]
    out = []
    for n, polynomial in PHI.items():
        degree = len(polynomial)-1
        factors = [[c*pow(v, degree-j, modulus) % modulus
                    for j, c in enumerate(polynomial)] for v in units]
        out.append((n, convolution(*factors, modulus)))
    return out


def test(coefficients, digits):
    modulus = 5**digits
    assert len(coefficients) == 9 and coefficients[-1] == 1 and coefficients[0] % 5
    tests = [dict(order=n, polynomial=f,
                  remainder=long_remainder(coefficients, f, modulus))
             for n, f in all_filters(digits)]
    return dict(digits=digits, coefficients=coefficients, tests=tests,
                passing_orders=[t['order'] for t in tests if not t['remainder']])


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('data_root', type=Path)
    p.add_argument('output', type=Path)
    args = p.parse_args()
    started = time.monotonic()
    root = args.data_root
    labels_path = root/'degree2-carrier-labels-20260911.json'
    labels = load(labels_path)
    seeds = labels['seeds']
    assert len(seeds) == 1533 and len(set(seeds)) == 1533
    assert labels['covered_nonzero_double_labels'] == 262143
    assert labels['independent_partition_replay'] == 'PASS'
    torsion_path = root/'degree2-frobenius-torsion-342-20260911/torsion.json'
    torsion = load(torsion_path)
    assert torsion['nonzero'] and torsion['doubling_zero'] and torsion['field_degree'] == 342
    source_dirs = sorted(root.glob('degree2-prym-sieve-full-*-20260911'))
    entries = {}
    for directory in source_dirs:
        selected = load(directory/'selection.json')
        assert selected['labels_sha256'] == digest(labels_path)
        assert Path(selected['torsion_source']).resolve() == torsion_path.resolve()
        for i, seed in zip(selected['indices'], selected['seeds']):
            assert i not in entries and seed == seeds[i]
            path = directory/('carrier_%04d' % i)/'result.json'
            entries[i] = dict(index=i, seed=seed, first_path=path)
    assert sorted(entries) == list(range(1533))
    results = []
    for i, entry in sorted(entries.items()):
        path = entry.pop('first_path')
        entry.update(status='open', evidence=[], tests=[])
        def retain(file):
            assert file.is_file(), str(file)
            entry['evidence'].append(dict(path=str(file.resolve()), sha256=digest(file)))
        if not path.exists():
            entry['reason'] = 'first pass missing'
            results.append(entry)
            continue
        first = load(path)
        assert first['seed'] == seeds[i] and first['cartier_rank'] == 8
        retain(path)
        retain(path.parent/'torsion_matrix.json.gz')
        retain(path.parent/'cartier_witness.json.gz')
        ftest = test(first['coefficients'], 1)
        entry['tests'].append(ftest)
        # The original coarse test groups several of these exact filters.
        if first['sieve']['geometric_backup_factor_excluded']:
            assert not ftest['passing_orders']
            entry.update(status='excluded', exclusion_digits=1)
            results.append(entry)
            continue
        high = root/'degree2-prym-higher-stage-20260911'/('carrier_%04d' % i)
        if not (high/'result.json').exists():
            entry['reason'] = 'higher pass missing'
            results.append(entry)
            continue
        high_record = load(high/'result.json')
        retain(high/'result.json')
        assert Path(high_record['source']).resolve() == path.resolve()
        if high_record['status'] not in ('excluded', 'needs_more_precision'):
            entry['reason'] = high_record
            results.append(entry)
            continue
        model_path = high/'toric/model.json.gz'
        model = load(model_path)
        assert Path(model['matrix_source']).resolve() == (path.parent/'torsion_matrix.json.gz').resolve()
        assert Path(model['field_source']).resolve() == torsion_path.resolve()
        assert model['modulus'] == torsion['modulus']
        assert model['exact_birational_substitution'] and model['diagnostics']['all_edges_transverse']
        assert model['diagnostics']['interior_count'] == 8
        for file in [model_path, high/'toric/norm.json.gz', high/'unitroots/result.json',
                     high/'unitroots/matrices.json.gz', high/'unitroots/kummer_twist.json']:
            retain(file)
        previous_path = high/'unitroots/result.json'
        previous = load(previous_path)
        assert previous['status'] == 'complete' and previous['digits'] == 2
        assert previous['model_sha256'] == digest(model_path) and previous['field_degree'] == 342
        sign = previous['verified_quadratic_twist']
        twist = load(high/'unitroots/kummer_twist.json')
        assert twist['verified'] and twist['sign'] == sign and sign in (-1, 1)
        assert [c % 5 for c in previous['coefficients']] == [c*sign**j % 5 for j, c in enumerate(first['coefficients'])]
        htest = test(previous['coefficients'], 2)
        assert high_record['passing_orders'] == htest['passing_orders']
        entry['tests'].append(htest)
        if not htest['passing_orders']:
            entry.update(status='excluded', exclusion_digits=2)
            results.append(entry)
            continue
        final = root/'degree2-prym-final-stage-20260911'/('carrier_%04d' % i)/'result.json'
        if not final.exists():
            entry['reason'] = 'final pass missing'
            results.append(entry)
            continue
        frecord = load(final)
        retain(final)
        assert Path(frecord['source']).resolve() == (high/'result.json').resolve()
        for stage in frecord['stages']:
            unit_path = Path(stage['unit_result'])
            unit = load(unit_path)
            assert unit['status'] == 'complete' and unit['digits'] == previous['digits']+1
            assert unit['field_degree'] == 342 and unit['model_sha256'] == digest(model_path)
            assert unit['verified_quadratic_twist'] == sign
            assert [c % (5**previous['digits']) for c in unit['coefficients']] == previous['coefficients']
            retain(unit_path)
            retain(unit_path.parent/'matrices.json.gz')
            utest = test(unit['coefficients'], unit['digits'])
            assert stage['passing_orders'] == utest['passing_orders']
            entry['tests'].append(utest)
            previous = unit
        if entry['tests'][-1]['passing_orders']:
            entry['reason'] = 'all available precisions still pass'
        else:
            assert frecord['status'] == 'excluded'
            entry.update(status='excluded', exclusion_digits=entry['tests'][-1]['digits'])
        results.append(entry)
    missing = [r['index'] for r in results if r['status'] != 'excluded']
    summary = dict(status='coverage_and_division_PASS' if not missing else 'incomplete',
                   carrier_count=len(results), excluded=len(results)-len(missing), open_indices=missing,
                   excluded_by_digits=dict(sorted(Counter(r['exclusion_digits'] for r in results
                                                          if r['status'] == 'excluded').items())),
                   labels_sha256=digest(labels_path), torsion_sha256=digest(torsion_path),
                   seconds=time.monotonic()-started,
                   scope='Complete label coverage, source hashes and independent integral factor divisions; geometric theorems and matrix replay are separate')
    args.output.write_text(json.dumps(dict(summary=summary, carriers=results), separators=(',', ':'))+'\n')
    print(json.dumps(summary), flush=True)


if __name__ == '__main__':
    main()
