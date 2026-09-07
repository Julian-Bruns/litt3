#!/usr/bin/env python3
"""Exact checkpointed atlas F4 queue; plain ETA monitor; no success by exit code.

Large inputs/checkpoints live outside the repository. ETA is an empirical
    Macaulay-work forecast, NOT a complexity bound or a time-to-Litt3-proof claim.
"""
import argparse
import fcntl
import hashlib
import json
import math
import os
from pathlib import Path
import re
import signal
import statistics
import subprocess
import time
import atlas_telemetry as operation_log

DEFAULT = Path('/Users/julian/Documents/litt3-computation-data/atlas-rooted-first')
ENGINE = Path('/Users/julian/Documents/litt3-computation-data/atlas-f4-telemetry/msolve/msolve')
COMPLETED = {'basis_needs_verification', 'linear_certificate_verified',
             'verified_polynomial_certificate'}


def sha(path):
    with Path(path).open('rb') as f:
        return hashlib.file_digest(f, 'sha256').hexdigest()


def engine_fingerprint(engine):
    # A logging-only build still has different timing overhead. Do not mix
    # its timing samples with an earlier build under the old patch hash.
    parent=Path(engine).parent
    pieces=[parent/'f4-checkpoint.patch',parent/'src/neogb/.libs/libneogb.3.dylib']
    return hashlib.sha256(''.join(sha(p) for p in pieces if p.exists()).encode()).hexdigest()


def atomic(path, obj):
    tmp = path.with_suffix(path.suffix + '.tmp')
    with tmp.open('w') as f:
        json.dump(obj, f, indent=2)
        f.write('\n')
        f.flush()
        os.fsync(f.fileno())
    os.replace(tmp, path)


def read_json(path, default=None):
    try:
        return json.loads(path.read_text())
    except FileNotFoundError:
        return default


def rss(pid):
    p = subprocess.run(['ps', '-axo', 'pgid=,rss='], capture_output=True, text=True)
    return sum(int(b)*1024 for line in p.stdout.splitlines()
               if len(ab := line.split()) == 2 for a, b in [ab] if int(a) == pid)


def telemetry(path):
    rows = []
    try:
        with path.open() as f:
            for line in f:
                try:
                    rows.append(json.loads(line))
                except json.JSONDecodeError:
                    break  # A concurrent final line may be incomplete.
    except FileNotFoundError:
        pass
    return rows


def telemetry_max_degree(events):
    """Metadata/operation events need not have a Macaulay degree."""
    return max((row['degree'] for row in events
                if isinstance(row.get('degree'), int)), default=0)


def work_size(job, degree=4):
    """Macaulay columns: monomials through degree d, not a completion percent."""
    n = job['nvars']
    return math.comb(n + degree, degree)


def bilinear_work(chart):
    """Dimension-count witness degree, a heuristic, never an emptiness test.

    q free b coordinates;96-q rows linear in32 v's. Multipliers of b-degree
    <=r give (96-q)*C(q+r,r) rows and32*C(q+r+1,r+1)+C(q+r,r)
    columns. Pick the first row-count crossing. Structured rank may differ.
    """
    q = 31-chart
    r = max(0, math.ceil(32*q/(63-q))-1)
    return 32*math.comb(q+r+1,r+1)+math.comb(q+r,r)


def hydrate_work_counts(state, folder):
    # Work counts survive engine changes; timings do not. These are tiny logs,
    # read once per controller invocation, and only missing records in watch.
    for key, record in state.get('jobs', {}).items():
        if record.get('status') == 'basis_needs_verification' and 'max_basis' not in record:
            events = telemetry(folder/f'chart-{int(key):02d}'/'rounds.jsonl')
            record['max_basis'] = max((r.get('basis_count',0) for r in events), default=0)


