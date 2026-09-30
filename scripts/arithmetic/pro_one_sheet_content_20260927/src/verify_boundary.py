"""Independent Python verification of all thirteen polynomial Bezout identities."""
from univar import *
import json

def em(a,b,f):return ur(um(a,b),f)
def pa(a,b):
 c=a+[[] for _ in range(max(0,len(b)-len(a)))]
 for i,v in enumerate(b):c[i]=ua(c[i],v)
 while c and not c[-1]:c.pop()
 return c
def pm(a,b,f):
 if not a or not b:return []
 c=[[] for _ in range(len(a)+len(b)-1)]
 for i,x in enumerate(a):
  if x:
   for j,y in enumerate(b):
    if y:c[i+j]=ua(c[i+j],em(x,y,f))
 while c and not c[-1]:c.pop()
 return c
def read(path):
 ls=iter(path.read_text().splitlines());hdr=next(ls).split();assert hdr[0]=='field';d=int(hdr[1]);f=list(map(int,hdr[2:]));assert len(f)==d+1 and f[-1]==1
 hdr=next(ls).split();assert hdr[0]=='q';q=int(hdr[1]);out={}
 for name in ['C71','C72','U','V','GCD']:
  hd=next(ls).split();assert hd[0]==name;l,n=map(int,hd[1:]);a=[[0]*d for _ in range(l)]
  for _ in range(n):j,i,c=map(int,next(ls).split());assert c and not a[j][i];a[j][i]=c
  out[name]=[trim(v) for v in a]
 return f,q,out

def main():
 boundaries=json.loads((ROOT/'data'/'B1_boundaries.json').read_text());checks=[]
 for b in boundaries:
  prod=[1]
  for index,f in enumerate(b['factors']):
   prod=um(prod,f);id=f"{b['r']}_{index}";ff,q,a=read(ROOT/'evidence'/f'tails_{id}.txt');assert f==ff and q==b['q']
   result=pa(pm(a['U'],a['C71'],f),pm(a['V'],a['C72'],f));assert result==[[1]]==a['GCD']
   checks.append({'id':id,'field_degree':len(f)-1,'C71_mu_degree':len(a['C71'])-1,'C72_mu_degree':len(a['C72'])-1,'bezout_identity':'U*C71+V*C72=1','verified':True})
   print(id,'degree',len(f)-1,'BEZOUT=1 PASS',flush=True)
  assert prod==b['retained_H_polynomial'];assert um(prod,b['removed_factor'])==b['norm_incidence'];assert ug(prod,b['H_open'])==[1]
 result={'verified_blocks':len(checks),'total_K_dimension':sum(x['field_degree'] for x in checks),'boundaries':[[b['r'],b['q']] for b in boundaries],'checks':checks}
 (ROOT/'evidence'/'boundary_verification.json').write_text(json.dumps(result,indent=2)+'\n')
if __name__=='__main__':main()
