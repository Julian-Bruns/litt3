"""Read-only Fermi work forecast for the live atlas queue (stdlib only).

Units are native-F25-update-equivalents, NOT a count of identical machine
instructions across backends. Native counters are measured; other work is
estimated from elapsed time and calibrated matrix-size proxies. Forecasts
never alter solver state, certify a chart, or prescribe a stopping rule.
"""
import json
import math
from collections import deque
from pathlib import Path
import re
import statistics
import time

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT.parent/'litt3-computation-data'
DONE = {'linear_certificate_verified','verified_polynomial_certificate','basis_needs_verification'}
CERTIFIED = DONE-{'basis_needs_verification'}
RATE = 1.35e9  # measured end-to-end first23/22: 1.30/1.40 billion updates/s
_CACHE = {}
_ROUNDS = {}


def read(path):
    path = Path(path)
    try:
        stat = path.stat()
        identity = (stat.st_mtime_ns,stat.st_size)
        old = _CACHE.get(str(path))
        if old and old[0] == identity:
            return old[1]
        obj = json.loads(path.read_text())
        # Never retain large proof coefficients or tensors in the watcher.
        if isinstance(obj,dict):
            obj = {k:v for k,v in obj.items() if k not in
                   {'polynomial_multipliers','N_tensor','R_tensor','Bc','Iproj','SU_basis','S40_basis'}}
        _CACHE[str(path)] = (identity,obj)
        return obj
    except (FileNotFoundError,json.JSONDecodeError):
        return {}


def tail(path, limit=196608):
    try:
        with Path(path).open('rb') as stream:
            stream.seek(0,2);size=stream.tell();stream.seek(max(0,size-limit))
            lines=stream.read().decode('utf-8',errors='replace').splitlines()
            return lines[1:] if size>limit else lines
    except FileNotFoundError:
        return []


def events(path):
    result=[]
    for line in tail(path):
        try:
            row=json.loads(line)
            if isinstance(row,dict):result.append(row)
        except json.JSONDecodeError:
            pass
    return result


def round_summary(path):
    """Incremental cumulative counters; never reread a growing log per refresh."""
    path=Path(path)
    try:stat=path.stat()
    except FileNotFoundError:return dict(selected=0,recent=[],native_updates=0)
    key=str(path);item=_ROUNDS.get(key)
    if item is None or item['inode']!=stat.st_ino or stat.st_size<item['offset']:
        item=dict(inode=stat.st_ino,offset=0,selected=0,native_updates=0,recent=deque(maxlen=5))
        _ROUNDS[key]=item
    with path.open('rb') as stream:
        stream.seek(item['offset'])
        while True:
            line=stream.readline()
            if not line or not line.endswith(b'\n'):break
            item['offset']=stream.tell()
            try:row=json.loads(line)
            except json.JSONDecodeError:continue
            if row.get('event')=='round':
                item['selected']+=row.get('selected_pairs',0);item['recent'].append(row)
            if row.get('counter_scope')=='interval_actual_work':
                item['native_updates']+=row.get('counts',{}).get('coefficient_updates',0)
    return dict(selected=item['selected'],recent=list(item['recent']),native_updates=item['native_updates'])


def duration(seconds):
    seconds=max(0.,float(seconds))
    if seconds<60:return f'{seconds:.0f}s'
    if seconds<3600:return f'{seconds/60:.1f}min'
    if seconds<86400:return f'{seconds/3600:.1f}h'
    if seconds<365.25*86400:return f'{seconds/86400:.1f} days'
    years=seconds/(365.25*86400)
    return f'{years:,.0f} years' if years>=100 else f'{years:.1f} years'


def number(value):
    return f'{value:.2e}'


def native_budget(chart):
    q=31-chart
    degree=min(5,max(0,math.ceil(32*q/(63-q))-1))
    columns=32*math.comb(q+degree+1,degree+1)+math.comb(q+degree,degree)
    rows=(96-q)*math.comb(q+degree,degree)
    return 49758395881*(columns/41679)**1.982,rows,degree


def f4_budget(chart, field_degree, anchor_seconds=164., anchor_variables=40):
    # Fermi scenario: effective degree6, roughly quadratic elimination in
    # monomial-space size, linear field cost. Extra decade for charts0..7,
    # where the weak bilinear geometry cannot alone exclude the full system.
    variables=64-chart
    columns=math.comb(variables+6,6)
    anchor=math.comb(anchor_variables+6,6)
    return RATE*anchor_seconds*(columns/anchor)**2*field_degree*(10 if chart<8 else 1)


