"""Try polynomial row reduction to shorten the new global jet identity."""
import sys,time,json
from pathlib import Path
root=Path(sys.argv[1]);st=time.time();d=load(str(root/'vertical_jet_module.sobj'))
C=d['curve'];M=d['matrix'];PX=d['P'].parent();y=C.gen();kap=d['kappa'];weights=[1,2,0,2,0,1,0,1,2]
def parts(f):
 a=list(f.list());a += [C.base_field().zero()]*(3-len(a))
 assert all(t.denominator()==1 for t in a)
 return [PX(t.numerator()) for t in a]
R=matrix(PX,9,24)
for i in range(9):
 for j in range(8):
  for k,c in enumerate(parts(y**weights[i]*M[i,j])):R[i,3*j+k]=c
rhs=vector(PX,[c for k in kap for c in [PX(k),PX.zero(),PX.zero()]])
print('polynomial rank',R.rank(),'seconds',time.time()-st,flush=True)
H,U=R.hermite_form(transformation=True,include_zero_rows=True)
assert U*R==H
print('Hermite complete seconds',time.time()-st,flush=True)
F=PX.fraction_field();cc=H.change_ring(F).transpose().solve_right(vector(F,rhs))
cc=cc*U
assert cc*R==rhs
den=lcm([v.denominator() for v in cc]);print('den degree',den.degree(),flush=True)
before=cc
kernel=[vector(PX,U[i]) for i in range(H.nrows()) if not H.row(i)]
def lead(v):
 return max((3*int(f.degree())+10*weights[j],j) for j,f in enumerate(v) if f)
if den.degree()==0:
 cc=vector(PX,[PX(f) for f in cc])
 # One-variable weak Popov reduction, with actual coefficient pole shifts.
 while True:
  hit=False
  for i in range(len(kernel)):
   for j in range(i):
    li,lj=lead(kernel[i]),lead(kernel[j])
    if li[1]!=lj[1]:continue
    big,small=(i,j) if li>=lj else (j,i); p=li[1]
    q,rem=kernel[big][p].quo_rem(kernel[small][p])
    kernel[big]-=q*kernel[small];assert kernel[big]
    hit=True;break
   if hit:break
  if not hit:break
 while True:
  hit=False
  for v in kernel:
   p=lead(v)[1]
   if cc[p] and cc[p].degree()>=v[p].degree():
    q,rem=cc[p].quo_rem(v[p]);cc-=q*v;hit=True;break
  if not hit:break
 assert cc*R==rhs
save({'polynomial_matrix':R,'weights':weights,'rhs':rhs,'hermite':H,'transformation':U,'certificate_before_reduction':before,'kernel_popov':kernel,'certificate':cc},str(root/'reduced_jet_identity.sobj'))
report={'polynomial_certificate':bool(den.degree()==0),'degrees':[int(v.numerator().degree()) if v else -1 for v in cc],'denominator_degree':int(den.degree()),'seconds':time.time()-st}
(root/'reduced_identity_summary.json').write_text(json.dumps(report,indent=2,default=int)+'\n');print(report,flush=True)
