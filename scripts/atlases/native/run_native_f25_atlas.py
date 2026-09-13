#!/usr/bin/env python3
"""First-oper laboratory: exact native F25 Singular, completed-stage artifacts.

Run with sage -python. This does NOT save Singular's active critical pairs.
Timeouts restart the solver stage; original F4 checkpoints are never touched.
"""
import argparse
from collections import Counter
import hashlib
import json
import os
from pathlib import Path
import resource
import signal
import subprocess
import time

FIRST = Path('/Users/julian/Documents/litt3-computation-data/atlas-rooted-first')


def save(path, value):
    temporary = path.with_suffix(path.suffix + '.tmp')
    temporary.write_text(json.dumps(value, indent=2, default=int) + '\n')
    os.replace(temporary, path)


def run(chart, output, seconds=300, memory_gib=2, method='slimgb'):
    from sage.all import GF, PolynomialRing, sage_eval
    if seconds <= 0 or memory_gib <= 0:
        raise ValueError('Time and memory budgets must be positive')
    started = time.monotonic()
    requested_stop = []
    def request_stop(signum, frame):
        requested_stop.append(signum)
    signal.signal(signal.SIGINT, request_stop)
    signal.signal(signal.SIGTERM, request_stop)
    out = Path(output).resolve()
    out.mkdir(parents=True, exist_ok=True)
    if any(out.iterdir()):
        raise ValueError('Use an empty output directory; completed stage artifacts are immutable.')
    events = out / 'events.jsonl'

    def event(stage, **values):
        row = dict(stage=stage, elapsed_seconds=round(time.monotonic()-started, 3), **values)
        with events.open('a') as stream:
            stream.write(json.dumps(row, default=int)+'\n')
        print(json.dumps(row, default=int), flush=True)

    if not 0 <= chart <= 31:
        raise ValueError('chart must be between 0 and 31')
    folder = FIRST / ('chart-%02d' % chart)
    raw = (folder/'input.ms').read_bytes()
    meta = json.loads((folder/'metadata.json').read_text())
    digest = hashlib.sha256(raw).hexdigest()
    if digest != meta['input_sha256']:
        raise ValueError('Original input hash mismatch')
    lines = raw.decode().strip().splitlines()
    names = lines[0].split(',')
    equations = [s.strip().rstrip(',') for s in lines[2:]]
    if lines[1] != '5' or names[-1] != 'a' or equations[-1].replace(' ', '') != 'a^2-a+2':
        raise ValueError('Only the first F25 representative is supported')
    k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'z')([2,4,1]))
    a = k.gen()
    native = PolynomialRing(k, names=names[:-1], order='degrevlex')
    encoded = PolynomialRing(GF(5), names=names, order='degrevlex')
    local_native = dict(zip(names[:-1], native.gens()), a=a)
    local_encoded = dict(zip(names, encoded.gens()))
    projection = encoded.hom(list(native.gens())+[native(a)], native)
    polys = []
    degrees = Counter()
    low, frobenius, admissibility = [], [], []
    event('input_validation_started', chart=chart, worker_pid=os.getpid(), input_sha256=digest,
          coefficient_field='F5[a]/(a^2-a+2)', original_variables=len(names), native_variables=len(names)-1)
    for index, expression in enumerate(equations[:-1]):
        f = native(sage_eval(expression, locals=local_native))
        original = encoded(sage_eval(expression, locals=local_encoded))
        if projection(original) != f:
            raise ValueError('Encoded-to-native mismatch at equation %s' % index)
        # Lifting every native coefficient proves the reverse identity modulo minpoly.
        lifted = encoded.zero()
        for exponents, coefficient in f.dict().items():
            cp = coefficient.polynomial()
            term = encoded(int(cp[0])) + int(cp[1])*encoded.gen(len(names)-1)
            for variable, exponent in zip(encoded.gens(), exponents):
                if exponent:
                    term *= variable**exponent
            lifted += term
        if (original-lifted).reduce([encoded(sage_eval(equations[-1], locals=local_encoded))]) != 0:
            raise ValueError('Native-to-encoded mismatch at equation %s' % index)
        bidegree = tuple(max((sum(e for e,n in zip(ex,names[:-1]) if n.startswith(prefix))
                             for ex in f.dict()), default=0) for prefix in ('v','b','w'))
        degrees[str(bidegree)] += 1
        if bidegree[2]:
            admissibility.append(index)
        elif bidegree[0] > 1 or bidegree[1] > 1:
            frobenius.append(index)
        else:
            low.append(index)
        polys.append(f)
    declaration = 'ring r=(5,a),(%s),dp; minpoly=a^2-a+2; short=0;\n' % ','.join(names[:-1])
    body = declaration + 'ideal I=' + ',\n'.join(equations[:-1]) + ';\n'
    (out/'native-input.sing').write_text(body)
    # Separate completed parse stage; actual Singular output is compared in Sage.
    roundtrip = out/'singular-roundtrip.txt'
    parse_program = body + 'int ii; for(ii=1;ii<=size(I);ii++){write(%s,string(I[ii]));} quit;\n' % json.dumps(str(roundtrip))
    parsed = subprocess.run(['Singular','-q'], input=parse_program, capture_output=True, text=True, timeout=30)
    (out/'parse.log').write_text(parsed.stdout+parsed.stderr)
    if parsed.returncode or '?' in parsed.stdout or not roundtrip.exists():
        raise RuntimeError('Singular parse failed; inspect parse.log')
    returned = roundtrip.read_text().splitlines()
    if len(returned) != len(polys) or any(native(sage_eval(s, locals=local_native)) != f for s,f in zip(returned, polys)):
        raise ValueError('Singular-to-Sage native polynomial roundtrip failed')
    validation = dict(chart=chart, input_sha256=digest, field='F25', modulus='a^2-a+2',
        native_input_sha256=hashlib.sha256(body.encode()).hexdigest(),
        adapter_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        encoded_native_reverse_identity=True, singular_sage_roundtrip=True,
        equations=len(polys), terms=sum(len(f.dict()) for f in polys),
        bidegrees_v_b_w=dict(degrees), low_incidence_equation_indices=low,
        frobenius_equation_indices=frobenius, admissibility_equation_indices=admissibility,
        low_stage_meaning='Row-reduced mixture of N and chart s equations; individual provenance in original initial_rref.json',
        solver_checkpoint=False, completed_stage='validated_native_input')
    save(out/'validated-input.json', validation)
    event('validated_native_input', bidegrees_v_b_w=dict(degrees), low_incidence_rows=len(low),
          frobenius_rows=len(frobenius), admissibility_rows=len(admissibility), terms=validation['terms'])
    candidate = out/'candidate-basis.txt'
    program = body + 'option(prot); print("NATIVE_SOLVER_STARTED");\n'
    program += 'ideal G=%s(I); print("NATIVE_SOLVER_COMPLETED");\n' % method
    program += 'int ii; for(ii=1;ii<=size(G);ii++){write(%s,string(G[ii]));}\n' % json.dumps(str(candidate))
    program += 'print("NATIVE_BASIS_EXPORT_COMPLETED"); quit;\n'
    (out/'solve.sing').write_text(program)
    remaining = max(0, seconds-(time.monotonic()-started))
    def limits():
        resource.setrlimit(resource.RLIMIT_CPU, (max(1,int(remaining)+1),max(2,int(remaining)+2)))
    status = 'time_limit'
    peak_rss = 0
    with (out/'singular.log').open('w') as log:
        proc = subprocess.Popen(['Singular','-q',str(out/'solve.sing')], stdout=log,
                                stderr=subprocess.STDOUT, preexec_fn=limits)
        event('native_solver_started', pid=proc.pid, method=method, budget_seconds=remaining,
              memory_gib=memory_gib, critical_pair_checkpoint=False)
        next_report = time.monotonic()
        while proc.poll() is None:
            sample = subprocess.run(['ps','-o','rss=,time=,%cpu=','-p',str(proc.pid)], capture_output=True, text=True).stdout.strip().split()
            rss = int(sample[0])*1024 if sample else 0
            peak_rss = max(rss, peak_rss)
            if time.monotonic() >= next_report:
                with (out/'singular.log').open('rb') as protocol:
                    protocol.seek(max(0, (out/'singular.log').stat().st_size-240))
                    protocol_tail = protocol.read().decode(errors='replace').strip()
                event('native_solver_progress', rss_bytes=rss, cpu_time=sample[1] if sample else None,
                      cpu_percent=sample[2] if sample else None, log_bytes=(out/'singular.log').stat().st_size,
                      protocol_tail=protocol_tail)
                next_report = time.monotonic()+10
            if requested_stop or rss > memory_gib*1024**3 or time.monotonic()-started >= seconds:
                status = 'stopped' if requested_stop else ('memory_limit' if rss > memory_gib*1024**3 else 'time_limit')
                proc.terminate()
                try:
                    proc.wait(timeout=2)
                except subprocess.TimeoutExpired:
                    proc.kill(); proc.wait()
                break
            time.sleep(.25)
        else:
            status = 'solver_finished' if proc.returncode == 0 else 'solver_error'
    logtext = (out/'singular.log').read_text(errors='replace')
    if status == 'solver_finished' and ('NATIVE_BASIS_EXPORT_COMPLETED' not in logtext or '?' in logtext):
        status = 'solver_error'
    if status == 'solver_finished':
        basis = [native(sage_eval(s, locals=local_native)) for s in candidate.read_text().splitlines()]
        status = 'unit_basis_candidate' if any(f.is_constant() and f != 0 for f in basis) else 'nonunit_basis_candidate'
    result = dict(chart=chart, status=status, returncode=proc.returncode,
        elapsed_seconds=time.monotonic()-started, peak_sampled_rss_bytes=peak_rss,
        input_sha256=digest, method=method, field='F25', internally_checkpointable=False,
        monitoring='RSS sampled every 0.25s; short processes may finish between samples. CPU time is recorded in events.jsonl.',
        verification='Input equivalence verified. Solver basis is a candidate, not an independently verified certificate.',
        completed_checkpoints=['validated-input.json'],
        scope='First untwisted representative, selected chart only. No whole-oper or common-cover conclusion.')
    save(out/'result.json', result)
    event('finished', **{k:v for k,v in result.items() if k!='elapsed_seconds'})
    return result


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--chart', type=int, required=True)
    ap.add_argument('--output', required=True)
    ap.add_argument('--seconds', '--timebudget', type=float, default=300)
    ap.add_argument('--memory-gib', type=float, default=2)
    ap.add_argument('--method', choices=['std','slimgb'], default='slimgb')
    args = ap.parse_args()
    run(args.chart, args.output, args.seconds, args.memory_gib, args.method)
