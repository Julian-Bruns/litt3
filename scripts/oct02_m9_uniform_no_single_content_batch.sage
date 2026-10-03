#!/usr/bin/env sage
"""All eight no-single parameter/omission representatives; seven NEW ranks."""
import json,time,signal
from pathlib import Path
task_started=time.monotonic();folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
prefix=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_four_zero_prototype.sage').read_text().split('double_root=')[0]
exec(compile(prefix,'normalized_quotient_prefix','exec'))
def expired30(signum,frame):raise TimeoutError('all no-single content hard30-second budget; checkpoints retained')
signal.signal(signal.SIGALRM,expired30);signal.setitimer(signal.ITIMER_REAL,max(.1,30-(time.monotonic()-task_started)))
F8=E;R8=R;P8=P;Pold8=Pold;Z8=Z;Zold8=Zold;q8=q;q38=q3;basis8=basis;beta8=beta
def code8(c):return F8(c%5)+F8(c//5)*beta8
contacts8=[]
for omitted in range(4):
 selected=[(r,y) for i,r in enumerate(aroots) if i!=omitted for y in cubes(r)]
 contacts8.append(matrix(F8,[row for pt in selected for (j,t),row in allrows[pt].items() if t<2-j]))
support=json.loads((folder/'no_single_affine_cube_parameter_support.json').read_text())
drop=json.loads((folder/'no_single_leading_drop_exclusion.json').read_text());assert drop['gcd_degree']==0
prototype=json.loads((folder/'no_single_content_quartic_prototype.json').read_text())
E=GF(5**48,'u',modulus=R5(prototype['field_modulus']));R=PolynomialRing(E,'x');x=R.gen()
base_image=E(prototype['base_generator_image']);embedding=F8.hom([base_image],E)
def liftpoly(g):return R([embedding(v) for v in g.list()])
P=liftpoly(P8);Pold=liftpoly(Pold8);Z=liftpoly(Z8);Zold=liftpoly(Zold8);q=liftpoly(q8);q3=liftpoly(q38)
basis=[[[liftpoly(h) for h in f] for f in fs] for fs in basis8]
contacts=[m.apply_map(embedding) for m in contacts8]
def coords(v):return [int(c) for c in v.polynomial().list()]
def encoded(g):return [coords(v) for v in g.list()]
records=[];output=folder/'no_single_content_complete.json'
for factor in drop['primitive_factors']:
 parameter=R([embedding(code8(c)) for c in factor['polynomial']]);degree=factor['degree']
 lam=E(prototype['lambda']) if degree==4 else parameter.roots(multiplicities=False)[0]
 assert parameter(lam)==0
 delta=q3+lam*q;K,rem=(Zold*delta).quo_rem(Pold)
 gg=(-8*K**3*Pold)%delta;g0,g1,g2=[gg[i] for i in range(3)];d0,d1,d2=[delta[i] for i in range(3)];assert g2
 f=g1*(3*x-d2)-g2*(3*x*x-d1);h=g0*(3*x-d2)-g2*(x**3-d0);tgcd=f.gcd(h)
 assert tgcd.degree()==1,'Multiple finite t roots retained as unresolved, not discarded'
 tvalue=-tgcd[0]/tgcd[1];slope_cube=g2/(3*tvalue-d2)
 D1=R([E(v) for v in prototype['records'][0]['D1']]) if degree==4 else (x**3-slope_cube/embedding(pbase)).roots(multiplicities=False)[0]*(x+tvalue)
 assert not (D1**3+8*K**3*P)%delta
 rows=[]
 for j in range(4):
  c1=[(K*fs[j][1]+D1*fs[j][2]/2)%delta for fs in basis]
  c0=[(K**2*fs[j][0]-D1**2*fs[j][2]/4)%delta for fs in basis]
  for c in [c1,c0]:
   for n in range(3):rows.append([v[n] for v in c])
 for omitted,contact in enumerate(contacts):
  if degree==4 and omitted==0:
   assert prototype['records'][0]['combined_rank']==50
   records.append({'parameter_factor_degree':degree,'omitted_A_root_index':omitted,'stored_prototype':'no_single_content_quartic_prototype.json','combined_rank':50});continue
  M=matrix(E,list(contact.rows())+rows);assert M.nrows()==51 and M.ncols()==50
  rank=M.rank();assert rank==50
  pivot_rows=list(M.transpose().pivots());minor=M.matrix_from_rows(pivot_rows).det();assert minor
  records.append({'parameter_factor_degree':degree,'omitted_A_root_index':omitted,'lambda':coords(lam),
      'delta':encoded(delta),'D1':encoded(D1),'t_gcd':encoded(tgcd),'combined_rank':int(rank),
      'independent_row_indices':list(map(int,pivot_rows)),'nonzero_50_minor':coords(minor),
      'seconds_at_completion':time.monotonic()-task_started})
  out={'scope':'All ordinary no-C-singleton finite support factors4/8, all four omissions, one diagonal-C3 slope phase. Seven NEW51x50 ranks plus stored prototype, no selectedzero or c numerator assumptions.',
      'field_modulus':prototype['field_modulus'],'base_generator_image':coords(base_image),
      'normalized_P':encoded(P),'normalized_Z':encoded(Z),'A_roots':[coords(embedding(r)) for r in aroots],
      'records':records,'complete':len(records)==8,'seconds':time.monotonic()-task_started,'sage_version':version()}
  output.write_text(json.dumps(out,indent=2,default=int)+'\n')
  print('NEWnoSingle',degree,'omitted',omitted,'rank50; records',len(records),'seconds',time.monotonic()-task_started,flush=True)
assert len(records)==8
signal.setitimer(signal.ITIMER_REAL,0)
