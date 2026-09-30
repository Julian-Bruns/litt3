"""Execute each finite-algebra check in a separate, auditable process."""
from pathlib import Path
import sys, json, time, subprocess, argparse, concurrent.futures
ROOT=Path(__file__).resolve().parents[1]
SRC=ROOT/'src'

def execute(args,logname):
    log=ROOT/'logs'/logname
    with log.open('w') as f:
        p=subprocess.run([sys.executable,str(SRC/'linear_138_square.py')]+args,stdout=f,stderr=subprocess.STDOUT)
    if p.returncode: raise RuntimeError(f'Check failed ({p.returncode}): {log}')
    return logname

def main():
    a=argparse.ArgumentParser();a.add_argument('--workers',type=int,default=4);a.add_argument('--start',type=int,default=1);a.add_argument('--stop',type=int,default=10);args=a.parse_args()
    start=time.monotonic()
    for i in range(args.start,args.stop+1):
        execute(['--index',str(i),'--prepare'],f'linear_138_prepare_{i}.log')
        print('prepared',i,flush=True)
    jobs=[]
    for i in range(args.start,args.stop+1):
        shape=json.loads((ROOT/'data'/f'linear_138_shape_{i}.json').read_text())
        for j in range(len(shape['factors'])):jobs.append((i,j))
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as pool:
        todo={pool.submit(execute,['--index',str(i),'--factor',str(j)],f'linear_138_square_{i}_{j}.log'):(i,j) for i,j in jobs}
        for f in concurrent.futures.as_completed(todo):
            i,j=todo[f];f.result();print('checked',i,j,'elapsed',round(time.monotonic()-start,2),flush=True)
    for i in range(args.start,args.stop+1):
        shape=json.loads((ROOT/'data'/f'linear_138_shape_{i}.json').read_text());fs=[]
        for j,m in enumerate(shape['factors']):
            d=json.loads((ROOT/'data'/f'linear_138_square_{i}_{j}.json').read_text());assert d['status']=='geometrically excluded'
            fs.append({'factor_index':j,'degree':len(m)-1,'excluded':True,'gcd_degree':len(d['gcd'])-1})
        (ROOT/'data'/f'linear_138_summary_{i}.json').write_text(json.dumps({'space_index':i,'status':'degree 138 excluded geometrically','factors':fs},indent=2)+'\n')
    print('ALL REQUESTED LINEAR-V DEGREE-138 CHECKS PASSED; elapsed',round(time.monotonic()-start,2),flush=True)

if __name__=='__main__':main()
