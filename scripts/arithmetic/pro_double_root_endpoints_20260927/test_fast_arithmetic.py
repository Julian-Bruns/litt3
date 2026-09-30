"""Explicitly bounded independent implementation tests, not geometric searches."""
import ctypes as ct,random,time,json
from exact import *
from fast_arithmetic import library

def run():
 t0=time.time();l=library();IP=ct.POINTER(ct.c_int)
 l.ks_test_product.argtypes=[IP,ct.c_int,IP,ct.c_int,IP]
 l.ef_init.argtypes=[IP,ct.c_int];l.ef_mul.argtypes=[IP,IP,IP];l.ef_inv.argtypes=[IP,IP]
 rng=random.Random(2709261400);sizes=[(1,1),(2,3),(95,96),(96,96),(99,123),(128,129),(264,301),(396,396),(726,726),(1024,1009)]
 for n,m in sizes:
  for dense in [False,True]:
   a=[rng.randrange(390625) if dense or rng.randrange(4)==0 else 0 for _ in range(n)]
   b=[rng.randrange(390625) if dense or rng.randrange(4)==0 else 0 for _ in range(m)]
   out=(ct.c_int*(n+m-1))();assert l.ks_test_product((ct.c_int*n)(*a),n,(ct.c_int*m)(*b),m,out)==0
   assert trim(list(out))==pm(trim(a),trim(b)),(n,m,dense)
 for d in [127,128,129,264,396,726,1584]:
  # Deliberately nonreduced and with a nilpotent generator q.
  M=[0]*d+[1];assert l.ef_init((ct.c_int*len(M))(*M),len(M))==d
  for repeat in range(2):
   a=[rng.randrange(390625) for _ in range(d)];b=[rng.randrange(390625) for _ in range(d)]
   out=(ct.c_int*d)();l.ef_mul((ct.c_int*d)(*a),(ct.c_int*d)(*b),out)
   assert trim(list(out))==prem(pm(a,b),M),(d,repeat)
  q=[0,1]+[0]*(d-2);out=(ct.c_int*d)();assert l.ef_inv((ct.c_int*d)(*q),out)!=0
  M=[rng.randrange(390625) for _ in range(d)]+[1];assert l.ef_init((ct.c_int*len(M))(*M),len(M))==d
  a=[rng.randrange(390625) for _ in range(d)];b=[rng.randrange(390625) for _ in range(d)]
  l.ef_mul((ct.c_int*d)(*a),(ct.c_int*d)(*b),out);assert trim(list(out))==prem(pm(a,b),M)
 print('FAST ARITHMETIC: 20 independent Kronecker product comparisons, 21 quotient products through degree1584, seven rejected nilpotent inversions; passed; seconds',round(time.time()-t0,3),flush=True)
if __name__=='__main__':run()
