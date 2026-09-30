"""Bounded arithmetic implementation tests, not geometric point exclusions.
Compare the extended quotient helper with independent K-polynomial products,
including a nonzero nilpotent and a rejected nonunit in the actual degree486
coefficient algebra. These tests do not replace the certificate identities.
"""
from exact import *
from extension import E,Poly,init
import gzip,json,random,time

def run():
 tic=time.time();g=json.loads(gzip.open(ROOT/'evidence/branch_root/geometry_x_14.json.gz','rb').read())['finite']
 M=g['scale_graph_modulus'];d=len(M)-1;init(M);rng=random.Random(271426)
 for _ in range(20):
  a=[rng.randrange(390625) for _ in range(d)];b=[rng.randrange(390625) for _ in range(d)]
  expected=prem(pm(a,b),M)
  assert list((E(a)*E(b)).a)==expected+[0]*(d-len(expected))
  gg,s,t=pxgcd(a,M)
  if gg==[1]:assert E(a).inv()==E(s)
 # rad(M) is nonzero in the nonreduced algebra but its cube vanishes.
 rad=[1]
 for p in g['squarefree_blocks'].values():rad=pm(rad,p)
 eta=E(prem(rad,M));assert eta and eta**3==0 and eta**2!=0
 try:eta.inv()
 except AssertionError:pass
 else:raise AssertionError('Nonunit was incorrectly inverted')
 # A low-degree polynomial product over the LARGE coefficient algebra.
 aa=[E([rng.randrange(390625) for _ in range(d)]) for _ in range(4)]
 bb=[E([rng.randrange(390625) for _ in range(d)]) for _ in range(3)]
 out=Poly(aa)*Poly(bb)
 for n in range(6):
  expected=[]
  for i in range(4):
   if 0<=n-i<3:expected=pa(expected,pm(list(aa[i].a),list(bb[n-i].a)))
  assert out[n]==E(prem(expected,M))
 r={'status':'passed','bounded_implementation_tests':True,'quotient_degree':d,
    'random_product_and_unit_tests':20,'nonzero_nilpotent_index':3,'nonunit_rejected':True,
    'independent_low_degree_polynomial_product':True,'seconds':round(time.time()-tic,3)}
 (ROOT/'logs/branch_large_quotient_tests.json').write_text(json.dumps(r,indent=2)+'\n')
 print('LARGE NONREDUCED QUOTIENT ARITHMETIC CHECKS PASSED',r,flush=True)
if __name__=='__main__':run()
