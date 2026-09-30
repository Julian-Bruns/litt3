"""Compact exact factorization over a supplied list of proved units.

Discovery uses the logarithmic derivative to recover multiplicities modulo
five. Exact division and a checked fifth root prove every step; a final
multiply-out checks the resulting certificate. Failure is explicit, never
interpreted as a new geometric exclusion.
"""
import numpy as np
from ff import Poly,EXP,LOG,inv

def balanced_product(polys):
 ps=[Poly(p)for p in polys if Poly(p)!=1]
 if not ps:return Poly(1)
 while len(ps)>1:
  ps.sort(key=len);ps=[ps[i]*ps[i+1]if i+1<len(ps)else ps[i]for i in range(0,len(ps),2)]
 return ps[0]

def series_inverse(a,n):
 assert a[0];r=Poly(inv(a[0]));m=1
 while m<n:
  m=min(m*2,n);r=r.mullow(2-a.mullow(r,m),m)
 return r.truncate(n)

def pow_five(f,e):
 assert e>=0;r=Poly(1);p=Poly(f)
 while e:
  digit=e%5
  if digit:r=r*(p**digit)
  e//=5
  if e:p=p.frob()
 return r

def rebuild(data,fs):
 ex=data['exponents'];assert len(ex)==len(fs) and all(isinstance(e,int)and e>=0 for e in ex)
 shift=0;parts=[]
 for f,e in zip(fs,ex):
  if not e:continue
  if f==Poly([0,1]):shift+=e
  else:parts.append(pow_five(f,e))
 return balanced_product(parts).shift(shift)*data['scalar']

def factor_known(p,fs,verify_product=True):
 p=Poly(p);assert p;original=p;scalar=p[p.degree()];p=p*inv(scalar);exps=[0]*len(fs);qinds=[i for i,f in enumerate(fs)if f==Poly([0,1])];assert len(qinds)==1
 v=int(np.flatnonzero(p.a)[0]);exps[qinds[0]]=v;p=Poly(p.a[v:]);others=[i for i in range(len(fs))if i!=qinds[0]]
 F=balanced_product([fs[i]for i in others]);assert F[0] and F.gcd(F.derivative())==1;N=F.degree();deninv={}
 for i in others:
  f=fs[i];den=((F//f)*f.derivative())%f;g,iv,_=den.xgcd(f);assert g==1;deninv[i]=iv%f
 level=1;steps=[]
 while p.degree()>0:
  assert p[0]
  logarithm=p.derivative().truncate(N).mullow(series_inverse(p.truncate(N),N),N)
  numerator=F.mullow(logarithm,N);digits=[0]*len(fs)
  for i in others:
   residue=(numerator*deninv[i])%fs[i]
   if residue.degree()>0 or residue[0] not in range(5):raise ArithmeticError(('factor outside proposed unit list',p.degree(),level,i))
   digits[i]=residue[0];exps[i]+=level*digits[i]
  A=balanced_product([fs[i]**digits[i]for i in others if digits[i]])
  quotient=p//A
  assert not quotient.a[np.arange(len(quotient))%5!=0].any(),('not a fifth power after unit extraction',p.degree(),level)
  raw=quotient.a[::5];root=np.where(raw==0,0,EXP[(LOG[raw].astype(np.uint64)*78125)%390624]).astype(np.uint32)
  newp=Poly(root);assert newp.frob()==quotient
  steps.append({'degree_before':p.degree(),'degree_removed':A.degree(),'fifth_root_degree':newp.degree()});p=newp;level*=5
 assert p==1
 result={'scalar':scalar,'exponents':exps,'discovery_steps':steps}
 if verify_product:assert rebuild(result,fs)==original
 return result
