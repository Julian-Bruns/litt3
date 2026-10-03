#!/usr/bin/env sage
"""Remaining NEW ordinary J4 parameter tests, hard60s, norm modulo delta."""
import json,time,signal
from pathlib import Path
from itertools import product,permutations
task_started=time.monotonic();folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
prefix=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_four_zero_prototype.sage').read_text().split('double_root=')[0]
exec(compile(prefix,'J4_base_prefix','exec'))
def expired_batch(signum,frame):raise TimeoutError('ordinary J4 hard60-second budget; checkpoints retained')
signal.signal(signal.SIGALRM,expired_batch);signal.setitimer(signal.ITIMER_REAL,max(.1,60-(time.monotonic()-task_started)))
F8=E;R8=R;roots8=aroots[:];P8=P;Pold8=Pold;Zold8=Zold;q8=q;q38=q3;basis8=basis
selected8=[(r,y) for r in aroots[1:] for y in cubes(r)]
def coords(v):return [int(c) for c in v.polynomial().list()]
cached=json.loads((folder/'four_zero_contact_prototype_cache.json').read_text())
configs=[];contact_records=[]
for doubled in range(3):
 other=[i for i in range(3) if i!=doubled]
 for singles in product(range(3),repeat=2):
  indices=sorted([3*doubled,3*doubled+1]+[3*i+j for i,j in zip(other,singles)])
  hit={selected8[i] for i in indices}
  if indices==cached['selected_zero_indices']:
   kernel=matrix(F8,[[F8(v) for v in row] for row in cached['contact_kernel']])
  else:
   contact=matrix(F8,[row for pt in selected8 for (j,t),row in allrows[pt].items() if pt not in hit or t<2-j])
   kernel=contact.right_kernel_matrix()
  assert kernel.nrows()==8
  configs.append((doubled,indices,kernel));contact_records.append({'doubled_fiber_index':doubled,'selected_zero_indices':indices,
      'contact_kernel':[[coords(v) for v in row] for row in kernel.rows()]})
(folder/'four_zero_contact_spaces.json').write_text(json.dumps({'scope':'All27 fixed-omission/diagonal-C3 representatives, only26 NEWcontact kernels plus stored prototype.',
    'field_modulus':data['field_modulus'],'selected_endpoints':[[coords(r),coords(y)] for r,y in selected8],
    'records':contact_records},indent=2,default=int)+'\n')
