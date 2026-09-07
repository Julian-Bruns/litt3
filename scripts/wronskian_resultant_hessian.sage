#!/usr/bin/env sage
"""Exact local Hessian probe using implicit differentiation, not interpolation."""
from pathlib import Path
source=Path('scripts/wronskian_linear_syzygy.sage').read_text()
marker='wquad={}'
assert source.count(marker)==1
# This initializes helpers and builds TM on stable J. For full E below,
# rebuild only affine matrices; retain exact polynomial W functionals WF.
head=source.split(marker)[0]
head=head.split('eta5s=')[0]
exec(preparse(head))
rt=json.loads(Path('Research/computations/wronskian_universal_image.json').read_text())
canon=json.loads(Path('Research/computations/canonical_atlas_system.json').read_text())
prior=json.loads(Path('Research/computations/wronskian_matrix_pencil.json').read_text())
Rs=[matrix(k,[parse(row) for row in M]) for M in rt['R_tensor']]
Iproj=matrix(k,[parse(row) for row in canon['Iproj']])
Bc=matrix(k,[parse(row) for row in canon['Bc']])
Ts=[]
for i,uv in enumerate(KU.rows()):
    U=laurent(uv,monsU); cols=[]
    for e in target:
        aff,rem=split_aff(U*tt**(5*e)); cols.append(-aff)
    Ts.append(matrix(k,cols).transpose())
    if i%8==7: print('full affine directions',i+1,flush=True)
def lincomb(mats,uc): return sum((c*M for c,M in zip(uc,mats)),zero_matrix(k,*mats[0].dimensions()))
out={'scope':'Two exact local Hessian probes using proposed global gradient identity; no global rank or exclusion conclusion','normalization':'Delta=1 at sample; e chosen with w(U)e=1; gradDelta=-i(R_Ue)','samples':[]}
for sample,old in zip(saved['samples'][:2],prior['samples'][:2]):
    uc=KU.transpose().solve_right(parse(sample['U_coefficients']))
    NU=lincomb(Ns,uc); RU=lincomb(Rs,uc); TU=lincomb(Ts,uc)
    wu=uc*WF; w=wu*TU
    ep=fifthvector(parse(old['normalized_eta_coefficients']))
    assert NU*ep==0 and w*ep==1
    grad=-Iproj*RU*ep
    assert grad*uc==k(48)
    dw=matrix(k,[WF.row(h)*TU+wu*Ts[h] for h in range(32)])
    augmented=NU.stack(matrix(k,[w])); assert augmented.rank()==56
    rhs=matrix(k,[list(-Ns[h]*ep)+[grad[h]-dw.row(h)*ep] for h in range(32)]).transpose()
    epprime=augmented.solve_right(rhs)
    assert augmented*epprime==rhs
    cols=[]
    for h in range(32):
        combined=Rs[h]*ep+RU*epprime.column(h)
        assert Bc*Iproj*combined==combined
        cols.append(-Iproj*combined)
    H=matrix(k,cols).transpose()
    symmetric=H==H.transpose(); euler=H*uc==47*grad
    print('seed',sample['seed'],'symmetric',symmetric,'Euler',euler,'Hrank',H.rank(),'logrank',(H-grad.column()*grad.row()).rank(),flush=True)
    assert symmetric and euler
    out['samples'].append({'seed':sample['seed'],'Delta':1,'U_coordinates':enc(uc),'gradient':enc(grad),'Hessian':[enc(row) for row in H.rows()],'Hessian_rank':H.rank(),'log_Hessian_rank':(H-grad.column()*grad.row()).rank(),'symmetric_verified':bool(symmetric),'Euler_Hessian_U_equals47_gradient_verified':bool(euler),'all_combined_R_derivatives_lie_in_J_verified':True,'implicit_e_derivative_equations_verified':True})
out['elapsed_seconds']=time.monotonic()-started
Path('Research/computations/wronskian_resultant_hessian.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
