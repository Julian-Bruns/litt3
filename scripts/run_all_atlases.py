#!/usr/bin/env python3
"""Selectable exact untwisted atlas queue. Never wakes or launches a Codex agent.

Heavy jobs run serially with all available algebra threads. Timed solver
slices rotate among representatives; failed/resource-limited jobs are held
for diagnosis, never silently skipped as exclusions or retried in a loop.
"""
import argparse
import fcntl
import hashlib
import json
import math
import os
from pathlib import Path
import shutil
import signal
import subprocess
import sys
import time
import textwrap

import atlas_f4 as f4
import atlas_eta

ROOT = Path(__file__).resolve().parents[1]
DEFAULT = ROOT.parent/'litt3-computation-data/atlas-all18'
FIRST = ROOT.parent/'litt3-computation-data/atlas-rooted-first'
CENSUS = ROOT/'Research/computations/oper_representatives_manifest.json'
FILES = ['scripts/run_all_atlases.py', 'scripts/atlas_f4.py',
         'scripts/build_oper_atlas.sage', 'scripts/oper_representatives.sage',
         'scripts/export_rooted_atlas.sage','scripts/mixed_atlas_certificate.sage',
         'scripts/atlas_series.py','scripts/atlas_native_rref.py',
         'scripts/atlas_native_rref.cpp','scripts/atlas_native_directions.py',
         'scripts/atlas_residue_projection.py','scripts/atlas_resources.py',
         'scripts/atlas_complete_directions.py','scripts/atlas_direction_kernel.cpp',
         'scripts/atlas_factored_R_witness.py',
         'scripts/atlas_native_batch.py','scripts/native_original_atlas.sage',
         'scripts/atlas_coefficient_codec.py',
         'scripts/atlas_native_R_checks.py','scripts/atlas_R_check.cpp','scripts/atlas_field_maps.py',
         'scripts/atlas_native_tensor_input.py','scripts/prepare_native_atlas_input.sage',
         'scripts/atlas_native_roots.py','scripts/atlas_frobenius_roots.cpp',
         'scripts/prepare_native_atlas_roots.sage','scripts/atlas_native_recovery.py',
         'scripts/atlas_legacy_native_blocks.py','scripts/pack_legacy_native_direction.sage',
         'scripts/atlas_deck_chart.py','scripts/check_atlas_tensor_grading.py',
         'scripts/atlas_original_chart.py','scripts/atlas_affine_precondition.py',
         'scripts/verify_native_original_atlas.sage']
DONE = f4.COMPLETED
CERTIFIED = {'linear_certificate_verified', 'verified_polynomial_certificate'}


def select_representatives(state, defer=(), resume=()):
    """Persist scheduling choices separately from mathematical job status."""
    defer, resume = set(defer), set(resume)
    unknown = (defer | resume) - state['jobs'].keys()
    if unknown or defer & resume:
        raise ValueError(f'Invalid selection: unknown={sorted(unknown)}, conflicting={sorted(defer & resume)}')
    selected = {rid for rid, job in state['jobs'].items()
                if not job.get('deferred', False)} - defer | resume
    if not selected:
        raise ValueError('At least one representative must remain selected')
    for rid in defer | resume:
        job = state['jobs'][rid]
        job['deferred'] = rid in defer
        job['selection_reason'] = 'user_deferred_for_later' if rid in defer else 'user_resumed'
    state['selected_representatives'] = [rid for rid in state['jobs'] if rid in selected]
    state['deferred_representatives'] = [rid for rid in state['jobs'] if rid not in selected]
    state['selected_geometric_coverage'] = sum(state['jobs'][rid]['geometric_coverage'] for rid in selected)
    state['selected_multiplicity'] = sum(state['jobs'][rid]['scheme_length'] for rid in selected)
    state['scope'] = (f'{len(selected)}/18 untwisted representatives selected; '
                      'deferred cases remain unresolved; not torsion twists or Litt3 proof')


def census():
    data = f4.read_json(CENSUS)
    reps = data['representatives']
    assert len(reps) == len({r['id'] for r in reps}) == 18
    assert sum(r['geometric_coverage'] for r in reps) == 28990
    assert sum(r['scheme_length'] for r in reps) == 29375
    # Include the old checkpoint first, then smaller coefficient fields first.
    return sorted(reps, key=lambda r: (r['id'] != 'orbit_0000', r['degree_F25'], r['id']))


