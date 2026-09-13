"""Write the exact oper census as orbit ranges; expand individual indices on demand."""
import argparse
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
FOLDER = ROOT / 'Research/computations'


def description(folder=FOLDER):
    factors = json.loads((folder / 'normalized_oper_closed_points.json').read_text())['factors']
    invariant = json.loads((folder / 'invariant_oper_solutions.json').read_text())
    assert len(invariant['solutions']) == 55
    assert all(f['multiplicity'] == 1 and f['degree_F5'] == 2 * f['degree_F25'] for f in factors)
    orbits = [{'id': f['id'], 'degree_F25': f['degree_F25'], 'multiplicity': 1} for f in factors]
    assert len(orbits) == 12 and len({f['id'] for f in orbits}) == 12
    assert sum(f['degree_F25'] for f in orbits) == 9645
    return {
        'schema_version': 2,
        'status': 'complete_exact_algebraic_index_ranges; multiplicities retained',
        'distinct_points': 28990, 'total_multiplicity': 29375,
        'normalized_closed_points': 'normalized_oper_closed_points.json',
        'coordinate_polynomials': 'normalized_oper_algebra_certificate.json',
        'invariant_points': 'invariant_oper_solutions.json',
        'formula_conventions': 'complete_oper_solutions_README.md',
        'invariant_count': 55, 'invariant_multiplicity': 8, 'cubic_branches': 3,
        'normalized_orbits': orbits,
    }


def indices(data):
    """Yield exactly the former 28,990 rows, in their original order."""
    for i in range(data['invariant_count']):
        yield {'id': f'invariant_{i:02d}', 'invariant_row': i,
               'multiplicity': data['invariant_multiplicity']}
    for orbit in data['normalized_orbits']:
        for j in range(orbit['degree_F25']):
            for branch in range(data['cubic_branches']):
                yield {'id': f'{orbit["id"]}_{j:04d}_{branch}', 'orbit': orbit['id'],
                       'frobenius_exponent': j, 'cubic_branch': branch,
                       'multiplicity': orbit['multiplicity']}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, default=FOLDER / 'complete_oper_solutions.json')
    parser.add_argument('--expanded-output', type=Path,
                        help='Optionally export individual index rows to a separate file.')
    args = parser.parse_args()
    if args.expanded_output and args.expanded_output.resolve() == args.out.resolve():
        raise ValueError('Expanded output must be separate from the compact census')
    data = description()
    args.out.write_text(json.dumps(data, separators=(',', ':')) + '\n')
    if args.expanded_output:
        points = list(indices(data))
        assert len(points) == len({p['id'] for p in points}) == data['distinct_points']
        assert sum(p['multiplicity'] for p in points) == data['total_multiplicity']
        args.expanded_output.write_text(json.dumps({'points': points}, separators=(',', ':')) + '\n')
    print('Exact census: 55 invariant indices and 12 orbit ranges; 28,990 points, total length 29,375.')


if __name__ == '__main__':
    main()
