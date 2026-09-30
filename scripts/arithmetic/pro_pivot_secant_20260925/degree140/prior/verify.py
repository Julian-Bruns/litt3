#!/usr/bin/env python3
"""Verify all computational claims. No global emptiness/witness decision is performed.
This regenerates temporary field tables and exact atlases, tests original equations,
checks all saved data and Bezout identities, and independently checks resultants.
"""
import argparse,hashlib,json,platform,subprocess,sys,tempfile,time
from pathlib import Path
import numpy as np
ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'src'))
import exact as E
from atlas import reconstruct,fixed_data
from series_chart import gen_chart
from residual import evaluate_chart,residual_lambda,evaluate_lambda,square_check,resultant_coeffs,norm_lambda
from scale_errors import errors,xgcd
from cube_chart import build as cube_build,evaluate as cube_evaluate
from necessary_curve import specification,sylvester
from checks import check_original_atlas,scalar_resultant_checks,infinity_certificate

def load(path):return json.loads(Path(path).read_text())
def check_manifest():
 path=ROOT/'SHA256SUMS'
 if not path.exists():print('Manifest not yet present (packaging-stage verification).');return
 n=0
 for line in path.read_text().splitlines():
  digest,rel=line.split('  ',1);assert hashlib.sha256((ROOT/rel).read_bytes()).hexdigest()==digest,rel;n+=1
 print(f'SHA-256 manifest: {n} files checked.',flush=True)

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--skip-manifest',action='store_true');args=ap.parse_args()
 if not args.skip_manifest:check_manifest()
 print('STATUS: PARTIAL. The full geometric square locus is not decided.',flush=True)
 print('Python:',sys.version.replace('\n',' '),'NumPy:',np.__version__,'platform:',platform.platform(),flush=True)
 start=time.time()
 with tempfile.TemporaryDirectory(prefix='degree140_verify_') as tmp:
  tmp=Path(tmp);exe=tmp/'field_tables';table=tmp/'field.bin'
  subprocess.run(['g++','-O3','-std=c++17',str(ROOT/'src/field_tables.cpp'),'-o',str(exe)],check=True)
  subprocess.run([str(exe),str(table)],check=True);E.init(table);F=E.F
  fixed=load(ROOT/'data/fixed.json');P,A,Q,B,L,t,Ct=fixed_data()
  roots=np.flatnonzero(E.evaluate(P,np.arange(E.SIZE,dtype=np.int32))==0).tolist();assert roots==fixed['roots_P']
  assert E.evaluate(E.poly(fixed['alpha_minpoly_over_F5']),25)==0
  recovered=F.M(int(E.evaluate(E.poly(fixed['beta_in_alpha']['numerator']),25)),F.I(int(E.evaluate(E.poly(fixed['beta_in_alpha']['denominator']),25))))
  assert recovered==5
  for a,b in [(P,E.derivative(P)),(A,E.derivative(A)),(P,A),(t,Ct)]:
   while len(b):a,b=b,E.rem(a,b)
   assert len(a)==1
  print('Field, all ten P-roots, Q-primitives, squarefreeness and coprimality: verified.',flush=True)
  print('Independent fixed-degree Sylvester tests:',scalar_resultant_checks(),'including degree drops.',flush=True)
  z=E.poly([0,1]);p13=E.power(E.poly([1,1]),13);expected=np.zeros(27,dtype=np.int32);expected[[0,1,25,26]]=1
  assert E.power(p13,2).tolist()==expected.tolist()
  print('Constant-v weight-zero square-root identity: verified.',flush=True)
  curve_specs={x['atlas']:x for x in load(ROOT/'data/necessary_curve_specs.json')}
  for fn in sorted((ROOT/'data').glob('atlas_*.json')):
   a=load(fn);rebuilt=reconstruct(a['root'],tmp/fn.name);assert rebuilt==a
   assert check_original_atlas(a)
   c=load(fn.with_name(fn.name.replace('atlas_','chart_')));assert gen_chart(a)==c
   cube=load(fn.with_name(fn.name.replace('atlas_','cube_')));assert cube_build(a,c)==cube
   H,par=evaluate_chart(a,c,2,1);R=residual_lambda(H,a['root']);original=residual_lambda(H,a['root'],False)
   assert all(not len(E.sub(x,y)) for x,y in zip(R,original))
   saved=load(fn.with_name(fn.name.replace('atlas_','residual_h2w1_')))
   assert saved['parameters']==par and [p.tolist() for p in R]==saved['R_lambda']
   bounds=[140,138,137,136,133,131,129] if a['root'] is None else [140,138,137,136,134,133,132]
   assert [len(p)-1 for p in R]==bounds
   lc=F.P(F.M(3,F.M(F.P(2,3),F.M(F.P(c['epsilon'],8),par['F6']))),3);assert R[0][140]==lc
   inf=infinity_certificate(H,a['root'],R)
   inf_fn=fn.with_name(fn.name.replace('atlas_','infinity_h2w1_'))
   if inf_fn.exists():assert inf==load(inf_fn)
   _,es=errors(R)
   assert all(len(e)-1<=min(104,(3*m)//4) for e,m in zip(es,range(71,141)))
   if a['root'] is None:
    ag=F.M(2,F.M(F.P(c['epsilon'],6),F.P(2,-9)))
    assert F.M(int(R[3][136]),F.I(int(R[0][140])))==ag
    assert len(es[29])-1==75 and int(es[29][-1])==F.N(F.P(ag,25))
   cert=load(ROOT/'certificates'/fn.name.replace('atlas_','bezout_h2w1_'))
   assert [p.tolist() for p in es[:2]]==cert['errors']
   aa,bb=[E.poly(p) for p in cert['bezout']]
   assert E.add(E.mul(aa,es[0]),E.mul(bb,es[1])).tolist()==[1]
   spec=curve_specs[fn.name];ii=spec['error_indices'];dd=spec['fixed_degrees'];ff=[es[i-71] for i in ii]
   assert [len(p)-1 for p in ff]==dd
   val=sylvester(ff[0],ff[1],*dd);assert val==spec['determinant_value'] and val
   if a['root'] is None:
    sp=load(ROOT/'certificates/constant_ratio_resultant_specialization.json')
    assert [p.tolist() for p in ff]==sp['errors'];aa,bb=[E.poly(p) for p in sp['bezout']]
    assert E.add(E.mul(aa,ff[0]),E.mul(bb,ff[1])).tolist()==[1]
   for item in saved['checks']:
    rp=evaluate_lambda(R,item['lambda']);assert (square_check(rp) is not None)==item['square']
    assert sum(1 for i,cf in enumerate(rp) if cf and i%5)==item['nonzero_non5_coeffs']
   # A second ratio pair tests the nontrivial cube-root-free change and q^13 factor.
   H_old,par2=evaluate_chart(a,c,3,2);q=F.P(2,3);Hratio=F.M(3,2) if a['root'] is None else F.M(3,F.I(2))
   H_new=cube_evaluate(cube,Hratio,q)
   for x,y in zip(H_old,H_new):
    transformed=tuple(E.scale(p,F.P(2,j-1)) for j,p in enumerate(x));assert all(not len(E.sub(p,r)) for p,r in zip(transformed,y))
   psi=__import__('sparse').Poly.read(cube['Psi']).evaluate([Hratio,q,0,0]);dd=__import__('sparse').Poly.read(cube['common_denominator_d']).evaluate([Hratio,q,0,0]);assert F.M(psi,F.I(F.M(q,F.P(dd,2))))==par2['F6']
   Pn=E.scale(P,F.I(q));tn=E.scale(t,q);v=E.poly([1]) if a['root'] is None else E.poly([F.N(a['root']),1])
   Tn=(E.poly(),E.mul(E.power(tn,3),E.power(Pn,3)),E.poly())
   rr=resultant_coeffs(H_new,(Q,E.poly(),E.poly()),Tn,Pn,v);rn=norm_lambda(rr,Pn);den=E.mul(E.mul(E.power(Pn,40),E.power(tn,15)),E.power(v,3));Rn=[E.exactdiv(p,den) for p in rn]
   Ro=residual_lambda(H_old,a['root'])
   assert all(not len(E.sub(p, E.scale(r, F.M(F.P(q,13), F.P(2,j))))) for j, (p,r) in enumerate(zip(Rn,Ro)))
   print(fn.name,': original (1)-(4), full chart, two residual routes, all-scale Bezout, necessary curve, lambda-infinity factor, and cube-free identity VERIFIED.',flush=True)
  print('All computational claims passed.',flush=True)
  print('NOT CHECKED/NOT CLAIMED: absence or existence above the necessary ratio curves; global square-ideal elimination.',flush=True)
  print('Elapsed verification seconds:',round(time.time()-start,3),flush=True)

if __name__=='__main__':main()