def remaining(target, spent, floor=30*RATE):
    # Overrunning a guess enlarges the budget; it never means completion.
    return target-spent if spent<target else max(floor,spent)


def native_info(directory):
    directory=Path(directory)
    result=read(directory/'result.json')
    progress=read(directory/'state.cp.progress.json')
    info=progress or result
    if result.get('status')=='verified_polynomial_certificate':info=result
    seconds=float(info.get('cumulative_seconds',info.get('native_seconds',0)))
    ops=float(info.get('work_since_invocation_start',{}).get('coefficient_updates',0))
    elapsed=float(info.get('native_seconds',0))
    # Recover all invocation deltas where logs exist. Otherwise use the same
    # cumulative-time conversion on every refresh, so restarting does not
    # replace an old measured rate by a different one and lose apparent work.
    logpath=directory/'operations.jsonl'
    spent=round_summary(logpath)['native_updates'] if logpath.exists() else seconds*RATE
    intervals=[e for e in events(directory/'operations.jsonl')
               if e.get('counts',{}).get('coefficient_updates',0)>0][-8:]
    recent_ops=sum(e['counts']['coefficient_updates'] for e in intervals)
    recent_seconds=sum(e.get('interval_seconds',0) for e in intervals)
    recent_rows=sum(max(0,e.get('processed_end',0)-e.get('processed_start',0)) for e in intervals)
    rate=recent_ops/recent_seconds if recent_seconds>0 else (ops/elapsed if elapsed>0 else RATE)
    row_cost=recent_ops/recent_rows if recent_rows>0 else ops/max(1,info.get('rows_processed',0))
    return dict(info,estimated_ops_spent=spent,measured_ops_this_invocation=ops,
                measured_rate=rate,estimated_ops_per_row=row_cost,
                result_status=result.get('status'),directory=str(directory))


def sparse_export_progress(folder,exported,now):
    """Calibrate the new implementation separately from obsolete timings."""
    session=read(folder/'export_session.json')
    if not session.get('workers'):
        return None
    workers=int(session['workers']); weights={j:(32-j)**1.6 for j in range(32)}
    samples=[]
    for j in exported:
        row=read(folder/f'chart-{j:02d}'/'metadata.json')
        if row.get('sparse_specialization') and row.get('elapsed_seconds',0)>1:
            samples.append(row['elapsed_seconds']/weights[j])
    # A numeric first-batch estimate remains available before any completion.
    rate=statistics.median(samples) if samples else 0.6*max(1,session.get('coefficient_field_degree_F5',2)/2)
    remaining=[]; live=[]; credit=sum(weights[j] for j in exported)
    for j in range(32):
        if j in exported: continue
        target=rate*weights[j]; progress=read(folder/f'chart-{j:02d}'/'export_progress.json')
        if session.get('status')=='running' and j in session.get('charts_requested',[]) and progress:
            elapsed=progress.get('elapsed_seconds',0)+max(0,now-progress.get('updated',now))
            if progress.get('phase')=='complete':
                credit+=weights[j]; remaining.append(0); continue
            credit+=weights[j]*min(.95,elapsed/max(1,target))
            remaining.append(max(5,target-elapsed) if elapsed<target else max(30,.5*elapsed))
            live.append(dict(chart=j,phase=progress.get('phase'),
                units_done=progress.get('units_done',0),units_total=progress.get('units_total',0),
                pid=progress.get('pid')))
        else: remaining.append(target)
    return dict(eta_seconds=max(sum(remaining)/workers,max(remaining,default=0)),
        workers=workers,live_charts=live,estimated_work_percent=100*credit/sum(weights.values()),
        calibrated_sparse_charts=len(samples),method='sparse_phase_and_worker_Fermi_model')


def bounded_parallel_time(memory_charges,workers,memory_bytes,seconds):
    """Deterministic memory-constrained waves; this predicts ATTEMPTS only."""
    pending=list(memory_charges);running=[];clock=0.
    while pending or running:
        while pending and len(running)<workers:
            room=memory_bytes-sum(charge for _,charge in running)
            fitting=next((i for i,charge in enumerate(pending) if charge<=room),None)
            if fitting is None:break
            charge=pending.pop(fitting);running.append((clock+seconds,charge))
        if not running:raise ValueError('A bounded job exceeds the complete memory budget')
        clock=min(end for end,_ in running);running=[x for x in running if x[0]>clock]
    return clock


