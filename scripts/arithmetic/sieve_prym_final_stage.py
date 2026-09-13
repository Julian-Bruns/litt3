#!/usr/bin/env python3
"""Finite snapshot of stronger actual Prym tests; every surviving case stays open."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse
import json
import subprocess
import time
from pathlib import Path
from scripts.genus_two.backup_unit_root_filters import sieve

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('data_root',type=Path);p.add_argument('higher_stage',type=Path)
p.add_argument('out',type=Path);p.add_argument('--seconds',type=int,default=1200)
p.add_argument('--max-digits',type=int,default=4,choices=range(3,7))
p.add_argument('--index-from',type=int,default=0);p.add_argument('--index-to',type=int,default=1533)
args=p.parse_args();args.out.mkdir(exist_ok=True,parents=True);started=time.monotonic()
root=Path(__file__).resolve().parent
work=[]
for path in args.higher_stage.glob('carrier_*/result.json'):
    data=json.loads(path.read_text());i=data['index']
    if data['status']=='needs_more_precision' and args.index_from<=i<args.index_to:
        work.append((i,path,data))
work.sort()
suffix='-%d-%d'%(args.index_from,args.index_to)
(args.out/('selection'+suffix+'.json')).write_text(json.dumps(dict(
    indices=[i for i,_,_ in work],scope='Finite completed higher-stage snapshot'),indent=2)+'\n')
results=[]
for index,path,record in work:
    if time.monotonic()-started>=args.seconds:break
    out=args.out/('carrier_%04d'%index);out.mkdir(exist_ok=True)
    final=out/'result.json'
    if final.exists():
        results.append(json.loads(final.read_text()));continue
    began=time.monotonic();previous=path.parent/'unitroots/result.json'
    model=path.parent/'toric/model.json.gz'
    result=dict(index=index,source=str(path),status='open',stages=[])
    try:
        for digits in range(3,args.max_digits+1):
            unit=out/('digits_'+str(digits));saved=unit/'result.json'
            legacy=args.data_root/('degree2-prym-mod125-%04d-20260911'%index)/'result.json'
            if digits==3 and legacy.exists():
                saved=legacy
            elif not saved.exists():
                with (out/('digits_'+str(digits)+'.log')).open('w') as log:
                    code=subprocess.run(['sage','-python',str(root/'toric_prym_unit_roots3.py'),
                        str(model),record['source'],str(previous),str(unit),
                        '--digits',str(digits),'--seconds','600'],
                        stdout=log,stderr=subprocess.STDOUT,timeout=630).returncode
                assert code==0 and saved.exists(),'no certified result at precision '+str(digits)
            data=json.loads(saved.read_text())
            assert data['status']=='complete' and data['digits']==digits and data['field_degree']==342
            import hashlib
            assert data['model_sha256']==hashlib.sha256(model.read_bytes()).hexdigest()
            assert [c%(5**(digits-1)) for c in data['coefficients']]==json.loads(previous.read_text())['coefficients']
            test=sieve(data['coefficients'],digits)
            (out/('factor_sieve_'+str(digits)+'.json')).write_text(json.dumps(test,indent=2)+'\n')
            result['stages'].append(dict(digits=digits,unit_result=str(saved.resolve()),
                passing_orders=test['passing_orders']))
            if test['geometric_backup_factor_excluded']:
                result.update(status='excluded',exclusion_digits=digits);break
            previous=saved
        else:
            result['status']='needs_more_precision'
    except (AssertionError,subprocess.TimeoutExpired) as e:
        result['error']=str(e)
    result['seconds']=time.monotonic()-began
    final.write_text(json.dumps(result,indent=2)+'\n');results.append(result)
    print(json.dumps(result),flush=True)
summary=dict(selected=len(work),processed=len(results),
    excluded=sum(r['status']=='excluded' for r in results),
    remaining=[r for r in results if r['status']!='excluded'],seconds=time.monotonic()-started,
    scope='Only certified listed actual carriers; unprocessed and failed charts remain open')
(args.out/('summary'+suffix+'.json')).write_text(json.dumps(summary,indent=2)+'\n')
print(json.dumps(summary),flush=True)
