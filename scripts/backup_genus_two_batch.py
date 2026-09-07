#!/usr/bin/env python3
"""Coordinated ten-process backup jobs with real CPU telemetry.

Launch only after the main atlas owner explicitly grants a CPU window.
No production controller/state is imported or changed.
"""
import argparse
import concurrent.futures
from datetime import datetime,timezone,timedelta
import hashlib
import json
import os
from pathlib import Path
import resource
import signal
import subprocess
import threading
import time

ROOT=Path(__file__).resolve().parents[1]
OUT=Path('/Users/julian/Documents/litt3-computation-data/backup-genus-two')
LOCK=threading.Lock()
GROUPS=set()


def run_job(job,limit):
    name,command=job
    log=OUT/'logs'/STAMP/(name+'.log');log.parent.mkdir(parents=True,exist_ok=True)
    started=time.monotonic()
    limit=min(limit,max(0,DEADLINE-started))
    if limit<=2:return {'name':name,'exit_code':None,'status':'not_started_window_closed','elapsed_seconds':0,'log':str(log)}
    command=list(command)
    if '--seconds' in command:command[command.index('--seconds')+1]=str(max(1,int(limit)-2))
    with log.open('w') as handle:
        proc=subprocess.Popen(command,cwd=ROOT,stdout=handle,stderr=subprocess.STDOUT,start_new_session=True)
        with LOCK: GROUPS.add(proc.pid)
        try:
            code=proc.wait(timeout=limit)
        except subprocess.TimeoutExpired:
            os.killpg(proc.pid,signal.SIGTERM)
            try: code=proc.wait(timeout=5)
            except subprocess.TimeoutExpired:
                os.killpg(proc.pid,signal.SIGKILL);code=proc.wait()
        finally:
            # A parent exit does not prove its native descendants exited.
            try:os.killpg(proc.pid,0)
            except ProcessLookupError:pass
            else:
                try:os.killpg(proc.pid,signal.SIGKILL)
                except ProcessLookupError:pass
            with LOCK: GROUPS.discard(proc.pid)
    return {'name':name,'exit_code':code,'elapsed_seconds':time.monotonic()-started,'log':str(log)}


