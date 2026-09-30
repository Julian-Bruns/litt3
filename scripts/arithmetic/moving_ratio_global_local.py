"""Focused reproduction and resource-bounded probes of the root9 global model.

Inputs and outputs live outside the source repository. This does not assert
emptiness of the square scheme. Preserve the received prototype unchanged.
"""
from __future__ import annotations
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import signal
import subprocess
import sys
import time


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def reproduce(root, out):
    records = []
    for line in (root / 'SHA256SUMS').read_text().splitlines():
        expected, name = line.split(None, 1)
        assert sha(root / name.strip()) == expected, name
    work = out / 'reproduction'
    if not work.exists():
        shutil.copytree(root, work)
    for script, target in [('prepare_global.py', 'preparation.json'),
                           ('check_global_model.py', 'model_diagnostics.json')]:
        start = time.monotonic()
        p = subprocess.run([sys.executable, '-B', 'decision/src/' + script],
                           cwd=work, capture_output=True, text=True)
        (out / (script + '.log')).write_text(p.stdout + p.stderr)
        assert p.returncode == 0, script
        a = json.loads((root / 'decision/data' / target).read_text())
        b = json.loads((work / 'decision/data' / target).read_text())
        assert a == b, target
        records.append({'script': script, 'outcome': 'PASS',
                        'seconds': time.monotonic() - start})
    assert sha(root / 'decision/global_incidence.sing') == sha(work / 'decision/global_incidence.sing')
    result = {'manifest': 'PASS', 'new_checks': records,
              'prototype_identical': True, 'global_decision': 'UNRESOLVED'}
    (out / 'focused_verification.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2), flush=True)


def generate(root, out, optimized=False):
    original = (root / 'decision/global_incidence.sing').read_text()
    prefix = original.split('// All 141 coefficients, not merely early square tails, now enter.')[0]
    if optimized:
        # Equalities in the quotient ring, with reduction after each product.
        # Avoid expanding high z powers in a large product only to reduce them
        # at the end. Powers of five are sparse in characteristic five.
        prefix = prefix.replace(
            'poly resu=nf(ell^2*T0^2+ell*(T0*V0+cap*(U0^2-2*a5*T0))+aa^3*(T0*W0+cap*M0)+cap^2*aa^10);',
            'poly aa3=nf(aa^3);\n'
            'poly aa10=nf(a5^2);\n'
            'poly res2=nf(T0^2);\n'
            'poly res1=nf(T0*V0)+cap*(nf(U0^2)-2*nf(a5*T0));\n'
            'poly res0=nf(aa3*(nf(T0*W0)+cap*M0))+cap^2*aa10;\n'
            'poly resu=ell^2*res2+ell*res1+res0;')
    lines = []
    for line in prefix.splitlines():
        lines.append(line)
        if line.startswith('poly ') and '=' in line:
            name = line.split('=', 1)[0].split()[1]
            # The three declarations on this one line are all already evaluated.
            lines.append('print("STAGE ' + name + '"); print(size(' + name + '));')
    lines.extend(['print("POLYNOMIAL_MODEL_PASS");',
                  'print(size(RR)); print(ncols(XC));',
                  'write("polynomial_model.txt",RR);',
                  'quit;'])
    dest = out / ('build_model_reduced.sing' if optimized else 'build_model.sing')
    dest.write_text('\n'.join(lines) + '\n')
    print(dest, flush=True)


def bounded(command, out, seconds, rss_mib, label):
    start = time.monotonic()
    log = out / (label + '.log')
    samples = []
    stop = None
    with log.open('w') as stream:
        proc = subprocess.Popen(command, cwd=out, stdout=stream, stderr=subprocess.STDOUT,
                                start_new_session=True)
        while proc.poll() is None:
            elapsed = time.monotonic() - start
            ps = subprocess.run(['ps', '-o', 'rss=', '-p', str(proc.pid)],
                                capture_output=True, text=True)
            rss = int(ps.stdout.strip() or 0)
            samples.append((round(elapsed, 3), rss))
            if rss > rss_mib * 1024:
                stop = 'RSS_LIMIT'
            elif elapsed > seconds:
                stop = 'ELAPSED_LIMIT'
            if stop:
                os.killpg(proc.pid, signal.SIGTERM)
                try:
                    proc.wait(timeout=5)
                except subprocess.TimeoutExpired:
                    os.killpg(proc.pid, signal.SIGKILL)
                break
            time.sleep(1)
        proc.wait()
    result = {'command': command, 'returncode': proc.returncode, 'stop': stop,
              'seconds': round(time.monotonic() - start, 3),
              'max_rss_kib': max((x[1] for x in samples), default=0),
              'bounded_probe_only': True}
    (out / (label + '.run.json')).write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2), flush=True)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('mode', choices=['verify', 'generate', 'generate-reduced', 'run'])
    p.add_argument('--root', type=Path, required=True)
    p.add_argument('--out', type=Path, required=True)
    p.add_argument('--singular', default='/var/tmp/sage-10.9-current/local/bin/Singular')
    p.add_argument('--seconds', type=int, default=240)
    p.add_argument('--rss-mib', type=int, default=2200)
    p.add_argument('--program', default='build_model.sing')
    p.add_argument('--label', default='build_model')
    a = p.parse_args()
    a.root = a.root.resolve(); a.out = a.out.resolve()
    a.out.mkdir(parents=True, exist_ok=True)
    if a.mode == 'verify':
        reproduce(a.root, a.out)
    elif a.mode.startswith('generate'):
        generate(a.root, a.out, a.mode == 'generate-reduced')
    else:
        bounded([a.singular, '-q', a.program], a.out, a.seconds, a.rss_mib, a.label)


if __name__ == '__main__':
    main()
