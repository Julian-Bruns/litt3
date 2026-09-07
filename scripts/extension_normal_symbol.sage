#!/usr/bin/env sage
"""Exact quadratic normal-symbol/coefficient-transport witness; no solver."""
from pathlib import Path
import hashlib
source=Path('scripts/direct_wronskian_test.sage').read_text()
marker='monsU=basis(112); monsT=basis(197)'
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
cache={}
def parse(s):
    if s not in cache: cache[s]=k(sage_eval(s,locals={'a':a}))
    return cache[s]
def mat(M):return matrix(k,[[parse(c) for c in row] for row in M])
enc=lambda v:[str(c) for c in v]
read=lambda stem:json.loads(Path('Research/computations/'+stem+'.json').read_text())
full=read('wronskian_universal_image'); dual=read('wronskian_serre_dual')
grad=read('wronskian_line_gradient'); compact=read('canonical_atlas_system')
jdata=read('extension_projection_differential')['samples'][0]
Qc=mat(grad['Qc_matrix']); Q5=Qc.apply_map(lambda c:c**5)
S=mat(dual['S_matrix']); S5=S.apply_map(lambda c:c**5)
Bc5=mat(compact['Bc']).apply_map(lambda c:c**5)
KU=mat(full['S_U_basis']); monsU=full['S_U_monomials']
mons64=basis(64); mons320=basis(320)
H=Qc.right_kernel().basis_matrix()
hs=[poly(row,mons64) for row in H.rows()]
dhs=[delta(v) for v in hs]; ddhs=[delta(v) for v in dhs]
def add(v,w): return tuple(f+g for f,g in zip(v,w))
def scale(c,v): return tuple(c*f for f in v)
def pow5(v):return mul(mul(mul(mul(v,v),v),v),v)
PM=matrix(k,[coeff(pow5(poly(vector(k,[int(i==j) for i in range(56)]),mons64)),mons320) for j in range(56)]).transpose()
piv=list(PM.transpose().pivots()); inv=PM.matrix_from_rows(piv).inverse()
assert len(piv)==56
u=vector(k,[parse(s) for s in jdata['U']]); up=poly(u*KU,monsU); dup=delta(up)
uu=mul(up,up); udu=mul(up,dup); rest=sub(mul(dup,dup),mul(P,uu))
cols=[]
for h,dh,ddh in zip(hs,dhs,ddhs):
    b=add(sub(scale(k(3),mul(uu,ddh)),mul(udu,dh)),mul(rest,h))
    assert delta(b)==(R.zero(),)*3
    v=coeff(b,mons320); assert poly(v,mons320)==b
    co=inv*vector(k,[v[i] for i in piv]); assert PM*co==v
    cols.append(co)
V=matrix(k,cols).transpose()
Normal=V.transpose()*S5.transpose()
Project=Q5*V
assert Project==Bc5.transpose()*Normal.transpose()
Ns=[mat(M) for M in read('wronskian_linear_sieve')['N_tensor']]
Rs=[mat(M) for M in full['R_tensor']]; IP=mat(compact['Iproj'])
N=sum((u[i]*Ns[i] for i in range(32)),zero_matrix(k,64,56))
RR=sum((u[i]*Rs[i] for i in range(32)),zero_matrix(k,56))
c=vector(k,[parse(s) for s in jdata['normalized_extension']])
w=k(3)*(u*IP*RR)
rhs=matrix(k,[-Ns[i]*c for i in range(32)]).transpose().stack(matrix(k,[[-k(3)*((IP*RR).row(i)*c+u*IP*Rs[i]*c) for i in range(32)]]))
DC=N.stack(matrix(k,[w])).solve_right(rhs)
print('full normalrank',Normal.rank(),'projectedrank',Project.rank(),'annihilates derivative',Normal*DC==0,flush=True)
assert Normal.rank()==24 and Project.rank()==24 and Normal*DC==0
assert Normal.right_kernel()==DC.column_space()
out={'scope':'One exact transported quadratic-normal-map identification, not an all-point injectivity or exclusion theorem.',
 'formula':'B_U(h)=U^2 delta^2(h)/2-U delta(U) delta(h)+((delta(U))^2-P U^2)h',
 'all24_outputs_fifth_powers_verified':True,'normal_rank':Normal.rank(),'projected_rank':Project.rank(),'normal_annihilates_exact_extension_derivative':True,
 'U':enc(u),'normal_matrix':[enc(v) for v in Normal.rows()],'elapsed_seconds':time.monotonic()-started}
stems=['wronskian_universal_image','wronskian_serre_dual','wronskian_line_gradient','canonical_atlas_system','extension_projection_differential','wronskian_linear_sieve','normalized_oper_algebra_certificate']
out['source_sha256']={s:hashlib.sha256(Path('Research/computations/'+s+'.json').read_bytes()).hexdigest() for s in stems}
out['polynomial_setup_sha256']=hashlib.sha256(Path('scripts/direct_wronskian_test.sage').read_bytes()).hexdigest()
Path('Research/computations/extension_normal_symbol.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('elapsed',out['elapsed_seconds'],flush=True)
