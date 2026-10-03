#!/usr/bin/env sage
"""One quartic-parameter two-sheet content plus universal endpoint contact2."""
import json,time,signal
from pathlib import Path
from itertools import product
task_started=time.monotonic();folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform')
prefix=Path('/Users/julian/Documents/litt3/scripts/oct02_m9_uniform_four_zero_prototype.sage').read_text().split('double_root=')[0]
exec(compile(prefix,'normalized_quotient_prefix','exec'))
def expired30(signum,frame):raise TimeoutError('no-single content prototype hard30-second budget')
signal.signal(signal.SIGALRM,expired30);signal.setitimer(signal.ITIMER_REAL,max(.1,30-(time.monotonic()-task_started)))
F8=E;R8=R;P8=P;Z8=Z;Pold8=Pold;Zold8=Zold;q8=q;q38=q3;basis8=basis
selected8=[(r,y) for r in aroots[1:] for y in cubes(r)]
contact8=matrix(F8,[row for pt in selected8 for (j,t),row in allrows[pt].items() if t<2-j]);assert contact8.nrows()==27
support=json.loads((folder/'no_single_affine_cube_parameter_support.json').read_text())
drop=json.loads((folder/'no_single_leading_drop_exclusion.json').read_text());assert drop['gcd_degree']==0
factor=next(f for f in drop['primitive_factors'] if f['degree']==4)
parameter8=R8([code(c) for c in factor['polynomial']]);lam8=parameter8.roots(multiplicities=False)[0]
delta8=q38+lam8*q8;K8,rem8=(Zold8*delta8).quo_rem(Pold8)
gg=(-8*K8**3*Pold8)%delta8;g0,g1,g2=[gg[i] for i in range(3)];d0,d1,d2=[delta8[i] for i in range(3)];assert g2
f=3*g1*x-g1*d2-g2*(3*x*x-d1)
h=g0*(3*x-d2)-g2*(x**3-d0);tgcd=f.gcd(h);print('t-gcd degree',tgcd.degree(),flush=True)
E=GF(5**48,'u');R=PolynomialRing(E,'x');x=R.gen()
base_image=R(data['field_modulus']).roots(multiplicities=False)[0];embedding=F8.hom([base_image],E)
def liftpoly(g):return R([embedding(v) for v in g.list()])
P=liftpoly(P8);Z=liftpoly(Z8);Pold=liftpoly(Pold8);Zold=liftpoly(Zold8);q=liftpoly(q8);q3=liftpoly(q38)
basis=[[[liftpoly(h) for h in f] for f in fs] for fs in basis8]
delta=liftpoly(delta8);K=liftpoly(K8);contact=contact8.apply_map(embedding);records=[]
def coords(v):return [int(c) for c in v.polynomial().list()]
def encoded(g):return [coords(v) for v in g.list()]
for tvalue in liftpoly(tgcd).roots(multiplicities=False):
 slope_cube=embedding(g2)/(3*tvalue-embedding(d2));assert slope_cube
 # D1/z slope uses the same endpoint normalization as the quotient basis.
 bnorm=(x**3-slope_cube/embedding(pbase)).roots(multiplicities=False)[0]
 D1=bnorm*(x+tvalue);assert not (D1**3+8*K**3*P)%delta
 rows=[]
 for j in range(4):
  c1=[(K*fs[j][1]+D1*fs[j][2]/2)%delta for fs in basis]
  c0=[(K**2*fs[j][0]-D1**2*fs[j][2]/4)%delta for fs in basis]
  for c in [c1,c0]:
   for n in range(3):rows.append([f[n] for f in c])
 M=matrix(E,list(contact.rows())+rows);assert M.nrows()==51 and M.ncols()==50
 rank=M.rank();kernel=M.right_kernel_matrix();assert rank+kernel.nrows()==50
 records.append({'tvalue':coords(tvalue),'slope_cube_normalized':coords(slope_cube/embedding(pbase)),
       'D1':encoded(D1),'combined_rank':int(rank),'kernel_dimension':int(kernel.nrows()),
       'kernel':[[coords(v) for v in row] for row in kernel.rows()]})
 print('NOsingle prototype rank',rank,'kernel',kernel.nrows(),'seconds',time.monotonic()-task_started,flush=True)
out={'scope':'One quartic-factor parameter, one omission, all finite-t solutions and one C3 slope phase each; universal contact2, no selectedzero assumptions.',
    'field_modulus':[int(v) for v in E.modulus().list()],'base_generator_image':coords(base_image),'lambda':coords(embedding(lam8)),
    'delta':encoded(delta),'normalized_P':encoded(P),'t_gcd_degree':int(tgcd.degree()),'records':records,
    'complete_t_roots':len(records)==tgcd.degree(),'seconds':time.monotonic()-task_started,'sage_version':version()}
(folder/'no_single_content_quartic_prototype.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
signal.setitimer(signal.ITIMER_REAL,0)