def active_bilinear_eta(state, pending):
    """A calibrated work-count forecast for ONE tested empty-tail regime.

    Not used for chart0..7: the weak bilinear section can have positive
    dimension there, so this model cannot predict the full Frobenius solve.
    """
    if len(pending) != 1 or pending[0]['chart'] < 8:
        return None
    active = state.get('active', {})
    if active.get('chart') != pending[0]['chart']:
        return None
    rounds = [r for r in state.get('recent_rounds', [])
              if r.get('unix_seconds',0) >= active['started'] and r['new_pivots'] > 0]
    if len(rounds) < 2:
        return None
    ratios = [r['max_basis']/bilinear_work(r['chart']) for r in state['jobs'].values()
              if r.get('status') == 'basis_needs_verification' and r.get('max_basis',0)]
    if len(ratios) < 3:
        return None
    B = rounds[-1]['basis_count']
    base = bilinear_work(pending[0]['chart'])
    target = base*statistics.median(ratios)
    # A surpassed target is evidence the model has missed; extend, don't stall
    # at zero. Failure of the genericity heuristic never stops the exact solver.
    target = max(target, B+base/4)
    cost = statistics.median(r['round_seconds']/r['new_pivots'] for r in rounds[-4:])
    # Growing reducer bases make later pivots costlier. Linear cost growth is
    # a local scenario; bracket by constant through quadratic growth.
    point = cost*(target*target-B*B)/(2*B)
    low_target = max(B+base/10, base*min(ratios))
    high_target = max(target*1.2, base*max(ratios))
    return {'seconds_point':point, 'seconds_low':cost*(low_target-B)/2,
            'seconds_high':cost*(high_target**3-B**3)/(3*B*B)*2,
            'method':'calibrated_bilinear_module_column_count_and_live_pivot_rate',
            'scope':'current tail chart only, not full oper or list',
            'confidence':'heuristic generic-rank work model tested on completed tail charts'}


def predict_job(job, finished):
    """Fit monomial growth and observed exponential growth in free coordinates.

    These four degrees bracket modest algebraic solving degrees rather than
    assuming all bilinear systems are generic. Exact linear exclusions are
    NOT used as timing samples. The band expands with extrapolation distance.
    Coefficient fields other than this fixed F25 are not in this forecast.
    """
    samples = [(j, max(.05, j['seconds'])) for j in finished
               if j.get('status') == 'basis_needs_verification']
    substantial = [(j,t) for j,t in samples if t >= 5]
    if len(substantial) >= 2:
        samples = substantial  # Do not fit process-polling latency as algebra cost.
    if not samples:
        return None
    predictions = []
    distance = max(1., (job['nvars']+1)/(max(j['nvars'] for j, _ in samples)+1))
    for degree in (3, 4, 5, 6):
        xs = [math.log(work_size(j, degree)) for j, _ in samples]
        ys = [math.log(t) for _, t in samples]
        var = sum((x-statistics.mean(xs))**2 for x in xs)
        slope = (sum((x-statistics.mean(xs))*(y-statistics.mean(ys))
                     for x, y in zip(xs, ys))/var) if var > 1e-12 else 2.
        # Effective slope can exceed dense elimination's exponent because the
        # solving degree and number of repeated matrices also grow. Clipping it
        # at three would discard precisely the observed evidence of blow-up.
        slope = max(1., slope)
        intercept = statistics.median(y-slope*x for x, y in zip(xs, ys))
        predictions.append(math.exp(min(700, intercept+slope*math.log(work_size(job, degree)))))
    if len(samples) >= 2:
        xs = [31-j['chart'] for j,_ in samples]
        ys = [math.log(t) for _,t in samples]
        var = sum((x-statistics.mean(xs))**2 for x in xs)
        if var:
            growth = max(0, sum((x-statistics.mean(xs))*(y-statistics.mean(ys))
                               for x,y in zip(xs,ys))/var)
            constant = statistics.median(y-growth*x for x,y in zip(xs,ys))
            predictions.append(math.exp(min(700, constant+growth*(31-job['chart']))))
    # Unmeasured degree jumps/fill-in dominate far extrapolation. This is a
    # scenario band, not a statistically calibrated confidence interval.
    return min(predictions)/3, max(predictions)*max(3., distance**4)


