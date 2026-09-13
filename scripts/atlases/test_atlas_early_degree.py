"""One-core pair-order regressions; no production files are modified."""
import argparse,json,os,subprocess,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--out',required=True)
p.add_argument('--atlas-chart',type=int);p.add_argument('--seconds',type=int,default=30)
a=p.parse_args();out=Path(a.out).resolve();out.mkdir(parents=True,exist_ok=False)
base=Path('/Users/julian/Documents/litt3-computation-data/atlas-f4-telemetry/msolve/msolve')
new=Path('/Users/julian/Documents/litt3-computation-data/atlas-f4-early-degree/msolve')
fixtures=[
 ('xy','x,y',['x*y-1','y-x^5-y^5'],5),
 ('xy_unit','x,y',['x*y-1','y-x^5-y^5','x^5-1'],5),
 ('chain','x,y,z',['x^2-y','y^2-z','z^2-1','x^5-2'],5),
 ('mixed','x,y,z',['x*y-z','x^2+y^2-1','z^5-z'],5),
 ('cyclic3','x,y,z',['x+y+z','x*y+y*z+z*x','x*y*z-1'],3),
]
records=[]
for label,names,polys,threshold in fixtures:
    inp=out/(label+'.ms');inp.write_text(names+'\n5\n'+',\n'.join(polys)+'\n')
    outputs=[];rec=dict(test=label)
    for mode,exe in [('baseline',base),('early',new)]:
        dest=out/(label+'-'+mode+'.gb')
        env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1')
        if mode=='early':env['MSOLVE_F4_EARLY_DEGREE']=str(threshold)
        started=time.monotonic()
        run=subprocess.run([str(exe),'-f',str(inp),'-o',str(dest),'-g','2','-l','2','-t','1','-m','64','-c','0'],
            capture_output=True,text=True,env=env,timeout=20)
        (out/(label+'-'+mode+'.log')).write_text(run.stdout+run.stderr)
        assert run.returncode==0,(label,mode,run.returncode)
        outputs.append(dest.read_bytes())
        rec[mode+'_seconds']=time.monotonic()-started
        if mode=='early':rec['early_bucket_executed']='F4_EARLY_BUCKET' in run.stderr
    rec['same_reduced_basis']=outputs[0]==outputs[1]
    assert rec['same_reduced_basis'],label
    records.append(rec);print(json.dumps(rec),flush=True)
assert any(r['early_bucket_executed'] for r in records)
(out/'tests.json').write_text(json.dumps(records,indent=2)+'\n')
if a.atlas_chart is not None:
    assert 0<=a.atlas_chart<=31 and 0<a.seconds<=60
    folder=Path('/Users/julian/Documents/litt3-computation-data/atlas-rooted-first')/('chart-%02d'%a.atlas_chart)
    dest=out/'atlas.gb';cp=out/'atlas.cp';tele=out/'atlas.jsonl'
    env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MSOLVE_F4_EARLY_DEGREE='11',
        MSOLVE_F4_CHECKPOINT=str(cp),MSOLVE_F4_TELEMETRY=str(tele),MSOLVE_F4_STOP_AFTER_ROUNDS='1')
    started=time.monotonic()
    with (out/'atlas.log').open('w') as log:
        try:
            run=subprocess.run([str(new),'-f',str(folder/'input.ms'),'-o',str(dest),'-g','2','-l','2','-t','1','-m','32','-c','0'],
                stdout=log,stderr=subprocess.STDOUT,env=env,timeout=a.seconds)
            result=dict(status='one_round_result',returncode=run.returncode)
        except subprocess.TimeoutExpired:
            result=dict(status='time_limit',returncode=None)
    result.update(seconds=time.monotonic()-started,chart=a.atlas_chart,
        scope='Fresh diagnostic only. No atlas exclusion. Exit75 means incomplete.')
    (out/'atlas_result.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result),flush=True)