def native_batch_progress(active,now):
    """Live native phases and sampled aggregate CPU, without process writes."""
    command=active.get('command',[])
    if '--output' not in command:return {}
    folder=Path(command[command.index('--output')+1]);batch=read(folder/'batch.json')
    start=command.index('--charts')+1;requested=[]
    for value in command[start:]:
        if value.startswith('--'):break
        requested.append(int(value))
    limit=float(command[command.index('--seconds')+1])
    age=max(0.,now-batch.get('updated_epoch',now));live=[]
    for chart,job in batch.get('active',{}).items():
        if int(chart) not in requested:continue
        path=folder/f'chart-{int(chart):02d}'/'events.jsonl';rows=events(path);event=rows[-1] if rows else {}
        elapsed=job.get('elapsed_seconds')
        if elapsed is None:
            elapsed=float(event.get('seconds',0))+(max(0.,now-path.stat().st_mtime) if path.exists() else 0)
        else:elapsed+=age
        live.append(dict(chart=int(chart),pid=job['pid'],phase=job['phase'],
            stage=event.get('stage','starting'),elapsed_seconds=elapsed,
            remaining_slice_seconds=max(0.,limit+5-elapsed)))
    telemetry=events(folder/'telemetry.jsonl');sample=telemetry[-1] if telemetry else {}
    terminal={'verified_polynomial_certificate','bounded_native_slice_incomplete','nonunit_basis_candidate',
              'native_solver_error','bounded_native_batch_interrupted'}
    done=sum(batch.get('charts',{}).get(str(c),{}).get('status') in terminal for c in requested)
    return dict(rep=active['rep'],stage='native_original',done=done,total=len(requested),
        unit='bounded chart attempts finished (not exclusions)',live_charts=live,
        sampled_cpu_percent=sample.get('cpu_percent',0),sampled_rss_bytes=sample.get('rss_bytes',0),
        peak_cpu_percent=batch.get('peak_aggregate_cpu_percent',0),
        eta_seconds=max([r['remaining_slice_seconds'] for r in live]+[0.])+
            max(0,len(requested)-done-len(live))*(limit+5)/max(1,len(live)),
        estimated_work_percent=100*done/max(1,len(requested)),
        scope='Only the current bounded batch; a timeout or nonunit candidate is not an exclusion')


def native_sweep_progress(selected,state,active):
    from atlas_native_batch import TERMINAL,indexed_reservation,reservation
    workers=max(1,int(state.get('threads',10)));limit=float(state.get('slice_minutes',5))*60
    command=active.get('command',[])
    memory_gib=float(command[command.index('--rss-gib')+1]) if '--rss-gib' in command else 8.
    memory_bytes=memory_gib*1024**3;remaining_count=attempted=noncert=0;seconds=0.;uncached=[]
    for rid,job in selected.items():
        directory=DATA/'atlas-native-affine'/rid
        if active.get('rep')==rid and active.get('stage')=='native_original_solving' and '--output' in command:
            directory=Path(command[command.index('--output')+1])
        batch=read(directory/'batch.json');records=dict(job.get('native_original_attempts',{}))
        records.update(batch.get('charts',{}))
        folder=Path(job['charts']);manifest=read(folder/'manifest.json');run=read(folder/'run.json')
        calculated={str(r['chart']):r for r in manifest.get('jobs',[])};calculated.update(run.get('jobs',{}))
        pending=[]
        for j in range(31,-1,-1):
            if calculated.get(str(j),{}).get('status') in CERTIFIED:continue
            status=records.get(str(j),{}).get('status')
            if status in TERMINAL:
                attempted+=1;noncert+=int(status!='verified_polynomial_certificate');continue
            pending.append(j)
        remaining_count+=len(pending)
        if not pending:continue
        source=Path(job['tensor']);size=source.stat().st_size if source.exists() else 0
        header=read(source.parent/'native-original-input.json')
        if header:
            degree=header['field_model']['degree_F5']
            if state.get('native_optimizations',{}).get('deck_descended'):
                checked=read(source.parent/'native-deck-grading.json')
                if checked.get('source_sha256')==header.get('source_sha256') and checked.get('all_original_N_and_R_character_identities_verified'):
                    degree=checked['descended_degree_F5']
            charges=[min(memory_bytes,indexed_reservation(j,'solve',degree,size))
                     for j in pending]
        else:
            uncached.append(rid);slots,_=reservation(workers,len(pending),memory_bytes,size)
            charges=[memory_bytes/slots]*len(pending)
        seconds+=bounded_parallel_time(charges,workers,memory_bytes,limit+5)
    return dict(remaining_unfinished_or_unattempted_charts=remaining_count,
        terminal_uncertified_native_attempts=noncert,terminal_native_attempts_not_already_adopted=attempted,
        nominal_attempt_sweep_seconds=seconds,slice_seconds=limit,workers=workers,rss_budget_gib=memory_gib,
        uncached_representatives=uncached,
        scope='Memory-reserved bounded ATTEMPT sweep only, not a whole-run completion ETA; '
              'excludes unmeasured cache preparation and independent replay; held jobs require explicit repair')


