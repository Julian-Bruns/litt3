#!/usr/bin/env sage -python
"""Direct actual-Jacobian check of the principal relation-ideal generator.

No Weil polynomial, primary eigenvalue, or claimed relation is assumed
in this check. The input polynomial is tested by actual group operations.
"""
import sys,json,hashlib
from pathlib import Path
input_path=Path(sys.argv[1]);output_path=Path(sys.argv[2])
input_record=json.loads(input_path.read_text())
assert len(input_record['generators'])==1
relation=[int(x)for x in input_record['generators'][0]]
source=Path(__file__).with_name('marked_jacobian_relation_probe_20260929.py')
sys.argv=[str(source),str(output_path.parent)]
exec(compile(source.read_text().split('record={',1)[0],str(source),'exec'),globals())
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
powers=[P]
for i in range(1,max(abs(n)for n in relation).bit_length()):powers.append(powers[-1]+powers[-1])
def mul(n):
 q=abs(n);v=G.zero()
 for i in range(q.bit_length()):
  if (q>>i)&1:v=v+powers[i]
 return -v if n<0 else v
value=G.zero()
for i in reversed(range(8)):
 value=frob_pt(value)+mul(relation[i]);say('generator Horner coefficient',i)
assert value==G.zero()
rec={'scope':'actual principal relation-generator check, with no Weil-polynomial assumption',
 'input_sha256':hashlib.sha256(input_path.read_bytes()).hexdigest(),
 'relation':relation,'jacobian_class_zero':True,
 'coefficient_frobenius_calibrated':True,
 'seconds':time.monotonic()-start}
output_path.write_text(json.dumps(rec,indent=2)+'\n')
say('PASS principal relation generator on actual Jacobian')
