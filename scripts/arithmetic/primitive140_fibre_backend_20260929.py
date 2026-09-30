#!/usr/bin/env python3
"""Prepare a new whole-q fibre for native exact elimination.

This is a discovery driver, not an emptiness certificate. It reuses the
received source construction and does not replay its settled certificates.
The unknown H and mu remain geometric variables. Output belongs outside
the research repository. No bounded field search replaces elimination.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--archive', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    p.add_argument('--q', type=int, default=25)
    p.add_argument('--compiler', default='/opt/homebrew/opt/llvm/bin/clang++')
    p.add_argument('--equations', type=int, default=30)
    args = p.parse_args()
    root = args.archive.resolve()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    started = time.time()
    sys.path.insert(0, str(root / 'src'))
    # The cache is generated inside the external received tree, never in
    # the source repository; the original archive remains untouched.
    import ff
    from algebra import P, Q, B0, t
    source = json.loads((root / 'data/ratio_source.json').read_text())
    inp = out / 'source.txt'
    with inp.open('w') as f:
        for poly in [P, Q, B0, t]:
            f.write(' '.join(map(str, [len(poly), *poly])) + '\n')
        for row in source['G']:
            f.write(str(len(row)) + '\n')
            for x, v, h, q, c in row:
                f.write(f'{x} {h} {q} {v} {c}\n')

    def run(command, name):
        print(name, flush=True)
        with (out / (name + '.log')).open('w') as log:
            subprocess.run(list(map(str, command)), stdout=log,
                           stderr=subprocess.STDOUT, check=True)

    for name in ['global_quadratic', 'current_fibre_many']:
        exe = out / name
        src = root / 'src' / (name + '.cpp')
        if not exe.exists() or exe.stat().st_mtime < src.stat().st_mtime:
            run([args.compiler, '-std=c++17', '-O3', src, '-o', exe],
                'compile_' + name)
    quad = out / 'quadratic.txt'
    if not quad.exists():
        run([out / 'global_quadratic', root / 'build/field.bin', inp, quad],
            'quadratic')
    fibre = out / f'q{args.q}.txt'
    if not fibre.exists():
        run([out / 'current_fibre_many', root / 'build/field.bin', inp,
             quad, args.q, fibre], 'fibre')

    # A=alpha^4+2alpha^3+alpha^2+2alpha,
    # B=alpha^3+alpha^2+1, beta=-A/B. Its degree-eight minimal
    # polynomial is A^2+A*B-3*B^2. This is an exact change of the
    # received tower convention, not integer reduction of K codes.
    def cp(c):
        terms = []
        for i in range(4):
            b = c % 25
            c //= 25
            if b:
                terms.append(f'({b%5}+{b//5}*bb)*a^{i}')
        return '(' + '+'.join(terms or ['0']) + ')'

    equations = []
    with fibre.open() as f:
        assert f.readline().strip() == f'fixedq_v1 {args.q}'
        tag, n = f.readline().split()
        assert tag == 'R'
        for _ in range(int(n)):
            f.readline()
        while line := f.readline():
            assert line.startswith('removed ')
            name, n = f.readline().split()
            terms = []
            for _ in range(int(n)):
                h, mu, c = map(int, f.readline().split())
                terms.append(f'{cp(c)}*H^{h}*m^{mu}')
            equations.append((name, '+'.join(terms)))

    for count in sorted(set([3, min(10, args.equations), args.equations])):
        path = out / f'slimgb_{count}.sing'
        with path.open('w') as f:
            f.write('ring r=(5,a),(H,m),dp;\n')
            f.write('minpoly=a8+a6+2*a3+4*a2+2*a+2;\n')
            f.write('number bb=-(a4+2*a3+a2+2*a)/(a3+a2+1);\n')
            f.write('option(redSB); option(prot);\n')
            for name, poly in equations[:count]:
                f.write(f'poly {name}={poly};\n')
            f.write('ideal I=' + ','.join(n for n, _ in equations[:count]) + ';\n')
            f.write('"START_NATIVE_ELIMINATION"; timer=1;\n')
            f.write('ideal G=slimgb(I);\n')
            f.write('"END_NATIVE_ELIMINATION"; timer; size(G); G;\nquit;\n')
    meta = {'q_code': args.q,
            'scope': 'First thirty necessary square tails on whole geometric H,mu fibre; no decision yet.',
            'source_sha256': hashlib.sha256(inp.read_bytes()).hexdigest(),
            'fibre_sha256': hashlib.sha256(fibre.read_bytes()).hexdigest(),
            'elapsed_seconds': time.time() - started}
    (out / 'metadata.json').write_text(json.dumps(meta, indent=2) + '\n')
    print(json.dumps(meta), flush=True)


if __name__ == '__main__':
    main()
