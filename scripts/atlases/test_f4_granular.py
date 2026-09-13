#!/usr/bin/env python3
"""Bounded instrumented-F4 differential tests; no atlas conclusions from them."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time

BASE=Path('/Users/julian/Documents/litt3-computation-data/atlas-f4.bGX35h/msolve/msolve')
NEW=Path('/Users/julian/Documents/litt3-computation-data/atlas-f4-telemetry/msolve/msolve')
OUT=NEW.parent.parent/'tests'


def run():
    OUT.mkdir(exist_ok=True)
    inputs={
        'cyclic4': 'x,y,z,w\n5\nx+y+z+w,\nx*y+y*z+z*w+w*x,\nx*y*z+y*z*w+z*w*x+w*x*y,\nx*y*z*w-1\n',
        'extension4': 'x,y,a\n5\nx*y-a,\nx^2+y^2-1,\na^4-a^2+2\n',
        'actual_chart29': Path('/Users/julian/Documents/litt3-computation-data/atlas-rooted-first/chart-29/input.ms').read_text(),
    }
    results=[]
    for name,body in inputs.items():
        inp=OUT/(name+'.ms');inp.write_text(body)
        outputs={}
        for mode,engine,enabled in [('baseline',BASE,False),('new_off',NEW,False),('new_on',NEW,True)]:
            output=OUT/(name+'-'+mode+'.gb');tele=OUT/(name+'-'+mode+'.jsonl')
            # Logs are per invocation; overwrite test files, not production work.
            tele.write_text('')
            env=dict(os.environ,MSOLVE_F4_TELEMETRY=str(tele))
            env.pop('MSOLVE_F4_GRANULAR',None)
            if enabled:env['MSOLVE_F4_GRANULAR']='1'
            if name=='extension4':env['MSOLVE_F4_COEFF_VARIABLES']='2'
            elif name=='actual_chart29':env['MSOLVE_F4_COEFF_VARIABLES']=str(len(body.splitlines()[0].split(','))-1)
            began=time.monotonic()
            command=[str(engine),'-f',str(inp),'-o',str(output),'-g','2','-l','2','-t','1','-m','4','-c','0','-v','2']
            p=subprocess.run(command,env=env,capture_output=True,timeout=30)
            (OUT/(name+'-'+mode+'.log')).write_bytes(p.stdout+p.stderr)
            assert p.returncode==0,(name,mode,p.returncode)
            data=output.read_bytes();outputs[mode]=data
            events=[json.loads(s) for s in tele.read_text().splitlines()]
            detailed=[e for e in events if e['event']=='granular_round']
            assert bool(detailed)==enabled,(name,mode,'instrumentation flag ignored')
            if detailed:
                assert sum(e['row_subtractions'] for e in detailed)>0
                assert all(e['coefficient_updates']>=e['row_subtractions'] for e in detailed)
                if name=='extension4':
                    assert all(e['coefficient_degree_profile_available'] for e in detailed)
            results.append(dict(test=name,mode=mode,seconds=time.monotonic()-began,
                output_sha256=hashlib.sha256(data).hexdigest(),granular_rounds=len(detailed),
                coefficient_updates=sum(e['coefficient_updates'] for e in detailed)))
        assert len(set(outputs.values()))==1,(name,'basis mismatch')
    # Checkpoint from the old binary must resume in the instrumented binary.
    name='cyclic4';inp=OUT/(name+'.ms');cp=OUT/'resume.cp'
    env=dict(os.environ,MSOLVE_F4_CHECKPOINT=str(cp),MSOLVE_F4_STOP_AFTER_ROUNDS='1')
    p=subprocess.run([str(BASE),'-f',str(inp),'-o',str(OUT/'stop.gb'),'-g','2','-l','2','-t','1','-m','1','-c','0'],env=env,capture_output=True,timeout=30)
    assert p.returncode==75
    env.pop('MSOLVE_F4_STOP_AFTER_ROUNDS');env.update(MSOLVE_F4_RESUME=str(cp),MSOLVE_F4_GRANULAR='1',MSOLVE_F4_TELEMETRY=str(OUT/'resume.jsonl'))
    p=subprocess.run([str(NEW),'-f',str(inp),'-o',str(OUT/'resume.gb'),'-g','2','-l','2','-t','2','-m','4','-c','0'],env=env,capture_output=True,timeout=30)
    assert p.returncode==0
    assert (OUT/'resume.gb').read_bytes()==(OUT/'cyclic4-baseline.gb').read_bytes()
    results.append(dict(test='old_checkpoint_new_instrumented_resume',passed=True))
    (OUT/'results.json').write_text(json.dumps(results,indent=2)+'\n')
    print(json.dumps(results,indent=2),flush=True)


if __name__=='__main__':run()
