#!/usr/bin/env sage
"""Exact scalar third-order projection and kernel computation."""
from pathlib import Path
source=Path('scripts/wronskian_matrix_pencil.sage').read_text()
marker="for sample in saved['samples']:"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
def add(v,w): return tuple(f+g for f,g in zip(v,w))
def scale(c,v): return tuple(c*f for f in v)
def dpow(v,n):
    for _ in range(n): v=delta(v)
    return v
zero=(R.zero(),)*3
ad=add(scale(3,dpow(P,2)),mul(P,P))
assert delta(ad)==zero
xp=(x,R.zero(),R.zero()); yp=(R.zero(),R.one(),R.zero())
assert all(sub(dpow(v,5),mul(ad,delta(v)))==zero for v in [xp,yp])
dP=delta(P)
def L(v): return sub(dpow(v,2),mul(P,v))
def Q(v): return add(add(dpow(v,3),mul(P,delta(v))),scale(3,mul(dP,v)))
mons64=basis(64); mons32=basis(32)
qimages=[]; poles=[]
for h in range(56):
    v=poly(vector(k,[int(i==h) for i in range(56)]),mons64)
    q=Q(v)
    assert L(q)==zero and Q(L(v))==zero
    p=max([3*i+10*j for j,f in enumerate(q) for i,c in enumerate(f.list()) if c]+[-1])
    assert p<=112
    cv=coeff(q,monsU)
    assert poly(cv,monsU)==q
    qimages.append(cv); poles.append(p)
QM=matrix(k,qimages).transpose()
LM=matrix(k,[coeff(L(poly(vector(k,[int(i==h) for i in range(24)]),mons32)),mons64) for h in range(24)]).transpose()
assert QM*LM==0
same=QM.right_kernel()==LM.column_space()
print('Q rank',QM.rank(),'kernel dimension',QM.right_nullity(),'kernel=image L',same,flush=True)
assert QM.rank()==32 and same
assert QM.column_space()==KU.row_space()
data={'scope':'Exact operator and bounded-space certificate for the fixed noninvariant oper','Q_definition':'delta^3+P*delta+3*(delta P)','a_delta_definition':'3*delta^2(P)+P^2','a_delta_polynomial_y_components':[enc(f.list()) for f in ad],'delta_a_zero_verified':True,'delta5_equals_a_delta_on_x_and_y_verified':True,'Q_domain_monomials_L64':mons64,'Q_target_monomials_L112':monsU,'Q_matrix_rows':[enc(row) for row in QM.rows()],'Q_output_pole_orders':poles,'all56_LQ_and_QL_polynomial_zero_verified':True,'Q_rank':QM.rank(),'Q_kernel_dimension':QM.right_nullity(),'Q_kernel_equals_L32_image':bool(same),'Q_image_equals_SU32':True,'elapsed_seconds':time.monotonic()-started}
Path('Research/computations/wronskian_differential_projection.json').write_text(json.dumps(data,indent=2,default=int)+'\n')
