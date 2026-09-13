#!/usr/bin/env python3
"""Process a finite snapshot of completed first-pass survivors on one core.

Every carrier keeps its exact matrix, norm, toric model, Witt matrices and
factor remainders. Unsupported charts or failures remain open. This script
does not poll for new work; later snapshots resume completed output safely.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse,json,subprocess,time,sys
from pathlib import Path
from scripts.genus_two.backup_unit_root_filters import sieve

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('data_root',type=Path);p.add_argument('out',type=Path)
p.add_argument('--limit',type=int,default=10000);p.add_argument('--seconds',type=int,default=1200)
p.add_argument('--index-from',type=int,default=0);p.add_argument('--index-to',type=int,default=1533)
args=p.parse_args();args.out.mkdir(exist_ok=True,parents=True);start=time.monotonic()
root=Path(__file__).resolve().parent;work=[]
for path in args.data_root.glob('degree2-prym-sieve-full-*-20260911/carrier_*/result.json'):
    data=json.loads(path.read_text());index=int(path.parent.name.split('_')[1])
    if not data['sieve']['geometric_backup_factor_excluded'] and args.index_from<=index<args.index_to:
        work.append((index,path))
work=sorted(work)[:args.limit]
suffix='' if (args.index_from,args.index_to)==(0,1533) else '-%d-%d'%(args.index_from,args.index_to)
(args.out/('selection'+suffix+'.json')).write_text(json.dumps(dict(indices=[i for i,_ in work],
    source_files=[str(p) for _,p in work],scope='Finite completed-work snapshot'),indent=2)+'\n')
results=[]
def run(script,arguments,log,timeout):
    with log.open('w') as f:
        return subprocess.run(['sage','-python',str(root/script),*map(str,arguments)],
            stdout=f,stderr=subprocess.STDOUT,timeout=timeout,check=False).returncode
for index,path in work:
    if time.monotonic()-start>args.seconds:break
    out=args.out/('carrier_%04d'%index);out.mkdir(exist_ok=True)
    final=out/'result.json'
    if final.exists():
        results.append(json.loads(final.read_text()));continue
    begun=time.monotonic();result=dict(index=index,source=str(path),status='open')
    try:
        toric=out/'toric'
        if not (toric/'model.json.gz').exists():
            if toric.exists():
                result['status']='previous_toric_failure_open'
                raise RuntimeError('Retained failed toric artifact; investigate before retry')
            code=run('fixed_x_prym_toric.py',[
                args.data_root/'degree2-frobenius-torsion-342-20260911/torsion.json',
                path.parent/'torsion_matrix.json.gz',toric,'--seconds','180'],out/'toric.log',200)
            assert code==0 and (toric/'model.json.gz').exists(),'toric chart not certified'
        unit=out/'unitroots'
        if not (unit/'result.json').exists():
            code=run('toric_prym_unit_roots.py',[toric/'model.json.gz',path,unit,
                '--digits','2','--seconds','180'],out/'unitroots.log',200)
            assert code==0 and (unit/'result.json').exists(),'unit roots not certified'
        values=json.loads((unit/'result.json').read_text());test=sieve(values['coefficients'],2)
        (out/'factor_sieve.json').write_text(json.dumps(test,indent=2)+'\n')
        result.update(status='excluded' if test['geometric_backup_factor_excluded'] else 'needs_more_precision',
                      coefficients=values['coefficients'],passing_orders=test['passing_orders'])
    except (AssertionError,RuntimeError,subprocess.TimeoutExpired) as e:
        result['error']=str(e)
    result['seconds']=time.monotonic()-begun
    final.write_text(json.dumps(result,indent=2)+'\n');results.append(result)
    print(json.dumps(result),flush=True)
summary=dict(selected=len(work),processed=len(results),
    excluded=sum(r['status']=='excluded' for r in results),
    remaining=[r for r in results if r['status']!='excluded'],
    seconds=time.monotonic()-start,scope='Only listed actual carriers; unprocessed labels and failed charts remain open')
(args.out/('summary'+suffix+'.json')).write_text(json.dumps(summary,indent=2)+'\n')
print(json.dumps(summary),flush=True)
