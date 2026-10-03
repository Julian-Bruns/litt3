#!/usr/bin/env sage
"""One NEW degree8 parameter/J4 normalized singleton-norm test, hard15s."""
import json,time,signal
from pathlib import Path
task_started=time.monotonic()
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
prefix=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_four_zero_prototype.sage').read_text().split('double_root=')[0]
exec(compile(prefix,'J4_base_prefix','exec'))
def expired8(signum,frame):raise TimeoutError('degree8 J4 hard15-second budget')
signal.signal(signal.SIGALRM,expired8);signal.setitimer(signal.ITIMER_REAL,max(.1,15-(time.monotonic()-task_started)))
F8=E;R8=R;roots8=aroots[:]
double_root8=aroots[1];selected8=[(r,y) for r in aroots[1:] for y in cubes(r)]
indices=[0,1,3,6];hit={selected8[i] for i in indices}
remaining8=next(y for y in cubes(double_root8) if (double_root8,y) not in hit)
contact=matrix(F8,[row for pt in selected8 for (j,t),row in allrows[pt].items() if pt not in hit or t<2-j])
kernel8=contact.right_kernel_matrix();assert kernel8.nrows()==8
def coords(v):return [int(c) for c in v.polynomial().list()]
(folder/'four_zero_contact_prototype_cache.json').write_text(json.dumps({'field_modulus':data['field_modulus'],
    'selected_zero_indices':indices,'contact_kernel':[[coords(v) for v in row] for row in kernel8.rows()]},indent=2,default=int)+'\n')
E=GF(5**64,'u');R=PolynomialRing(E,'x');x=R.gen()
base_modulus=R(data['field_modulus']);base_image=base_modulus.roots(multiplicities=False)[0]
embedding=F8.hom([base_image],E)
def liftpoly(g):return R([embedding(v) for v in g.list()])
P=liftpoly(P);Z=liftpoly(Z);Pold=liftpoly(Pold);Zold=liftpoly(Zold);q=liftpoly(q);q3=liftpoly(q3)
basis=[[[liftpoly(h) for h in f] for f in fs] for fs in basis]
double_root=embedding(double_root8);remaining_y=embedding(remaining8)
factor8=next(f for f in data['records'][1]['factors'] if f['degree']==8)
parameter=R([embedding(F8(v)) for v in factor8['polynomial']]);lam=parameter.roots(multiplicities=False)[0]
field_setup_seconds=time.monotonic()-task_started
delta=q3+lam*q;K,rem=(Zold*delta).quo_rem(Pold);gamma=-rem(double_root)*remaining_y/Pold(double_root)
gcd=delta.gcd(K**3*P-gamma**3);assert gcd.degree()==1
r0=-gcd[0]/gcd[1];y0=gamma/K(r0);assert y0**3==P(r0)
kernel=kernel8.apply_map(embedding)
evaluation=matrix(E,[[ev(fs[j],r0,y0) for fs in basis] for j in range(4)])*kernel.transpose()
subkernel=evaluation.right_kernel_matrix();assert subkernel.nrows()==4
fullkernel=subkernel*kernel;sections=[]
for row in fullkernel.rows():
 fs=[[R.zero() for _ in range(3)] for _ in range(4)]
 for c,bas in zip(row,basis):
  if c:
   for j in range(4):fs[j]=add(fs[j],scale(bas[j],c))
 sections.append(fs)
from itertools import permutations
det=[R.zero() for _ in range(3)]
for perm in permutations(range(4)):
 sign=(-1)**sum(perm[i]>perm[j] for i in range(4) for j in range(i+1,4))
 term=[R.one(),R.zero(),R.zero()]
 for j in range(4):term=mul(term,sections[perm[j]][j])
 det=add(det,scale(term,sign))
a,b,c=[h%delta for h in det];pd=P%delta
norm_remainder=(a**3+pd*b**3+pd**2*c**3-3*pd*a*b*c)%delta
support=delta.gcd(norm_remainder)
def encoded(g):return [coords(v) for v in g.list()]
out={'scope':'One NEW degree8 parameter/J4 prototype. Normalization keeps all parameter data in F5^64; no actual-source realization.',
     'absolute_field_modulus':[int(v) for v in E.modulus().list()],'base_field_modulus':data['field_modulus'],
     'base_generator_image':coords(base_image),'parameter_lambda':coords(lam),'selected_zero_indices':indices,
     'critical_singleton_point':[coords(r0),coords(y0)],'linear_critical_gcd':encoded(gcd),
     'evaluated_quotient_dimension':int(subkernel.nrows()),'norm_determinant_remainder':encoded(norm_remainder),
     'delta_norm_support_degree':int(support.degree()),'excluded_by_norm_minor':support.degree()<3,
     'full_quotient_kernel':[[coords(v) for v in row] for row in fullkernel.rows()],
     'field_setup_seconds':field_setup_seconds,'seconds':time.monotonic()-task_started,'sage_version':version()}
(folder/'four_zero_degree8_prototype.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
print('degree8 J4 norm-support',support.degree(),'excluded',support.degree()<3,'field setup',field_setup_seconds,'total seconds',time.monotonic()-task_started)
