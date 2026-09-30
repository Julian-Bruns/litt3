"""Universal polynomial identity for the critical scale discriminant.
An independent sparse polynomial expansion over F5 (seven indeterminates)
verifies all coefficients, not evaluations of selected scalar values.
"""
from exact import ROOT,P,ps,pgcd,pder
from residual import resultant_coefficients
import json,time
NV=7
class S:
 def __init__(self,x=0):
  self.d=x.d if isinstance(x,S) else (x if isinstance(x,dict) else ({(0,)*NV:x%5} if x%5 else {}))
 def __add__(self,y):
  y=S(y);d=dict(self.d)
  for k,c in y.d.items():
   a=(d.get(k,0)+c)%5
   if a:d[k]=a
   else:d.pop(k,None)
  return S(d)
 __radd__=__add__
 def __neg__(self):return S({k:-c%5 for k,c in self.d.items()})
 def __sub__(self,y):return self+-S(y)
 def __rsub__(self,y):return S(y)+-self
 def __mul__(self,y):
  y=S(y);d={}
  for a,c in self.d.items():
   for b,e in y.d.items():
    k=tuple(x+y for x,y in zip(a,b));z=(d.get(k,0)+c*e)%5
    if z:d[k]=z
    else:d.pop(k,None)
  return S(d)
 __rmul__=__mul__
 def __pow__(self,n):
  r=S(1);a=self
  while n:
   if n&1:r=r*a
   n//=2
   if n:a=a*a
  return r

def run():
 start=time.time();vv=[]
 for i in range(NV):
  ex=[0]*NV;ex[i]=1;vv.append(S({tuple(ex):1}))
 a,b,c,g,Q,T,v=vv;D=b*b+a*c;N=a**5*Q**2-b**5*Q+c**5
 K=N*(D*g+a**3*Q+2*b*c*c)+T*D*(2*a**5*Q-b**5)
 C=resultant_coefficients(a,b,c,g,Q,T,v)
 lhs=C[1]**2-4*C[0]*C[2];rhs=v*v*D**3*K**2
 assert not (lhs-rhs).d
 assert pgcd(ps(P,[1]),pder(P))==[1]
 out={'status':'passed','ring':'F5[a,b,c,g,Q,T,v]',
  'identity':'C1^2-4*C0*C2=v^2*(b^2+a*c)^3*Kstar^2',
  'nonzero_terms_on_each_side':len(lhs.d),'difference_terms':0,
  'gcd_P_minus_1_Pprime':[1],
  'scope':'universal polynomial expansion; valid at every specialized degree drop',
  'seconds':round(time.time()-start,3)}
 (ROOT/'logs/critical_universal_identity.json').write_text(json.dumps(out,indent=2)+'\n')
 print('UNIVERSAL CRITICAL DISCRIMINANT IDENTITY VERIFIED',json.dumps(out),flush=True)
if __name__=='__main__':run()