def eta(state, jobs, now=None):
    now = time.time() if now is None else now
    records = [r for r in state.get('jobs', {}).values()
               if r.get('timing_engine_sha256') == state.get('engine_patch_sha256')
               and r.get('comparable_timing', True)]
    pending = [j for j in jobs if str(j['chart']) not in state.get('jobs', {}) or
               state['jobs'][str(j['chart'])]['status'] not in
               COMPLETED]
    if not pending:
        return {'seconds_low': 0, 'seconds_high': 0,
                'method': 'queue_finished_verification_still_required'}
    local = active_bilinear_eta(state, pending)
    if local:
        return local
    lo = hi = 0.
    for job in pending:
        band = predict_job(job, records)
        if band is None:
            return {'seconds_low': None, 'seconds_high': None,
                    'method': 'calibrating_first_nontrivial_completed_chart'}
        a, b = band
        active = state.get('active', {})
        if active.get('chart') == job['chart']:
            elapsed = active.get('previous_seconds', 0) + now-active['started']
            # A surpassed forecast must expand; never stick at "one second".
            if elapsed >= b:
                a, b = elapsed*1.25, elapsed*4
            a, b = max(0, a-elapsed), max(0, b-elapsed)
            rounds = state.get('recent_rounds', [])
            if len(rounds) >= 4:
                current = rounds[-1]
                same = [r for r in rounds[-8:] if r['degree'] == current['degree']]
                if len(same) >= 3:
                    dt = sum(r['round_seconds'] for r in same[1:])
                    drain = same[0]['pending_pairs']-same[-1]['pending_pairs']
                    if drain > 0 and dt > 0:
                        # Measured queue-drain model assumes its net birth rate
                        # persists. It is an additional scenario, not an upper bound.
                        queue_time = current['pending_pairs']*dt/drain
                        b = max(b, queue_time*3)
                    elif current['pending_pairs'] > 0:
                        # Still-growing queues are positive evidence against a
                        # tiny remainder estimate, not a completion percentage.
                        b = max(b, 4*elapsed)
        lo += a
        hi += b
    return {'seconds_low': lo, 'seconds_high': hi,
            'method': 'heuristic_Macaulay_growth_and_measured_queue_drain',
            'scope': 'first-oper projective chart queue only; not all candidates or proof',
            'confidence': 'scenario range; degree jumps can exceed it'}


def duration(t):
    if t < 60:
        return f'{max(1, math.ceil(t))}s'
    if t < 3600:
        return f'{math.ceil(t/60)}min'
    if t < 86400:
        return f'{t/3600:.1f}h'
    if t < 31557600:
        return f'{t/86400:.1f}d'
    if t > 100*31557600:
        return '>100yr'
    return f'{t/31557600:.1f}yr'


def eta_text(state):
    if state.get('status') in ('paused', 'memory_stop', 'failed', 'stopped'):
        return f"ETA: paused ({state.get('reason', state['status'])})."
    if state.get('status') == 'queue_finished' or state.get('eta', {}).get('method') == 'queue_finished_verification_still_required':
        return 'ETA: calculation finished; exact result verification remains.'
    e = state.get('eta', {})
    if e.get('seconds_high') is None:
        return 'ETA: calibrating on the first nontrivial case.'
    if e.get('seconds_point') is not None:
        return f"ETA — current chart only: about {duration(e['seconds_point'])} (model-based)."
    if e['seconds_low'] > 30*86400:
        return 'ETA: over 30 days at current measured scaling (extrapolated).'
    return f"ETA: {duration(e['seconds_low'])}–{duration(e['seconds_high'])} remaining for this queue (heuristic)."


def output_kind(path):
    # Output is only a candidate result until independent verification.
    if not path.exists() or not path.stat().st_size:
        return None
    with path.open() as f:
        header = [f.readline() for _ in range(7)]
        if not header[0].startswith('#Reduced Groebner basis data'):
            return None
        body_start = f.read(100)
        unit = bool(re.match(r'\[\s*1\s*\]', body_start))
    with path.open('rb') as f:
        f.seek(max(0, path.stat().st_size-64))
        if not f.read().rstrip().endswith(b']:'):
            return None
    return 'unit_candidate' if unit else 'nonunit_basis_candidate'


