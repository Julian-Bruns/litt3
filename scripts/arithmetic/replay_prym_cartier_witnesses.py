#!/usr/bin/env python3
"""Replay saved actual Prym normal spaces, Cartier action, and linear norms.

All saved anti-form equations are checked by direct polynomial substitution.
The norm is recomputed with an iterative binary-composition implementation,
separate from the recursive producer. A sample is a sample, never full replay.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse
import hashlib
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, identity_matrix
from cysignals.alarm import alarm, cancel_alarm, AlarmInterrupt
from scripts.arithmetic.sieve_fixed_x_carriers import load_json
from scripts.atlases.opers.fixed_x_monomial_jacobian import FixedXMonomialJacobian
from scripts.arithmetic.fixed_x_prym_cartier import TrigonalArithmetic, cutoff, torsion_trivialization


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('coverage', type=Path)
    p.add_argument('torsion', type=Path)
    p.add_argument('out', type=Path)
    p.add_argument('--sample', type=int, default=15)
    p.add_argument('--all', action='store_true')
    p.add_argument('--index-from', type=int, default=0)
    p.add_argument('--index-to', type=int, default=1533)
    p.add_argument('--seconds', type=int, default=1200)
    args = p.parse_args()
    args.out.mkdir(exist_ok=True)
    start = time.monotonic()
    coverage = load_json(args.coverage)
    torsion = load_json(args.torsion)
    raw_hash = hashlib.sha256(args.coverage.read_bytes()).hexdigest()
    k = GF(5**342, 'b', modulus=PolynomialRing(GF(5), 'z')(torsion['modulus']), impl='pari_ffelt')
    J = FixedXMonomialJacobian(k, k(torsion['a']))
    ar = TrigonalArithmetic(J)
    phi = k.frobenius_endomorphism(-1)
    def decode(data):
        return matrix(k, data['rows'], data['columns'], [k(c) for c in data['coefficients']])
    def twist(M, n):
        hom = k.frobenius_endomorphism(-n)
        return matrix(k, M.nrows(), M.ncols(), [hom(c) for c in M.list()])
    def iterative_norm(M, n):
        # Append blocks to v -> phi^-r(v)*N_r, in left-to-right bit order.
        out = identity_matrix(k, 8)
        length = 0
        for digit in bin(n)[2:]:
            out = twist(out, length)*out
            length *= 2
            if digit == '1':
                out = twist(out, 1)*M
                length += 1
        assert length == n
        return out
    indices = list(range(args.index_from, args.index_to))
    if not args.all:
        indices = sorted({indices[j*len(indices)//args.sample] for j in range(args.sample)})
    setup_seconds = time.monotonic()-start
    results = []
    alarm(args.seconds)
    status = 'complete'
    try:
        for i in indices:
            receipt = args.out/('carrier_%04d.json' % i)
            entry = coverage['carriers'][i]
            assert entry['index'] == i
            source = next(Path(e['path']) for e in entry['evidence']
                          if e['path'].endswith('/result.json') and 'prym-sieve-full-' in e['path'])
            source_hash = hashlib.sha256(source.read_bytes()).hexdigest()
            if receipt.exists():
                result = load_json(receipt)
                assert result['status'] == 'PASS' and result['source_sha256'] == source_hash
                results.append(result)
                continue
            began = time.monotonic()
            data = load_json(source)
            witness = load_json(source.parent/'cartier_witness.json.gz')
            w = decode(load_json(source.parent/'torsion_matrix.json.gz'))
            h = decode(witness['anti_basis'])
            M = decode(witness['matrix'])
            N = decode(witness['linear_norm'])
            assert M.nrows() == M.ncols() == 8 and M.rank() == 8
            assert h.nrows() == h.rank() == 8
            assert h.row_space() == cutoff(w, J.bases[3], 26).row_space()
            g = [ar.R([k(c) for c in f]) for f in witness['trivialization']]
            # Regenerate the small pole-space certificate of div(g)=2D-20O.
            gg, hh, _ = torsion_trivialization(J, w)
            assert g == gg and h == hh
            g2 = ar.multiply(g, g)
            for j, row in enumerate(h):
                image = ar.cartier(ar.multiply(g2, ar.row(row, J.bases[3])))
                expected = matrix(k, 1, len(J.bases[3]), ar.vector(image, J.bases[3]))[0]
                assert M[j]*h == expected
            assert iterative_norm(M, 342) == N
            polynomial = N.charpoly()
            assert polynomial.list() == [k(c) for c in data['coefficients']]
            result = dict(status='PASS', index=i, source_sha256=source_hash,
                          anti_form_equations=8, regenerated_normal_space=True,
                          independently_iterated_norm=True,
                          seconds=time.monotonic()-began)
            receipt.write_text(json.dumps(result, indent=2)+'\n')
            results.append(result)
            if len(results) % 10 == 0 or not args.all:
                print(json.dumps(result | dict(processed=len(results))), flush=True)
    except AlarmInterrupt:
        status = 'time_limit_completed_receipts_retained'
    finally:
        cancel_alarm()
    measured = [r['seconds'] for r in results]
    summary = dict(status=status, selected=len(indices), completed=len(results),
                   all_carriers=(args.all and args.index_from == 0 and args.index_to == 1533),
                   index_from=args.index_from, index_to=args.index_to,
                   setup_seconds=setup_seconds, elapsed_seconds=time.monotonic()-start,
                   mean_carrier_seconds=sum(measured)/len(measured) if measured else None,
                   coverage_sha256=raw_hash,
                   scope='Exact replay of listed actual normal spaces, all anti-Cartier equations and norms; label generation is a separate prerequisite')
    (args.out/('summary-%d-%d.json' % (args.index_from,args.index_to))).write_text(json.dumps(summary, indent=2)+'\n')
    print(json.dumps(summary), flush=True)


if __name__ == '__main__':
    main()
