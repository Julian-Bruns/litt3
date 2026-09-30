"""Decode bounded Kronecker products and verify global coefficient degree bounds."""
import json,sys
from ff import ROOT

def extract(name):
 R=json.loads((ROOT/'data'/f'{name}.json').read_text())['lambda_coefficients']
 rp=[[[] for l in range(7)] for n in range(141)]
 for l,p in enumerate(R):
  for idx,c in enumerate(p):
   if c:
    r,x=divmod(idx,1024);n=140-x
    assert 0<=n<=140
    if len(rp[n][l])<=r:rp[n][l]+=[0]*(r+1-len(rp[n][l]))
    rp[n][l][r]=c
 assert not any(rp[0][l] for l in range(1,7)) and rp[0][0][:3]==[0,0,0] and len(rp[0][0])==4
 for n in range(1,141):
  for l,p in enumerate(rp[n]):
   assert len(p)-1<=3*n+3
   assert not p or 4*l<=3*n
 lc=rp[0][0][3]
 (ROOT/'data'/f'{name}_coeffs.txt').write_text(str(lc)+'\n'+'\n'.join(' '.join(map(str,[len(p)]+p)) for row in rp for p in row)+'\n')
 print(name, 'leading constant',lc,'global bounds deg_r R[n,l]<=3n+3, 4l<=3n checked; normalized bound deg_r <=6n',flush=True)
 return rp
if __name__=='__main__':extract(sys.argv[1] if len(sys.argv)>1 else 'exceptional_param_3_0')
