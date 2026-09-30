"""Glue rational jet certificates into one polynomial identity, if possible."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);st=time.time();d=load(str(root/'vertical_jet_module.sobj'))
M=d['matrix'];C=d['curve'];PX=d['P'].parent();x=PX.gen();kr=vector(C,d['kappa'])
g=PX.zero();total=vector(C,[0]*9);steps=[]
orders=[]
for reverse in [False,True]:
 base=list(range(9));base=base[::-1] if reverse else base
 for shift in range(9):orders.append(base[shift:]+base[:shift])
for order in orders:
 A=M.matrix_from_rows(order);cc=A.transpose().solve_right(kr)
 c=vector(C,[0]*9)
 for i,j in enumerate(order):c[j]=cc[i]
 den=PX.one()
 for f in c:
  for a in f.list():den=lcm(den,PX(a.denominator()))
 num=den*c
 for f in num:
  assert all(a.denominator()==1 for a in f.list())
 gg,u,v=g.xgcd(den);total=u*total+v*num;g=gg
 assert total*M==g*kr
 rec={'row_order':order,'denominator_degree':int(den.degree()),'remaining_gcd_degree':int(g.degree())}
 steps.append(dict(rec,denominator=den,certificate=c,bezout=(u,v)))
 print(rec,flush=True)
 if g.is_one():break
save({'matrix':M,'kappa':kr,'global_polynomial_certificate':total,'remaining_denominator':g,'steps':steps},str(root/'global_jet_identity.sobj'))
report={'complete_global_identity':bool(g.is_one()),'remaining_denominator_degree':int(g.degree()),'steps':[{k:v for k,v in s.items() if k not in ['denominator','certificate','bezout']} for s in steps],'seconds':time.time()-st,'scope':'polynomial row identity on the entire affine curve, not only generic or rational points'}
if g.is_one():
 report['coefficient_degrees']=[[int(a.numerator().degree()) if a else -1 for a in f.list()] for f in total]
(root/'global_identity_summary.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print(report,flush=True)
