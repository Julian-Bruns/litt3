#!/usr/bin/env python3
"""Bounded fresh-process all18 root arithmetic fixtures, never production.

No Sage process is forked. The pool uses at most ten separately launched
process groups and the production-tested exact owned-PID cleanup helper.
Completed case/root files persist; a bound is a test INCOMPLETE, not PASS.
"""
import argparse,json,os,signal,subprocess,time
from pathlib import Path
from atlas_native_batch import atomic,descendants,live_group_members,process_table,stop

ROOT=Path(__file__).resolve().parents[1]


def run(args):
    assert 1<=args.workers<=10 and 1<=args.seconds<=120 and 0<args.rss_gib<=8
    args.output.mkdir(parents=True,exist_ok=True)
    cases=[('orbit_%04d'%i,'intrinsic') for i in range(12)]
    cases += [('invariant_%d'%i,'intrinsic') for i in range(6)]
    cases += [('orbit_%04d'%i,'chosen') for i in [1,3,4,5,7,8,9,10]]
    if args.case:
        selected=set(args.case);assert selected<={r+':'+k for r,k in cases}
        cases=[(r,k) for r,k in cases if r+':'+k in selected]
    # Finish cheap syntax/format controls first; largest independent jobs then
    # start early enough to get most of the bounded parallel window.
    cases=sorted(cases,key=lambda z:(z!=('orbit_0000','intrinsic'),
        z!=('orbit_0011','intrinsic'),z[1]!='chosen',z[0]),reverse=False)
    started=time.monotonic();deadline=started+max(.1,args.seconds-8);pending=list(cases)
    active={};results={};history=[];requested=[];next_sample=started
    peak_cpu=0.;peak_rss=0;cpu_integral=0.;last_sample=started
    signal.signal(signal.SIGTERM,lambda *_:requested.append('signal'))
    signal.signal(signal.SIGINT,lambda *_:requested.append('signal'))
    def launch(rep,kind):
        key=rep+':'+kind;folder=args.output/(rep+'-'+kind);folder.mkdir(exist_ok=True)
        log=(folder/('test-'+str(time.time_ns())+'.log')).open('w')
        command=[args.sage,str(ROOT/'scripts/test_atlas_native_roots_fields.sage'),
            '--representative',rep,'--field-kind',kind,'--output',str(folder)]
        if (rep,kind)==('orbit_0000','intrinsic'):command.append('--negative-controls')
        proc=subprocess.Popen(command,cwd=ROOT,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
        active[key]=dict(proc=proc,log=log,started=time.monotonic(),folder=folder)
        history.append(dict(case=key,pid=proc.pid,command=command))
    def finish(key,reason=None):
        job=active[key];code=job['proc'].poll()
        stop(job,grace=.5);assert not live_group_members(job['proc'].pid)
        job['log'].close();report_path=job['folder']/'report.json'
        row=dict(case=key,pid=job['proc'].pid,returncode=code,reason=reason,
                 seconds=time.monotonic()-job['started'],status='incomplete')
        if reason is None and code==0 and report_path.exists():
            report=json.loads(report_path.read_text())
            assert report['all_3072_independent_fifth_power_checks']
            assert report['independent_inverse_checks']==24 and report['resume_hash_check_passed']
            assert report['representative']+':'+report['field_kind']==key
            row.update(status='passed',report=str(report_path),degree_F5=report['degree_F5'],
                       algebra_seconds=report['total_seconds'])
        results[key]=row;del active[key];print(json.dumps(row),flush=True)
    try:
        while pending or active:
            now=time.monotonic()
            if now>=deadline or requested:
                reason='wall_limit' if now>=deadline else requested[0]
                for key in list(active):finish(key,reason)
                break
            # The first small control is a genuinely sequential correctness
            # gate. Once it passes, use all ten slots when ten cases remain.
            control='orbit_0000:intrinsic'
            gated=any(r==('orbit_0000','intrinsic') for r in cases) and control not in results
            limit=1 if gated else args.workers
            while pending and len(active)<limit:
                launch(*pending.pop(0))
            for key in list(active):
                if active[key]['proc'].poll() is not None:finish(key)
            if control in results and results[control]['status']!='passed':
                requested.append('control_failed');continue
            if now>=next_sample:
                rows=process_table();owned=set()
                for job in active.values():owned|=descendants(rows,job['proc'].pid)
                cpu=sum(c for p,_,_,_,c in rows if p in owned)
                rss=sum(m for p,_,_,m,_ in rows if p in owned)
                cpu_integral+=cpu/100*(now-last_sample);last_sample=now
                peak_cpu=max(peak_cpu,cpu);peak_rss=max(peak_rss,rss)
                print(json.dumps(dict(stage='sample',active=len(active),completed=len(results),
                    pending=len(pending),cpu_percent=cpu,rss_bytes=rss,seconds=now-started)),flush=True)
                if rss>args.rss_gib*1024**3:requested.append('aggregate_memory_limit')
                next_sample=now+2
            time.sleep(.1)
    finally:
        failures=[]
        for key,job in list(active.items()):
            try:finish(key,'parent_exception')
            except BaseException as error:failures.append(dict(case=key,error=str(error)))
        remaining={r['pid']:live_group_members(r['pid']) for r in history}
        remaining={p:members for p,members in remaining.items() if members}
        result=dict(schema=1,all_passed=len(results)==len(cases) and all(r['status']=='passed' for r in results.values()),
            requested_cases=[r+':'+k for r,k in cases],results=results,
            unstarted=[r+':'+k for r,k in pending],seconds=time.monotonic()-started,
            peak_cpu_percent=peak_cpu,peak_rss_bytes=peak_rss,sampled_cpu_seconds=cpu_integral,
            workers=args.workers,history=history,cleanup_failures=failures,remaining_owned_groups=remaining,
            scope='Bounded tiny field arithmetic fixtures only; no production state or atlas tensor')
        atomic(args.output/('batch-'+str(time.time_ns())+'.json'),result)
        print(json.dumps({k:v for k,v in result.items() if k not in ['history','results']}),flush=True)
        if failures or remaining:raise RuntimeError('Owned test workers not cleanly stopped')
    return result


if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--sage',default='/usr/local/bin/sage');ap.add_argument('--workers',type=int,default=10)
    ap.add_argument('--seconds',type=float,default=120);ap.add_argument('--rss-gib',type=float,default=6)
    ap.add_argument('--case',action='append');args=ap.parse_args()
    result=run(args)
    raise SystemExit(0 if result['all_passed'] else 2)
