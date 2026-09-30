#!/usr/bin/env sage -python
"""Assemble the exact marked relation lattice from complete primary data."""
import argparse,json,hashlib
from pathlib import Path
from sage.all import ZZ,QQ,GF,PolynomialRing,matrix,vector,identity_matrix
p=argparse.ArgumentParser()
p.add_argument('order',type=Path);p.add_argument('small_primary',type=Path)
p.add_argument('output',type=Path);args=p.parse_args()
ordrec=json.loads(args.order.read_text());small=json.loads(args.small_primary.read_text())
assert 'exact_point_order'in ordrec and small.get('complete')
m=ZZ(ordrec['exact_point_order']);assert all(e==1 for l,e in m.factor())
small_by_prime={ZZ(r['prime']):r for r in small['primes']}
R=PolynomialRing(ZZ,'T');T=R.gen()
Pi=(T**18-2*T**17-29*T**16+57*T**15-124*T**14+3716*T**13+3083*T**12
 -94215*T**11+141450*T**10+601875*T**9+3536250*T**8
 -58884375*T**7+48171875*T**6+1451562500*T**5-1210937500*T**4
 +13916015625*T**3-177001953125*T**2-305175781250*T+3814697265625)
Q=T**8+T**4+1
L=identity_matrix(ZZ,8);groups=[];index=ZZ(1);all_constraints=[]
for ell,power in m.factor():
 S=PolynomialRing(GF(ell),'T');g=S(Pi).gcd(S(Q))
 if ell in small_by_prime:
  data=small_by_prime[ell]
  assert data['actual_primary_exponent']==1
  constraints=matrix(ZZ,data['constraint_columns'])
  rank=data['actual_primary_rank']
  assert constraints.nrows()==8 and matrix(GF(ell),constraints).rank()==rank
 elif g.degree()==1:
  root=ZZ(-g[0]/g[1]);constraints=matrix(ZZ,8,1,[pow(root,i,ell)for i in range(8)])
  rank=1
 else:raise ValueError('Uncovered primary component '+str(ell))
 added=0
 for v in constraints.columns():
  a=L*v
  nonzero=[j for j in range(8)if a[j]%ell]
  if not nonzero:continue
  pivot=nonzero[0];inv=ZZ(a[pivot]).inverse_mod(ell)
  J=identity_matrix(ZZ,8)
  for j in range(8):
   if j!=pivot:J[j,pivot]=-ZZ(a[j]*inv%ell)
  J[pivot,pivot]=ell
  L=(J*L).hermite_form();added+=1
 assert added==rank
 index*=ell**rank
 groups.append({'prime':str(ell),'rank':rank,'gcd_coefficients':[int(c)for c in g],
                'constraint_columns':[[str(c)for c in row]for row in constraints]})
 all_constraints.append((ell,constraints))
L=L.LLL();assert abs(L.det())==index
for ell,cons in all_constraints:assert all(c%ell==0 for c in L*cons)
inv=L.change_ring(QQ).inverse()
rows=matrix(QQ,[[(T**i%Q)[j]for j in range(8)]for i in range(12)])*inv
beta=max(abs(c)for row in rows for c in row)
width=max(max([QQ(0)]+list(rows.column(j)))-min([QQ(0)]+list(rows.column(j)))for j in range(8))
rec={'scope':'EXACT kernel of Z[T]/(T8+T4+1) -> marked Jacobian subgroup',
 'conditional':False,'exact_kernel':True,'actual_point_order':str(m),
 'actual_marked_group_order':str(index),'primary_components':groups,
 'basis_rows':[[str(c)for c in row]for row in L],
 'inverse_rows':[[str(c)for c in row]for row in inv],
 'twelve_point_coordinate_rows':[[str(c)for c in row]for row in rows],
 'max_coordinate':str(beta),'supported_function_invariance_through':str((1/beta).ceil()-1),
 'max_coordinate_width_with_infinity':str(width),
 'signed_supported_function_invariance_through':str((1/width).ceil()-1),
 'inputs':{str(path):hashlib.sha256(path.read_bytes()).hexdigest()for path in [args.order,args.small_primary]},
 'checks':{'all_actual_primes_covered':True,'all_exponents_one':True,
           'all_congruences':True,'index_equals_group_order':True}}
args.output.write_text(json.dumps(rec,indent=2)+'\n')
print('PASS exact kernel; point order',m,'group order',index)
print('coordinate bound',rec['supported_function_invariance_through'])
