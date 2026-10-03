#!/usr/bin/env sage
"""NEW fixed mixed-form first Hermitian/Cartier gate; no endpoint replay.

Gauge-zero H0 and V's constant-F freedom are removed explicitly.
Default is one F25 diagnostic; --symbolic uses F5(nu).
"""
import json,sys,signal,time
from pathlib import Path
symbolic='--symbolic' in sys.argv
if symbolic:
    signal.signal(signal.SIGALRM,lambda *_: (_ for _ in ()).throw(TimeoutError('bounded symbolic gate expired')))
    signal.alarm(20)
started=time.process_time()
if symbolic:
    rr=PolynomialRing(GF(5),'nu'); nu=rr.gen(); K=rr.fraction_field(); nu=K(nu)
else:
    zz=PolynomialRing(GF(5),'z'); K=GF(25,'b',modulus=zz.gen()**2-2); nu=1+K.gen()
q=nu**2
S=PolynomialRing(K,'w'); w=S.gen()
phi=w**5+q*w**4+4*w+4*q
aa=nu*w**3+1/nu; bb=w
ffeven=aa**4+aa**2*phi*bb**2+phi**2*bb**4
ffodd=4*aa**3*bb+4*aa*phi*bb**3
de=phi*bb.derivative()+phi.derivative()*bb/2
do=aa.derivative()
ue=3*aa**2*bb+phi*bb**3
uo=aa**3+3*aa*phi*bb**2
he=4*w**9+3*q*w**8+q*w**4+4/q*w**2
ho=3*nu*w**6+w**3/nu+3/nu**3
assert he.derivative()==ue
assert phi*ho.derivative()+phi.derivative()*ho/2==uo
norm=aa**2-phi*bb**2
assert norm==4*w**7+3*w**3+q*w**2+1/q
def twist(f): return sum(f[i]**5*w**i for i in range(f.degree()+1))
pe=twist(phi); qe=twist(ffeven); qo=twist(ffodd)
ut=twist(ue); vt=twist(uo)
columns=[]; labels=[]
for i in range(12):
    columns.append((qe*w**i,qo*w**i)); labels.append('C'+str(i))
oddindices=[0]+list(range(2,9))
for i in oddindices:
    columns.append((pe*qo*w**i,qe*w**i)); labels.append('E'+str(i))
columns.append((twist(de**5),twist(phi**2*do**5))); labels.append('alpha5')
n=len(columns)
rows=[]; rowlabels=[]
for j in range(21,26):
    rows.append([re[j] for re,ro in columns]+[K(0)]); rowlabels.append('evenpole'+str(j))
for j in range(19,23):
    rows.append([ro[j] for re,ro in columns]+[K(0)]); rowlabels.append('oddpole'+str(j))
invw=w.inverse_mod(norm)
yfiber=(-aa*invw)%norm
hf=(he+yfiber*ho)%norm; df=(de+yfiber*do)%norm
rhs=(2*w**5*hf*df**5)%norm
fibers=[]
for i in range(12): fibers.append((w**(5*i+5))%norm)
for i in oddindices: fibers.append((-aa**5*w**(5*i))%norm)
fibers.append(S.zero())
for j in range(7):
    rows.append([f[j] for f in fibers]+[rhs[j]]); rowlabels.append('fiber'+str(j))
for j in [4,9,14,19,24]:
    rows.append([(re*ut+ro*vt)[j] for re,ro in columns]+[K(0)]); rowlabels.append('cartierdw'+str(j))
for j in [4,9,14,19,24,29,34,39]:
    rows.append([((re*vt+pe*ro*ut)*pe**2)[j] for re,ro in columns]+[K(0)]); rowlabels.append('cartiersigma'+str(j))
mat=matrix(K,rows)
co=mat.matrix_from_columns(range(n))
if symbolic:
    assert all(x.denominator()==rr.gen()**x.denominator().degree() for x in mat.list())
    # The rational-function backend ignores transformation=True; append identity instead.
    augmented=mat.augment(identity_matrix(K,mat.nrows())).echelon_form()
    echelon=augmented.matrix_from_columns(range(n+1))
    transform=augmented.matrix_from_columns(range(n+1,augmented.ncols()))
    assert transform*mat==echelon
    coefficient_rank=sum(bool(any(echelon[i,j] for j in range(n))) for i in range(echelon.nrows()))
    augmented_rank=sum(bool(any(echelon.row(i))) for i in range(echelon.nrows()))
else:
    coefficient_rank=co.rank(); augmented_rank=mat.rank()
output={'mode':'symbolic' if symbolic else 'F25', 'unknown_count':int(n),
        'equation_count':int(mat.nrows()),'coefficient_rank':int(coefficient_rank),
        'augmented_rank':int(augmented_rank)}
if not symbolic: output.update({'nu':str(nu),'q':str(q)})
else:
    # One exact rational elimination witness, directly multiplied against all original rows.
    hits=[i for i in range(echelon.nrows()) if not any(echelon[i,j] for j in range(n)) and echelon[i,n]]
    assert hits
    witness=vector(K,transform.row(hits[0]))/echelon[hits[0],n]
    assert witness*mat==vector(K,[0]*n+[1])
    output['witness_largest_numerator_degree']=int(max(x.numerator().degree() for x in witness if x))
    output['witness_largest_denominator_degree']=int(max(x.denominator().degree() for x in witness if x))
    output['witness_nonzero_rows']=[rowlabels[i] for i in range(len(rowlabels)) if witness[i]]
    den=rr.one()
    for x in witness: den=den.lcm(x.denominator())
    cleared=[rr(den*x) for x in witness]
    assert vector(K,cleared)*mat==vector(K,[0]*n+[den])
    output['cleared_witness_rhs_degree']=int(den.degree())
    output['cleared_witness_rhs_factorization']=str(den.factor())
    assert den==rr.gen()**131*(rr.gen()**8-1)**18*(rr.gen()**8+1)**25*(rr.gen()**8+3)
    target=Path(__file__).resolve().parents[3]/'litt3-computation-data'/'oct03_fixed_mixed_cartier'
    target.mkdir(parents=True,exist_ok=True)
    receipt={'unknown_labels':labels,'row_labels':rowlabels,
             'rhs_polynomial':[int(x) for x in den.list()],
             'cleared_witness':[[int(x) for x in z.list()] for z in cleared],
             'metadata':output}
    (target/'first_tier_witness.json').write_text(json.dumps(receipt,sort_keys=True))
output['mathematical_cpu_seconds']=float(round(time.process_time()-started,3))
if symbolic: signal.alarm(0)
print(json.dumps(output,sort_keys=True))
