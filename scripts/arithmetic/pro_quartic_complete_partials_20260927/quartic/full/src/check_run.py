#!/usr/bin/env python3
"""Validate a complete regenerated scan against the retained exact evidence.
Timing and implementation-startup records are not mathematical counters.
"""
from pathlib import Path
import argparse
import gzip
import json

ROOT = Path(__file__).resolve().parents[2]
KEYS = ['pairs', 'first_projection_zero', 'Z_zero', 'norm_boundary',
        'generic_Z_zero', 'T_zero', 'eq3_zero', 'eq4_zero']

def records(path):
    opener = gzip.open if str(path).endswith('.gz') else open
    with opener(path, 'rt') as handle:
        return [json.loads(line) for line in handle if line.strip()]

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('kind', choices=['generic', 'boundary'])
    parser.add_argument('summary', type=Path)
    parser.add_argument('candidates', type=Path)
    parser.add_argument('--projection', type=int, default=1, choices=range(14))
    args = parser.parse_args()
    log, candidates = records(args.summary), records(args.candidates)
    if args.kind == 'generic':
        assert log[-1]['kind'] == 'completed'
        assert (log[-1]['start'], log[-1]['stop']) == (0, 9776)
        rows = sorted((r for r in log if r.get('kind') == 'full_scan_h_summary'),
                      key=lambda r: r['h_index'])
        expected = records(ROOT/'full/evidence/scan_rows.jsonl.gz')
        assert len(rows) == len(expected) == 9776
        for actual, target in zip(rows, expected):
            assert actual['h_index'] == target['h_index']
            assert actual['pairs'] == 812*(actual['h_index']+1)
            for key in KEYS:
                if key != 'first_projection_zero' or args.projection == 1:
                    assert actual[key] == target[key], (actual['h_index'], key)
        target = records(ROOT/'full/evidence/generic_survivors.jsonl')
        key = lambda r: (r['h_index'], r['q_index'], r['orbit'])
        assert sorted(candidates, key=key) == sorted(target, key=key)
        counters = {key: sum(row[key] for row in rows) for key in KEYS}
    else:
        actual = log[-1]
        expected = json.loads((ROOT/'full/evidence/boundary_summary.json').read_text())
        assert actual['kind'] == 'summary'
        assert (actual['start'], actual['stop']) == (0, 9776)
        for key, value in expected.items():
            if key != 'seconds':
                assert actual[key] == value, key
        target = records(ROOT/'full/evidence/boundary_survivors.jsonl')
        key = lambda r: (r['q_index'], r['H'])
        assert sorted(candidates, key=key) == sorted(target, key=key)
        counters = {key: value for key, value in actual.items() if key != 'seconds'}
    print(json.dumps({'status': 'PASS', 'scope': 'COMPLETE', 'kind': args.kind,
                      'exact_survivor_match': True, 'survivors': len(candidates),
                      'counters': counters}, indent=2, sort_keys=True))

if __name__ == '__main__':
    main()
