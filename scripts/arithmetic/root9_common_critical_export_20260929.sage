#!/usr/bin/env sage
import argparse,json,hashlib
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory');a=p.parse_args();out=Path(a.directory)
lexfile=out/'lex_groebner.sobj'
if lexfile.exists():
 lex=load(str(lexfile));polys=load(str(out/'incidence.sobj'));fixed_root=None
else:
 lex=load(str(out/'lex.sobj'));src=load(str(out/'source.sobj'));polys=src['polys'];fixed_root=src['root']
R=lex[0].parent();K=R.base_ring();alpha=K.gen();nv=R.ngens();qi=nv-1
beta=-(alpha**4+2*alpha**3+alpha**2+2*alpha)/(alpha**3+alpha**2+1)
F5=GF(5)
def vec(c):
 pp=K(c).polynomial();return vector(F5,[pp[i] for i in range(8)])
cb=matrix(F5,[vec(beta**j*alpha**i) for i in range(4) for j in range(2)]).transpose().inverse()
def code(c):
 dd=cb*vec(c);return int(sum(ZZ(dd[2*i])*25**i+ZZ(dd[2*i+1])*5*25**i for i in range(4)))
Q=PolynomialRing(K,'q');q=Q.gen();fq=Q.zero();coordinates={}
for f in lex:
 if all(all(e==0 for e in mon[:-1]) for mon in f.dict()):
  fq=Q([f.coefficient({R.gen(qi):i}) for i in range(f.degree(R.gen(qi))+1)])
 else:
  targets=[j for j in range(qi) if f.lm()==R.gen(j)];assert len(targets)==1;j=targets[0]
  tail=R.gen(j)-f
  assert all(all(e==0 for e in mon[:-1]) for mon in tail.dict())
  coordinates[j]=Q([tail.coefficient({R.gen(qi):i}) for i in range(max(0,tail.degree(R.gen(qi)))+1)])
assert fq.degree()>0 and fq.gcd(fq.derivative()).degree()==0
factors=list(fq.factor());blocks=[]
for ff,pow in factors:
 assert pow==1
 vals=[coordinates[j]%ff for j in range(qi)]+[q%ff]
 # Every actual incidence generator vanishes under the parametrization.
 for f in polys:
  z=Q.zero()
  for mon,c in f.dict().items():
   t=Q(c)
   for j,e in enumerate(mon):
    if e:t=t*power_mod(vals[j],e,ff)%ff
   z=(z+t)%ff
  assert not z
 cv={}
 for j,name in enumerate(R.variable_names()[:-1]):cv[str({'inv':0,'z':1,'x':2,'u':3}[name])]=[code(c) for c in vals[j]]
 if fixed_root is not None:cv['2']=[code(fixed_root)]
 block={'degree':int(ff.degree()),'modulus':[code(c) for c in ff], 'coordinates':cv}
 blocks.append(block)
obj={'scope':('Whole off-P*t common-critical incidence' if fixed_root is None else 'Whole common-critical incidence at the specified t endpoint')+'; original source denominator and q inverted. No square equations yet.', 'length':int(fq.degree()),'q_polynomial':[code(c) for c in fq],'blocks':blocks,'incidence_substitutions':'PASS','lex_shape':str(qi)+' linear coordinates and squarefree q polynomial of degree'+str(fq.degree())}
(out/'finite_incidence.json').write_text(json.dumps(obj,separators=(',',':'),default=int)+'\n')
print('EXPORTED',[(b['degree'],len(b['coordinates']['3'])) for b in blocks],flush=True)
