#!/usr/bin/env sage -python
"""A certified relation superlattice, conditional on marked-point orders.

With --order-receipt, use ONLY primes certified in that completed actual
Jacobian-point receipt. Without it this is an explicitly conditional probe.
The small rational inverse gives a rigorous lower bound, not an SVP claim.
"""
import argparse,json
from pathlib import Path
from sage.all import ZZ,QQ,GF,PolynomialRing,matrix,vector,identity_matrix

p=argparse.ArgumentParser();p.add_argument('output',type=Path)
p.add_argument('--order-receipt',type=Path)
args=p.parse_args()
R=PolynomialRing(ZZ,'T');T=R.gen()
Pi=(T**18-2*T**17-29*T**16+57*T**15-124*T**14+3716*T**13+3083*T**12
 -94215*T**11+141450*T**10+601875*T**9+3536250*T**8-58884375*T**7
 +48171875*T**6+1451562500*T**5-1210937500*T**4+13916015625*T**3
 -177001953125*T**2-305175781250*T+3814697265625)
Q=T**8+T**4+1
M=matrix(ZZ,[[(T**i*Pi%Q)[j] for j in range(8)] for i in range(8)])
exp=M.elementary_divisors()[-1]
ord_actual=exp
if args.order_receipt:
 inp=json.loads(args.order_receipt.read_text())
 assert 'exact_point_order' in inp
 ord_actual=ZZ(inp['exact_point_order'])
L=identity_matrix(ZZ,8);rows=[]
for ell,power in ord_actual.factor():
 S=PolynomialRing(GF(ell),'T');g=S(Pi).gcd(S(Q))
 if g.degree()!=1:continue
 root=ZZ(-g[0]/g[1]);v=vector(ZZ,[pow(root,j,ell) for j in range(8)])
 a=L*v;ip=next(j for j in range(8) if a[j]%ell)
 J=identity_matrix(ZZ,8)
 inv=ZZ(a[ip]).inverse_mod(ell)
 for j in range(8):
  if j!=ip:J[j,ip]=-ZZ(a[j]*inv%ell)
 J[ip,ip]=ell
 L=(J*L).hermite_form().LLL()
 assert all(n%ell==0 for n in L*v)
 rows.append({'prime':str(ell),'root':str(root)})
for item in rows:
 ell=ZZ(item['prime']);root=ZZ(item['root'])
 assert all(n%ell==0 for n in L*vector(ZZ,[pow(root,j,ell) for j in range(8)]))
assert abs(L.det())==ZZ.prod(ZZ(r['prime']) for r in rows)
B=L.change_ring(QQ).inverse()
C=matrix(QQ,[[ (T**i%Q)[j] for j in range(8)] for i in range(12)])*B
bound=max(abs(c) for row in C for c in row)
cutoff=(1/bound).ceil()-1
width=max(max([QQ(0)]+list(C.column(j)))-min([QQ(0)]+list(C.column(j)))
          for j in range(8))
signed_cutoff=(1/width).ceil()-1
rec={'scope':'necessary relation superlattice; no equality with actual kernel asserted',
 'conditional':not bool(args.order_receipt),'actual_order_receipt':str(args.order_receipt) if args.order_receipt else None,
 'module_exponent':str(exp),'used_point_order':str(ord_actual),
 'modular_rows':rows,'basis_rows':[[str(c) for c in r] for r in L],
 'inverse_rows':[[str(c) for c in r] for r in B],
 'twelve_point_coordinate_rows':[[str(c) for c in r] for r in C],
 'max_coordinate':str(bound),'supported_function_invariance_through':str(cutoff),
 'max_coordinate_width_with_infinity':str(width),
 'signed_supported_function_invariance_through':str(signed_cutoff),
 'checks':{'all_congruences':True,'index_is_product':True,'strict_bound':bool(cutoff*bound<1)}}
args.output.parent.mkdir(parents=True,exist_ok=True)
args.output.write_text(json.dumps(rec,indent=2)+'\n')
print('conditional',rec['conditional'],'primes',len(rows),'cutoff',cutoff,
      'signed cutoff',signed_cutoff,'beta',bound)
