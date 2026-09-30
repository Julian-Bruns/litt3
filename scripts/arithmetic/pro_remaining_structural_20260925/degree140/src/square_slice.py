"""Exact all-geometric-inverse-scaling square test on a fixed coefficient slice.
This is NOT a search over scalars lambda. A polynomial Bezout identity excludes
all nonzero lambda in the algebraic closure when the common gcd is a monomial.
"""
import json, sys
from pathlib import Path
from ff import *

def pxgcd(a,b):
 s,t,ss,tt=[1],[],[],[1]
 while b:
  q,r=pdivmod(a,b);a,b=b,r;s,ss=ss,psub(s,pmul(q,ss));t,tt=tt,psub(t,pmul(q,tt))
 if not a:return [],[],[]
 ci=inv(a[-1]);return pscale(a,ci),pscale(s,ci),pscale(t,ci)

def slice_certificate(Rlambda,verbose=True):
 degree=max(map(lambda p:len(p)-1,Rlambda));assert degree==140
 lead=[p[140] if len(p)>140 else 0 for p in Rlambda];assert lead[0] and not any(lead[1:])
 lead=lead[0];r=[pscale(trim([p[140-n] if len(p)>140-n else 0 for p in Rlambda]),inv(lead)) for n in range(141)]
 j=[[1]]
 for n in range(1,71):
  known=[]
  for i in range(1,n):known=padd(known,pmul(j[i],j[n-i]))
  j.append(pscale(psub(r[n],known),3))
 if verbose:print('root coefficient lambda degrees:',[len(p)-1 for p in j],flush=True)
 g=[];witness=[];errors=[]
 for n in range(71,141):
  sq=[]
  for i in range(max(0,n-70),min(70,n)+1):sq=padd(sq,pmul(j[i],j[n-i]))
  e=psub(r[n],sq)
  if not e:continue
  if not g:
   g=pscale(e,inv(e[-1]));witness=[[inv(e[-1])]];errors=[{'n':n,'polynomial':e}]
  else:
   gg,a,b=pxgcd(g,e);witness=[pmul(a,u) for u in witness]+[b];g=gg;errors.append({'n':n,'polynomial':e})
  if verbose:print('tail equation',n,'x degree',140-n,'lambda degree',len(e)-1,'common gcd degree',len(g)-1,flush=True)
  if sum(c!=0 for c in g)==1:break
 cert={'degree':degree,'normalizing_leading_coefficient':lead,'root_coefficients_descending_x':j,'tail_errors':errors,'bezout_coefficients':witness,'gcd':g,'excludes_all_nonzero_lambda':sum(c!=0 for c in g)==1,'status':'proved_by_exact_univariate_Bezout' if sum(c!=0 for c in g)==1 else 'not_excluded'}
 z=[]
 for e,u in zip(errors,witness):z=padd(z,pmul(e['polynomial'],u))
 assert z==g
 return cert
if __name__=='__main__':
 inp=Path(sys.argv[1]) if len(sys.argv)>1 else ROOT/'data/test_residual.json'
 out=Path(sys.argv[2]) if len(sys.argv)>2 else ROOT/'certificates/test_slice.json'
 cert=slice_certificate(json.loads(inp.read_text())['lambda_coefficients'])
 out.write_text(json.dumps(cert,indent=2)+'\n')
 print('EXCLUDES ALL NONZERO GEOMETRIC LAMBDA:',cert['excludes_all_nonzero_lambda'],flush=True)
