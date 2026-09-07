#!/usr/bin/env sage
"""Iterated exact linear necessary condition, retaining coupled N/R tensors."""
from pathlib import Path
source=Path('scripts/wronskian_serre_dual.sage').read_text()
marker="for sample,old in zip(saved['samples'],prior['samples']):"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
rtensor=json.loads(Path('Research/computations/wronskian_universal_image.json').read_text())
Rs=[matrix(k,[parse(row) for row in M]) for M in rtensor['R_tensor']]
assert matrix(k,[parse(row) for row in rtensor['S_U_basis']])==KU
# One fixed coordinate left inverse for all Wronskians.
piv=list(power_matrix.transpose().pivots())
sq=power_matrix.matrix_from_rows(piv)
inv=sq.inverse()
assert inv*sq==identity_matrix(k,56)
Ns=[]
for i,uv in enumerate(KU.rows()):
    up=poly(uv,monsU)
    wh=[sub(mul(up,delta(tp)),mul(tp,delta(up))) for tp in T40]
    wc=matrix(k,[coeff(v,mons320) for v in wh]).transpose()
    coords=inv*wc.matrix_from_rows(piv)
    assert power_matrix*coords==wc
    assert all(poly(wc.column(h),mons320)==wh[h] for h in range(64))
    Ns.append(coords.transpose()*S5.transpose())
print('all32 N tensors built and polynomial identities verified',flush=True)
B=identity_matrix(k,56)
data={'scope':'Linear necessary-condition sieve; positive stable dimension is not exclusion','N_tensor_definition':'64-row Serre dual Wronskian matrices','N_tensor':[[enc(row) for row in M.rows()] for M in Ns],'R_tensor_source':'wronskian_universal_image.json','all32_N_polynomial_identities_verified':True,'iterations':[]}
for iteration in range(57):
    dim=B.ncols()
    B5=matrix(k,[[c**5 for c in row] for row in B.rows()])
    NN=block_matrix(k,1,32,[M*B5 for M in Ns])
    RR=block_matrix(k,1,32,[M*B5 for M in Rs])
    nr=NN.rank(); sr=NN.stack(RR).rank()
    predicted=sr-nr
    K=NN.right_kernel().basis_matrix()
    assert NN*K.transpose()==0
    image=RR*K.transpose()
    newB=image.column_space().basis_matrix().transpose()
    assert newB.ncols()==predicted
    assert B.transpose().stack(newB.transpose()).rank()==dim
    item={'iteration':iteration,'dimension_in':dim,'NN_shape':list(NN.dimensions()),'rank_NN':nr,'rank_stacked_NN_RR':sr,'dimension_out':newB.ncols(),'image_basis_columns_as_rows':[enc(row) for row in newB.transpose().rows()],'kernel_and_rank_difference_verified':True}
    data['iterations'].append(item)
    print('iteration',iteration,'dim',dim,'to',newB.ncols(),'rankNN',nr,'stackrank',sr,flush=True)
    if newB.ncols()==dim or newB.ncols()==0:
        data['terminal_dimension']=newB.ncols()
        data['stable']=bool(newB.ncols()==dim)
        break
    B=newB
else: raise AssertionError('Sieve failed to stabilize in56 strict dimension drops')
data['elapsed_seconds']=time.monotonic()-started
Path('Research/computations/wronskian_linear_sieve.json').write_text(json.dumps(data,indent=2,default=int)+'\n')
print('DONE',data['elapsed_seconds'],flush=True)
