#!/usr/bin/env sage
"""Construct the24x24 quadratic inverse-cup tensor by acyclic splitting."""
from pathlib import Path
source=Path('scripts/wronskian_matrix_pencil.sage').read_text()
marker="for sample in saved['samples']:"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
ident=json.loads(Path('Research/computations/wronskian_stable_identification.json').read_text())
prior=json.loads(Path('Research/computations/wronskian_matrix_pencil.json').read_text())
dual=json.loads(Path('Research/computations/wronskian_serre_dual.json').read_text())
linegrad=json.loads(Path('Research/computations/wronskian_line_gradient.json').read_text())
mons32=basis(32); mons64=basis(64); mons160=basis(160)
xi_exps=[-g for g in gaps]+list(range(1,16)); assert len(xi_exps)==24
LM=matrix(k,[parse(row) for row in ident['image_rows']]).transpose()
lpiv=list(LM.transpose().pivots()); Linv=LM.matrix_from_rows(lpiv).inverse()
def L(v): return sub(delta(delta(v)),mul(P,v))
ups=[poly(uv,monsU) for uv in KU.rows()]; dups=[delta(v) for v in ups]
hUs=[]; dhUs=[]
for i,uv in enumerate(KU.rows()):
    U=laurent(uv,monsU); hs=[]; dhs=[]
    for e in xi_exps:
        pv,rem=split_aff(U*tt**(5*e)); pp=poly(pv,monsT); lpp=L(pp)
        cv=coeff(lpp,mons64)
        assert poly(cv,mons64)==lpp
        assert all(3*h+10*j<=51 for j,f in enumerate(lpp) for h,c in enumerate(f.list()) if c)
        bv=Linv*vector(k,[cv[h] for h in lpiv])
        assert LM*bv==cv
        bp=poly(bv,mons32)
        hp=sub(bp,pp)
        assert L(hp)==(R.zero(),)*3
        hs.append(hp); dhs.append(delta(hp))
    hUs.append(hs); dhUs.append(dhs)
    if i%8==7: print('acyclic splittings',i+1,flush=True)
def pow5(v): return mul(mul(mul(mul(v,v),v),v),v)
ms=[poly(vector(k,[int(i==h) for i in range(24)]),mons32) for h in range(24)]
PM=matrix(k,[coeff(pow5(v),mons160) for v in ms]).transpose()
ppiv=list(PM.transpose().pivots()); Pinv=PM.matrix_from_rows(ppiv).inverse()
theta=1/delta_t
S16=matrix(k,[[((tt**e)*expansions[m]*theta)[-1] for m in mons32] for e in xi_exps])
assert S16.rank()==24
fifth=lambda M:matrix(k,[[c**5 for c in row] for row in M.rows()])
change=fifth(S16.transpose()).inverse()
tensor=[]
for i in range(32):
    for j in range(i,32):
        cols=[]
        for h in range(24):
            w=sub(mul(ups[i],dhUs[j][h]),mul(hUs[j][h],dups[i]))
            if i!=j:
                w2=sub(mul(ups[j],dhUs[i][h]),mul(hUs[i][h],dups[j]))
                w=tuple(f+g for f,g in zip(w,w2))
            cv=coeff(w,mons160)
            assert poly(cv,mons160)==w
            outv=Pinv*vector(k,[cv[q] for q in ppiv])
            assert PM*outv==cv
            cols.append(outv)
        M=matrix(k,cols).transpose()*change
        assert M==M.transpose()
        tensor.append(((i,j),M))
    if i%8==7: print('quadratic tensor first indices',i+1,flush=True)
S=matrix(k,[parse(row) for row in dual['S_matrix']])
products=[[coeff(mul(u,v),mons64) for v in ms] for u in ms]
checks=[]; sign=None
def evaluate(uc): return sum((uc[i]*uc[j]*M for (i,j),M in tensor),zero_matrix(k,24))
for sample,old in zip(saved['samples'],prior['samples']):
    uc=KU.transpose().solve_right(parse(sample['U_coefficients']))
    eta=parse(old['normalized_eta_coefficients'])
    ff=eta*S
    cup=matrix(k,[[ff*p for p in row] for row in products])
    BB=evaluate(uc); product=BB*fifth(cup)
    if sign is None: sign=product[0,0]
    print('sample',sample['seed'],'inverse-cup scale',product[0,0],flush=True)
    assert sign and product==sign*identity_matrix(k,24)
    checks.append({'seed':sample['seed'],'inverse_cup_scalar':str(sign),'B_rank':BB.rank()})
# Normalize the Cech sign (or any fixed nonzero scalar) once, transparently.
tensor=[(ij,M/sign) for ij,M in tensor]
Z=PolynomialRing(k,'z'); zz=Z.gen()
uc0=KU.transpose().solve_right(parse(saved['samples'][0]['U_coefficients']))
uc1=KU.transpose().solve_right(parse(saved['samples'][1]['U_coefficients']))
B0=evaluate(uc0); B1=evaluate(uc1)
Bc=evaluate(uc0+uc1)-B0-B1
Bline=B0.change_ring(Z)+zz*Bc.change_ring(Z)+zz**2*B1.change_ring(Z)
detline=Bline.det()
Delta=Z(list(parse(linegrad['Delta'])))
ratio=detline.leading_coefficient()/Delta.leading_coefficient()
print('det degree',detline.degree(),'Delta degree',Delta.degree(),'ratio',ratio,'proportional',detline==ratio*Delta,flush=True)
assert detline==ratio*Delta
out={'scope':'Exact quadratic Bezout tensor for this noninvariant oper; no atlas exclusion','field':'F5[a]/(a^2+4*a+2)','SU_basis_convention':'wronskian_universal_image.json:S_U_basis','xi_P16_exponents':xi_exps,'L32_monomials':mons32,'S16':[enc(row) for row in S16.rows()],'quadratic_convention':'B(U)=sum_(i<=j) u_i*u_j tensor[i,j], with cross coefficients already polarized','tensor':[{'pair':list(ij),'matrix':[enc(row) for row in M.rows()]} for ij,M in tensor],'Cech_raw_inverse_cup_scalar':str(sign),'normalization':'All raw tensor coefficients divided by displayed scalar so B*M_eta^[5]=I','all_splitting_ODE_identities_verified':True,'all_12672_Wronskians_verified_as_fifth_powers_L32':True,'all_quadratic_coefficients_symmetric_verified':True,'sample_inverse_cup_checks':checks,'line_determinant':enc(detline.list()),'line_determinant_over_Delta':str(ratio),'line_determinant_proportional_verified':True,'elapsed_seconds':time.monotonic()-started}
Path('Research/computations/wronskian_quadratic_bezout.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