def cpu_snapshot():
    with LOCK: active=set(GROUPS)
    rows=subprocess.check_output(['ps','-axo','pgid=,%cpu=,rss='],text=True).splitlines()
    cpu=rss=0
    for row in rows:
        cols=row.split()
        if len(cols)==3 and int(cols[0]) in active:
            cpu+=float(cols[1]);rss+=int(cols[2])
    return {'elapsed_seconds':time.monotonic()-START,'active_jobs':len(active),
            'aggregate_cpu_percent':cpu,'aggregate_rss_kib':rss}


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--mode',choices=['tensors','solve','pipeline','finish'],required=True)
    parser.add_argument('--seconds',type=int,default=270)
    parser.add_argument('--workers',type=int,default=10,choices=range(1,11))
    parser.add_argument('--rss-gib',type=float,help='Stop all backup jobs if sampled aggregate RSS exceeds this cap.')
    parser.add_argument('--solver-backend',choices=['original','rooted-incidence','rooted-atlas'],default='original')
    parser.add_argument('--window-confirmed',action='store_true',required=True)
    args=parser.parse_args();OUT.mkdir(parents=True,exist_ok=True);STAMP=str(time.time_ns())
    jobs=[];scheduled=set()
    def add(name,command):
        if name not in scheduled:jobs.append((name,command));scheduled.add(name)
    def tensor_done(path):
        if not path.exists():return False
        data=json.loads(path.read_text())
        return data.get('all_B_coboundary_generators_verified') and 'tensor' in data
    def add_solvers(twist):
        tensor=OUT/f'tensor_twist{twist}_p500.json'
        if not tensor_done(tensor):return
        for chart in range(4):
            name=f'solve_twist{twist}_chart{chart}';target=OUT/(name+'.json')
            prior=OUT/f'debug_solve_trivial_chart{chart}.json' if twist==-1 else target
            if prior.exists():
                status=json.loads(prior.read_text()).get('status','')
                if status in ['empty_chart_exact_original_equation_certificate','nonempty_finite_chart_exact_groebner_algebra']:continue
            command=['sage',str(ROOT/('scripts/backup_genus_two_solve.sage' if args.solver_backend=='original' else 'scripts/backup_genus_two_native_solve.sage')),
                     '--tensor',str(tensor),'--chart',str(chart),'--seconds',str(args.seconds),'--output',str(target)]
            if args.solver_backend!='original':
                command+=['--'+args.solver_backend,'--work',str(OUT/('native_'+STAMP+'_'+name))]
            add(name,command)
    manifests=[]
    if args.mode=='finish':
        # Precomputed inventory is only scheduling metadata. The finalizer
        # reloads the exact hashed state/partial tensor and checks every
        # independent relation receipt before publishing a full tensor.
        for twist in [1,2,3]:
            for precision in [500,600]:
                target=OUT/f'tensor_twist{twist}_p{precision}.json'
                if tensor_done(target):continue
                state=Path(str(target)+'.state.sobj')
                path=Path(str(state)+'.tasks.json')
                if not path.exists():raise SystemExit(f'Prepare inventory first: sage scripts/backup_genus_two_finish.py --state {state} --inventory')
                manifest=json.loads(path.read_text())
                assert hashlib.sha256(state.read_bytes()).hexdigest()==manifest['state_sha256']
                assert manifest['tensor_blocks']==4
                manifest['target']=str(target);manifests.append(manifest)
        # Round-robin between states, so a cheap tail on one state cannot
        # leave the other states without workers. These are substantial
        # independent exact checks, not idle worker placeholders.
        for index in range(max((m['relation_count'] for m in manifests),default=0)):
            for manifest in manifests:
                if not manifest['contiguous_relations_checked']<=index<manifest['relation_count']:continue
                state=manifest['state_path'];receipt=Path(state+f'.relation_{index}.json')
                if receipt.exists():
                    record=json.loads(receipt.read_text())
                    if (record.get('state_sha256')==manifest['state_sha256'] and
                        record.get('relation_index')==index and record.get('exact_I_and_all_four_tensor_coboundaries_zero')):continue
                name=Path(state).name+f'_relation{index}'
                add(name,['sage',str(ROOT/'scripts/backup_genus_two_finish.py'),
                          '--state',state,'--relation',str(index)])
    def add_finalizers():
        for manifest in manifests:
            state=manifest['state_path'];ready=True
            for index in range(manifest['contiguous_relations_checked'],manifest['relation_count']):
                receipt=Path(state+f'.relation_{index}.json')
                if not receipt.exists():ready=False;break
                record=json.loads(receipt.read_text())
                if (record.get('state_sha256')!=manifest['state_sha256'] or
                    record.get('relation_index')!=index or not record.get('exact_I_and_all_four_tensor_coboundaries_zero')):
                    ready=False;break
            if ready and not tensor_done(Path(manifest['target'])):
                add(Path(state).name+'_aggregate',['sage',str(ROOT/'scripts/backup_genus_two_finish.py'),
                    '--state',state,'--output',manifest['target'],'--aggregate-only'])
        for twist in [-1,0,1,2,3]:add_solvers(twist)
    if args.mode=='finish':add_finalizers()
    if args.mode in ['tensors','pipeline']:
        for twist in [-1,0,1,2,3]:
            for precision in [500,600]:
                name=f'tensor_twist{twist}_p{precision}'
                if tensor_done(OUT/(name+'.json')):continue
                add(name,['sage',str(ROOT/'scripts/backup_genus_two_tensor.sage'),
                          '--twist',str(twist),'--precision',str(precision),'--output',str(OUT/(name+'.json'))])
    if args.mode in ['solve','pipeline']:
        for twist in [-1,0,1,2,3]:
            tensor=OUT/f'tensor_twist{twist}_p500.json'
            if args.mode=='solve' and not tensor_done(tensor):raise SystemExit(f'Missing tensor {tensor}')
            add_solvers(twist)
    START=time.monotonic();DEADLINE=START+args.seconds
    usage0=resource.getrusage(resource.RUSAGE_CHILDREN);samples=[];results=[]
    print(json.dumps({'mode':args.mode,'workers':args.workers,'jobs':len(jobs),'limit_per_job_seconds':args.seconds,
                      'launcher_pid':os.getpid(),'deadline_utc':(datetime.now(timezone.utc)+timedelta(seconds=args.seconds)).isoformat(),
                      'aggregate_rss_gib_cap':args.rss_gib}),flush=True)
    memory_cap_triggered=False
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as pool:
        pending={pool.submit(run_job,job,args.seconds+10):job[0] for job in jobs}
        while pending:
            done,_=concurrent.futures.wait(pending,timeout=5,return_when=concurrent.futures.FIRST_COMPLETED)
            sample=cpu_snapshot();samples.append(sample)
            print(json.dumps(sample),flush=True)
            if args.rss_gib is not None and sample['aggregate_rss_kib']>args.rss_gib*1024**2:
                memory_cap_triggered=True;DEADLINE=min(DEADLINE,time.monotonic())
                with LOCK: groups_to_stop=list(GROUPS)
                for group in groups_to_stop:
                    try:os.killpg(group,signal.SIGTERM)
                    except ProcessLookupError:pass
            for future in done:
                result=future.result();results.append(result);del pending[future]
                print(json.dumps({'completed':result}),flush=True)
            if args.mode in ['pipeline','finish'] and time.monotonic()<DEADLINE-2:
                jobs=[]
                if args.mode=='finish':add_finalizers()
                else:
                    for twist in [-1,0,1,2,3]:add_solvers(twist)
                for job in jobs:pending[pool.submit(run_job,job,args.seconds+10)]=job[0]
    elapsed=time.monotonic()-START;usage=resource.getrusage(resource.RUSAGE_CHILDREN)
    cpu_seconds=usage.ru_utime+usage.ru_stime-usage0.ru_utime-usage0.ru_stime
    sampled_cpu=0;previous={'elapsed_seconds':0,'aggregate_cpu_percent':0}
    for sample in samples:
        sampled_cpu+=(sample['elapsed_seconds']-previous['elapsed_seconds'])*(sample['aggregate_cpu_percent']+previous['aggregate_cpu_percent'])/200
        previous=sample
    result={'mode':args.mode,'solver_backend':args.solver_backend,'workers':args.workers,'jobs':results,'telemetry':samples,'wall_seconds':elapsed,
            'aggregate_rss_gib_cap':args.rss_gib,'memory_cap_triggered':memory_cap_triggered,
            'reaped_child_cpu_seconds_incomplete_after_group_kills':cpu_seconds,
            'sampled_cpu_seconds_estimate':sampled_cpu,'sampled_mean_busy_cores_estimate':sampled_cpu/elapsed,
            'peak_sampled_cpu_percent':max((s['aggregate_cpu_percent'] for s in samples),default=0),
            'peak_sampled_rss_kib':max((s['aggregate_rss_kib'] for s in samples),default=0)}
    path=OUT/f'batch_{args.mode}_{STAMP}.json';path.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({key:value for key,value in result.items() if key not in ['jobs','telemetry']},indent=2),flush=True)
    print('SUMMARY',path,flush=True)
