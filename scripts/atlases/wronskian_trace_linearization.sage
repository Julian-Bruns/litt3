#!/usr/bin/env sage
"""Trace-linearized R operator and constant N-row identity; no solver."""
import json,time,random
from pathlib import Path
started=time.monotonic()
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
parse=lambda row:vector(k,[sage_eval(c,locals={'a':a}) for c in row])
enc=lambda row:[str(c) for c in row]
mat=lambda rows:matrix(k,[parse(row) for row in rows])
canon=json.loads(Path('Research/computations/canonical_atlas_system.json').read_text())
bez=json.loads(Path('Research/computations/wronskian_quadratic_bezout.json').read_text())
dual=json.loads(Path('Research/computations/wronskian_serre_dual.json').read_text())
rt=json.loads(Path('Research/computations/wronskian_universal_image.json').read_text())
prior=json.loads(Path('Research/computations/wronskian_matrix_pencil.json').read_text())
saved=json.loads(Path('Research/computations/direct_wronskian_samples.json').read_text())
Bc=mat(canon['Bc']); Iproj=mat(canon['Iproj']); KU=mat(canon['SU_basis']); S=mat(dual['S_matrix'])
Nc=[mat(M) for M in canon['N_tensor']]; Rc=[mat(M) for M in canon['R_tensor']]
Rs=[mat(M) for M in rt['R_tensor']]
tensor=[(item['pair'],mat(item['matrix'])) for item in bez['tensor']]
R=PolynomialRing(k,'x'); x=R.gen()
F=R([2*a+1,4*a+2,3*a+3,a,3*a+4,4*a,3*a,3*a+1,a+4,4*a+2,1])
mons32=[tuple(m) for m in bez['L32_monomials']]
mons64=[tuple(m) for m in dual['monomials_L64']]; pos64={m:h for h,m in enumerate(mons64)}
def product(i,j):
    p,q=mons32[i]; r,s=mons32[j]; jj=(q+s)%3
    f=x**(p+r)*F**((q+s)//3)
    v=vector(k,56)
    for h,c in enumerate(f.list()):
        if c:v[pos64[h,jj]]=c
    return v
products=[[product(i,j) for j in range(24)] for i in range(24)]
def cup(eta):
    f=eta*S
    return matrix(k,[[f*p for p in row] for row in products])
fifth=lambda M:matrix(k,[[c**5 for c in row] for row in M.rows()])
def traceH(cup5):
    vv=vector(k,cup5.transpose().list())
    H=zero_matrix(k,32)
    for (i,j),B in tensor:
        c=vv*vector(k,B.list())
        H[i,j]=(2*c if i==j else c)
        H[j,i]=H[i,j]
    return H
Hs=[traceH(fifth(cup(Bc.column(h)))) for h in range(32)]
assert all(H==H.transpose() for H in Hs)
# Output row h, column u_i*beta_j^5. Constant coefficient row identity.
Nflat=matrix(k,[[Nc[i][r,j] for i in range(32) for j in range(32)] for r in range(64)])
diff=matrix(k,[[-Hs[j][h,i]-Rc[i][h,j] for i in range(32) for j in range(32)] for h in range(32)])
rows=list(Nflat.transpose().pivots())
NR=Nflat.matrix_from_rows(rows)
cols=list(NR.pivots())
Csmall=diff.matrix_from_columns(cols)*NR.matrix_from_columns(cols).inverse()
syzygy=Csmall*NR==diff
print('N coefficient rank',Nflat.rank(),'constant trace-R syzygy',syzygy,flush=True)
assert syzygy
C=zero_matrix(k,32,64)
for i,r in enumerate(rows):C.set_column(r,Csmall.column(i))
assert C*Nflat==diff
out={'scope':'Exact trace-linearized R identity on canonical J; no atlas exclusion or solver','H_definition':'H(beta^[5])u has i-th coordinate Tr(M_eta^[5]*partial_i B(u))','H_tensor_axis_order':'beta_fifthpower_direction,output_coordinate,U_coordinate','H_tensor':[[enc(row) for row in H.rows()] for H in Hs],'H_all_coefficients_symmetric_verified':True,'identity':'-H(beta^[5])*u-Rc_u*beta^[5]=C*(Nc_u*beta^[5])','C_matrix':[enc(row) for row in C.rows()],'all_bilinear_coefficients_identity_verified':True,'N_coefficient_rank':Nflat.rank(),'extension_samples':[],'generic_beta_samples':[]}
for sample,old in zip(saved['samples'],prior['samples']):
    uc=KU.transpose().solve_right(parse(sample['U_coefficients']))
    eta=parse(old['normalized_eta_coefficients'])
    H=traceH(fifth(cup(eta)))
    RU=sum((c*M for c,M in zip(uc,Rs)),zero_matrix(k,56))
    r=Iproj*RU*vector(k,[c**5 for c in eta]); hu=-H*uc
    pivot=next(i for i in range(32) if r[i]); scale=hu[pivot]/r[pivot]
    assert hu==scale*r
    print('extension',sample['seed'],'Hrank',H.rank(),'scale',scale,flush=True)
    out['extension_samples'].append({'seed':sample['seed'],'H_rank':H.rank(),'minus_H_U_over_projected_R':str(scale),'whole_vector_scale_verified':True})
for seed in range(202609101,202609106):
    rng=random.Random(seed)
    beta=vector(k,[k(rng.randrange(5))+a*rng.randrange(5) for _ in range(32)])
    H=sum((c**5*M for c,M in zip(beta,Hs)),zero_matrix(k,32))
    print('generic beta',seed,'Hrank',H.rank(),flush=True)
    out['generic_beta_samples'].append({'seed':seed,'beta':enc(beta),'H_rank':H.rank(),'determinant':str(H.det())})
out['quadratic_inverse_cup_syzygy_status']='Not attempted:576 matrix entries would require separate quadratic-U syzygies; existing five inverse-cup checks retained.'
out['elapsed_seconds']=time.monotonic()-started
Path('Research/computations/wronskian_trace_linearization.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
