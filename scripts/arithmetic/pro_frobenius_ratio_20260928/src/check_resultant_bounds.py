#!/usr/bin/env python3
"""Independent proof checks for global resultant degree/pole bounds.

No resultant values or point searches enter this verification.  Hensel
congruences, raw-model prime-power divisibility, scale weights and integer
assignment duals certify polynomial normalization over the entire curve.
"""
import json,time,hashlib
from pathlib import Path
import numpy as np
from ff import Poly,X,power,mul
from global_curve import QC,Z0,Z1,b,c,e
from residual import RATIO
from reconstruct import epsilon
from global_units import known_q_units
from resultant_bounds import tropical_tails,valuation,lift_root,INF
ROOT=Path(__file__).resolve().parents[1]

def verify():
 start=time.time();dat=json.loads((ROOT/'data/resultant_pole_bounds.json').read_text());fs=[Poly(f)for f in json.loads((ROOT/'data/zero_scale_compact.json').read_text())['unit_factors']]
 G=np.load(ROOT/'data/global_residual.npz')['coefficients'];assert hashlib.sha256(G.astype('<u4').tobytes()).hexdigest()=='b7da17bf2b8553a8019909fe87214464ba4123cbfe44599f5011e04005b04a44'
 old=known_q_units();prod=Poly(1)
 for f in fs:
  assert f[f.degree()]==1 and not old%f
  assert prod.gcd(f)==1;prod=prod*f
  # Exact absence of any additional K-rational normalization holes.
  roots=f.gcd(X.powmod(390625,f)-X)
  assert roots==f if f.degree()==1 else roots==1
 a0,d,delta3=Poly(RATIO['a0']),Poly(RATIO['d']),b*b*c*c+Poly(RATIO['a0'])*c**3+b**3*e+3*Poly(RATIO['a0'])**2*e**2+3*Poly(RATIO['a0'])*b*c*e
 z=QC(0,1);JV=z**3*a0+z**2*b*b+z*c*b*b+QC(e*b**3)
 pp=[[[Poly(G[j,n,s])for s in range(7)]for n in range(75)]for j in range(2)]
 leading=QC(pp[0][0][0],pp[1][0][0]);assert leading==(z**9)*(JV**3)*(b**54*X**84*d**33)*mul(2,power(epsilon,24))
 norm=leading.norm();assert norm==b**126*X**168*d**66*e**12*delta3**3*mul(3,power(epsilon,48));assert norm.degree()==1044
 for n in range(141):
  for s in range(7):
   if 4*s>3*n:assert not G[:,n,s,:].any()
 # The three companion b-branches have finite u and a regular normalization.
 regular=[]
 for i in (3,12,16):
  f=fs[i];m=73;zz=lift_root(f,Poly(),m);mod=f**m
  v0=valuation((leading.a+leading.b*zz)%mod,f,m);assert v0==72
  for n in range(75):
   for s in range(7):assert valuation((pp[0][n][s]+pp[1][n][s]*zz)%mod,f,m)>=72
  regular.append({'factor_index':i,'leading_valuation':72,'verified_regular_coefficients':75*7})
 finite={n:{}for n in (72,73,74)};infs={}
 for place in dat['places']:
  vals=np.array(place['values'],dtype=np.int64)
  if place['name']=='infinity':
   assert place['multiplicity']==2
   for n in range(75):
    for s in range(7):
     aa,bb=pp[0][n][s],pp[1][n][s]
     expected=522-max(aa.degree(),bb.degree()+7 if bb else -1)if aa or bb else INF
     assert vals[n,s]==expected
  else:
   f=fs[place['factor_index']];m=place['precision'];v0=place['leading_valuation'];mod=f**m
   if place['branch']=='quadratic':zz=None;assert place['multiplicity']==2
   else:
    zz=Poly(place['lifted_root']);assert not (zz*zz-Z1*zz-Z0)%mod;assert (2*zz-Z1).gcd(f)==1;assert place['multiplicity']==1
   for n in range(75):
    for s in range(7):
     aa,bb=pp[0][n][s],pp[1][n][s]
     if not aa and not bb:assert vals[n,s]==INF;continue
     val=min(valuation(aa,f,m),valuation(bb,f,m))if zz is None else valuation((aa+bb*zz)%mod,f,m)
     assert vals[n,s]==val-v0
   assert vals[0,0]==0
  tails=tropical_tails(vals)
  for n,tt in tails.items():assert tt==place['tail_bounds'][str(n)]
  for n in (72,73,74):
   a,bb=tails[71],tails[n];n1,n2=len(a)-1,len(bb)-1;N=n1+n2;cert=place['resultants'][str(n)];rr,cc=cert['row_potentials'],cert['column_potentials'];assert len(rr)==len(cc)==N
   for i in range(N):
    for j in range(N):
     row,at=(a,j-i)if i<n2 else(bb,j-(i-n2))
     if 0<=at<len(row):assert rr[i]+cc[j]<=row[at]
   bound=sum(rr)+sum(cc);assert bound==cert['bound'];bound*=place['multiplicity']
   if place['name']=='infinity':infs[n]=bound
   else:
    fi=place['factor_index'];finite[n][fi]=finite[n].get(fi,0)+bound
 for n in (72,73,74):
  r=dat['resultants'][str(n)];assert finite[n]=={int(k):v for k,v in r['finite_valuation_lower_bounds'].items()};assert infs[n]==r['valuation_at_infinity_lower_bound']
  assert -infs[n]-sum(v*fs[i].degree()for i,v in finite[n].items())==r['degree_bound']
 result={'status':'whole-curve polynomial resultant degree bounds proved; no global exclusion claimed by this check','resultant_degrees':{n:dat['resultants'][str(n)]['degree_bound']for n in (72,73,74)},'finite_u_b_branches':regular,'rational_holes':sum(f.degree()==1 for f in fs),'model_sha256':hashlib.sha256(G.astype('<u4').tobytes()).hexdigest(),'seconds':round(time.time()-start,3)}
 (ROOT/'checks/resultant_bounds.json').write_text(json.dumps(result,indent=2)+'\n');print('GLOBAL_RESULTANT_BOUNDS_VERIFIED='+json.dumps(result),flush=True)
 return result
if __name__=='__main__':verify()
