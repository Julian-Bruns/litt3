#!/usr/bin/env python3
"""Build the degree84 coefficient-field certificate from its14 input equations.

Run with sage -python. A bounded identity search only supplies polynomial
consequences; closure and finite-field incompatibility are checked separately.
"""
import argparse
import hashlib
import json
import subprocess
import sys
import tempfile
from pathlib import Path

from sage.all import GF, PolynomialRing, matrix
from sage.libs.singular.function import singular_function
from cysignals.alarm import alarm, cancel_alarm


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--max-nodes', type=int, default=125)
    parser.add_argument('--seconds', type=int, default=60)
    args = parser.parse_args()
    raw = args.source.read_bytes()
    source = json.loads(raw)
    assert source['field_degree'] == 15 and len(source['equations']) == 14
    assert source['variables'] == ['b8', 'b9', 'lead_inv', 'c2', 'c3', 'c5', 'pole0_inv']
    k = GF(5**15, 'a', modulus=PolynomialRing(GF(5), 'z')(source['field_modulus']))
    R = PolynomialRing(k, source['variables'], order='degrevlex')
    decode = lambda f: R({tuple(e): k(c) for e, c in f})
    encode = lambda f: [[list(e), list(map(int, c.polynomial().list()))]
                        for e, c in f.dict().items()]
    scalar_poly = lambda f: [list(map(int, c.polynomial().list())) for c in f.list()]
    inputs = list(map(decode, source['equations']))
    with tempfile.TemporaryDirectory(prefix='degree84-field-') as temporary:
        temporary = Path(temporary)
        input_path = temporary / 'source.json'
        input_path.write_text(json.dumps(dict(prime=5, **{
            key: source[key] for key in ('field_degree', 'field_modulus', 'variables', 'equations')
        }), separators=(',', ':')) + '\n')
        builder = Path(__file__).resolve().parents[2] / 'atlases/algebra/buchberger_identity_dag.py'
        subprocess.run([sys.executable, str(builder), str(input_path), str(temporary / 'search'),
                        '--seconds', str(args.seconds), '--max-nodes', str(args.max_nodes),
                        '--chain-criterion'], check=True, capture_output=True, text=True,
                       timeout=args.seconds + 10)
        dag = json.loads((temporary / 'search/dag.json').read_text())
        assert dag['source_sha256'] == hashlib.sha256(input_path.read_bytes()).hexdigest()

    alarm(args.seconds)
    try:
        nodes, mapping = [], {i: i for i in range(len(inputs))}
        for i, node in enumerate(dag['nodes']):
            old_index = len(inputs) + i
            f = decode(node['polynomial'])
            if i < len(inputs) and f == inputs[i]:
                mapping[old_index] = i
                continue
            mapping[old_index] = len(inputs) + len(nodes)
            nodes.append(dict(polynomial=node['polynomial'],
                              weights=[[mapping[j], w] for j, w in node['weights']]))
        consequences = inputs + [decode(node['polynomial']) for node in nodes]
        ideal = R.ideal(inputs)
        gb = ideal.groebner_basis()
        monomials = list(ideal.normal_basis())
        assert len(monomials) == 64
        positions = {tuple(m.exponents()[0]): i for i, m in enumerate(monomials)}
        c5 = R('c5')
        images = [(c5 * m).reduce(gb) for m in monomials]
        differences = [c5 * m - image for m, image in zip(monomials, images)]
        transform, remainders = singular_function('division')(
            R.ideal(differences), R.ideal(consequences), 4)
        assert all(R(f) == 0 for f in remainders), 'Increase the bounded identity search'
        weights = []
        for j, difference in enumerate(differences):
            assert difference == sum(transform[i, j] * f for i, f in enumerate(consequences))
            weights.append([[i, encode(R(transform[i, j]))]
                            for i in range(len(consequences)) if transform[i, j]])

        needed = {i for row in weights for i, _ in row}
        queue = list(needed)
        for i in queue:
            if i < len(inputs):
                continue
            for dependency, _ in nodes[i - len(inputs)]['weights']:
                if dependency not in needed:
                    needed.add(dependency)
                    queue.append(dependency)
        selected = [i for i in range(len(nodes)) if len(inputs) + i in needed]
        remap = {i: i for i in range(len(inputs))}
        remap.update({len(inputs) + i: len(inputs) + j for j, i in enumerate(selected)})
        nodes = [dict(polynomial=nodes[i]['polynomial'],
                      weights=[[remap[j], w] for j, w in nodes[i]['weights']])
                 for i in selected]
        weights = [[[remap[i], w] for i, w in row] for row in weights]

        columns = []
        for image in images:
            column = [k.zero()] * len(monomials)
            for e, c in image.dict().items():
                column[positions[tuple(e)]] = c
            columns.append(column)
        h = matrix(k, columns).transpose().charpoly()
        t = h.parent().gen()
        frobenius = pow(t, 5**30, h)
        gcd, a, b = h.xgcd(frobenius - t)
        assert gcd == 1
        record = dict(prime=5, **{key: source[key] for key in
                      ('field_degree', 'field_modulus', 'variables')},
                      source=str(args.source.resolve()), source_sha256=hashlib.sha256(raw).hexdigest(),
                      nodes=nodes, monomials=[list(m.exponents()[0]) for m in monomials],
                      coordinate='c5', images=list(map(encode, images)), closure_weights=weights,
                      annihilator=scalar_poly(h), frobenius_steps=30,
                      frobenius_remainder=scalar_poly(frobenius),
                      bezout_h=scalar_poly(a), bezout_remainder=scalar_poly(b))
        with args.output.open('x') as out:
            out.write(json.dumps(record, separators=(',', ':')) + '\n')
        print(json.dumps(dict(identity_nodes=len(nodes), closed_monomials=len(monomials),
                              annihilator_degree=h.degree(), bytes=args.output.stat().st_size),
                         default=int), flush=True)
    finally:
        cancel_alarm()


if __name__ == '__main__':
    main()
