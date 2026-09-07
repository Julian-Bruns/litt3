#!/usr/bin/env sage
"""Bounded exact search for W(U)=ell(U)N_U on the stable32 space."""
from pathlib import Path
source=Path('scripts/wronskian_matrix_pencil.sage').read_text()
marker="for sample in saved['samples']:"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
sieve=json.loads(Path('Research/computations/wronskian_linear_sieve.json').read_text())
Ns=[matrix(k,[parse(row) for row in M]) for M in sieve['N_tensor']]
BJ=matrix(k,[parse(row) for row in sieve['iterations'][-1]['image_basis_columns_as_rows']]).transpose()
BJ5=matrix(k,[[c**5 for c in row] for row in BJ.rows()])
NJ=[N*BJ5 for N in Ns]
ups=[poly(v,monsU) for v in KU.rows()]
monTs=[poly(vector(k,[int(q==h) for q in range(len(monsT))]),monsT) for h in range(len(monsT))]
# Extract coefficient of x^0*y^0 in actual polynomial Wronskians.
WF=matrix(k,[[sub(mul(u,delta(v)),mul(v,delta(u)))[0][0] for v in monTs] for u in ups])
eta5s=[monseries(BJ5.column(h),[5*e for e in target]) for h in range(32)]
Ts=[]
for i,uv in enumerate(KU.rows()):
    U=laurent(uv,monsU)
    cols=[]
    for eta5 in eta5s:
        aff,rem=split_aff(U*eta5)
        cols.append(-aff)
    Ts.append(matrix(k,cols).transpose())
    if i%8==7: print('affine T directions',i+1,flush=True)
wquad={}
for i in range(32):
    for j in range(i,32):
        wquad[i,j]=WF.row(i)*Ts[j] if i==j else WF.row(i)*Ts[j]+WF.row(j)*Ts[i]
# Independent deterministic evaluations check polarization and polynomial W.
for seed in range(202609081,202609084):
    rng=random.Random(seed)
    uu=vector(k,[k(rng.randrange(5))+a*rng.randrange(5) for _ in range(32)])
    aa=vector(k,[k(rng.randrange(5))+a*rng.randrange(5) for _ in range(32)])
    u=poly(uu*KU,monsU)
    tv=sum((uu[i]*(Ts[i]*aa) for i in range(32)),vector(k,len(monsT)))
    tp=poly(tv,monsT)
    expected=sub(mul(u,delta(tp)),mul(tp,delta(u)))[0][0]
    actual=sum(uu[i]*uu[j]*(wquad[i,j]*aa) for i,j in wquad)
    assert actual==expected
print('all quadratic W coefficients built and independently checked',flush=True)
# Precompute every equation (at most128 nonzeros). Unknown order ell[i,r].
equations=[]; labels=[]
for gap in range(32):
    for i in range(32-gap):
        j=i+gap
        for h in range(32):
            row={64*i+r:NJ[j][r,h] for r in range(64) if NJ[j][r,h]}
            if i!=j:
                row.update({64*j+r:NJ[i][r,h] for r in range(64) if NJ[i][r,h]})
            equations.append((row,wquad[i,j][h])); labels.append([i,j,h])
def axpy(d,c,other):
    for h,v in other.items():
        new=d.get(h,k.zero())+c*v
        if new: d[h]=new
        elif h in d: del d[h]
pivots={}; witness=None
for q,(original,rhs0) in enumerate(equations):
    if time.monotonic()-started>550: raise RuntimeError('550-second runtime cap')
    row=original.copy(); rhs=rhs0; comb={q:k.one()}
    while row:
        p=min(row)
        if p not in pivots:
            c=1/row[p]
            row={h:c*v for h,v in row.items()}
            comb={h:c*v for h,v in comb.items()}
            pivots[p]=(row,c*rhs,comb)
            break
        prow,prhs,pcomb=pivots[p]
        c=-row[p]
        axpy(row,c,prow); rhs+=c*prhs; axpy(comb,c,pcomb)
    else:
        if rhs:
            witness={h:v/rhs for h,v in comb.items()}
            print('INCONSISTENT after',q+1,'equations, independent rows',len(pivots),'witness support',len(witness),flush=True)
            break
    if q%512==511: print('equations processed',q+1,'rank',len(pivots),flush=True)
data={'scope':'Degree-one polynomial row-syzygy sufficient-certificate search only; failure does not imply an atlas','equation_convention':'coefficient u_i*u_j of ell(U)*N_U^J=W(U), unknown ell[i,r] at64*i+r','equations_total':len(equations),'equations_processed':q+1,'independent_rows_at_stop':len(pivots),'quadratic_W_sample_checks':3,'elapsed_seconds':time.monotonic()-started}
if witness is not None:
    check={}; checkrhs=k.zero()
    for q,c in witness.items():
        erow,erhs=equations[q]
        axpy(check,c,erow); checkrhs+=c*erhs
    assert not check and checkrhs==1
    data['status']='no_degree_one_syzygy_exists'
    data['inconsistency_witness']=[{'equation':labels[q],'multiplier':str(c),'rhs':str(equations[q][1])} for q,c in sorted(witness.items())]
    data['witness_sum_coefficients_zero_rhs_one_verified']=True
else:
    solution=vector(k,2048)
    for p in sorted(pivots,reverse=True):
        row,rhs,comb=pivots[p]
        solution[p]=rhs-sum(v*solution[h] for h,v in row.items() if h!=p)
    assert all(sum(c*solution[h] for h,c in row.items())==rhs for row,rhs in equations)
    data['status']='degree_one_syzygy_exists'
    data['solution']=enc(solution)
data['W_quadratic_coefficients']=[{'pair':[i,j],'coefficients':enc(v)} for (i,j),v in wquad.items()]
Path('Research/computations/wronskian_linear_syzygy.json').write_text(json.dumps(data,indent=2,default=int)+'\n')
