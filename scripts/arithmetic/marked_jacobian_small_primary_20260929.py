#!/usr/bin/env sage -python
"""Exact small-primary relation kernels of the actual marked point.

Only3 and13 are considered. The accepted point-order run determines
their exponents are one. Other primary components are not inferred.
Meet-in-the-middle enumerates at most two sets of81 group elements.
"""
from pathlib import Path
import sys,json,time,itertools,hashlib
from sage.all import ZZ,GF,PolynomialRing,matrix,vector

src=Path(__file__).with_name('marked_jacobian_relation_probe_20260929.py')
# Reuse the exact field, curve, integral bases and place construction;
# stop before the old probes and order reduction. The program takes the
# same single output-directory argument.
prefix=src.read_text().split('record={',1)[0]
exec(compile(prefix,str(src),'exec'),globals())
out=args.output/'small_primary.json'
record={'scope':'actual3- and13-primary Frobenius relation kernels',
 'setup_source_sha256':hashlib.sha256(src.read_bytes()).hexdigest(),
 'field_modulus':[int(c)for c in k.modulus()],
 'beta':[int(c)for c in beta],'alpha':[int(c)for c in alpha],
 'rho':[int(c)for c in rho],'primes':[]}
def save():out.write_text(json.dumps(record,indent=2)+'\n')
save()
Ebound=ZZ(348845748669743914287634301453156614528955729501515119047979680559316323399234377575817619)

# Coefficient25-power map fixes the actual x,y equation over F25.
basepoly=K.maximal_order()._ring
def frob_rat(r):
 return K(basepoly([c**25 for c in r.numerator()]))/K(basepoly([c**25 for c in r.denominator()]))
def frob_fun(f):return sum((F(frob_rat(c))*y**i for i,c in enumerate(F(f).list())),F(0))
def frob_pt(pt):
 I=F.maximal_order().ideal([frob_fun(f)for f in pt._finite_ideal.gens()])
 J=F.maximal_order_infinite().ideal([frob_fun(f)for f in pt._infinite_ideal.gens()])
 return G.element_class(G,I,J)
next_R=F.maximal_order().ideal(x-alpha**25,y-rho**25).place()
assert frob_pt(P)==G(next_R.divisor()-O.divisor())
say('coefficient Frobenius checked on actual marked point')
powers=[P]
for i in range(1,Ebound.nbits()):powers.append(powers[-1]+powers[-1])
say('doubling table',len(powers))
def mul(n):
 z=G.zero()
 for i in range(n.nbits()):
  if n.test_bit(i):z=z+powers[i]
 return z
RZ=PolynomialRing(ZZ,'T');T=RZ.gen()
Pi=(T**18-2*T**17-29*T**16+57*T**15-124*T**14+3716*T**13+3083*T**12
 -94215*T**11+141450*T**10+601875*T**9+3536250*T**8-58884375*T**7
 +48171875*T**6+1451562500*T**5-1210937500*T**4+13916015625*T**3
 -177001953125*T**2-305175781250*T+3814697265625)
Q=T**8+T**4+1
for ell in [3,13]:
 eta=mul(Ebound//(ell**Ebound.valuation(ell)))
 assert eta!=G.zero() and ell*eta==G.zero()
 say('actual primary point',ell)
 Rp=PolynomialRing(GF(ell),'T');g=Rp(Pi).gcd(Rp(Q));deg=g.degree()
 pts=[eta]
 for i in range(1,9):pts.append(frob_pt(pts[-1]))
 zero=G.zero()
 total=zero
 for i,a in enumerate(g):total=total+int(a)*pts[i]
 assert total==zero
 cut=deg//2
 def table(indices):
  data=[(zero,())]
  for i in indices:
   mult=[zero]
   for j in range(1,ell):mult.append(mult[-1]+pts[i])
   data=[(p+v,c+(j,))for p,c in data for j,v in enumerate(mult)]
  return data
 left=table(range(cut));right=table(range(cut,deg))
 lookup={}
 for pt,coeff in left:lookup.setdefault(pt,[]).append(coeff)
 relations=[]
 for pt,coeff in right:
  for prefix in lookup.get(-pt,[]):relations.append(prefix+coeff)
 assert len(relations)>=1
 reduced_kernel=matrix(GF(ell),relations).row_space()
 assert len(relations)==ell**reduced_kernel.dimension()
 # Recover all eight input coefficients by reduction modulo g.
 reduction=matrix(GF(ell),[[(Rp.gen()**i%g)[j]for j in range(deg)]for i in range(8)])
 # A vector maps to a relation precisely when it kills the annihilator
 # of the relation row space in the reduced polynomial coordinates.
 checks=reduction*reduced_kernel.basis_matrix().right_kernel().basis_matrix().transpose()
 kernel=checks.left_kernel()
 rec={'prime':ell,'actual_primary_exponent':1,
      'primary_multiplier':str(Ebound//ell**Ebound.valuation(ell)),
      'gcd_coefficients':[int(c)for c in g],
      'left_points':len(left),'right_points':len(right),
      'number_of_reduced_relations':len(relations),
      'reduced_kernel_basis':[[int(c)for c in r]for r in reduced_kernel.basis_matrix()],
      'eight_coefficient_kernel_basis':[[int(c)for c in r]for r in kernel.basis_matrix()],
      'constraint_columns':[[int(c)for c in r]for r in checks],
      'actual_primary_rank':int(8-kernel.dimension()),
      'checks':{'eta_nonzero':True,'ell_eta_zero':True,'gcd_annihilates':True,
                'all_mitm_relations_form_full_linear_kernel':True},
      'seconds':time.monotonic()-start}
 record['primes'].append(rec);save()
 say('small primary kernel',ell,'rank',rec['actual_primary_rank'])
record['complete']=True;save();say('PASS both exact primary kernels')
