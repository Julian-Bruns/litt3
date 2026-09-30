#!/usr/bin/env python3
"""Run exact prime-field F4 on a retained F25 polynomial chart.

F25 is represented by the explicit additional equation a^2-a+2.
Only a reduced basis is requested; no heuristic rational parametrization
or finite-field point enumeration is used. New emptiness conclusions
still require an ideal-membership certificate or independent replay.
"""
import argparse
import hashlib
import json
import subprocess
import time
from pathlib import Path
from sage.all import GF, PolynomialRing


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('input', type=Path)
    ap.add_argument('--chart', type=int)
    ap.add_argument('--msolve', type=Path, required=True)
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--threads', type=int, default=2)
    ap.add_argument('--pairs', type=int, default=512)
    args = ap.parse_args()
    data = json.loads(args.input.read_text())
    if args.chart is not None:
        data = data['charts'][args.chart]
    names = list(data['variables']) + ['a']
    assert len(set(names)) == len(names)
    R = PolynomialRing(GF(5), names, order='degrevlex')
    eq = [R(s) for s in data['equations']]
    a = R.gens()[-1]
    eq.append(a*a-a+2)
    source = args.output.with_suffix('.ms')
    result = args.output.with_suffix('.gb')
    log = args.output.with_suffix('.log')
    source.write_text(','.join(names)+'\n5\n'+',\n'.join(str(f).replace(' ', '') for f in eq)+'\n')
    command = [str(args.msolve.resolve()), '-g', '2', '-l', '2',
               '-t', str(args.threads), '-m', str(args.pairs), '-v', '1',
               '-f', str(source.resolve()), '-o', str(result.resolve())]
    receipt = {'status': 'RUNNING', 'scope': 'Exact F4 basis of specified chart over geometric F25.',
               'input_sha256': hashlib.sha256(args.input.read_bytes()).hexdigest(),
               'chart': args.chart, 'variables': names, 'command': command,
               'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest()}
    args.output.write_text(json.dumps(receipt, indent=2)+'\n')
    print('START exact F4', len(names), 'variables', len(eq), 'equations', flush=True)
    start = time.time()
    with log.open('w') as out:
        run = subprocess.run(command, stdout=out, stderr=subprocess.STDOUT)
    receipt.update(exit_code=run.returncode, seconds=time.time()-start)
    if run.returncode:
        receipt['status'] = 'ERROR'
        receipt['error_tail'] = log.read_text()[-2000:]
    else:
        raw = '\n'.join(line for line in result.read_text().splitlines()
                        if not line.lstrip().startswith('#')).strip()
        clean = raw.rstrip(':;').strip()
        assert clean.startswith('[') and clean.endswith(']'), raw[:200]
        basis = [R(s.strip()) for s in clean[1:-1].split(',') if s.strip()]
        receipt.update(status='COMPLETE', empty=basis == [R.one()],
                       basis_length=len(basis), basis_sha256=hashlib.sha256(result.read_bytes()).hexdigest())
    args.output.write_text(json.dumps(receipt, indent=2)+'\n')
    print(receipt['status'], 'empty', receipt.get('empty'), 'seconds', receipt['seconds'], flush=True)
    if run.returncode:
        print(receipt['error_tail'])
        raise SystemExit(run.returncode)


if __name__ == '__main__':
    main()
