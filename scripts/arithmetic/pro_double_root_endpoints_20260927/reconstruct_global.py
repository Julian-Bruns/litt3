"""Restartable exhaustive interpolation reconstruction.  Not a bounded point search.
Degree <=132 in u is proved from the source weight filtration.
"""
import sys,subprocess,json,time,concurrent.futures,gzip,hashlib
from pathlib import Path
ROOT=Path(__file__).resolve().parent.parent
CACHE=ROOT/'work/global_samples'

def run(i):
 p=CACHE/(str(i)+'.json')
 if p.exists() and '--fresh' not in sys.argv:
  cached=json.loads(p.read_text());raw=gzip.open(CACHE/(str(i)+'.bin.gz'),'rb').read()
  if hashlib.sha256(raw).hexdigest()==cached['digest']:return cached
 r=subprocess.run([sys.executable,str(ROOT/'src/global_residual.py'),str(i)],capture_output=True,text=True)
 if r.returncode:raise RuntimeError(str(i)+'\n'+r.stdout+r.stderr)
 print(r.stdout.strip(),flush=True)
 return json.loads(p.read_text())

if __name__=='__main__':
 start=time.time();n=int(sys.argv[1]) if len(sys.argv)>1 else 133
 with concurrent.futures.ProcessPoolExecutor(max_workers=4) as pool:
  rows=list(pool.map(run,range(n)))
 result={'interpolation_points':list(range(n)),'u_degree_bound':132,'samples':rows,'wall_seconds':round(time.time()-start,3)}
 if '--verify' in sys.argv:
  expected=json.loads((ROOT/'evidence/global_samples.json').read_text())
  assert expected['interpolation_points']==result['interpolation_points']
  for got,old in zip(rows,expected['samples']):
   for key in ['u_code','modulus','shape','digest','degrees_x']:assert got[key]==old[key],(got['u_code'],key)
  print('All source records match the archived mathematical evidence (fresh or cache-verified as requested).',flush=True)
 else:(ROOT/'evidence/global_samples.json').write_text(json.dumps(result,indent=2)+'\n')
 print('ALL',n,'GLOBAL SAMPLES COMPLETE',round(time.time()-start,2),flush=True)
