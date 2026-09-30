#!/usr/bin/env python3
"""Verify the prior reductions and all new geometric boundary exclusions.
No global square-ideal decision is performed by this program.
"""
import argparse,concurrent.futures,hashlib,json,os,platform,subprocess,sys,tempfile,time
from pathlib import Path
import numpy as np
ROOT=Path(__file__).resolve().parent;PRIOR=ROOT/'prior'
sys.path[:0]=[str(ROOT/'src'),str(PRIOR/'src')]
import exact as E
from atlas import fixed_data
from cube_chart import evaluate as cube_evaluate
from residual import evaluate_chart
from necessary_curve import sylvester
from fast import Fast
from verify_support import *

def manifest():
 f=ROOT/'SHA256SUMS'
 if not f.exists(): print('Manifest not present during packaging-stage verification.');return
 n=0
 for row in f.read_text().splitlines():
  sha,rel=row.split('  ',1);assert hashlib.sha256((ROOT/rel).read_bytes()).hexdigest()==sha,rel;n+=1
 print('Manifest verified:',n,'files.',flush=True)

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--skip-manifest',action='store_true');ap.add_argument('--skip-prior',action='store_true');ap.add_argument('--jobs',type=int,default=3);args=ap.parse_args()
 assert 1<=args.jobs<=4
 if not args.skip_manifest:manifest()
 print('STATUS: PARTIAL. The global nonzero-pivot square locus remains unresolved.',flush=True)
 print('Python',sys.version.replace('\n',' '),'NumPy',np.__version__,'platform',platform.platform(),flush=True)
 print(subprocess.check_output(['g++','--version'],text=True).splitlines()[0],flush=True);start=time.time()
 if not args.skip_prior:subprocess.run([sys.executable,str(PRIOR/'verify.py')],check=True)
 with tempfile.TemporaryDirectory(prefix='degree140_continuation_verify_') as temp:
  tmp=Path(temp);table=tmp/'field.bin';field=tmp/'field_tables';lib=tmp/'fast_exact.so'
  subprocess.run(['g++','-O3','-std=c++17',str(PRIOR/'src/field_tables.cpp'),'-o',str(field)],check=True);subprocess.run([str(field),str(table)],check=True)
  subprocess.run(['g++','-O3','-std=c++17','-shared','-fPIC',str(ROOT/'src/fast_exact.cpp'),'-o',str(lib)],check=True)
  for name in ['interpolate_fast_resultants','bezout_fast','verify_coefficients']:
   subprocess.run(['g++','-O3','-std=c++17',str(ROOT/f'src/{name}.cpp'),'-o',str(tmp/name)],check=True)
  E.init(table);fast=Fast(lib,table)
  subprocess.run([str(tmp/'interpolate_fast_resultants'),str(table),'unused','unused','test'],check=True)
  # Independent checks against the original exact implementation and literal Sylvesters.
  for name in ['constant']+[f'linear_{i}' for i in range(10)]:
   a=load(PRIOR/f'data/atlas_{name}.json');c=load(PRIOR/f'data/chart_{name}.json');H,_=evaluate_chart(a,c,2,1);rr=fast.residual(H,a['root']);ref=load(PRIOR/f'data/residual_h2w1_{name}.json')['R_lambda']
   assert [E.poly(row).tolist() for row in rr]==ref
   ee=fast.errors(rr);old=load(PRIOR/f'certificates/bezout_h2w1_{name}.json')['errors'];assert [E.poly(row).tolist() for row in ee[:2]]==old
  from random import Random
  rng=Random(140026)
  for _ in range(100):
   md,nd=rng.randrange(1,10),rng.randrange(1,10);m,n=rng.randrange(md+1),rng.randrange(nd+1)
   a=np.array([rng.randrange(E.SIZE) for _ in range(m+1)],np.int32);b=np.array([rng.randrange(E.SIZE) for _ in range(n+1)],np.int32)
   assert fast.resultant(a,b,md,nd)==sylvester(a,b,md,nd)
  print('Exact engine cross-check: eleven residuals/errors and 100 literal fixed-degree Sylvesters passed.',flush=True)
  from interpolation import interp_vec
  xp=np.arange(1,15,dtype=np.int32);original=np.array([[rng.randrange(E.SIZE) for _ in range(3)] for i in range(14)],np.int32)
  values=np.stack([at_tensor(original,h) for h in xp]);assert np.array_equal(interp_vec(xp,values),original)
  print('Retained exact interpolation routine: polynomial-vector round trip verified.',flush=True)
  P,A,Q,B,L,t,Ct=fixed_data();cases=[]
  # This retained exploratory identity is not an exclusion or a square witness.
  expcube=load(PRIOR/'data/cube_constant.json');expa=np.load(ROOT/'data/constant_q1_residual.npy')
  assert expa.shape==(37,7,141)
  for h in range(37):assert np.array_equal(at_tensor(expa,h),fast.residual(cube_evaluate(expcube,h,1),None,P,t))
  print('Exploratory q=1 residual table: exact degree-bounded identity verified; no square-locus conclusion.',flush=True)
  boundary_index={r['case']:r for r in load(ROOT/'data/boundary_index.json')['cases']}
  for name in ['constant']+[f'linear_{i}' for i in range(10)]:
   constant=name=='constant';cube=load(PRIOR/f'data/cube_{name}.json')
   record=load(ROOT/('data/constant_q15383_errors.json' if constant else f'data/{name}_boundary_formal.json'))
   q,pivot,psi=boundary(cube,None if constant else record)
   ix=boundary_index[name];assert (ix['root'],ix['q'],ix['pivot_q'],ix['Psi_at_q'])==(cube['root'],q,pivot,psi.tolist())
   dh=max(e[0] for e,c in cube['Psi']);assert dh==ix['highest_H_degree']
   assert ix['highest_H_coefficient_q_terms']==[[e[1],c] for e,c in cube['Psi'] if e[0]==dh]
   arr=np.load(ROOT/('data/constant_q15383_residual.npy' if constant else f'data/{name}_boundary_residual.npy'))
   # The four G_i are numerator term lists, sharing d(q), independent of H.
   assert len(cube['G'])==4
   for row in cube['G']:
    assert all(0<=e[0]<=(1 if constant else 2) for e,c in row)
   Pn=E.scale(P,E.F.I(q));tn=E.scale(t,q)
   for h in range(len(arr)):
    expected=fast.residual(cube_evaluate(cube,h,q),cube['root'],Pn,tn)
    assert np.array_equal(at_tensor(arr,h),expected),(name,h)
   scalar=check_tensor_bounds(arr,psi,constant,record)
   base=tmp/name;base.mkdir();raw,inp=write_coefficient_input(base/'coefficients',arr,record,constant)
   cases.append((name,constant,record,q,base,raw,inp))
   print(name,': boundary root',q,'complete residual interpolation identity and pole/degree bounds verified.',flush=True)
  def case_job(case):
   name,constant,record,q,base,raw,inp=case
   def run(cmd,label):
    log=base/(label+'.log')
    with log.open('w') as out:subprocess.run(cmd,stdout=out,stderr=subprocess.STDOUT,check=True)
    return log.read_text()
   result=run([str(tmp/'verify_coefficients'),str(table),str(raw),str(inp)],'coefficient_verification')
   ee={e['index']:e for e in record['errors']};certdir=ROOT/'certificates'
   for j in [72,74]:
    prefix='boundary' if constant else name;stem=f'{prefix}_G71_{j}'
    cert=load(certdir/(stem+'.bounds.json'));assert cert['q']==q and cert['indices']==[71,j]
    lo,hi,factors,degree=check_dual_bounds(cert,ee[71],ee[j],fast)
    if not constant:
     assert [p for e,p in factors]==record['Psi_factors']
    source=base/(stem+'.input');write_resultant_input(source,ee[71],ee[j],lo,hi,factors)
    target=base/stem
    result+=run([str(tmp/'interpolate_fast_resultants'),str(table),str(source),str(target),'compute'],stem)
    assert np.array_equal(readpoly(str(target)+'.poly'),readpoly(certdir/(stem+'.poly')))
    assert len(readpoly(str(target)+'.poly'))-1==degree==boundary_index[name]['resultant_degrees_H'][0 if j==72 else 1]
   bp='boundary_fastbezout' if constant else name+'_bezout';prefix='boundary' if constant else name
   result+=run([str(tmp/'bezout_fast'),str(table),str(certdir/f'{prefix}_G71_72.poly'),str(certdir/f'{prefix}_G71_74.poly'),str(certdir/bp),'verify'],'bezout')
   G=readpoly(certdir/(bp+'.gcd'))
   if constant:assert G.tolist()==[1]
   else:
    rad=quotient_certificate(certdir/f'{name}_candidates',G,record,fast)
    assert len(rad)==10
    result+='Degree-nine radical, its fifth-power identity, and full quotient-ring Bezout identity 1 verified.\n'
   result+='EXCLUDED: every geometric H and every geometric scaling on this valid coefficient-zero boundary.\n'
   print('\n=== '+name+' ===\n'+result,flush=True)
   return name
  with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:list(pool.map(case_job,cases))
 print('ALL ELEVEN COEFFICIENT-ZERO BOUNDARY EXCLUSIONS VERIFIED.',flush=True)
 print('FULL RESULT: PARTIAL. No decision on the remaining open ratio locus; no square witness.',flush=True)
 print('Elapsed verification seconds:',round(time.time()-start,3),flush=True)
if __name__=='__main__':main()
