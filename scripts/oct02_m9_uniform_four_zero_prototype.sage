#!/usr/bin/env sage
"""One ordinary linear-parameter J4 singleton-evaluation/norm-minor test."""
import json,time,signal
from pathlib import Path
from itertools import combinations,permutations
from math import comb
lease_started=time.monotonic()
def expired(signum,frame):raise TimeoutError('J4 prototype hard10-second budget')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,10)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
data=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text())
R5=PolynomialRing(GF(5),'t');E=GF(5**8,'e',modulus=R5(data['field_modulus']))
beta=E(data['beta_coordinates']);R=PolynomialRing(E,'x');x=R.gen()
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
Pold=poly([11,22,18,5,19,20,15,16,9,22,1]);A=poly([1,21,14,22,13])
Zold=poly([15,19,24,12,10,19,3,24,18,16]);q3=poly([1,22,9,1]);q=poly([13,18,24])
aroots=[E(v['A_root']) for v in data['records']];pbase=Pold(aroots[0]);P=Pold/pbase;Z=Zold/pbase
def cubes(r):return (x**3-P(r)).roots(multiplicities=False)
source=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_quotient_probe.sage').read_text()
source=source[source.index('def add(f,g):'):source.index('records=[]')]
exec(compile(source,'normalized_quotient_basis','exec'))
double_root=aroots[1];selected=[(r,y) for r in aroots[1:] for y in cubes(r)]
indices=[0,1,3,6];hit={selected[i] for i in indices};remaining_y=next(y for y in cubes(double_root) if (double_root,y) not in hit)
record=data['records'][1]
endpointfactor=R([E(v) for v in record['endpoint_cubic_zero_factor']])
ordinary=next(f for f in record['factors'] if f['degree']==1 and R([E(v) for v in f['polynomial']]).monic()!=endpointfactor.monic())
parameter=R([E(v) for v in ordinary['polynomial']]);lam=-parameter[0]/parameter[1]
delta=q3+lam*q;K,rem=(Zold*delta).quo_rem(Pold)
gamma=-rem(double_root)*remaining_y/Pold(double_root)
gcd=delta.gcd(K**3*P-gamma**3);assert gcd.degree()==1
r0=-gcd[0]/gcd[1];y0=gamma/K(r0);assert y0**3==P(r0) and r0 not in aroots
contact=matrix(E,[row for pt in selected for (j,t),row in allrows[pt].items() if pt not in hit or t<2-j])
kernel=contact.right_kernel_matrix();print('J4contact dimension',kernel.nrows(),flush=True)
evaluation=matrix(E,[[ev(fs[j],r0,y0) for fs in basis] for j in range(4)])*kernel.transpose()
subkernel=evaluation.right_kernel_matrix();print('singleton-evaluated dimension',subkernel.nrows(),flush=True)
assert 1<=subkernel.nrows()<=4
fullkernel=subkernel*kernel
sections=[]
for row in fullkernel.rows():
 fs=[[R.zero() for _ in range(3)] for _ in range(4)]
 for c,bas in zip(row,basis):
  if c:
   for j in range(4):fs[j]=add(fs[j],scale(bas[j],c))
 sections.append(fs)
def norm(f):
 a,b,c=f;return a**3+P*b**3+P**2*c**3-3*P*a*b*c
minor_norms=[];r=len(sections)
for rows in combinations(range(4),r):
 f=[R.zero() for _ in range(3)]
 for perm in permutations(range(r)):
  sign=(-1)**sum(perm[i]>perm[j] for i in range(r) for j in range(i+1,r))
  term=[R.one(),R.zero(),R.zero()]
  for j in range(r):term=mul(term,sections[perm[j]][rows[j]])
  f=add(f,scale(term,sign))
 minor_norms.append(norm(f))
support=delta
for n in minor_norms:support=support.gcd(n)
def coords(v):return [int(c) for c in v.polynomial().list()]
def encoded(g):return [coords(v) for v in g.list()]
out={'scope':'One J4 ordinary linear-parameter prototype, necessary singleton evaluation followed by dim2 norm-minor obstruction.',
     'field_modulus':data['field_modulus'],'beta_coordinates':coords(beta),'normalized_curve_P':encoded(P),
     'selected_zero_indices':indices,'parameter_lambda':coords(lam),'critical_singleton_point':[coords(r0),coords(y0)],
     'contact_dimension':int(kernel.nrows()),'evaluated_quotient_dimension':int(subkernel.nrows()),
     'delta':encoded(delta),'common_delta_norm_support':encoded(support),'common_support_degree':int(support.degree()),
     'minor_norm_remainders':[encoded(n%delta) for n in minor_norms],
     'full_quotient_kernel':[[coords(v) for v in row] for row in fullkernel.rows()],
     'excluded_by_norm_minor':support.degree()<3,'seconds':time.monotonic()-lease_started,'sage_version':version()}
(folder/'four_zero_ordinary_linear_prototype.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
print('J4prototype dims',kernel.nrows(),subkernel.nrows(),'delta norm-support degree',support.degree(),'excluded',support.degree()<3,'seconds',time.monotonic()-lease_started)
