"""Independent schoolbook verification of the stored Bezout identities.
Does not use the C++ extension-polynomial arithmetic or its xgcd routine.
Only K addition/multiplication tables (proved from the specified field) are reused.
"""
from exact import ROOT,add,mul,neg
import json,time

def run(path):
 C=json.loads(path.read_text())
 if C.get('status')!='excluded_all_geometric_scales':return 0
 mod=C.get('modulus',C.get('modulus_on_original_open'));n=len(mod)-1;zero=(0,)*n
 def ea(a,b):return tuple(add(x,y) for x,y in zip(a,b))
 def em(a,b):
  v=[0]*(2*n-1)
  for i,x in enumerate(a):
   if x:
    for j,y in enumerate(b):
     if y:v[i+j]=add(v[i+j],mul(x,y))
  for i in range(2*n-2,n-1,-1):
   z=v[i]
   if z:
    for j,w in enumerate(mod[:-1]):v[i-n+j]=add(v[i-n+j],neg(mul(z,w)))
  return tuple(v[:n])
 def pm0(a,b):
  out=[zero]*(len(a)+len(b)-1)
  for i,x in enumerate(a):
   if any(x):
    for j,y in enumerate(b):
     if any(y):out[i+j]=ea(out[i+j],em(x,y))
  return out
 a,b=C['tails'];s,t=C['bezout'];v=pm0(a,s);w=pm0(b,t)
 for i in range(max(len(v),len(w))):
  z=ea(v[i] if i<len(v) else zero,w[i] if i<len(w) else zero)
  assert z==((1,)+(0,)*(n-1) if i==0 else zero),(path.name,i,z)
 print(path.name,'schoolbook identity = 1; residue degree',n,flush=True)
 return n
if __name__=='__main__':
 start=time.time();total=0
 for p in sorted((ROOT/'evidence').glob('boundary_*.json')):total+=run(p)
 assert total==65,total
 print('Independent schoolbook verification covers 65 geometric ratio points; seconds',round(time.time()-start,3),flush=True)
