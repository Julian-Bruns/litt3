"""Exact complete scale checks at the fourteen coordinate-cubic triple ratios.

The finite ratio stratum is certified by check_cubic_branch.py. No unknown
scale is restricted to a finite field. A unit polynomial Bezout identity
excludes every geometric scale in each coefficient-field factor.
"""
from __future__ import annotations
import hashlib,json,os,shutil,subprocess,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(ROOT/'src')]
import field as F,poly as U,evaluate as E,polynomial_model as PM

def canonical_bytes(x):return json.dumps(x,sort_keys=True,separators=(',',':')).encode()

def verify_bezout(mod,rows):
 """Independent Python multiplication check; no C++ result is trusted as 1."""
 n=len(mod)-1;zero=(0,)*n;one=(1,)+(0,)*(n-1)
 assert len(rows['tails_ascending_mu'])==len(rows['bezout_multipliers_ascending_mu'])
 for name in ['tails_ascending_mu','bezout_multipliers_ascending_mu']:
  assert all(len(x)==n and all(0<=v<F.ORDER for v in x) for p in rows[name] for x in p)
 def ea(a,b):return tuple(F.add(x,y) for x,y in zip(a,b))
 def em(a,b):
  v=[0]*(2*n-1)
  for i,x in enumerate(a):
   if x:
    for j,y in enumerate(b):
     if y:v[i+j]=F.add(v[i+j],F.mul(x,y))
  for i in range(2*n-2,n-1,-1):
   z=v[i]
   if z:
    for j in range(n):v[i-n+j]=F.sub(v[i-n+j],F.mul(z,mod[j]))
  return tuple(v[:n])
 def trim(p):
  while p and p[-1]==zero:p.pop()
  return p
 def pa(a,b):
  c=a.copy()+[zero]*max(0,len(b)-len(a))
  for i,y in enumerate(b):c[i]=ea(c[i],y)
  return trim(c)
 def pm(a,b):
  if not a or not b:return []
  c=[zero]*(len(a)+len(b)-1)
  for i,x in enumerate(a):
   if x!=zero:
    for j,y in enumerate(b):
     if y!=zero:c[i+j]=ea(c[i+j],em(x,y))
  return trim(c)
 got=[]
 for a,b in zip(rows['tails_ascending_mu'],rows['bezout_multipliers_ascending_mu']):
  got=pa(got,pm(list(map(tuple,a)),list(map(tuple,b))))
 target=list(map(tuple,rows['monic_tail_gcd']))
 assert got==target
 if rows['all_geometric_scales_excluded']:assert target==[one]
 return True

def main():
 if sys.flags.optimize:raise RuntimeError('Assertions must be enabled')
 compiler=os.environ.get('CXX','g++')
 if shutil.which(compiler) is None:raise RuntimeError('A C++17 compiler is required; tested with g++ 14.2.0')
 branch=json.loads((ROOT/'resolution/data/cubic_branch.json').read_text())
 cc=json.loads((ROOT/'resolution/data/critical_coordinates.json').read_text())
 data=json.loads((ROOT/'data/cube_free.json').read_text())
 def input_text(mod):
  out=['914021',str(len(mod)-1),' '.join(map(str,mod))]
  cf=cc['cubic_f']
  for p in [E.P,E.t,data['Qbar_x_polynomial']]+[cf[k] for k in ['a0','d','b','c','e']]:
   out.append(str(len(p))+' '+' '.join(map(str,p)))
  for i in range(2,6):
   terms=data['barred_numerators']['g'+str(i)];out.append(str(len(terms)))
   for ex,v in terms:out.append(' '.join(map(str,ex+[v])))
  return '\n'.join(out)+'\n'
 checked=[]
 with tempfile.TemporaryDirectory(prefix='r9-cusp-scales-') as temp:
  exe=Path(temp)/'cusp_scale'
  subprocess.run([compiler,'-std=c++17','-O3','-Wall','-Wextra','-Werror',str(ROOT/'resolution/src/cusp_scale.cpp'),'-o',str(exe)],check=True,capture_output=True,text=True)
  for idx,record in enumerate(branch['q_factors']):
   mod=record['q_minpoly_monic_K_codes'];n=len(mod)-1
   print('Checking complete scale line over ratio field factor '+str(idx)+' (degree '+str(n)+')',flush=True)
   process=subprocess.run([str(exe)],input=input_text(mod),capture_output=True,text=True)
   if process.returncode:raise RuntimeError(process.stderr+'\n'+process.stdout)
   row=json.loads(process.stdout)
   assert row['q_minpoly_K_codes']==mod and row['field_degree_over_K']==n
   for name in ['H','s']:
    rem=U.rem(branch['triple_ratio_algebra'][name+'_mod_C'],mod)
    assert row[name]==rem+[0]*(n-len(rem))
   assert row['source_degree_140_leading_check']
   verify_bezout(mod,row)
   R=row.pop('regenerable_residual_scale_rows')
   row['residual_array_sha256']=hashlib.sha256(canonical_bytes(R)).hexdigest()
   row['independent_python_bezout_check']=True
   row['independent_K_residual_comparisons']=[]
   if n==1:
    H,q=row['H'][0],row['q'][0]
    for mu in [0,1]:
     actual=[]
     for k,rr in enumerate(R):actual=U.add(actual,U.scale([x[0] for x in rr],F.powk(mu,k)))
     expected=PM.evaluate_polynomial(H,q,mu)
     assert actual==expected
     row['independent_K_residual_comparisons'].append(mu)
   checked.append(row)
   print('factor '+str(idx)+': '+('EMPTY for all geometric scales' if row['all_geometric_scales_excluded'] else 'UNRESOLVED')+'; tail degrees '+str([len(p)-1 for p in row['tails_ascending_mu']])+'; independent Bezout PASS',flush=True)
 all_empty=all(r['all_geometric_scales_excluded'] for r in checked)
 assert all_empty, 'The finite-stratum exclusion certificate is incomplete'
 result={'scope':'Complete fourteen-point coordinate-cubic triple-root ratio stratum ONLY, with arbitrary geometric scale. Not the whole moving-ratio decision.',
   'ratio_stratum':'C(q)=0, u=-c/b, H=-c/(b*q), s=(a0*c-2*b^2)/(d*c)',
   'ratio_degrees':[r['field_degree_over_K'] for r in checked],
   'geometric_ratio_count':sum(r['field_degree_over_K'] for r in checked),
   'source_residual_model':'S_model=(q*d)^36*Rcal; exact source and universal fixed-degree resultant from data/cube_free.json',
   'necessary_tails':'Coefficients 71 onward of Ahat^63, without discarding any scale degree drop',
   'factors':checked,
   'stratum_all_geometric_scales_empty':all_empty,
   'nilpotent_lift':'On the full triple-root cubic algebra, a lifted Bezout expression is 1+W with W^3=0; multiply by 1-W+W^2. Proof in REPORT.md.',
   'main_moving_ratio_decision':'UNRESOLVED'}
 (ROOT/'resolution/data/cusp_scales.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps({'status':'PASS','complete_ratio_stratum_empty':all_empty,
   'geometric_ratios':result['geometric_ratio_count'],'coefficient_field_factors':len(checked),
   'all_scales_geometric_not_finite_field_search':True,'main_decision':'UNRESOLVED'},indent=2),flush=True)
if __name__=='__main__':main()
