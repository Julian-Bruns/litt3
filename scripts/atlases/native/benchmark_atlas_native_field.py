#!/usr/bin/env python3
"""Bounded Singular coefficient-domain comparison; never alters atlas data."""
import argparse, json, subprocess, time
from pathlib import Path

p = argparse.ArgumentParser()
p.add_argument('input', type=Path)
p.add_argument('--seconds', type=float, default=15)
p.add_argument('--method', choices=['std', 'slimgb'], default='std')
p.add_argument('--mode', choices=['native', 'encoded', 'both'], default='both')
p.add_argument('--f625', action='store_true', help='Extend the F25 chart using a=u^2, u^4+4u^2+2=0')
args = p.parse_args()
lines = args.input.read_text().strip().splitlines()
names = lines[0].split(',')
assert lines[1] == '5' and names[-1] == 'a'
equations = [s.strip().rstrip(',') for s in lines[2:]]
assert equations[-1].replace(' ', '') == 'a^2-a+2'
if args.f625:
    # The F25 generator has order24, hence is nonsquare. This quadratic
    # extension is a field, with a=u^2 and u^4+4u^2+2=0.
    import re
    equations = [re.sub(r'\ba\b', '(u^2)', s) for s in equations]
    names[-1] = 'u'
for mode in (['native','encoded'] if args.mode=='both' else [args.mode]):
    if mode == 'native':
        declaration = 'ring r=(5,%s),(%s),dp; minpoly=%s;' % (names[-1], ','.join(names[:-1]), equations[-1])
        generators = equations[:-1]
    else:
        declaration = 'ring r=5,(%s),dp;' % ','.join(names)
        generators = equations
    program = declaration + '\nideal I=' + ',\n'.join(generators) + ';\n'
    program += 'ideal G=%s(I); print("RESULT"); print(G); quit;\n' % args.method
    started = time.monotonic()
    try:
        proc = subprocess.run(['Singular', '-q'], input=program, text=True, capture_output=True, timeout=args.seconds)
        result = dict(status='finished', returncode=proc.returncode, stdout=proc.stdout[-2500:], stderr=proc.stderr[-1000:])
    except subprocess.TimeoutExpired:
        result = dict(status='timeout')
    print(json.dumps(dict(mode=mode, method=args.method, f625=args.f625, seconds=time.monotonic()-started, **result)), flush=True)
