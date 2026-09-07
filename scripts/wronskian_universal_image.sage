#!/usr/bin/env sage
"""Exact image span of every R_U for all 32 basis directions of S_U."""
from pathlib import Path
source=Path('scripts/wronskian_matrix_pencil.sage').read_text()
marker="for sample in saved['samples']:"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
Rs=[]; ranks=[]; span=matrix(k,0,56)
lam5s=[monseries(fifthvector(D.column(h)),[5*d for d in domain]) for h in range(56)]
for i,uv in enumerate(KU.rows()):
    U=laurent(uv,monsU); rc=[]
    for h,e in enumerate(target):
        aff,rem=split_aff(U*tt**(5*e))
        rc.append(rho(tt**(-85)*rem-U*lam5s[h],target))
    RM=matrix(k,rc).transpose(); Rs.append(RM)
    span=span.stack(RM.transpose()).row_space().basis_matrix()
    ranks.append(span.nrows())
    print('basis direction',i,'R rank',RM.rank(),'cumulative image',span.nrows(),flush=True)
ann=span.right_kernel().basis_matrix()
assert all(ann*RM==0 for RM in Rs)
assert ann.nrows()+span.nrows()==56
data={'scope':'All32 basis directions of the fixed noninvariant oper; exact linear-algebra certificate, not an atlas exclusion','oper_alpha':str(alpha),'c4':3,'eta_exponents':target,'S_U_monomials':monsU,'S_U_basis':[enc(row) for row in KU.rows()],'R_tensor_axis_order':'direction,row,column','R_tensor':[[enc(row) for row in RM.rows()] for RM in Rs],'cumulative_image_ranks':ranks,'universal_image_dimension':span.nrows(),'universal_image_basis_rows':[enc(row) for row in span.rows()],'annihilator_basis_rows':[enc(row) for row in ann.rows()],'annihilator_dimension':ann.nrows(),'all32_annihilator_times_R_zero_verified':True,'elapsed_seconds':time.monotonic()-started}
Path('Research/computations/wronskian_universal_image.json').write_text(json.dumps(data,indent=2,default=int)+'\n')
print('DONE universal image dimension',span.nrows(),'elapsed',data['elapsed_seconds'],flush=True)
