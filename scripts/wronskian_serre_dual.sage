#!/usr/bin/env sage
"""Exact five-sample comparison of the 64-row dual and 136-row matrices."""
from pathlib import Path
source=Path('scripts/wronskian_matrix_pencil.sage').read_text()
marker="for sample in saved['samples']:"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
prior=json.loads(Path('Research/computations/wronskian_matrix_pencil.json').read_text())
mons192=basis(192); mons64=basis(64); mons320=basis(320)
K40=kernel(mons192)
assert K40.nrows()==64
T40=[poly(row,mons192) for row in K40.rows()]
def power5poly(v): return mul(mul(mul(mul(v,v),v),v),v)
powers=[power5poly(poly(vector(k,[int(h==j) for h in range(len(mons64))]),mons64)) for j in range(len(mons64))]
power_matrix=matrix(k,[coeff(v,mons320) for v in powers]).transpose()
assert power_matrix.rank()==56
theta=1/delta_t
S=matrix(k,[[((tt**e)*expansions[m]*theta)[-1] for m in mons64] for e in target])
assert S.rank()==56
S5=matrix(k,[[c**5 for c in row] for row in S.rows()])
out={'scope':'Exact sample comparison; no global exclusion','S40_dimension':K40.nrows(),'monomials_L64':mons64,'monomials_L192':mons192,'eta_exponents':target,'pairing_definition':'S[i,l]=res_O(t^eta_exp_i*m_l*dt/delta_t)','new_matrix_definition':'Wronskian fifth-power polynomial coefficients times transpose(S^[5])','S_rank':S.rank(),'samples':[]}
for sample,old in zip(saved['samples'],prior['samples']):
    uv=parse(sample['U_coefficients']); up=poly(uv,monsU)
    wh=[sub(mul(up,delta(tp)),mul(tp,delta(up))) for tp in T40]
    wc=matrix(k,[coeff(v,mons320) for v in wh]).transpose()
    coords=power_matrix.solve_right(wc)
    assert power_matrix*coords==wc
    assert all(poly(wc.column(h),mons320)==wh[h] for h in range(64))
    ND=coords.transpose()*S5.transpose()
    U=laurent(uv,monsU)
    NC=[]
    for e in target:
        aff,rem=split_aff(U*tt**(5*e))
        NC.append(vector(k,[rem[d] for d in target128]))
    NN=matrix(k,NC).transpose()
    assert NN.rank()==55
    print('seed',sample['seed'],'dual rank',ND.rank(),flush=True)
    assert ND.rank()==55
    assert ND.right_kernel()==NN.right_kernel()
    eta5=fifthvector(parse(old['normalized_eta_coefficients']))
    assert ND*eta5==0
    item={'seed':sample['seed'],'U_pole':sample['U_pole'],'dual_rank':ND.rank(),'old_rank':NN.rank(),'kernels_equal':True,'normalized_eta5_annihilated':True,'all_64_polynomial_Wronskians_verified_as_fifth_powers':True}
    if not out['samples']:
        item['dual_matrix']=[enc(row) for row in ND.rows()]
        out['S_matrix']=[enc(row) for row in S.rows()]
        out['S40_basis']=[enc(row) for row in K40.rows()]
    out['samples'].append(item)
out['elapsed_seconds']=time.monotonic()-started
Path('Research/computations/wronskian_serre_dual.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('all dual checks pass',out['elapsed_seconds'],flush=True)