def run(args):
    folder = args.directory.resolve()
    manifest = read_json(folder/'manifest.json')
    if args.chart is None and args.min_chart is None and not manifest.get('all_32_complete'):
        raise ValueError('Full queue requires all32 charts; use --chart for a calibration run')
    jobs = sorted(manifest['jobs'], key=lambda j: -j['chart'])
    if args.chart is not None:
        jobs = [j for j in jobs if j['chart'] == args.chart]
        if not jobs:
            raise ValueError('Chart absent from manifest')
    elif args.min_chart is not None:
        jobs = [j for j in jobs if j['chart'] >= args.min_chart]
        if {j['chart'] for j in jobs} != set(range(args.min_chart, 32)):
            raise ValueError('Requested calibration range is not fully exported')
    lock = (folder/'run.lock').open('a')
    fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    statefile = folder/'run.json'
    state = read_json(statefile, {'jobs': {}})
    hydrate_work_counts(state, folder)
    if state.get('source_sha256') not in (None, manifest['source_sha256']):
        raise ValueError('Saved queue belongs to a different source tensor')
    state.update(status='running', controller_pid=os.getpid(),
                 threads=args.threads, pair_cap=args.pairs,
                 queue_charts=[j['chart'] for j in jobs],
                 source_sha256=manifest['source_sha256'],
                 manifest_sha256=sha(folder/'manifest.json'),
                 engine_patch_sha256=engine_fingerprint(args.engine))
    started = time.time()
    requested = []
    signal.signal(signal.SIGINT, lambda *_: requested.append('user_stop'))
    signal.signal(signal.SIGTERM, lambda *_: requested.append('user_stop'))
    process = None
    try:
        for job in jobs:
            key = str(job['chart'])
            old = state['jobs'].get(key, {})
            if old.get('status') == 'verified_polynomial_certificate':
                certificate_path = Path(old['certificate'])
                certificate = read_json(certificate_path)
                if (sha(certificate_path) != old['certificate_sha256'] or
                    certificate.get('source_sha256') != manifest['source_sha256'] or
                    not certificate.get('identity_sum_original_rows_times_multipliers_equals_one_verified')):
                    raise ValueError('Missing, changed or wrong-source polynomial certificate')
                continue
            if old.get('status') in COMPLETED:
                continue
            if job.get('status') == 'linear_certificate_verified':
                certificate = read_json(folder/job['certificate'])
                if certificate.get('source_sha256') != manifest['source_sha256'] or not certificate.get('constant_combination_identity_verified'):
                    raise ValueError('Wrong source or missing linear certificate')
                state['jobs'][key] = dict(job)
                continue
            source = folder/job['input']
            if sha(source) != job['sha256']:
                raise ValueError('Input hash mismatch')
            sub = folder/f'chart-{job["chart"]:02d}'
            sub.mkdir(exist_ok=True)
            checkpoint = sub/'state.cp'
            resume = args.resume_from or (checkpoint if checkpoint.exists() else None)
            if args.resume_from and args.chart is None:
                raise ValueError('--resume-from requires --chart')
            if resume and old.get('checkpoint_sha256') and resume == checkpoint and old.get('status') != 'running':
                if sha(resume) != old['checkpoint_sha256']:
                    raise ValueError('Checkpoint SHA mismatch; select a validated snapshot explicitly')
            log = sub/f'run-{time.time_ns()}.log'
            output = sub/'basis.gb'
            tele = sub/'rounds.jsonl'
            env = dict(os.environ, MSOLVE_F4_CHECKPOINT=str(checkpoint),
                       MSOLVE_F4_TELEMETRY=str(tele),
                       MSOLVE_F4_GRANULAR=os.environ.get('ATLAS_GRANULAR_LOGGING', '0'),
                       MSOLVE_F4_CHECKPOINT_INTERVAL=str(args.checkpoint_rounds),
                       OMP_NUM_THREADS=str(args.threads))
            if resume:
                env['MSOLVE_F4_RESUME'] = str(resume.resolve())
            cmd = [str(args.engine.resolve()), '-f', str(source), '-o', str(output),
                   '-g', '2', '-l', '2', '-t', str(args.threads), '-m', str(args.pairs),
                   '-c', '0', '-v', '2']
            previous = old.get('seconds', 0)
            jobstart = time.time()
            state['active'] = dict(chart=job['chart'], started=jobstart,
                                   previous_seconds=previous, log=str(log), command=cmd)
            state['jobs'][key] = dict(job, status='running', seconds=previous)
            atomic(statefile, state)
            safe_requested = False
            operation_context=operation_log.context(sub,'f4_encoded')
            input_names=source.open().readline().strip().split(',')
            env['MSOLVE_F4_COEFF_VARIABLES']=','.join(str(input_names.index(n)) for n in operation_context['encoded_coefficient_variables'])
            operation_log.start_run(tele,operation_context,
                engine=str(args.engine.resolve()),resumed=bool(resume),threads=args.threads,
                pair_cap=args.pairs,engine_patch_sha256=state['engine_patch_sha256'])
            with log.open('w') as stream:
                process = subprocess.Popen(cmd, stdout=stream, stderr=subprocess.STDOUT,
                                           env=env, start_new_session=True)
                state['active']['pid'] = process.pid
                while process.poll() is None:
                    now = time.time()
                    events = telemetry(tele)
                    rounds = [x for x in events if x['event'] == 'round']
                    state['recent_rounds'] = rounds[-10:]
                    memory = rss(process.pid)
                    state['active']['rss_bytes'] = memory
                    state['eta'] = eta(state, jobs, now)
                    atomic(statefile, state)
                    reason = (requested[-1] if requested else
                              'time_budget' if now-started >= args.hours*3600 else
                              'memory_budget' if memory > args.rss_gib*1024**3 else None)
                    if reason and not safe_requested:
                        os.kill(process.pid, signal.SIGUSR1)
                        safe_requested = True
                        state['reason'] = reason
                    if memory > (args.rss_gib+1.5)*1024**3:
                        os.killpg(process.pid, signal.SIGKILL)
                        state['reason'] = 'emergency_memory_stop_last_completed_round_retained'
                        break
                    time.sleep(2)
                code = process.wait()
            record = dict(job, seconds=previous+time.time()-jobstart,
                          returncode=code, log=str(log), threads=args.threads,
                          pair_cap=args.pairs,
                          timing_engine_sha256=state['engine_patch_sha256'],
                          comparable_timing=not previous or old.get('timing_engine_sha256') == state['engine_patch_sha256'])
            events = telemetry(tele)
            state['recent_rounds'] = [x for x in events if x['event'] == 'round'][-10:]
            record['matrix_seconds'] = sum(x['round_seconds'] for x in events if x['event'] == 'round')
            record['max_observed_degree'] = telemetry_max_degree(events)
            record['max_basis'] = max((x.get('basis_count',0) for x in events), default=0)
            if checkpoint.exists():
                record.update(checkpoint=str(checkpoint), checkpoint_sha256=sha(checkpoint))
            kind = output_kind(output) if code == 0 else None
            if code == 0 and kind:
                record.update(status='basis_needs_verification', result_kind=kind,
                              basis=str(output), basis_sha256=sha(output))
            elif code == 75:
                record['status'] = 'checkpoint_saved_incomplete'
                state['status'] = 'paused'
            else:
                record['status'] = 'failed_last_checkpoint_retained'
                state.update(status='failed', reason=state.get('reason', f'exit_{code}_or_invalid_output'))
            state['jobs'][key] = record
            state.pop('active', None)
            state['eta'] = eta(state, jobs)
            atomic(statefile, state)
            print(eta_text(state), flush=True)
            if state['status'] != 'running' or requested or time.time()-started >= args.hours*3600:
                if state['status'] == 'running':
                    state.update(status='paused', reason='time_budget_or_user_stop')
                break
        else:
            state['status'] = 'queue_finished'
        atomic(statefile, state)
    except BaseException as error:
        state.update(status='failed', reason=f'{type(error).__name__}: {error}')
        atomic(statefile, state)
        raise
    finally:
        if process is not None and process.poll() is None:
            os.killpg(process.pid, signal.SIGTERM)
            process.wait()
        lock.close()


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('action', choices=('run', 'watch', 'eta', 'stop'))
    p.add_argument('--directory', type=Path, default=DEFAULT)
    p.add_argument('--engine', type=Path, default=ENGINE)
    p.add_argument('--threads', type=int, default=os.cpu_count())
    p.add_argument('--pairs', type=int, default=64)
    p.add_argument('--checkpoint-rounds', type=int, default=5)
    p.add_argument('--hours', type=float, default=2)
    p.add_argument('--rss-gib', type=float, default=8)
    p.add_argument('--chart', type=int)
    p.add_argument('--min-chart', type=int, help='Explicit complete trailing range for calibration')
    p.add_argument('--resume-from', type=Path)
    a = p.parse_args()
    if a.action == 'run':
        run(a)
    elif a.action == 'stop':
        s = read_json(a.directory/'run.json')
        # Resolve identity through the lock before signalling a recorded PID.
        lock = (a.directory/'run.lock').open('a')
        try:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError:
            pid = s['controller_pid']
            command = subprocess.check_output(['ps', '-p', str(pid), '-o', 'command='], text=True)
            if 'atlas_f4.py run' not in command:
                raise RuntimeError('Recorded controller identity no longer matches')
            os.kill(pid, signal.SIGTERM)
        else:
            raise RuntimeError('No active controller holds the lock')
    else:
        try:
            while True:
                s = read_json(a.directory/'run.json', {})
                manifest = read_json(a.directory/'manifest.json', {'jobs': []})
                hydrate_work_counts(s, a.directory)
                if s.get('status') == 'running' and s.get('queue_charts'):
                    queued = [j for j in manifest['jobs'] if j['chart'] in s['queue_charts']]
                    s['eta'] = eta(s, queued)
                text = eta_text(s)
                print(('\r\033[2K' if a.action == 'watch' else '')+text,
                      end='' if a.action == 'watch' else '\n', flush=True)
                if a.action == 'eta' or s.get('status') != 'running':
                    break
                time.sleep(5)
        except KeyboardInterrupt:
            pass
        if a.action == 'watch':
            print()


if __name__ == '__main__':
    main()