def forecast(state, now=None):
    now=time.time() if now is None else now
    selected={rid:job for rid,job in state.get('jobs',{}).items() if not job.get('deferred',False)}
    deferred=[rid for rid,job in state.get('jobs',{}).items() if job.get('deferred',False)]
    active=state.get('active',{})
    active_elapsed=max(0.,now-active.get('started',now))
    # The last completed nontrivial F4 chart provides a distinct F4 anchor.
    first=state.get('jobs',{}).get('orbit_0000',{})
    first_run=read(Path(first.get('charts',DATA/'atlas-rooted-first'))/'run.json')
    anchors=[(int(k),r) for k,r in first_run.get('jobs',{}).items()
             if r.get('status')=='basis_needs_verification' and r.get('seconds',0)>=5]
    anchor_seconds=164.;anchor_variables=40
    if anchors:
        chart,record=min(anchors)
        anchor_seconds=float(record['seconds']);anchor_variables=64-chart
    prep_rates=[]
    for job in selected.values():
        if Path(job['tensor']).exists() and job.get('timings',{}).get('building'):
            prep_rates.append(job['timings']['building'][-1]/max(1,job['degree_F25']))
    prep_base=max(prep_rates,default=30.)
    spent=left=0.;certified=finished=built=0;blocked=[];active_view={};details=[]
    for rid,job in selected.items():
        folder=Path(job['charts']);manifest=read(folder/'manifest.json');run=read(folder/'run.json')
        records={str(r['chart']):r for r in manifest.get('jobs',[])}
        records.update(run.get('jobs',{}))
        field=float(job['degree_F25'])
        # Prefer actual exported field degree, which includes a cubic tower.
        for j in manifest.get('jobs',[])[:1]:
            metadata=read(folder/f'chart-{j["chart"]:02d}'/'metadata.json')
            if metadata.get('field_degree_F5'):field=metadata['field_degree_F5']/2
        if job.get('stage')=='needs_attention':blocked.append(rid)
        tensor_done=Path(job['tensor']).exists();built+=int(tensor_done)
        prior_build=sum(job.get('timings',{}).get('building',[]))
        prior_export=sum(job.get('timings',{}).get('exporting',[]))
        spent+=(prior_build+prior_export)*RATE
        export_weights={j:(32-j)**2 for j in range(32)}
        exported={int(r['chart']) for r in manifest.get('jobs',[])}
        export_done=sum(export_weights[j] for j in exported)
        export_total=sum(export_weights.values())
        export_rate_seconds=max(0.03*field,prior_export/max(1,export_done))
        sparse=sparse_export_progress(folder,exported,now)
        if active.get('rep')==rid and active.get('stage')=='exporting':
            spent+=active_elapsed*RATE
            export_rate_seconds=max(export_rate_seconds,active_elapsed/max(1,export_done))
            eta=export_rate_seconds*(export_total-export_done)
            active_view=dict(rep=rid,stage='exporting',done=len(exported),total=32,
                unit='equation sets written',eta_seconds=eta,
                estimated_work_percent=100*export_done/export_total)
            if sparse: active_view.update(sparse)
        if not manifest.get('all_32_complete'):
            left+=(sparse['eta_seconds'] if sparse else max(1,export_total-export_done)*export_rate_seconds)*RATE
        if not tensor_done:
            build_target=prep_base*field
            if active.get('rep')==rid and active.get('stage')=='building':
                lines=tail(active.get('log','/nonexistent'))
                blocks={int(m.group(1)) for line in lines
                        if (m:=re.search(r'completed direction_(\d+)',line))}
                # Independent directions finish out of order. A largest
                # finished index is NOT a completed-work counter.
                pending_at_launch=None
                for line in lines:
                    try: event=json.loads(line)
                    except json.JSONDecodeError: continue
                    if isinstance(event,dict) and 'directions_pending' in event:
                        pending_at_launch=set(event['directions_pending'])
                block=len(blocks) if pending_at_launch is None else 32-len(pending_at_launch-blocks)
                eta=(active_elapsed/max(1,block))*(32-block) if block else max(30,build_target-active_elapsed)
                if block==32:eta=max(30.,active_elapsed*0.1)
                spent+=active_elapsed*RATE;left+=eta*RATE
                active_view=dict(rep=rid,stage='building',done=block,total=32,
                    unit='input blocks built',eta_seconds=eta,
                    estimated_work_percent=100*block/32)
            else:left+=build_target*RATE
        attempts={}
        for key,entry in job.get('pencil_attempts',{}).items():
            attempts.setdefault(int(key.split(':')[0]),[]).append(Path(entry['directory']))
        active_native=None
        if active.get('rep')==rid and active.get('stage')=='pencil_solving':
            cmd=active['command'];directory=Path(cmd[cmd.index('--output')+1]);j=int(cmd[cmd.index('--chart')+1])
            attempts.setdefault(j,[]).append(directory);active_native=j
        for j in range(32):
            record=records.get(str(j),{})
            done=record.get('status') in DONE
            finished+=int(done);certified+=int(record.get('status') in CERTIFIED)
            directories=set(attempts.get(j,[]))
            if record.get('backend')=='native_F25_predecessor':
                directories.add(Path(record['certificate']).parent)
            natives=[native_info(d) for d in directories]
            native_spent=sum(n.get('estimated_ops_spent',0) for n in natives)
            seconds=float(record.get('seconds',0)) if record.get('backend')!='native_F25_predecessor' else 0.
            chart_spent=native_spent+seconds*RATE
            if active.get('rep')==rid and active.get('stage')=='solving' and run.get('active',{}).get('chart')==j:
                live=run['active'];seconds=live.get('previous_seconds',0)+max(0.,now-live['started'])
                chart_spent=native_spent+seconds*RATE
            spent+=chart_spent
            if done:continue
            nb,rows,degree=native_budget(j)
            full=f4_budget(j,field,anchor_seconds,anchor_variables)
            native_applicable=field==1 and rows<=300000
            bounded_failed=any(n.get('result_status') in ('bounded_ansatz_no_certificate','memory_limit') for n in natives)
            if native_applicable and not bounded_failed:
                rem=remaining(nb,native_spent)
                # A bounded native attempt is not the full system. Reserve a
                # fraction of the full-system budget for a failed attempt.
                rem+=0.1*full
                if natives:
                    latest=max(natives,key=lambda n:n.get('rows_processed',0))
                    to_go=max(0,latest.get('rows_total',rows)-latest.get('rows_processed',0))
                    rem=max(rem,latest['estimated_ops_per_row']*to_go*1.5)
                if active_native==j:
                    info=next((n for n in natives if n.get('directory')==str(directory)),{})
                    rate=info.get('measured_rate',RATE)
                    active_view=dict(rep=rid,stage='native',chart=j,
                        done=info.get('rows_processed',0),total=info.get('rows_total',rows),unit='matrix rows processed',
                        native_threads=info.get('native_threads',1),
                        updates=info.get('measured_ops_this_invocation',0),updates_per_second=rate,
                        eta_seconds=rem/max(1,rate),estimated_work_percent=100*native_spent/max(1,native_spent+rem))
            else:
                rem=remaining(full,seconds*RATE)
                if active.get('rep')==rid and active.get('stage')=='solving' and run.get('active',{}).get('chart')==j:
                    summary=round_summary(folder/f'chart-{j:02d}'/'rounds.jsonl')
                    recent=summary['recent'];e=recent[-1] if recent else {}
                    wall=sum(x.get('round_seconds',0) for x in recent)
                    selected=sum(x.get('selected_pairs',0) for x in recent)
                    pair_eta=e.get('pending_pairs',0)*wall/max(1,selected)*1.5
                    # Pair queues can grow. This is a second rolling estimate,
                    # not permission to treat a drained degree as a solution.
                    rem=max(rem,pair_eta*RATE)
                    active_view=dict(rep=rid,stage='F4',chart=j,done=summary['selected'],
                        pending=e.get('pending_pairs',0),unit='equation pairs processed',
                        round=e.get('round',0),eta_seconds=rem/RATE,
                        estimated_work_percent=100*seconds*RATE/max(1,seconds*RATE+rem))
            left+=rem
            details.append(dict(rep=rid,chart=j,field_degree_F25=field,remaining_update_equivalents=rem))
    status=state.get('status','unknown')
    native_sweep=None
    if any('native_original_attempts' in j for j in selected.values()) or active.get('stage')=='native_original_solving':
        native_sweep=native_sweep_progress(selected,state,active)
    if active.get('stage')=='native_original_solving':active_view=native_batch_progress(active,now)
    if status=='calculation_finished_verification_required':left=0.
    return dict(schema=1,status=status,eta_seconds=left/RATE,
        eta_low_seconds=left/RATE/10,eta_high_seconds=left/RATE*10,
        estimated_updates_done=spent,estimated_updates_total=spent+left,
        estimated_work_percent=100*spent/max(1.,spent+left),charts_finished=finished,
        charts_certified=certified,charts_total=32*len(selected),
        inputs_built=built,representatives=len(selected),active=active_view,
        deferred_representatives=deferred,
        bounded_native_sweep=native_sweep,
        blocked_representatives=blocked,state_age_seconds=max(0.,now-state.get('updated',now)),
        assumptions=dict(native_exponent=1.982,native_reference_rate=RATE,
            F4_effective_degree=6,F4_matrix_exponent=2,field_cost_exponent=1,
            full_frobenius_hard_chart_multiplier=10,uncertainty_factor=10,
            F4_anchor_seconds=anchor_seconds,F4_anchor_variables=anchor_variables,
            unit='native-F25-update-equivalent; mixed measured/modelled work, not machine instructions'),
        remaining_chart_budgets=details)


