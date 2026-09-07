#!/usr/bin/env sage
"""Identify the stable sieve annihilator with an exact scalar ODE image."""
from pathlib import Path
source=Path('scripts/wronskian_matrix_pencil.sage').read_text()
marker="for sample in saved['samples']:"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
dual=json.loads(Path('Research/computations/wronskian_serre_dual.json').read_text())
sieve=json.loads(Path('Research/computations/wronskian_linear_sieve.json').read_text())
S=matrix(k,[parse(row) for row in dual['S_matrix']])
J=matrix(k,[parse(row) for row in sieve['iterations'][-1]['image_basis_columns_as_rows']])
ann=J.right_kernel().basis_matrix()
Q=S.solve_right(ann.transpose())
assert S*Q==ann.transpose()
mons32=basis(32); mons64=basis(64)
assert len(mons32)==24 and len(mons64)==56
images=[]; poles=[]
for h in range(24):
    v=poly(vector(k,[int(i==h) for i in range(24)]),mons32)
    w=sub(delta(delta(v)),mul(P,v))
    p=max([3*i+10*j for j,f in enumerate(w) for i,c in enumerate(f.list()) if c]+[-1])
    assert p<=64
    cv=coeff(w,mons64)
    assert poly(cv,mons64)==w
    images.append(cv); poles.append(p)
L=matrix(k,images)
equal=L.row_space()==Q.column_space()
print('L image rank',L.rank(),'J annihilator dimension',ann.nrows(),'equal',equal,flush=True)
assert L.rank()==24 and equal
assert J*S*L.transpose()==0
data={'scope':'Exact identification for the fixed noninvariant oper; no atlas exclusion','domain_monomials_L32':mons32,'codomain_monomials_L64':mons64,'L_definition':'delta^2-P','image_rows':[enc(row) for row in L.rows()],'image_pole_orders':poles,'image_rank':L.rank(),'kernel_dimension':24-L.rank(),'stable_J_dimension':J.nrows(),'stable_J_annihilator_dimension':ann.nrows(),'annihilator_in_L64_basis_columns_as_rows':[enc(row) for row in Q.transpose().rows()],'image_equals_stable_annihilator_under_residue_pairing':bool(equal),'polynomial_images_and_pole64_bound_verified':True,'pairing_annihilation_verified':True,'elapsed_seconds':time.monotonic()-started}
Path('Research/computations/wronskian_stable_identification.json').write_text(json.dumps(data,indent=2,default=int)+'\n')
