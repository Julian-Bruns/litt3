"""All-scale checks over complete residue fields of the branch-root projection.
Certificates concern the actual source family, not just its ratio equations.
"""
import json,time,sys,subprocess,hashlib,gzip
from exact import ROOT,DATA,prem
from extension import E,Poly,init
from residual import make_residual,square_equations

BASE=ROOT/'work/branch_root';OUT=ROOT/'evidence/branch_root';OUT.mkdir(parents=True,exist_ok=True)
def cases():
 d=json.loads(gzip.open(OUT/'geometry_x_9.json.gz','rb').read())['finite']
 return [{'id':i,'modulus':f,'multiplicity':m,'u':prem(d['u'],f)} for i,(f,m) in enumerate(d['factors'])]
def run(case,verify=False):
 tic=time.time();init(case['modulus']);q=E([0,1]) if len(case['modulus'])>2 else -E(case['modulus'][0]);u=E(case['u'])
 out=dict(case);out['q_image']=list(q.a);out['u_image']=list(u.a)
 vals={s:Poly(DATA[s]).eval(q) for s in ['b','c','e','d','a0']}
 assert vals['b']*u*u+2*vals['c']*u+3*vals['e']==0
 F=vals['a0']*u**3+vals['b']*u*u+vals['c']*u+vals['e'];xi=vals['b']*u+vals['c']
 assert q and u and vals['d'] and F and xi
 assert all(q!=E(c) for c in DATA['excluded_q'])
 print('BEGIN branch factor',case['id'],'degree',len(case['modulus'])-1,flush=True)
 R=make_residual(q,u,True);eqs=square_equations(R,False,True)
 g,S,T=eqs[0].xgcd(eqs[1]);assert S*eqs[0]+T*eqs[1]==g
 out['first_two_tails']=[p.records() for p in eqs]
 out['first_two_bezout']=[S.records(),T.records()]
 out['gcd']=g.records()
 out['status']='excluded_all_scales' if g==1 else 'unresolved'
 out['actual_residual_sha256']=hashlib.sha256(json.dumps([p.records() for p in R],separators=(',',':')).encode()).hexdigest()
 out['scale_coordinate']='mu of Rcal in the original question'
 dest=OUT/f'factor_{case["id"]}.json.gz';payload=json.dumps(out,separators=(',',':')).encode()
 if verify:assert gzip.open(dest,'rb').read()==payload
 else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
 print('BRANCH FACTOR',case['id'],out['status'],'degree',len(case['modulus'])-1,'seconds',round(time.time()-tic,3),flush=True)
 return out
if __name__=='__main__':
 arg=sys.argv[1] if len(sys.argv)>1 else 'all'
 if arg=='all':
  for c in cases():subprocess.run([sys.executable,__file__,str(c['id'])]+(['--verify'] if '--verify' in sys.argv else []),check=True)
 else:run(next(c for c in cases() if c['id']==int(arg)),'--verify' in sys.argv)