def render(report):
    eta=duration(report['eta_seconds'])
    label='Selected-run' if report.get('deferred_representatives') else 'Full-run'
    lines=[f"{label} ETA ~{eta} (rough /10 to x10: {duration(report['eta_low_seconds'])}–{duration(report['eta_high_seconds'])})",
           f"Estimated work: {number(report['estimated_updates_done'])} / {number(report['estimated_updates_total'])} update-equivalents ({report['estimated_work_percent']:.3g}%)"]
    a=report['active']
    sweep=report.get('bounded_native_sweep')
    if sweep:
        lines[0]='Legacy F4 fallback scenario: '+lines[0]+'; not calibrated to the new native algorithm.'
        lines.insert(0,f"Bounded native attempt sweep ~{duration(sweep['nominal_attempt_sweep_seconds'])}: "
            f"{sweep['remaining_unfinished_or_unattempted_charts']} remaining; "
            f"{sweep['terminal_uncertified_native_attempts']} bounded attempts have no certificate. "
            'This is NOT a completion forecast; cache preparation/replay are additional.')
    if a:
        prefix=f"Now {a['rep']} / {a['stage']}"+(f" / chart {a['chart']}" if 'chart' in a else '')
        if a['stage']=='F4':
            detail=f"round {a['round']}; {a['done']:,} pairs processed; {a['pending']:,} pending"
        else:detail=f"{a['done']:,}/{a['total']:,} {a['unit']}"
        if 'updates' in a:detail+=f"; this invocation {number(a['updates'])} measured updates, {number(a['updates_per_second'])}/s"
        if 'native_threads' in a:detail+=f"; {a['native_threads']} native workers"
        if a['stage']=='native_original':
            detail+=f"; {len(a['live_charts'])} active workers; sampled {a['sampled_cpu_percent']:.0f}% CPU, "
            detail+=f"{a['sampled_rss_bytes']/1024**3:.2f} GiB RSS"
        lines.append(f"{prefix}: {detail}; stage/chart ETA ~{duration(a['eta_seconds'])}")
        if a['stage']=='native_original' and a['live_charts']:
            lines.append('Live phases: '+', '.join(f"{r['chart']} {r['stage']}" for r in a['live_charts']))
    lines.append(f"Finished: {report['charts_finished']}/{report['charts_total']} chart calculations ({report['charts_certified']} certified); inputs {report['inputs_built']}/{report['representatives']}")
    if report.get('deferred_representatives'):
        lines.append(f"Scope: {report['representatives']} representatives selected; {len(report['deferred_representatives'])} deferred, not excluded mathematically.")
    if report['blocked_representatives']:
        lines.append('Held for errors: '+', '.join(report['blocked_representatives'])+'; ETA assumes repair/resume.')
    if report['status']!='running':lines.append('Run status: '+report['status'])
    elif report['state_age_seconds']>20:lines.append(f"Controller state is {report['state_age_seconds']:.0f}s old; check process status.")
    return '\n'.join(lines)
