#!/usr/bin/env sage
"""Exact line test of a proposed gradient identity; no global assertion."""
from pathlib import Path
source=Path('scripts/wronskian_matrix_pencil.sage').read_text()
marker="for sample in saved['samples']:"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
line=json.loads(Path('Research/computations/wronskian_projective_line.json').read_text())
projection=json.loads(Path('Research/computations/wronskian_differential_projection.json').read_text())
dual=json.loads(Path('Research/computations/wronskian_serre_dual.json').read_text())
QM=matrix(k,[parse(row) for row in projection['Q_matrix_rows']])
Qc=KU.transpose().solve_right(QM)
assert KU.transpose()*Qc==QM and Qc.rank()==32
S=matrix(k,[parse(row) for row in dual['S_matrix']])
Z=PolynomialRing(k,'z'); zz=Z.gen()
ep=vector(Z,[Z(list(parse(v))) for v in line['primitive_kernel']])
# A in saved line uses s^5=z. Undo just the parameter substitution, keeping
# every field coefficient unchanged; no coefficient Frobenius is applied.
Y=[]
for v in line['A']:
    pv=parse(v)
    assert all(not pv[i] for i in range(len(pv)) if i%5)
    Y.append(Z([pv[i] for i in range(0,len(pv),5)]))
Y=vector(Z,Y)
yc=Y*S.change_ring(Z)
piv=list(Qc.pivots()); inv=Qc.matrix_from_columns(piv).inverse()
af=vector(Z,[yc[i] for i in piv])*inv.change_ring(Z)
assert af*Qc.change_ring(Z)==yc
ucs=[]; uvs=[]; Ts=[]; WFs=[]
monTs=[poly(vector(k,[int(q==h) for q in range(len(monsT))]),monsT) for h in range(len(monsT))]
for sample in saved['samples'][:2]:
    uv=parse(sample['U_coefficients']); uvs.append(uv)
    ucs.append(KU.transpose().solve_right(uv))
    U=laurent(uv,monsU); up=poly(uv,monsU)
    cols=[]
    for e in target:
        aff,rem=split_aff(U*tt**(5*e)); cols.append(-aff)
    Ts.append(matrix(k,cols).transpose())
    WFs.append(vector(k,[sub(mul(up,delta(tp)),mul(tp,delta(up)))[0][0] for tp in monTs]))
wt=(WFs[0]*Ts[0]).change_ring(Z)+zz*(WFs[0]*Ts[1]+WFs[1]*Ts[0]).change_ring(Z)+zz**2*(WFs[1]*Ts[1]).change_ring(Z)
Delta=wt*ep
radial=af*(ucs[0].change_ring(Z)+zz*ucs[1].change_ring(Z))
tangent=af*ucs[1].change_ring(Z)
derivative=Delta.derivative()/k(48)
def ratio(p,q):
    assert q
    g=gcd(p,q)
    num=p//g; den=q//g
    c=den.leading_coefficient(); num/=c; den/=c
    return {'numerator':enc(num.list()),'denominator':enc(den.list()),'constant':bool(num.degree()<=0 and den.degree()<=0),'constant_value':str(num[0]/den[0]) if num.degree()<=0 and den.degree()<=0 else None}
rr=ratio(radial,Delta); tr=ratio(tangent,derivative)
same=radial*derivative==tangent*Delta
print('Delta degree',Delta.degree(),'Y degree',max(p.degree() for p in Y),'radial ratio',rr['constant_value'],'tangent ratio',tr['constant_value'],'same rational ratio',same,flush=True)
data={'scope':'Exact proposed gradient identity on one line only; not a global identity','coefficient_convention':'Undo A(s)=Y(s^5) by dividing parameter exponents5, keeping field coefficients; Qc and residue S used without added Frobenius twists','Delta':enc(Delta.list()),'radial_pairing':enc(radial.list()),'tangent_pairing':enc(tangent.list()),'Delta_derivative_div48':enc(derivative.list()),'radial_over_Delta':rr,'tangent_over_derivative_div48':tr,'ratios_equal_as_rational_functions':bool(same),'functional_coordinates':[enc(p.list()) for p in af],'Qc_matrix':[enc(row) for row in Qc.rows()],'functional_composition_Qc_equals_Y_pairing_S_verified':True,'elapsed_seconds':time.monotonic()-started}
Path('Research/computations/wronskian_line_gradient.json').write_text(json.dumps(data,indent=2,default=int)+'\n')
