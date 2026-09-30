"""Exact endpoint normalization at the distinguished ramified point x=r=[9].
No source-specialization or scale inversion is used to derive the endpoint formula.
"""
import json
from pathlib import Path
from ff import *
from sparse import Sparse as S
from residual import RATIO
from reconstruct import P,t,B0
ROOT=Path(__file__).resolve().parents[1]
S.N=2 # (u,q), only in this standalone process/module
u,q=S.var(0),S.var(1)

def peval(cs,x):
 out=S()
 for a in cs[::-1]:out=out*S(x)+a
 return out

def eval_sp(f,U,Q):
 out=U*0
 for (i,j),v in f.d.items():out=out+v*(U**i)*(Q**j)
 return out

def padd(a,b):
 return [(a[i] if i<len(a) else S())+(b[i] if i<len(b) else S()) for i in range(max(len(a),len(b)))]
def pscale(a,b):return [c*b for c in a]
def pmulK(a,b):
 b=Poly(b).tolist()
 o=[S() for _ in range(len(a)+len(b)-1)]
 for i,x in enumerate(a):
  for j,y in enumerate(b):o[i+j]=o[i+j]+x*S(y)
 return o

def pdivideK(a,b):
 a=a.copy();b=Poly(b)
 out=[S() for _ in range(max(0,len(a)-len(b)+1))]
 for i in range(len(out)-1,-1,-1):
  z=a[i+len(b)-1]*S(inv(b[b.degree()]));out[i]=z
  for j in range(len(b)):a[i+j]=a[i+j]-z*S(b[j])
 assert not any(a)
 return out

def source_T():
 data=json.loads((ROOT/'data/source_cramer.json').read_text())
 ans=[]
 for gi in data['G_numerators']:
  comp=[]
  for j,row in enumerate(gi):
   rr=[]
   for terms in row:
    a=S()
    for (ha,wb,ka,kb),cf in terms:
     assert ka==kb==0
     k=wb-2*ha+j-1;assert k%3==0
     e=k//3+1;assert e>=0
     a=a+S({(ha,e):cf})
    rr.append(a)
   comp.append(rr)
  ans.append(comp)
 return ans

def endpoint_data():
 TT=source_T();R=9
 div=lambda a:q*peval(pdivideK(a,P),R)
 aa=div(TT[0][0])
 bb=div(padd(TT[1][0],pscale(pmulK(TT[0][0],B0),S(2))))
 cc=div(padd(padd(TT[2][1],pscale(pmulK(TT[1][1],B0),S(3))),pscale(pmulK(TT[0][1],B0**2),S(3))))
 dd=div(padd(padd(padd(TT[3][2],pscale(pmulK(TT[2][2],B0),S(4))),pmulK(TT[1][2],B0**2)),pscale(pmulK(TT[0][2],B0**3),S(4))))
 ratio_d=S({(0,i):x for i,x in enumerate(RATIO['d'])})
 tr=t.eval(R);pr=P.derivative().eval(R)
 EE=q**4*ratio_d*S(power(tr,3))*bb**6+S(2)*bb*cc**5*dd+S(2)*cc**7
 denominator=S(power(tr,5))*q**18*ratio_d**12
 l0=S(mul(3,pr))*aa**3*bb**2*EE
 l1=S(4)*q**2*ratio_d*bb**4*EE
 return {'A':aa,'B':bb,'C':cc,'D':dd,'E':EE,'D0':denominator,'ell0_numerator':l0,'ell1_numerator':l1}

def compact_model():
 data=endpoint_data();ratio_d=S({(0,i):v for i,v in enumerate(RATIO['d'])})
 Abar=S({(1,0):9004,(0,1):3794});Bbar=S({(1,0):113149,(0,1):216934});c0=186002
 Dbar=S({(i,j-1):v for (i,j),v in data['D'].d.items()})
 tr=t.eval(9);pr=P.derivative().eval(9)
 Ebar=ratio_d*S(power(tr,3))*Bbar**6+S(mul(2,power(c0,5)))*q**2*Bbar*Dbar+S(mul(2,power(c0,7)))*q**4*ratio_d
 assert data['A']==q*ratio_d*Abar
 assert data['B']==q*ratio_d*Bbar
 assert data['C']==q**2*ratio_d*S(c0)
 assert data['D']==q*Dbar
 assert data['E']==q**10*ratio_d**6*Ebar
 return {'Abar':Abar,'Bbar':Bbar,'Dbar':Dbar,'Ebar':Ebar},tr,pr,c0

def serialize_model():
 data,tr,pr,c0=compact_model()
 return {'conventions':'Sparse exponents (u,q); K-codes.', 'endpoint':9,
         't_at_r':tr,'Pprime_at_r':pr,'c0':c0,
         'ell_formula':'ell(mu)=4*Bbar^2*Ebar*(q*mu*Bbar^2+2*Pprime_at_r*Abar^3)/(t_at_r^5*q^3*d)',
         'endpoint_identity':'Rcal_r(9)=ell(mu)^3',
         'polynomials':{n:f.serialize() for n,f in data.items()}}

if __name__=='__main__':
 data=endpoint_data()
 for n,f in data.items():
  print(n,'terms',len(f.d),'u-degree',max((e[0] for e in f.d),default=-1),'q-degree',max((e[1] for e in f.d),default=-1),flush=True)
  if len(f.d)<=20:print(f.serialize(),flush=True)
 dest=ROOT/'data/endpoint_model.json';dest.write_text(json.dumps(serialize_model(),indent=2)+'\n')
 print('Wrote',dest,flush=True)