def initialize(folder):
    folder.mkdir(parents=True, exist_ok=True)
    path = folder/'all18.json'
    state = f4.read_json(path)
    identity = f4.sha(CENSUS)
    if state:
        if state['census_sha256'] != identity:
            raise ValueError('Census changed; resolve the saved queue explicitly')
        return state
    reps = census()
    state = dict(schema=1, status='initialized', created=time.time(),
                 census_sha256=identity, representative_count=18,
                 geometric_coverage=28990, total_multiplicity=29375,
                 scope='All18 untwisted representatives, not torsion twists or Litt3 proof',
                 no_agent_wakeup=True, pass_number=0, jobs={})
    for rep in reps:
        rid = rep['id']
        first = rid == 'orbit_0000'
        state['jobs'][rid] = dict(rep, stage='pending', visits=0,
            tensor=str(ROOT/'Research/computations/canonical_atlas_system.json') if first
                   else str(folder/rid/'tensor/canonical_atlas_system.json'),
            charts=str(FIRST) if first else str(folder/rid/'charts'),
            adopted_first_cache=first)
    f4.atomic(path, state)
    return state


def tree_rss(pid):
    rows = subprocess.check_output(['ps', '-axo', 'pid=,ppid=,rss='], text=True)
    entries = [tuple(map(int, line.split())) for line in rows.splitlines() if line.strip()]
    selected = {pid}
    while True:
        grown = selected | {p for p, parent, _ in entries if parent in selected}
        if grown == selected:
            return sum(mem*1024 for p, _, mem in entries if p in selected)
        selected = grown


def chart_progress(job):
    folder = Path(job['charts'])
    manifest = f4.read_json(folder/'manifest.json', {})
    run = f4.read_json(folder/'run.json', {})
    merged = {str(j['chart']): j for j in manifest.get('jobs', [])}
    merged.update(run.get('jobs', {}))
    complete = sum(j.get('status') in DONE for j in merged.values())
    certified = sum(j.get('status') in CERTIFIED for j in merged.values())
    return complete, certified, manifest, run


def adopt_certificate(job, path):
    """Adopt only an original-equation identity for this exact tensor/chart."""
    path = Path(path)
    result = f4.read_json(path)
    if not result or result.get('status') != 'verified_polynomial_certificate':
        return False
    if (result.get('source_sha256') != f4.sha(Path(job['tensor'])) or
        not result.get('identity_sum_original_rows_times_multipliers_equals_one_verified')):
        raise ValueError('Wrong-source or unverified pencil certificate')
    chart = int(result['chart'])
    if not 0 <= chart < 32:
        raise ValueError('Invalid certificate chart')
    backend=result.get('engine','native_F25_predecessor')
    replay=None
    if backend=='native_field_liftstd_original':
        replay=f4.read_json(path.parent/'replay.json',{})
        if not (replay.get('certificate_sha256')==f4.sha(path) and
                replay.get('source_sha256')==result['source_sha256'] and
                replay.get('verified_original_unit_identity') and
                replay.get('search_or_groebner_solver_used') is False):
            return False
    runpath = Path(job['charts'])/'run.json'
    runpath.parent.mkdir(parents=True,exist_ok=True)
    run = f4.read_json(runpath, {})
    record = dict(status='verified_polynomial_certificate', chart=chart,
        source_sha256=result['source_sha256'], certificate=str(path.resolve()),
        certificate_sha256=f4.sha(path), seconds=result['elapsed_seconds'],
        backend=backend, comparable_timing=False,
        independent_replay_verified=bool(replay))
    run.setdefault('jobs', {})[str(chart)] = record
    f4.atomic(runpath, run)
    return True


def full_eta(state):
    return atlas_eta.render(atlas_eta.forecast(state))


