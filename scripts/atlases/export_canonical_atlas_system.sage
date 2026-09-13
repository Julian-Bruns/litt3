#!/usr/bin/env sage
"""Export compact exact atlas tensors in beta=i(eta) coordinates; no solver."""
import json,time
from pathlib import Path
started=time.monotonic()
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
parse=lambda row:vector(k,[sage_eval(c,locals={'a':a}) for c in row])
enc=lambda row:[str(c) for c in row]
mat=lambda rows:matrix(k,[parse(row) for row in rows])
sieve=json.loads(Path('Research/computations/wronskian_linear_sieve.json').read_text())
rt=json.loads(Path('Research/computations/wronskian_universal_image.json').read_text())
grad=json.loads(Path('Research/computations/wronskian_line_gradient.json').read_text())
dual=json.loads(Path('Research/computations/wronskian_serre_dual.json').read_text())
radial=json.loads(Path('Research/computations/wronskian_radial_syzygy.json').read_text())
Qc=mat(grad['Qc_matrix']); S=mat(dual['S_matrix'])
Bj=mat(sieve['iterations'][-1]['image_basis_columns_as_rows']).transpose()
Bc=S.transpose().solve_right(Qc.transpose())
assert S.transpose()*Bc==Qc.transpose()
assert Bc.column_space()==Bj.column_space() and Bc.rank()==32
piv=list(Qc.pivots())
Iproj=(S.matrix_from_columns(piv)*Qc.matrix_from_columns(piv).inverse()).transpose()
assert Iproj*Bc==identity_matrix(k,32)
assert Iproj==mat(radial['projection_matrix']).transpose()
H=Bj.solve_right(Bc)
assert Bj*H==Bc and H.rank()==32
fifth=lambda M:matrix(k,[[c**5 for c in row] for row in M.rows()])
Bc5=fifth(Bc); H5=fifth(H)
Ns=[mat(M) for M in sieve['N_tensor']]
Rs=[mat(M) for M in rt['R_tensor']]
Nc=[M*Bc5 for M in Ns]; Rc=[Iproj*M*Bc5 for M in Rs]
ell=matrix(k,32,64,list(parse(radial['solution'])))
for item in radial['radial_difference_quadratic_coefficients']:
    i,j=item['pair']
    lhs=ell.row(i)*Nc[i] if i==j else ell.row(i)*Nc[j]+ell.row(j)*Nc[i]
    rhs=parse(item['coefficients'])*H5
    assert lhs==rhs
# A solution of all coupled N equations has R output in J. Verify this
# for the full relaxed tensor kernel as an independent linear implication.
NN=block_matrix(k,1,32,Nc)
RR=block_matrix(k,1,32,[M*Bc5 for M in Rs])
K=NN.right_kernel().basis_matrix()
assert (identity_matrix(k,56)-Bc*Iproj)*RR*K.transpose()==0
data={'scope':'Exact compact system export for the fixed noninvariant oper. No solver run and no exclusion claimed. Geometric equivalence uses the recorded author-proof structural theorems.','field':'F5[a]/(a^2+4*a+2)','oper_alpha':rt['oper_alpha'],'c4':rt['c4'],'coordinates':'U=sum_i u_i KU_i; eta=Bc beta; beta=i(eta) in SU*','variables':{'u':32,'beta':32},'equations':['For each r=0..63: sum_i,j N_tensor[i][r][j]*u_i*beta_j^5=0','For each h=0..31: sum_i,j R_tensor[i][h][j]*u_i*beta_j^5-beta_h=0','sum_i u_i*beta_i=2'],'equation_counts':[64,32,1],'tensor_axis_order':'u_direction,output_coordinate,beta_fifth_power_coordinate','eta_exponents':rt['eta_exponents'],'SU_monomials':rt['S_U_monomials'],'SU_basis':rt['S_U_basis'],'N_tensor':[[enc(row) for row in M.rows()] for M in Nc],'R_tensor':[[enc(row) for row in M.rows()] for M in Rc],'Bc':[enc(row) for row in Bc.rows()],'Iproj':[enc(row) for row in Iproj.rows()],'stable_basis_change_H':[enc(row) for row in H.rows()],'radial_syzygy_ell_U_rows':[enc(row) for row in ell.rows()],'Bc_spans_stable_J_verified':True,'Iproj_Bc_identity_verified':True,'transported_radial_syzygy_all_coefficients_verified':True,'coupled_N_kernel_forces_R_output_in_J_verified':True,'elapsed_seconds':time.monotonic()-started}
Path('Research/computations/canonical_atlas_system.json').write_text(json.dumps(data,indent=2,default=int)+'\n')
print('canonical atlas system exported; all identities verified; elapsed',data['elapsed_seconds'],flush=True)
