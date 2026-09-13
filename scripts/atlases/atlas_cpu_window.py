#!/usr/bin/env python3
"""Read-only bounded process-tree CPU/RSS measurement of the active queue."""
import argparse,json,subprocess,time
from pathlib import Path

def measure(state):
    controller=state.get('controller_pid')
    text=subprocess.check_output(['ps','-axo','pid=,ppid=,pcpu=,rss=,command='],text=True)
    rows=[]
    for line in text.splitlines():
        parts=line.split(None,4)
        if len(parts)==5: rows.append((int(parts[0]),int(parts[1]),float(parts[2]),int(parts[3])*1024,parts[4]))
    if not any(pid==controller and 'run_all_atlases.py run' in cmd for pid,_,_,_,cmd in rows):
        return dict(active=False,aggregate_cpu_percent=0,rss_bytes=0,processes=[])
    selected={controller}
    while True:
        grown=selected|{pid for pid,ppid,_,_,_ in rows if ppid in selected}
        if grown==selected: break
        selected=grown
    actual=[dict(pid=pid,parent=ppid,cpu_percent=cpu,rss_bytes=rss,command=cmd)
            for pid,ppid,cpu,rss,cmd in rows if pid in selected]
    return dict(active=True,aggregate_cpu_percent=sum(row['cpu_percent'] for row in actual),
        rss_bytes=sum(row['rss_bytes'] for row in actual),processes=actual)

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--state',type=Path,required=True)
    ap.add_argument('--output',type=Path,required=True);ap.add_argument('--seconds',type=float,default=180)
    ap.add_argument('--every',type=float,default=2);args=ap.parse_args()
    assert args.seconds>0 and args.every>=1
    args.output.parent.mkdir(parents=True,exist_ok=True); start=time.monotonic();peak=0;samples=0;high=0
    with args.output.open('x') as stream:
        while time.monotonic()-start<args.seconds:
            state=json.loads(args.state.read_text());row=measure(state);active=state.get('active',{})
            row.update(time=time.time(),elapsed_seconds=time.monotonic()-start,
                       rep=active.get('rep'),stage=active.get('stage'))
            stream.write(json.dumps(row)+'\n');stream.flush();samples+=1
            peak=max(peak,row['aggregate_cpu_percent']);high+=row['aggregate_cpu_percent']>=850
            if samples==1 or samples%10==0:
                print(json.dumps({key:row[key] for key in ['elapsed_seconds','rep','stage','aggregate_cpu_percent','rss_bytes']}),flush=True)
            time.sleep(min(args.every,max(0,args.seconds-(time.monotonic()-start))))
    print(json.dumps(dict(samples=samples,peak_aggregate_cpu_percent=peak,
        samples_at_least_850_percent=high,seconds=time.monotonic()-start)),flush=True)