class Queue:
    def __init__(self, args):
        self.args = args
        self.folder = args.directory.resolve()
        self.state = initialize(self.folder)
        self.requested = False
        self.child = None

    def save(self):
        self.state['updated'] = time.time()
        f4.atomic(self.folder/'all18.json', self.state)

    def command(self, job, stage, cmd):
        """One subprocess; SIGTERM stops builder at its last saved stage.

        For solver stages its own controller requests the exact F4 round
        checkpoint; do not kill that controller or the F4 child on a timer.
        """
        logdir = self.folder/job['id']/'logs'
        logdir.mkdir(parents=True, exist_ok=True)
        log = logdir/(stage+'-'+str(time.time_ns())+'.log')
        job['stage'] = stage
        job['last_log'] = str(log)
        env = dict(os.environ, OMP_NUM_THREADS=str(self.args.threads),
                   OPENBLAS_NUM_THREADS=str(self.args.threads),
                   SAGE_NUM_THREADS=str(self.args.threads),
                   MKL_NUM_THREADS=str(self.args.threads), PYTHONUNBUFFERED='1',
                   ATLAS_GRANULAR_LOGGING='1' if job['id']=='orbit_0000' else '0')
        start = time.time()
        stopped = False
        problem = None
        self.state['active'] = dict(rep=job['id'], stage=stage, log=str(log),
                                    command=cmd, started=start)
        with log.open('w') as out:
            self.child = subprocess.Popen(cmd, cwd=ROOT, stdout=out,
                stderr=subprocess.STDOUT, env=env, start_new_session=True)
            self.state['active']['pid'] = self.child.pid
            self.save()
            while self.child.poll() is None:
                if self.requested and not stopped:
                    if stage == 'solving':
                        os.kill(self.child.pid, signal.SIGTERM)
                    else:
                        os.killpg(self.child.pid, signal.SIGTERM)
                    stopped = True
                if stage != 'solving':
                    memory = tree_rss(self.child.pid)
                    if memory > self.args.rss_gib*1024**3 and not stopped:
                        problem = 'preparation_memory_limit_last_stage_retained'
                        os.killpg(self.child.pid, signal.SIGTERM)
                        stopped = True
                self.state['active']['elapsed_seconds'] = time.time()-start
                self.save()
                time.sleep(3)
            code = self.child.wait()
        self.child = None
        self.state.pop('active', None)
        job.setdefault('timings', {}).setdefault(stage, []).append(time.time()-start)
        self.save()
        if self.requested:
            job['stage'] = 'paused'
            self.save()
            return False
        if code != 0 or problem:
            job.update(stage='needs_attention', reason=problem or ('exit_'+str(code)))
            self.save()
            return False
        return True

    def prepare(self, job):
        tensor = Path(job['tensor'])
        if not tensor.exists():
            if not self.command(job, 'building', [self.args.sage, str(ROOT/'scripts/build_oper_atlas.sage'),
                    '--rep', job['id'], '--output', str(tensor.parent), '--verify-full',
                    '--workers',str(self.args.threads),'--memory-gib',str(self.args.rss_gib)]):
                return False
        if not tensor.exists():
            job.update(stage='needs_attention', reason='builder_returned_without_tensor')
            self.save()
            return False
        digest = f4.sha(tensor)
        if job.get('tensor_sha256') not in (None, digest):
            job.update(stage='needs_attention', reason='saved_tensor_changed')
            self.save()
            return False
        job['tensor_sha256'] = digest
        folder = Path(job['charts'])
        _, _, manifest, run = chart_progress(job)
        if manifest and manifest.get('source_sha256') != digest:
            job.update(stage='needs_attention', reason='wrong_source_export')
            self.save()
            return False
        # Native coefficient fields avoid introducing field generators as
        # additional polynomial unknowns. Try a bounded batch BEFORE expensive
        # prime-field export. It keeps every original R/normalization row and
        # has no variable-denominator or generic-rank restriction.
        if self.native_batch(job):
            return False  # This visit did useful work; rotate fairly.
        records={str(row['chart']):row for row in manifest.get('jobs',[])}
        records.update(run.get('jobs',{}))
        # Start algebra as soon as a verified chart is ready. Previously one
        # slow last export could block every representative for many hours.
        available=any(records.get(str(row['chart']),{}).get('status') not in DONE
                      for row in manifest.get('jobs',[]))
        if not manifest.get('all_32_complete') and not available:
            if not self.command(job, 'exporting', [self.args.sage, str(ROOT/'scripts/export_rooted_atlas.sage'),
                    '--tensor', str(tensor), '--output', str(folder),
                    '--workers',str(self.args.threads),'--memory-gib',str(self.args.rss_gib),
                    '--max-charts',str(getattr(self.args,'export_batch',10))]):
                return False
            manifest = f4.read_json(folder/'manifest.json', {})
        if not manifest.get('jobs') or manifest.get('source_sha256') != digest:
            job.update(stage='needs_attention', reason='incomplete_or_wrong_source_export')
            self.save()
            return False
        indices=[j['chart'] for j in manifest['jobs']]
        assert len(indices)==len(set(indices)) and set(indices)<=set(range(32))
        assert not manifest.get('all_32_complete') or set(indices)==set(range(32))
        job['exported_charts']=len(indices)
        job['stage'] = 'ready'
        self.save()
        return True

    def native_batch(self,job):
        if not getattr(self.args,'native_batch',0):return False
        from atlas_native_batch import TERMINAL
        directory=ROOT.parent/'litt3-computation-data/atlas-native-affine'/job['id']
        paths=[directory]
        if job['id']=='invariant_2':
            paths.append(ROOT.parent/'litt3-computation-data/orbit11-structure/native-batch-invariant2-test')
        for base in paths:
            for path in sorted(base.glob('chart-*/result.json')):
                adopt_certificate(job,path)
        _,certified,manifest,run=chart_progress(job)
        job['constant_certified_charts']=certified
        if certified==32:
            job.update(stage='calculation_finished_verification_required',calculated_charts=32)
            self.save();return True
        records={str(row['chart']):row for row in manifest.get('jobs',[])}
        records.update(run.get('jobs',{}))
        terminal={}
        for base in paths:
            batch=f4.read_json(base/'batch.json',{})
            if batch and batch.get('source_sha256')!=job['tensor_sha256']:
                raise ValueError('Native batch tensor source changed')
            terminal.update(batch.get('charts',{}))
        attempts=job.setdefault('native_original_attempts',{})
        candidates=[]
        for chart in range(31,-1,-1):
            key=str(chart)
            if records.get(key,{}).get('status') in CERTIFIED:continue
            record=terminal.get(key,{})
            if record.get('status') in TERMINAL:
                attempts[key]=record;continue
            result=f4.read_json(directory/f'chart-{chart:02d}'/'result.json',{})
            if result.get('status') in TERMINAL and result.get('status')!='verified_polynomial_certificate':
                attempts[key]=dict(status=result['status'],directory=str(directory/f'chart-{chart:02d}'))
                continue
            if attempts.get(key,{}).get('status') in TERMINAL:continue
            candidates.append(chart)
        if not candidates:
            self.save();return False
        selected=candidates[:self.args.native_batch]
        cmd=[sys.executable,str(ROOT/'scripts/atlas_native_batch.py'),
            '--tensor',job['tensor'],'--output',str(directory),'--charts',*map(str,selected),
            '--workers',str(self.args.threads),'--seconds',str(self.args.slice_minutes*60),
            '--rss-gib',str(self.args.rss_gib),'--sage',self.args.sage]
        for name in ['legacy_native_cache','deck_descended','native_term_cache']:
            if getattr(self.args,name,False):cmd.append('--'+name.replace('_','-'))
        if not self.command(job,'native_original_solving',cmd):return True
        batch=f4.read_json(directory/'batch.json',{})
        if batch.get('source_sha256')!=job['tensor_sha256']:
            job.update(stage='needs_attention',reason='native_batch_missing_or_wrong_source')
            self.save();return True
        for chart in selected:
            record=batch.get('charts',{}).get(str(chart),{})
            attempts[str(chart)]=record
            adopt_certificate(job,directory/f'chart-{chart:02d}'/'result.json')
        done,certified,_,_=chart_progress(job)
        job.update(stage='ready',calculated_charts=done,constant_certified_charts=certified,
            native_original_backend='exact_affine_then_native_field_liftstd_with_independent_replay')
        self.save();return True

    def solve(self, job):
        # Completed laboratory identities become production certificates;
        # never rerun an excluded chart or equate a bounded failure with one.
        if job['id'] == 'orbit_0000':
            for path in (ROOT.parent/'litt3-computation-data/atlas-predecessor-b4/chart-23/result.json',
                         ROOT.parent/'litt3-computation-data/atlas-predecessor-b5/chart-22/result.json'):
                adopt_certificate(job, path)
        if self.pencil(job):
            return
        done, certified, manifest, run = chart_progress(job)
        if done == 32:
            job.update(stage='calculation_finished_verification_required', calculated_charts=done,
                       constant_certified_charts=certified)
            self.save()
            return
        cmd = [sys.executable, str(ROOT/'scripts/atlas_f4.py'), 'run',
            '--directory', job['charts'], '--engine', str(self.args.engine),
            '--threads', str(self.args.threads), '--pairs', str(self.args.pairs),
            '--hours', str(self.args.slice_minutes/60), '--rss-gib', str(self.args.rss_gib),
            '--checkpoint-rounds', str(self.args.checkpoint_rounds)]
        if not manifest.get('all_32_complete'):
            records={str(row['chart']):row for row in manifest.get('jobs',[])}
            records.update(run.get('jobs',{}))
            pending=[row['chart'] for row in manifest.get('jobs',[])
                     if records.get(str(row['chart']),{}).get('status') not in DONE]
            if not pending:
                job['stage']='ready' # Next visit exports the next missing batch.
                self.save()
                return
            cmd.extend(['--chart',str(max(pending))])
        if not self.command(job, 'solving', cmd):
            return
        done, certified, _, result = chart_progress(job)
        job.update(calculated_charts=done, constant_certified_charts=certified)
        if done == 32:
            job['stage'] = 'calculation_finished_verification_required'
        elif result.get('status')=='queue_finished':
            job['stage']='ready' # A partial chart queue is not the full atlas.
        elif result.get('status') == 'paused' and result.get('reason') in (
                'time_budget', 'time_budget_or_user_stop'):
            job['stage'] = 'ready'
        else:
            job.update(stage='needs_attention', reason=result.get('reason',
                       'unexpected_solver_status_'+str(result.get('status'))))
        self.save()

    def pencil(self, job):
        """Use exact reusable linear-in-v elimination where implemented.

        Other fields and expensive multiplier spaces retain the exact F4
        backend. A failed bounded ansatz never excludes the full chart.
        """
        tensor = f4.read_json(Path(job['tensor']))
        desc = tensor.get('field_description') or dict(kind='finite_field',degree=2,characteristic=5)
        if not (desc.get('kind')=='finite_field' and desc.get('degree')==2 and
                desc.get('characteristic')==5):
            job['pencil_backend'] = 'not_implemented_for_this_field_F4_fallback'
            self.save()
            return False
        job['pencil_backend'] = 'native_F25_predecessor'
        done, _, manifest, run = chart_progress(job)
        if done == 32:
            return False
        exported = {str(j['chart']):j for j in manifest['jobs']}
        records = dict(exported); records.update(run.get('jobs', {}))
        attempts = job.setdefault('pencil_attempts', {})
        for chart in range(31,-1,-1):
            if str(chart) not in exported:
                continue # Incremental export never authorizes an absent chart.
            if records.get(str(chart), {}).get('status') in DONE:
                continue
            q = 31-chart
            degree = min(5,max(0,math.ceil(32*q/(63-q))-1))
            rows = (96-q)*math.comb(q+degree,degree)
            if rows > 300000:
                return False
            directory = self.folder/job['id']/'pencil'/f'chart-{chart:02d}-b{degree}'
            if job['id']=='orbit_0000' and chart==22 and degree==5:
                directory = ROOT.parent/'litt3-computation-data/atlas-predecessor-b5/chart-22'
            key = f'{chart}:{degree}'
            result = f4.read_json(directory/'result.json', {})
            if adopt_certificate(job, directory/'result.json'):
                attempts[key] = dict(status='verified_polynomial_certificate',directory=str(directory))
                continue
            if result.get('status') == 'bounded_ansatz_no_certificate' or attempts.get(key,{}).get('status') in (
                    'bounded_ansatz_no_certificate','memory_limit','pencil_failed'):
                return False
            cmd = [self.args.sage,str(ROOT/'scripts/mixed_atlas_certificate.sage'),
                '--tensor',job['tensor'],'--atlas-input',job['charts'],'--representative',job['id'],
                '--chart',str(chart),'--output',str(directory),
                '--v-degree','0','--b-degree',str(degree),'--predecessor-reuse',
                '--seconds',str(self.args.slice_minutes*60),
                '--memory-gib',str(min(6.,self.args.rss_gib)), '--checkpoint-seconds','60']
            cmd.extend(['--threads',str(self.args.threads)])
            if job['id']!='orbit_0000':
                cmd.append('--no-interval-log')
            if not self.command(job,'pencil_solving',cmd):
                if self.requested:
                    # A user pause preserves the last completed-row checkpoint;
                    # it is not failure of this bounded mathematical ansatz.
                    self.save()
                    return True
                attempts[key]=dict(status='pencil_failed',directory=str(directory),reason=job.get('reason'))
                return True
            result=f4.read_json(directory/'result.json', {})
            attempts[key]=dict(status=result.get('status','missing_result'),directory=str(directory))
            if adopt_certificate(job,directory/'result.json'):
                job['stage']='ready'
            elif result.get('status') in ('time_limit','row_limit'):
                job['stage']='ready'
            elif result.get('status') in ('bounded_ansatz_no_certificate','memory_limit'):
                job['stage']='ready'  # next visit uses full F4, preserving all equations
            else:
                job.update(stage='needs_attention',reason='pencil_'+result.get('status','missing_result'))
            self.save()
            return True
        return False

    def run(self):
        lock = (self.folder/'all18.lock').open('a')
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        select_representatives(self.state, getattr(self.args, 'defer', ()),
                               getattr(self.args, 'resume_representatives', ()))
        if getattr(self.args,'recover_legacy_packing',False):
            from atlas_native_recovery import recover_verified_packing
            recover_verified_packing(self.state,ROOT.parent/'litt3-computation-data/orbit11-structure/legacy-six-held-packing-verification.json')
        if getattr(self.args,'deck_descended',False):
            # These two completed original-coordinate identities were
            # independently replayed BEFORE deployment. No search is rerun.
            job=self.state['jobs'].get('orbit_0007')
            if job and not job.get('deferred'):
                for chart in [31,30]:
                    path=ROOT.parent/('litt3-computation-data/orbit11-structure/descended-native-orbit7-chart%d/result.json'%chart)
                    if path.exists():adopt_certificate(job,path)
        if getattr(self.args,'recover_native_cleanup',False):
            from atlas_native_recovery import recover_cleanup,APPROVED_CLEANUP_FAILURES
            for rep in APPROVED_CLEANUP_FAILURES:
                job=self.state['jobs'][rep]
                if not job.get('deferred',False):
                    recover_cleanup(job,ROOT.parent/'litt3-computation-data/atlas-native-affine'/rep,
                                    adopt_certificate)
        if getattr(self.args,'resume_unstarted_native',False):
            from atlas_native_recovery import resume_unstarted_user_stop
            for rep,job in self.state['jobs'].items():
                if not job.get('deferred',False):
                    resume_unstarted_user_stop(job,ROOT.parent/'litt3-computation-data/atlas-native-affine'/rep,
                                              f4.atomic)
        if getattr(self.args,'recover_invariant2_telemetry',False):
            job=self.state['jobs']['invariant_2']
            expected='8c0bb4081bd8ce45e626c197b9fbd586a868c077e434d74eb14267a458761fd5'
            if job['stage']=='needs_attention':
                log=Path(job['last_log']);body=log.read_text()
                if not (job.get('reason')=='exit_1' and log.name=='solving-1788789910184644000.log' and
                        "KeyError: 'degree'" in body and "x['degree'] for x in events" in body and
                        f4.sha(Path(job['tensor']))==expected and
                        'telemetry_max_degree(events)' in (ROOT/'scripts/atlas_f4.py').read_text()):
                    raise ValueError('Not the explicitly authorized invariant2 reporting failure')
                certificate=ROOT.parent/'litt3-computation-data/orbit11-structure/native-batch-invariant2-test/chart-30/result.json'
                if not adopt_certificate(job,certificate):
                    raise ValueError('Invariant2 chart30 lacks its fresh original-row replay')
                runpath=Path(job['charts'])/'run.json';old=f4.read_json(runpath)
                if old.get('reason')!="KeyError: 'degree'":
                    raise ValueError('Saved F4 controller does not match the reporting error')
                old.setdefault('recovery_history',[]).append(dict(time=time.time(),
                    reason=old['reason'],active=old.get('active'),log_sha256=f4.sha(log)))
                old.pop('active',None);old.pop('reason',None);old['status']='paused'
                f4.atomic(runpath,old)
                job.setdefault('restart_history',[]).append(dict(time=time.time(),
                    reason='exact_invariant2_telemetry_degree_repair',log=str(log),log_sha256=f4.sha(log),
                    original_chart30_certificate=str(certificate),certificate_sha256=f4.sha(certificate)))
                job.update(stage='paused');job.pop('reason',None)
        # Finished chart calculations need no more solver time. This is not
        # a claim that unverified bases certify a whole representative.
        for job in self.state['jobs'].values():
            if job.get('deferred', False):
                continue
            done, certified, _, _ = chart_progress(job)
            if done == 32:
                job.update(stage='calculation_finished_verification_required',
                           calculated_charts=done, constant_certified_charts=certified)
        if getattr(self.args,'retry_interrupted',False):
            allowed={'user_stop','user_stop_checkpoints_retained','exit_143',
                     'exit_-15_or_invalid_output'}
            for job in self.state['jobs'].values():
                if job['stage']=='needs_attention' and job.get('reason') in allowed:
                    job.setdefault('restart_history',[]).append(dict(time=time.time(),reason=job['reason']))
                    job.update(stage='paused')
                    job.pop('reason',None)
        if getattr(self.args,'restart_schedule',False):
            for job in self.state['jobs'].values():
                job['visits']=0
        self.state.update(status='running', controller_pid=os.getpid(),
                          algorithm='complete_native_directions_affine_native_batches_F4_fallback',
                          threads=self.args.threads, slice_minutes=self.args.slice_minutes,
                          code_sha256={p:f4.sha(ROOT/p) for p in FILES})
        self.state['native_optimizations']={name:bool(getattr(self.args,name,False)) for name in
            ['legacy_native_cache','deck_descended','native_term_cache']}
        signal.signal(signal.SIGTERM, lambda *_: setattr(self, 'requested', True))
        signal.signal(signal.SIGINT, lambda *_: setattr(self, 'requested', True))
        self.save()
        try:
            while not self.requested:
                selected = [j for j in self.state['jobs'].values() if not j.get('deferred', False)]
                pending = [j for j in selected if j['stage'] not in
                           ('needs_attention', 'calculation_finished_verification_required')]
                if not pending:
                    blocked = [j['id'] for j in selected if j['stage']=='needs_attention']
                    self.state.update(status='needs_attention' if blocked else
                        'calculation_finished_verification_required',
                        reason='; '.join(blocked) if blocked else 'independent proof verification remains')
                    break
                self.state['pass_number'] += 1
                # Least-visited representative first: restarting preserves fairness.
                pending.sort(key=lambda j: (j['visits'], j['degree_F25'], j['id']!='orbit_0000', j['id']))
                for job in pending:
                    if self.requested:
                        break
                    if shutil.disk_usage(self.folder).free < self.args.min_free_gib*1024**3:
                        self.state.update(status='needs_attention', reason='low_disk_space_checkpoints_retained')
                        self.save()
                        return
                    job['visits'] += 1
                    self.save()
                    if self.prepare(job):
                        self.solve(job)
            if self.requested:
                self.state.update(status='stopped', reason='user_stop_checkpoints_retained')
            self.save()
        except BaseException as error:
            self.state.update(status='failed', reason=f'{type(error).__name__}: {error}')
            self.save()
            raise
        finally:
            lock.close()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=('run', 'launch', 'eta', 'eta-json', 'watch', 'stop', 'status'))
    parser.add_argument('--directory', type=Path, default=DEFAULT)
    parser.add_argument('--engine', type=Path, default=f4.ENGINE)
    parser.add_argument('--sage', default=shutil.which('sage') or 'sage')
    parser.add_argument('--threads', type=int, default=os.cpu_count())
    parser.add_argument('--pairs', type=int, default=1024)
    parser.add_argument('--slice-minutes', type=float, default=30)
    parser.add_argument('--rss-gib', type=float, default=8)
    parser.add_argument('--min-free-gib', type=float, default=12)
    parser.add_argument('--checkpoint-rounds', type=int, default=5)
    parser.add_argument('--export-batch',type=int,default=10,
                        help='Maximum missing charts exported before returning to algebra')
    parser.add_argument('--native-batch',type=int,default=10,
                        help='One bounded native-field attempt per chart before F4; 0 disables this stage')
    parser.add_argument('--legacy-native-cache',action='store_true',help='Opt-in verified packing of retained legacy directions')
    parser.add_argument('--deck-descended',action='store_true',help='Use all-coefficient-checked cubic descent where applicable')
    parser.add_argument('--native-term-cache',action='store_true',help='Reuse exact low-row native coefficient dictionaries')
    parser.add_argument('--recover-legacy-packing',action='store_true',help='Only the six approved hash-bound metadata packing failures')
    parser.add_argument('--retry-interrupted',action='store_true',
                        help='Once at launch, requeue explicitly signal-interrupted jobs, not algebra/resource failures')
    parser.add_argument('--recover-invariant2-telemetry',action='store_true',
                        help='Explicitly authorized exact log/source/chart30-identity guarded reporting repair')
    parser.add_argument('--recover-native-cleanup',action='store_true',
                        help='Only the two approved orbit2/6 cleanup logs, with original97-row replays')
    parser.add_argument('--resume-unstarted-native',action='store_true',
                        help='Resume archived explicit user stops before any native search/input artifact')
    parser.add_argument('--restart-schedule',action='store_true',
                        help='Restart scheduling visits without discarding mathematical checkpoints')
    parser.add_argument('--defer', nargs='+', default=[], metavar='REP',
                        help='Persistently omit these representatives from scheduling and ETA, retaining all files')
    parser.add_argument('--resume-representatives', nargs='+', default=[], metavar='REP',
                        help='Restore previously deferred representatives to the selected queue')
    args = parser.parse_args()
    if args.threads<1 or args.export_batch<1 or args.native_batch<0 or args.rss_gib<=0:
        parser.error('threads, export-batch and rss-gib must be positive')
    if args.action == 'run':
        Queue(args).run()
    elif args.action == 'launch':
        state = initialize(args.directory)
        # Validate before spawning; the controller persists under its lock.
        select_representatives(state, args.defer, args.resume_representatives)
        # A duplicate launch must not overwrite a live queue's status.
        with (args.directory/'all18.lock').open('a') as lock:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        with (args.directory/'controller.log').open('a') as log:
            cmd = [sys.executable, str(Path(__file__).resolve()), 'run']+sys.argv[2:]
            child = subprocess.Popen(cmd, cwd=ROOT, stdin=subprocess.DEVNULL,
                stdout=log, stderr=subprocess.STDOUT, start_new_session=True)
        print(f'Atlas controller launched for {len(state["selected_representatives"])}/18 representatives, PID', child.pid, flush=True)
    elif args.action == 'stop':
        state = f4.read_json(args.directory/'all18.json')
        lock = (args.directory/'all18.lock').open('a')
        try:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError:
            pid = state['controller_pid']
            command = subprocess.check_output(['ps','-p',str(pid),'-o','command='], text=True)
            if 'run_all_atlases.py run' not in command:
                raise RuntimeError('Controller identity no longer matches')
            os.kill(pid, signal.SIGTERM)
            print('Safe stop requested; the active solver finishes its round and checkpoints.')
        else:
            raise RuntimeError('No live all18 controller')
    else:
        previous_lines=0
        try:
            while True:
                state = f4.read_json(args.directory/'all18.json')
                if args.action == 'status':
                    print(json.dumps(dict(status=state['status'], active=state.get('active'),
                        selected_representatives=state.get('selected_representatives', list(state['jobs'])),
                        deferred_representatives=state.get('deferred_representatives', []),
                        representatives={k:v['stage'] for k,v in state['jobs'].items()}), indent=2))
                    break
                report=atlas_eta.forecast(state)
                if args.action=='eta-json':
                    print(json.dumps(report,indent=2));break
                panel=atlas_eta.render(report)
                if args.action=='watch' and sys.stdout.isatty():
                    width=max(20,shutil.get_terminal_size((100,24)).columns-1)
                    panel='\n'.join(part for line in panel.splitlines()
                                    for part in (textwrap.wrap(line,width=width) or ['']))
                if args.action=='watch' and sys.stdout.isatty() and previous_lines:
                    print(f'\033[{previous_lines}F\033[J',end='')
                print(panel,flush=True)
                previous_lines=panel.count('\n')+1
                if args.action=='eta' or state['status']!='running':
                    break
                time.sleep(2)
        except KeyboardInterrupt:
            pass
        if args.action == 'watch':
            print()


if __name__ == '__main__':
    main()
