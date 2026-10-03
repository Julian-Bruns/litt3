#!/usr/bin/env sage
"""Four fixed leading ratios and four tensor kernels; no source search."""
import json,time,signal
from pathlib import Path
started=time.monotonic()
signal.signal(signal.SIGALRM,lambda s,f:(_ for _ in ()).throw(TimeoutError('fixed four-ratio hard10s')))
signal.setitimer(signal.ITIMER_REAL,10)
E=GF(5**8,'e'); R=PolynomialRing(E,'x'); x=R.gen()
beta=(x*x-x-3).roots(multiplicities=False)[0]
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
def enc(c):return [int(a) for a in E(c).polynomial().list()]
def encp(p):return [enc(c) for c in p.list()]
P=poly([11,22,18,5,19,20,15,16,9,22,1])
Z=poly([15,19,24,12,10,19,3,24,18,16])
A=poly([1,21,14,22,13]);q=poly([13,18,24]);q3=poly([1,22,9,1])
roots=A.roots(multiplicities=False);assert len(roots)==4
all_units=all(q(s)!=0 for s in roots)
records=[]
for s in roots:
 rec={'root':enc(s),'q_value':enc(q(s)),'q3_value':enc(q3(s))}
 if q(s):
  ratio=-q3(s)/q(s); d0=q3+ratio*q
  rec.update({'leading_ratio':enc(ratio),'d0':encp(d0),
              'gcd_A_degree':int(d0.gcd(A).degree()),
              'discriminant_nonzero':bool(d0.discriminant()),
              'Rd0_at_shared_root':enc(((Z*d0)%P)(s)),
              'Rd0_at_shared_root_nonzero':bool(((Z*d0)%P)(s))})
 records.append(rec)
differences=[]
for i in range(4):
 for j in range(i+1,4):
  num=q3(roots[i])*q(roots[j])-q3(roots[j])*q(roots[i])
  differences.append({'pair':[i,j],'numerator':enc(num),'nonzero':bool(num)})
out=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform/selected_leading_ratio_separation.json')
out.write_text(json.dumps({'scope':'NEW fixed four-value selected leading pencil separation, no source-coefficient rank assertion',
 'field_modulus':[int(c) for c in E.modulus().list()],'beta':enc(beta),'records':records,
 'differences':differences,'all_q_units':all_units,
 'all_distinct':all(v['nonzero'] for v in differences),
 'seconds':time.monotonic()-started},indent=2)+'\n')
Rq=(Z*q)%P;R3=(Z*q3)%P
tensor_records=[]
for omitted in roots:
 t=A//(x-omitted)
 cols=[(2*q3*Rq-3*q*R3)%t,(-q*Rq)%t,(-q3*R3)%t,(2*q*R3-3*q3*Rq)%t]
 M=matrix(E,[[cols[j][i] for j in range(4)] for i in range(3)])
 K=M.right_kernel(); rank=int(M.rank())
 rec={'omitted':enc(omitted),'t':encp(t),'matrix':[[enc(c) for c in row] for row in M.rows()],
      'rank':rank,'kernel_basis':[[enc(c) for c in row] for row in K.basis()]}
 if K.dimension()==1:
  v=K.basis()[0];det=v[0]*v[3]-v[1]*v[2]
  p_compatible=bool(v[0] or v[2])
  rec.update({'tensor_determinant':enc(det),'rank_one_kernel':not bool(det),
              'pole_nine_leading_compatible':p_compatible})
  if not det and p_compatible:
   rec['necessary_leading_ratio']=enc(v[1]/v[0] if v[0] else v[3]/v[2])
 tensor_records.append(rec)
 print('FIXED TENSOR MAP',len(tensor_records),'rank',rank,'kernel_dimension',K.dimension(),
       'rank_one',rec.get('rank_one_kernel'),flush=True)
out2=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform/zero_n0_selected_tensor_maps.json')
out2.write_text(json.dumps({'scope':'NEW four fixed 3x4 maps on moment/leading rank-one tensors; no source-coefficient search',
 'field_modulus':[int(c) for c in E.modulus().list()],'beta':enc(beta),'records':tensor_records,
 'all_exclude_nonzero_first_moment':all(r.get('rank')==3 and
   (not r.get('rank_one_kernel') or not r.get('pole_nine_leading_compatible')) for r in tensor_records),
 'seconds':time.monotonic()-started},indent=2)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
print('FIXED FOUR RATIOS q-units',all_units,'distinct',all(v['nonzero'] for v in differences),flush=True)
print('SHARED ROOT GCD DEGREES',[r.get('gcd_A_degree') for r in records],flush=True)
print('DONE',time.monotonic()-started,flush=True)
