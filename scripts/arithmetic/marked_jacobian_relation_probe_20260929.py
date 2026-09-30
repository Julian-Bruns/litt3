#!/usr/bin/env sage -python
"""Exact marked-point Jacobian probe; never infer a full relation lattice.

Use built-in ideal arithmetic rather than expanded large-pole functions.
Receipts are written after each exact multiplication; the integer Weil
annihilator is an input, not a claimed exact order.
"""
import argparse, json, time
from pathlib import Path
from sage.all import GF, PolynomialRing, FunctionField, ZZ

p=argparse.ArgumentParser()
p.add_argument('output',type=Path)
p.add_argument('--test-primes',type=int,default=0)
p.add_argument('--point-order',action='store_true')
args=p.parse_args();args.output.mkdir(parents=True,exist_ok=True)
start=time.monotonic()
def say(*x): print(round(time.monotonic()-start,2),*x,flush=True)
k=GF(5**24,'z')
R=PolynomialRing(k,'a');a=R.gen()
beta=(a*a-a-3).roots(multiplicities=False)[0]
dec=lambda c:k(c%5)+k(c//5)*beta
alpha=R([dec(c) for c in [5,2,6,7,1]]).roots(multiplicities=False)[0]
coeff=[dec(c) for c in [11,22,18,5,19,20,15,16,9,22,1]]
rho=(a**3-R(coeff)(alpha)).roots(multiplicities=False)[0]
assert alpha**(5**8)==alpha
assert rho**(5**8)==dec(11)*rho
say('field and marked point constructed')
K=FunctionField(k,'x');x=K.gen();S=PolynomialRing(K,'Y');Y=S.gen()
F=K.extension(Y**3-sum(c*x**i for i,c in enumerate(coeff)),'y');y=F.gen()
# These are the actual integral bases: P is squarefree, and the unique
# infinity branch has valuations(-3,-10). Avoid generic Singular
# normalization over the absolute degree24 coefficient field.
assert R(coeff).is_squarefree()
F._maximal_order_basis=lambda:[F(1),y,y*y]
M,from_M,to_M=F._inversion_isomorphism()
M._maximal_order_basis=lambda:[M(1),to_M(y/x**4),to_M(y*y/x**7)]
say('known integral bases installed')
# The inverted model has one prime over z=0, with residue degree1,
# ramification3 and basis valuations(0,2,1). This avoids the generic
# Buchmann--Lenstra split routine exponentiating in a huge residue field.
OM=M.maximal_order();z=M.base_field().gen()
prime0=OM.ideal(z,OM.basis()[1],OM.basis()[2])
below0=M.base_field().maximal_order().ideal(z)
prime0.is_prime.set_cache(True)
prime0._prime_below=below0
prime0._relative_degree=1
prime0._ramification_index=3
prime0._beta=[OM._module_base_ring._ring(c) for c in [0,1,0]]
assert prime0**3==OM.ideal(z)
OM.decomposition.set_cache([(prime0,1,3)],below0)
O=F.places_infinite()[0]
say('infinity place constructed')
Rp=F.maximal_order().ideal(x-alpha,y-rho).place()
say('places',O,Rp)
J=F.jacobian(model='unique_hess',base_div=O,extra_caching=False)
G=J.group()
P=G(Rp.divisor()-O.divisor())
say('Jacobian point',P)
record={'scope':'exact arithmetic on one actual marked Jacobian point',
 'field_modulus':[int(c) for c in k.modulus()],
 'beta':[int(c) for c in beta], 'alpha':[int(c) for c in alpha],
 'rho':[int(c) for c in rho], 'checks':[]}
out=args.output/'receipt.json'
out.write_text(json.dumps(record,indent=2)+'\n')
for n in [2,3,5,25]:
 Q=n*P
 record['checks'].append({'multiplier':n,'zero':bool(Q==G.zero()),'seconds':time.monotonic()-start})
 out.write_text(json.dumps(record,indent=2)+'\n');say('multiplier',n,'zero',Q==G.zero())
ann=ZZ(45095046841912830021622485696625833846862308638737180792041321268886159213510179436939976808107828897)
if args.test_primes:
 tests=[('annihilator',ann)]+[(str(l),ann//l) for l,e in ann.factor()][:args.test_primes]
 for label,n in tests:
  Q=n*P;zero=bool(Q==G.zero())
  record['checks'].append({'label':label,'multiplier':str(n),'zero':zero,'seconds':time.monotonic()-start})
  out.write_text(json.dumps(record,indent=2)+'\n');say(label,'zero',zero)
if args.point_order:
 # Exponent of the explicitly presented Z[T]/(Pi,T8+T4+1) module;
 # unlike its determinant, this is the sharper proved upper bound.
 order=ZZ(348845748669743914287634301453156614528955729501515119047979680559316323399234377575817619)
 record['point_order_upper_bound']=str(order)
 powers=[P]
 for i in range(1,order.nbits()):powers.append(powers[-1]+powers[-1])
 say('doubling table',len(powers))
 def mul(n):
  ans=G.zero()
  for i in range(n.nbits()):
   if n.test_bit(i):ans=ans+powers[i]
  return ans
 assert mul(order)==G.zero()
 say('module exponent checked on actual point')
 for l,e in order.factor():
  for j in range(e):
   candidate=order//l;zero=bool(mul(candidate)==G.zero())
   record['checks'].append({'label':'order reduction','prime':str(l),
       'multiplier':str(candidate),'zero':zero,'seconds':time.monotonic()-start})
   if zero:order=candidate
   record['current_point_order_bound']=str(order)
   out.write_text(json.dumps(record,indent=2)+'\n');say('prime',l,'zero',zero,'current',order)
   if not zero:break
 record['exact_point_order']=str(order)
 out.write_text(json.dumps(record,indent=2)+'\n')
 say('EXACT MARKED POINT ORDER',order)
if args.point_order:
 say('PASS exact point order; the full relation lattice is a separate computation')
else:
 say('PASS bounded exact probe; no full order or lattice inferred')
