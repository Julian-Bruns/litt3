#!/usr/bin/env python3
"""Prepare the exact two-character cyclic norm for a small twist of K.

Use complete section bases of K((1+3s)O) and Sym3 K(3sO).
The first has two characters; only invariant cubic sections contribute.
Normalize the last nonzero coordinate in the smaller character-zero part.
These projective charts retain all mixed-character global norm identities.
"""
import argparse
import hashlib
import json
from itertools import combinations_with_replacement
from math import factorial
from pathlib import Path

import pro_quadratic_twist_vanishing as q
from verify_k_shifted_norm_identities import product, read


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('source', type=Path)
    ap.add_argument('net', type=Path)
    ap.add_argument('--chart', type=int, required=True)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    source = json.loads(args.source.read_text())
    net = json.loads(args.net.read_text())
    shift = net['twist']//3
    assert net['twist'] == 3*shift and net['symmetric_degree'] == 3
    assert source['symmetric_degree'] == 1 and source['twist'] == 1+3*shift
    bychar = [[s for s in source['sections'] if s['C3_character'] == i] for i in range(3)]
    assert bychar[0] and bychar[1] and not bychar[2]
    ps = [[read(s, i) for i in range(2)] for s in bychar[0]]
    qs = [[read(s, i) for i in range(2)] for s in bychar[1]]
    gs = [[read(s, i) for i in range(4)] for s in net['sections'] if s['C3_character'] == 0]
    nb, nd, ng = len(ps), len(qs), len(gs)
    assert 0 <= args.chart < nb
    names = [f'b{i}' for i in range(nb)]+[f'd{i}' for i in range(nd)]+[f'g{i}' for i in range(ng)]
    cols, monomials = [], []
    for offset, basis in ((0, ps), (nb, qs)):
        for inds in combinations_with_replacement(range(len(basis)), 3):
            e = [0]*len(names)
            scale = factorial(3)
            for i in range(len(basis)):
                count = inds.count(i)
                e[offset+i] = count
                scale //= factorial(count)
            cols.append([q.add({}, f, scale % 5) for f in product([basis[i] for i in inds])])
            monomials.append(e)
    for i, p in enumerate(ps):
        for j, v in enumerate(qs):
            wedge = q.add(q.multiply(p[0], v[1]), q.multiply(p[1], v[0]), 4)
            assert all(r == 0 and 0 <= m <= 1+2*shift for r, m in wedge)
            for k, g in enumerate(gs):
                cols.append([q.add({}, q.multiply(wedge, f), 4) for f in g])
                e = [0]*len(names)
                e[i] = e[nb+j] = e[nb+nd+k] = 1
                monomials.append(e)
    rows = sorted({(i, r, m) for col in cols for i, f in enumerate(col) for r, m in f})
    full = [[col[i].get((r, m), 0) for col in cols] for i, r, m in rows]
    rr, piv = q.rref(full)
    assert q.prime_field_rank(full) == 2*len(piv)
    kept = names[:args.chart]+names[nb:]
    terms = []
    for e in monomials:
        if any(e[i] for i in range(args.chart+1, nb)):
            terms.append(None)
        else:
            factors = [name if power == 1 else f'{name}^{power}'
                       for name, power in zip(names, e) if power and name in kept]
            terms.append('*'.join(factors) or '1')
    equations = []
    for row in rr[:len(piv)]:
        pieces = [f'({c%5}+{c//5}*a)*({m})' for c, m in zip(row, terms) if c and m is not None]
        if pieces:
            equations.append('+'.join(pieces))
    result = {'status': 'PREPARED', 'scope': 'Exact mixed-character cyclic norm identities; no geometric decision asserted.',
              'shift': shift, 'chart': args.chart, 'variables': kept, 'equations': equations,
              'source_character_dimensions': [nb, nd], 'invariant_net_dimension': ng,
              'coefficient_matrix_shape': [len(full), len(cols)], 'coefficient_rank': len(piv),
              'all_coefficient_names': names, 'coefficient_monomials': monomials,
              'reduced_coefficient_rows': rr[:len(piv)],
              'input_hashes': [hashlib.sha256(p.read_bytes()).hexdigest() for p in (args.source, args.net)]}
    args.output.write_text(json.dumps(result, separators=(',', ':'))+'\n')
    print('PREPARED shift', shift, 'chart', args.chart, 'rank', len(piv),
          'variables', len(kept), 'equations', len(equations), flush=True)


if __name__ == '__main__':
    main()
