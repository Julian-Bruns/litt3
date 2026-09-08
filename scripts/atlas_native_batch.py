#!/usr/bin/env python3
"""Bounded parallel native-coefficient searches; never retries a failed slice.

Each verified unit is replayed in a FRESH Sage process without a solver.
All chart directories and interrupted inputs persist. This queue does not
write the production run.json or all18.json; only their owning controller
may adopt completed, source-bound certificates.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import signal
import subprocess
import time
from atlas_native_tensor_input import sha,cache_path

ROOT=Path(__file__).resolve().parents[1]
TERMINAL={'verified_polynomial_certificate','bounded_native_slice_incomplete',
          'nonunit_basis_candidate','native_solver_error','bounded_native_batch_interrupted'}


def read(path,default=None):return json.loads(Path(path).read_text()) if Path(path).exists() else default
def atomic(path,value):
    temporary=Path(str(path)+'.tmp')
    temporary.write_text(json.dumps(value,indent=2)+'\n');temporary.replace(path)


def reservation(workers,count,memory_bytes,source_bytes):
    estimate=max(600*1024**2,350*1024**2+2*source_bytes)
    return max(1,min(workers,count,int(memory_bytes)//estimate)),estimate


def indexed_reservation(chart,phase,degree,source_bytes):
    if phase=='replay':
        # The verifier deliberately reads ORIGINAL JSON, never this cache.
        # Actual degree1320 JSON parsing exceeded1.5GiB despite a434MB
        # source. Reserve the measured expansion plus this chart's terms.
        return max(600*1024**2,350*1024**2+4*source_bytes+3072*(32-chart)*degree*8)
    # Three dense coefficient copies plus bounded Sage/field overhead.
    # Reserve per actual chart width; using the widest job for EVERY slot
    # needlessly suppressed ten-core use on the easy prefix.
    return max(512*1024**2,200*1024**2+3*3072*(32-chart)*degree*8)


def process_table():
    raw=subprocess.check_output(['ps','-axo','pid=,ppid=,pgid=,rss=,pcpu='],text=True)
    return [(int(p),int(pp),int(pg),int(rss)*1024,float(cpu))
            for p,pp,pg,rss,cpu in (line.split() for line in raw.splitlines() if line.strip())]


def descendants(rows,pid):
    # A terminated shell wrapper can leave its Sage child reparented to1.
    # Every job starts a NEW session; include that exact process group.
    selected={pid}|{p for p,_,pg,_,_ in rows if pg==pid}
    while True:
        grown=selected|{p for p,pp,_,_,_ in rows if pp in selected}
        if grown==selected:return selected
        selected=grown


def live_group_members(pgid,skipped=None):
    """Resolve ONLY a job's own new-session group before signalling PIDs.

    In particular, never call killpg on an empty/reaped group. macOS can
    return EPERM there, and waiting only for the wrapper misses descendants
    whose SIGTERM handler merely records a checkpoint-stop request.
    """
    assert pgid>1 and pgid!=os.getpgrp()
    raw=subprocess.check_output(['ps','-axo','pid=,pgid=,uid=,stat='],text=True)
    selected=[]
    for line in raw.splitlines():
        if not line.strip():continue
        p,pg,uid,status=line.split()
        if int(pg)==pgid and not status.startswith('Z'):
            if int(uid)!=os.getuid():
                # A foreign UID in a dying/reused group is NOT an owned
                # worker and must never be
                # signalled; neither may it prevent cleanup of owned PIDs.
                if skipped is not None:
                    record=dict(pid=int(p),pgid=int(pg),uid=int(uid),status=status)
                    if record not in skipped:skipped.append(record)
                continue
            selected.append(int(p))
    return selected


def stop(job,grace=3):
    proc=job['proc'];pgid=proc.pid
    skipped=job.setdefault('foreign_uid_members_not_signalled',[])
    for sig,seconds in [(signal.SIGTERM,grace),(signal.SIGKILL,3)]:
        deadline=time.monotonic()+seconds;signalled=set()
        while True:
            members=live_group_members(pgid,skipped)
            if not members:
                proc.poll()
                return
            for pid in members:
                if pid in signalled:continue
                try:os.kill(pid,sig)
                except ProcessLookupError:pass
                except PermissionError:
                    # Never swallow a genuine denial on a live owned PID.
                    if pid in live_group_members(pgid):raise
                signalled.add(pid)
            proc.poll()
            if time.monotonic()>=deadline:break
            time.sleep(.05)
    raise RuntimeError('Owned workers survived SIGKILL: '+str(live_group_members(pgid)))


def cleanup(active):
    """Try EVERY owned group even when one cleanup reports an error."""
    failures=[]
    for chart,job in active.items():
        try:stop(job)
        except BaseException as error:
            failures.append(dict(chart=chart,pid=job['proc'].pid,
                                 error=type(error).__name__+': '+str(error)))
        finally:job['log'].close()
    return failures


def run(args):
    folder=args.output.resolve();folder.mkdir(parents=True,exist_ok=True)
    source=args.tensor.resolve();digest=sha(source)
    charts=list(dict.fromkeys(args.charts));assert charts and all(0<=c<32 for c in charts)
    marker=folder/'batch.json';state=read(marker,{})
    assert not state or state['source_sha256']==digest
    records=state.get('charts',{});pending=[]
    for chart in charts:
        directory=folder/f'chart-{chart:02d}'
        result=read(directory/'result.json',{})
        record=records.get(str(chart),{})
        if result:
            assert result['source_sha256']==digest and result['chart']==chart
        if result.get('status')=='verified_polynomial_certificate':
            replay=read(directory/'replay.json',{})
            if replay.get('certificate_sha256')==sha(directory/'result.json') and replay.get('verified_original_unit_identity'):
                records[str(chart)]=dict(status=result['status'],directory=str(directory),
                    certificate_sha256=sha(directory/'result.json'),independent_replay_verified=True)
            else:pending.append((chart,'replay'))
        elif result.get('status') in TERMINAL or record.get('status') in TERMINAL:
            records[str(chart)]=dict(status=result.get('status',record.get('status')),
                directory=str(directory),reason=result.get('reason',record.get('reason')))
        else:pending.append((chart,'solve'))
    prepared=None
    bindings=source.parent/'complete_native'
    if getattr(args,'legacy_native_cache',False) and any(phase=='solve' for _,phase in pending) and (source.parent/'oper.sobj').exists() and all(
            (source.parent/('direction_%02d.sobj'%i)).exists() for i in range(32)) and not all(
            (bindings/('binding-%02d.json'%i)).exists() for i in range(32)):
        subprocess.run([__import__('sys').executable,str(ROOT/'scripts/atlas_legacy_native_blocks.py'),
                        '--folder',str(source.parent),'--workers',str(min(10,args.workers)),
                        '--sage',args.sage],cwd=ROOT,check=True)
    if any(phase=='solve' for _,phase in pending) and all(
            (bindings/('binding-%02d.json'%i)).exists() for i in range(32)):
        subprocess.run([args.sage,str(ROOT/'scripts/prepare_native_atlas_input.sage'),
                        '--tensor',str(source)],cwd=ROOT,check=True)
        subprocess.run([args.sage,str(ROOT/'scripts/prepare_native_atlas_roots.sage'),
                        '--tensor',str(source),'--workers',str(min(10,args.workers))],cwd=ROOT,check=True)
    if cache_path(source).exists():
        prepared=read(cache_path(source));assert prepared['source_sha256']==digest
    deck_path=None
    if getattr(args,'deck_descended',False) and prepared and prepared.get('all_native_fifth_roots_verified'):
        from check_atlas_tensor_grading import grading,GradingUnavailable
        candidate=source.parent/'native-deck-grading.json'
        if candidate.exists():
            checked=read(candidate);assert checked['source_sha256']==digest
            assert checked['all_original_N_and_R_character_identities_verified'];deck_path=candidate
        else:
            try:checked=grading(source)
            except GradingUnavailable as error:
                print(json.dumps(dict(diagonal_deck_descent_applicable=False,reason=str(error),
                    original_equations_used_unchanged=True)),flush=True)
            else:atomic(candidate,checked);deck_path=candidate
    workers,estimate=reservation(args.workers,max(1,len(pending)),args.rss_gib*1024**3,source.stat().st_size)
    if prepared:workers=max(1,min(args.workers,len(pending)))
    def job_memory(chart,phase):
        if prepared:return min(int(args.rss_gib*1024**3),indexed_reservation(
            chart,phase,int(prepared['field_model']['degree_F5'])//(3 if deck_path and phase=='solve' else 1),
            source.stat().st_size))
        return int(args.rss_gib*1024**3/workers)
    history=state.get('visits',[])
    if state:
        history=history+[dict(status=state.get('status'),seconds=state.get('seconds'),
            workers=state.get('workers'),peak_aggregate_cpu_percent=state.get('peak_aggregate_cpu_percent'),
            peak_aggregate_rss_bytes=state.get('peak_aggregate_rss_bytes'))]
    started=time.monotonic();started_epoch=time.time();active={};requested=[];next_event=0;peak_cpu=0;peak_rss=0
    signal.signal(signal.SIGTERM,lambda *_:requested.append(True))
    signal.signal(signal.SIGINT,lambda *_:requested.append(True))
    def save(status):
        atomic(marker,dict(schema=1,source_sha256=digest,tensor=str(source),status=status,
            charts=records,workers=workers,requested_workers=args.workers,visits=history,
            requested_charts=charts,started_epoch=started_epoch,updated_epoch=time.time(),
            estimated_worker_rss_bytes=estimate,seconds=time.monotonic()-started,
            indexed_native_input=bool(prepared),
            checked_cubic_descent=bool(deck_path),deck_grading_path=str(deck_path) if deck_path else None,
            native_term_cache=bool(getattr(args,'native_term_cache',False)),
            active={str(c):dict(pid=v['proc'].pid,phase=v['phase'],reserved_rss_bytes=v['reserved'],
                elapsed_seconds=time.monotonic()-v['started']) for c,v in active.items()},
            peak_aggregate_cpu_percent=peak_cpu,peak_aggregate_rss_bytes=peak_rss,
            scope='Bounded original-97-row chart searches; no unverified basis is an exclusion'))
    def launch(chart,phase):
        directory=folder/f'chart-{chart:02d}';directory.mkdir(exist_ok=True)
        log=(directory/(phase+'-batch-'+str(time.time_ns())+'.log')).open('w')
        if phase=='solve':
            cmd=[args.sage,str(ROOT/'scripts/native_original_atlas.sage'),
                '--tensor',str(source),'--chart',str(chart),'--output',str(directory),
                '--seconds',str(args.seconds),'--memory-gib',str(max(.125,job_memory(chart,phase)/1024**3-.2))]
            if deck_path:cmd+=['--deck-grading',str(deck_path)]
            if getattr(args,'native_term_cache',False):cmd+=['--native-term-cache']
        else:cmd=[args.sage,str(ROOT/'scripts/verify_native_original_atlas.sage'),str(directory/'result.json')]
        env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',SAGE_NUM_THREADS='1',MKL_NUM_THREADS='1')
        proc=subprocess.Popen(cmd,cwd=ROOT,stdout=log,stderr=subprocess.STDOUT,env=env,start_new_session=True)
        active[chart]=dict(proc=proc,log=log,log_path=Path(log.name),phase=phase,
                          reserved=job_memory(chart,phase),started=time.monotonic())
        records[str(chart)]=dict(status='running',phase=phase,pid=proc.pid,directory=str(directory))
    try:
        while pending or active:
            while pending and len(active)<workers and not requested:
                room=args.rss_gib*1024**3-sum(v['reserved'] for v in active.values())
                fitting=next((i for i,(c,p) in enumerate(pending) if job_memory(c,p)<=room),None)
                if fitting is None:break
                chart,phase=pending.pop(fitting);launch(chart,phase)
            rows=process_table();total_rss=0;total_cpu=0
            for chart,job in list(active.items()):
                selected=descendants(rows,job['proc'].pid)
                rss=sum(r for p,_,_,r,_ in rows if p in selected)
                cpu=sum(c for p,_,_,_,c in rows if p in selected)
                total_rss+=rss;total_cpu+=cpu
                expired=time.monotonic()-job['started']>args.seconds+5
                over=rss>job['reserved']
                if requested or expired or over:
                    stop(job);job['interruption']='user_stop' if requested else ('memory_limit' if over else 'hard_time_limit')
                if job['proc'].poll() is None:continue
                # Ensure no unexpected orphaned native solver survives.
                stop(job);job['log'].close();active.pop(chart)
                directory=folder/f'chart-{chart:02d}';result=read(directory/'result.json',{})
                if job['phase']=='solve' and result.get('status')=='verified_polynomial_certificate':
                    assert result['source_sha256']==digest
                    pending.insert(0,(chart,'replay'))
                elif job['phase']=='replay' and job['proc'].returncode==0:
                    replay=json.loads(job['log_path'].read_text().strip().splitlines()[-1])
                    assert replay['source_sha256']==digest and replay['verified_original_unit_identity']
                    assert replay['certificate_sha256']==sha(directory/'result.json')
                    atomic(directory/'replay.json',replay)
                    records[str(chart)]=dict(status='verified_polynomial_certificate',directory=str(directory),
                        certificate_sha256=replay['certificate_sha256'],independent_replay_verified=True)
                else:
                    records[str(chart)]=dict(status=result.get('status','bounded_native_batch_interrupted'),
                        directory=str(directory),reason=job.get('interruption',result.get('reason',
                            'exit_'+str(job['proc'].returncode))))
                if job.get('foreign_uid_members_not_signalled'):
                    records[str(chart)]['foreign_uid_members_not_signalled']=job['foreign_uid_members_not_signalled']
            peak_cpu=max(peak_cpu,total_cpu);peak_rss=max(peak_rss,total_rss)
            if time.monotonic()>=next_event:
                event=dict(seconds=time.monotonic()-started,workers=len(active),
                    cpu_percent=total_cpu,rss_bytes=total_rss,completed=sum(
                        r.get('status')=='verified_polynomial_certificate' for r in records.values()))
                print(json.dumps(event),flush=True)
                with (folder/'telemetry.jsonl').open('a') as stream:stream.write(json.dumps(event)+'\n')
                next_event=time.monotonic()+5
            save('running')
            if requested and not active:break
            time.sleep(.5)
        save('paused' if requested else 'bounded_batch_complete')
    except BaseException as error:
        for chart,job in active.items():
            records[str(chart)]=dict(status='native_solver_error',
                directory=str(folder/f'chart-{chart:02d}'),reason=type(error).__name__+': '+str(error))
        save('needs_attention')
        raise
    finally:
        failures=cleanup(active)
        if failures:
            atomic(folder/('cleanup-errors-'+str(time.time_ns())+'.json'),failures)
            raise RuntimeError('Owned job cleanup failed; inspect cleanup-errors artifact')
    return state


if __name__=='__main__':
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--tensor',type=Path,required=True);ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--charts',type=int,nargs='+',required=True);ap.add_argument('--workers',type=int,default=10)
    ap.add_argument('--seconds',type=float,default=120);ap.add_argument('--rss-gib',type=float,default=8)
    ap.add_argument('--legacy-native-cache',action='store_true',
        help='Explicitly allow verified packing of retained legacy directions (no recomputation)')
    ap.add_argument('--deck-descended',action='store_true',help='Use exactly checked diagonal cubic descent when available')
    ap.add_argument('--native-term-cache',action='store_true',help='Retain exact native low-row coefficient dictionaries')
    ap.add_argument('--sage',default='sage');args=ap.parse_args()
    assert args.workers>0 and args.seconds>0 and args.rss_gib>0
    run(args)