field_data=json.loads((folder/'four_zero_degree8_prototype.json').read_text())
E=GF(5**64,'u',modulus=R5(field_data['absolute_field_modulus']));R=PolynomialRing(E,'x');x=R.gen()
embedding=F8.hom([E(field_data['base_generator_image'])],E)
def liftpoly(g):return R([embedding(v) for v in g.list()])
P=liftpoly(P8);Pold=liftpoly(Pold8);Zold=liftpoly(Zold8);q=liftpoly(q8);q3=liftpoly(q38)
basis=[[[liftpoly(h) for h in f] for f in fs] for fs in basis8]
signs=[(perm,(-1)**sum(perm[i]>perm[j] for i in range(4) for j in range(i+1,4))) for perm in permutations(range(4))]
records=[];output=folder/'four_zero_ordinary_batch.json'
def encode_poly(g):return [coords(v) for v in g.list()]
for doubled in range(3):
 double_root=embedding(roots8[doubled+1]);remaining_y=embedding(selected8[3*doubled+2][1])
 support_record=data['records'][doubled+1]
 endpointfactor=R8([F8(v) for v in support_record['endpoint_cubic_zero_factor']]).monic()
 ordinary=next(f for f in support_record['factors'] if f['degree']==1 and R8([F8(v) for v in f['polynomial']]).monic()!=endpointfactor)
 factor8=next(f for f in support_record['factors'] if f['degree']==8)
 parameter_specs=[('ordinary_linear',ordinary),('degree8',factor8)]
 for factor_kind,factor in parameter_specs:
  parameter=R([embedding(F8(v)) for v in factor['polynomial']]);lam=parameter.roots(multiplicities=False)[0]
  delta=q3+lam*q;K,rem=(Zold*delta).quo_rem(Pold);gamma=-rem(double_root)*remaining_y/Pold(double_root)
  critical_gcd=delta.gcd(K**3*P-gamma**3);assert critical_gcd.degree()==1
  r0=-critical_gcd[0]/critical_gcd[1];y0=gamma/K(r0);assert y0**3==P(r0)
  pd=P%delta
  def mulmod(f,g):
   h=[R.zero() for _ in range(5)]
   for i in range(3):
    for j in range(3):h[i+j]+=f[i]*g[j]
   h[0]+=pd*h[3];h[1]+=pd*h[4]
   return [v%delta for v in h[:3]]
  basis_mod=[[[h%delta for h in f] for f in fs] for fs in basis]
  evaluation=matrix(E,[[ev(fs[j],r0,y0) for fs in basis_mod] for j in range(4)])
  for dindex,indices,kernel8 in configs:
   if dindex!=doubled:continue
   if doubled==0 and indices==[0,1,3,6]:
    prototype='four_zero_ordinary_linear_prototype.json' if factor_kind=='ordinary_linear' else 'four_zero_degree8_prototype.json'
    assert json.loads((folder/prototype).read_text())['excluded_by_norm_minor']
    records.append({'doubled_fiber_index':doubled,'factor_kind':factor_kind,'selected_zero_indices':indices,'stored_prototype':prototype,'excluded_by_norm_minor':True});continue
   kernel=kernel8.apply_map(embedding);subkernel=(evaluation*kernel.transpose()).right_kernel_matrix();assert subkernel.nrows()==4
   fullkernel=subkernel*kernel;sections=[]
   for row in fullkernel.rows():
    fs=[[R.zero() for _ in range(3)] for _ in range(4)]
    for c,bas in zip(row,basis_mod):
     if c:
      for j in range(4):fs[j]=add(fs[j],scale(bas[j],c))
    sections.append(fs)
   det=[R.zero() for _ in range(3)]
   for perm,sign in signs:
    term=[R.one(),R.zero(),R.zero()]
    for j in range(4):term=mulmod(term,sections[perm[j]][j])
    det=add(det,scale(term,sign))
   a,b,c=[h%delta for h in det];nrem=(a**3+pd*b**3+pd**2*c**3-3*pd*a*b*c)%delta
   ngcd=delta.gcd(nrem);assert ngcd.degree()<3
   record={'doubled_fiber_index':doubled,'factor_kind':factor_kind,'selected_zero_indices':indices,
       'lambda':coords(lam),'critical_singleton_point':[coords(r0),coords(y0)],'linear_critical_gcd':encode_poly(critical_gcd),
       'evaluated_contact_kernel':[[coords(v) for v in row] for row in subkernel.rows()],
       'delta':encode_poly(delta),'norm_determinant_remainder':encode_poly(nrem),'delta_norm_support_degree':int(ngcd.degree()),
       'excluded_by_norm_minor':True,'seconds_at_completion':time.monotonic()-task_started}
   records.append(record)
   out={'scope':'Ordinary5pole exact4 selectedzero 211 necessary quotient spaces,27 diagonal-C3 reps times2 ordinary factor strata. Geometric scalar parameters excluded via norm-minor, not finite-field point search.',
       'absolute_field_modulus':field_data['absolute_field_modulus'],'base_generator_image':field_data['base_generator_image'],
       'field_modulus_F8':data['field_modulus'],'records':records,'complete':len(records)==54,'seconds':time.monotonic()-task_started}
   output.write_text(json.dumps(out,indent=2,default=int)+'\n')
   print('NEWJ4',doubled,factor_kind,indices,'norm-support',ngcd.degree(),'records',len(records),'seconds',time.monotonic()-task_started,flush=True)
assert len(records)==54
signal.setitimer(signal.ITIMER_REAL,0)
