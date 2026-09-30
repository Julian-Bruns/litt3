"""Regression checks for the reciprocal jet and arithmetic accelerations.
The universal jet identity is proved in REPORT.md; finite checks do not
replace that proof or decide any global square locus.
"""
import argparse,json,random,time
from pathlib import Path
from ff import Poly,add,mul,power
import ext
from ext import Element as E,EP
from residual import residual,RATIO,check_open,peval,Tails
from residual_jet import residual_jet
ROOT=Path(__file__).resolve().parents[1]

def arithmetic_checks():
 rng=random.Random(202609272142)
 sizes=[(1,400),(25,25),(70,50),(101,91),(100,7),(500,160),(153,153)]
 for na,nb in sizes:
  a=Poly([rng.randrange(390625) for _ in range(na)])
  b=Poly([rng.randrange(390625) for _ in range(nb)])
  c=[0]*(na+nb-1)
  for i in range(na):
   for j in range(nb):c[i+j]=add(c[i+j],mul(a[i],b[j]))
  assert a*b==Poly(c)
  for n in [1,23,(na+nb)//2,na+nb]:assert a.mullow(b,n)==Poly(c).truncate(n)
  assert a*b//a==b
 for deg in [8,16,50,153]:
  mod=Poly([rng.randrange(390625) for _ in range(deg)]+[1]);ext.context(mod)
  aa=[Poly([rng.randrange(390625) for _ in range(deg)]) for _ in range(9)]
  bb=[Poly([rng.randrange(390625) for _ in range(deg)]) for _ in range(13)];bb[-1]=Poly(1)
  a=EP([E(x) for x in aa]);b=EP([E(x) for x in bb]);c=a*b
  cc=[Poly() for _ in range(21)]
  for i in range(9):
   for j in range(13):cc[i+j]=cc[i+j]+aa[i]*bb[j]
  assert c==EP([E(x%mod) for x in cc])
  for n in [1,7,20,25]:assert a.mullow(b,n)==c.truncate(n)
  assert c//b==a
 return {'base_convolutions':sizes,'finite_algebra_dimensions':[8,16,50,153],
         'comparison':'naive K-code convolution; separate coefficientwise modulus reduction'}

def run_checks():
 start=time.time();arith=arithmetic_checks();print('Accelerated convolution exact comparisons passed',flush=True)
 cases=[]
 for qv,max_n in [(1,140),(2,72),(3,72),(29,72)]:
  b,c,e=[Poly(RATIO[k]).eval(qv) for k in ['b','c','e']]
  u=ext.context([mul(3,e),mul(2,c),b]);q=E(qv);check_open(q,u)
  rr,A=residual(q,u);jj,B=residual_jet(q,u,max_n)
  for s in range(7):
   for i in range(max_n+1):assert rr[s][140-i]==jj[s][i]
  assert A[:max_n+1]==B
  ts=Tails(A,max_n=max_n);tj=Tails(B,max_n=max_n)
  for n in range(71,max_n+1):assert ts.tail(n)==tj.tail(n)
  cases.append({'q':qv,'dimension':2,'max_n':max_n,'all_scale_coefficients_agree':True})
  print('Reciprocal jet agrees: q',qv,'through',max_n,flush=True)
 # Same exact nilpotent family as the independent endpoint regression.
 b,c,e=[Poly(RATIO[k]) for k in ['b','c','e']]
 m=Poly([mul(3,e.eval(1)),mul(2,c.eval(1)),b.eval(1)]).monic();u=ext.context(m*m);q=E(1)
 gg=peval(b.tolist(),q)*u*u+2*peval(c.tolist(),q)*u+3*peval(e.tolist(),q)
 gq=peval(b.derivative().tolist(),q)*u*u+2*peval(c.derivative().tolist(),q)*u+3*peval(e.derivative().tolist(),q)
 q=q-gg/gq;check_open(q,u)
 rr,A=residual(q,u);jj,B=residual_jet(q,u,140)
 assert A==B
 for s in range(7):
  for i in range(141):assert rr[s][140-i]==jj[s][i]
 result={'status':'passed','arithmetic':arith,'jet_cases':cases,
         'nilpotent_case':{'dimension':4,'max_n':140,'all_987_coefficients_agree':True},
         'elapsed_seconds':round(time.time()-start,3)}
 print('JET_VERIFICATION_SUMMARY_JSON='+json.dumps(result,sort_keys=True),flush=True)
 return result
if __name__=='__main__':
 ap=argparse.ArgumentParser();ap.add_argument('--save-summary',action='store_true');args=ap.parse_args()
 out=run_checks()
 if args.save_summary:(ROOT/'checks/jet_verification.json').write_text(json.dumps(out,indent=2)+'\n')
