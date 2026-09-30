"""Independent schoolbook checks of all new Bezout certificates.
No extension-polynomial product or xgcd implementation is used here. Products
are lifted to K[q,mu], multiplied by a separate K schoolbook routine, then
reduced by the displayed monic quotient. No field sampling is performed.
"""
from exact import *
from factor import irreducible
from branch_geometry import ROOTS
import gzip,json,time

def record(name):return json.loads(gzip.open(ROOT/'evidence/branch_root'/name,'rb').read())
def product(a,b,M):
 d=len(M)-1;stride=2*d-1
 if not a or not b:return []
 av=[0]*((len(a)-1)*stride+d);bv=[0]*((len(b)-1)*stride+d)
 for i,v in enumerate(a):av[i*stride:i*stride+d]=v
 for i,v in enumerate(b):bv[i*stride:i*stride+d]=v
 p=pm(av,bv);out=[]
 for i in range(len(a)+len(b)-1):out.append(prem(p[i*stride:(i+1)*stride],M))
 return out

def run():
 tic=time.time();r=record('geometry_x_9.json.gz')['finite'];total=0;product_factors=[1]
 for i,(f,m) in enumerate(r['factors']):
  c=record(f'factor_{i}.json.gz');assert c['modulus']==f and c['multiplicity']==m and irreducible(f)
  assert c['u']==prem(r['u'],f) and c['status']=='excluded_all_scales'
  a,b=c['first_two_tails'];s,t=c['first_two_bezout'];p=product(a,s,f);q=product(b,t,f)
  for j in range(max(len(p),len(q))):
   assert pa(p[j] if j<len(p) else [],q[j] if j<len(q) else [])==([1] if j==0 else [])
  product_factors=pm(product_factors,pp(f,m));total+=len(f)-1
  print('INDEPENDENT ALL-SCALE CERTIFICATE',i,'residue degree',len(f)-1,flush=True)
 assert product_factors==r['modulus'] and total==77
 graphs=[]
 for x in ROOTS:
  if x==9:continue
  c=record(f'graph_x_{x}.json.gz');M=c['modulus'];a,b=c['tails_71_72'];s,t,h=c['bezout_tail71_tail72_modulus']
  assert pa(pa(pm(s,a),pm(t,b)),pm(h,M))==[1]
  assert len(pgcd(a,M))==1
  geo=record(f'geometry_x_{x}.json.gz')['finite'];assert M==geo['scale_graph_modulus']
  assert c['u']==prem(geo['u'],M) and c['nu']==geo['nu']
  product_blocks=[1];geometric=0
  blocks=geo['squarefree_blocks'];vals=[]
  for m,z in blocks.items():
   assert pgcd(z,pder(z))==[1];product_blocks=pm(product_blocks,pp(z,int(m)));geometric+=len(z)-1;vals.append(z)
  assert all(pgcd(vals[i],vals[j])==[1] for i in range(len(vals)) for j in range(i))
  assert product_blocks==M and geometric==375 and len(M)-1==486
  graphs.append({'x_code':x,'algebra_length':486,'geometric_points':375,'first_tail_is_unit':True})
  print('INDEPENDENT WHOLE-ALGEBRA GRAPH CERTIFICATE',x,486,flush=True)
 result={'status':'passed','all_scale_residue_fields':12,'geometric_all_scale_ratios':77,
         'graphs':graphs,'geometric_graph_points_sum':3375,'finite_graph_lengths_sum':4374,
         'product_method':'schoolbook K-polynomials; separate coefficientwise monic reduction',
         'global_square_decision':'unresolved','seconds':round(time.time()-tic,3)}
 (ROOT/'logs/branch_certificates_independent.json').write_text(json.dumps(result,indent=2)+'\n')
 print('ALL 21 INDEPENDENT BRANCH CERTIFICATES PASSED',result['seconds'],flush=True)
 return result
if __name__=='__main__':run()
