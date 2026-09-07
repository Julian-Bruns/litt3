#!/usr/bin/env sage
"""Exact finite matrix checks on saved samples, not an atlas exclusion."""
from pathlib import Path
# Load definitions and fixed-oper setup, stopping before the original sampling
# loop and output mutation. The marker must occur exactly once.
source=Path('scripts/direct_wronskian_test.sage').read_text()
marker="results={'scope':"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
saved=json.loads(Path('Research/computations/direct_wronskian_samples.json').read_text())
parse=lambda v:vector(k,[sage_eval(c,locals={'a':a}) for c in v])
target128=[-g for g in gaps]+list(range(1,128))
assert len(target128)==136 and len(target)==56
pole_to_index={3*i+10*j:h for h,(i,j) in enumerate(monsT)}
def split_aff(s):
    assert s.valuation()>=-197 and s.precision_absolute()>132
    v=vector(k,len(monsT))
    for pole in sorted(reducers,reverse=True):
        c=s[-pole]
        if c:
            s-=c*reducers[pole]
            v[pole_to_index[pole]]+=c
    return v,s
def monseries(v,exps): return sum((c*tt**e for c,e in zip(v,exps)),LS.zero())
def fifthvector(v): return vector(k,[c**5 for c in v])
# Columns of D give -rho32(delta eta), before Frobenius.
D=matrix(k,[-rho(delta_t*(tt**e).derivative(),domain) for e in target]).transpose()
out={'scope':'Exact finite matrix checks on five saved U; no global exclusion','field':str(k.modulus()),'input':'direct_wronskian_samples.json','precision':precision,'N_row_exponents':target128,'R_row_and_column_exponents':target,'D_row_exponents':domain,'N_definition':'rho128(U*eta^5)','R_definition':'rho48(t^-85*rem(U*eta^5)-U*(-rho32(delta eta))^5)','samples':[]}
for sample in saved['samples']:
    uv=parse(sample['U_coefficients']); oldtv=parse(sample['T_coefficients'])
    U=laurent(uv,monsU); up=poly(uv,monsU)
    Ncols=[]; Rcols=[]; Tcols=[]
    for h,e in enumerate(target):
        aff,rem=split_aff(U*tt**(5*e))
        Ncols.append(vector(k,[rem[d] for d in target128]))
        lam5=monseries(fifthvector(D.column(h)),[5*d for d in domain])
        Rcols.append(rho(tt**(-85)*rem-U*lam5,target))
        Tcols.append(-aff)
    N=matrix(k,Ncols).transpose(); RM=matrix(k,Rcols).transpose()
    TM=matrix(k,Tcols).transpose()
    print('seed',sample['seed'],'Nrank',N.rank(),flush=True)
    assert N.rank()==55
    H=laurent(oldtv,monsT)/U
    oldeta=sum((-H[e]**5*tt**(e//5) for e in range(int(H.valuation()),int(H.precision_absolute())) if e%5==0),LS.zero()).add_bigoh(ceil(H.precision_absolute()/5))
    etav=rho(oldeta,target); eta=monseries(etav,target); eta5=fifthvector(etav)
    assert N*eta5==0
    tv=TM*eta5; tp=poly(tv,monsT)
    assert sub(delta(delta(tp)),mul(P,tp))==(R.zero(),)*3
    W=sub(mul(up,delta(tp)),mul(tp,delta(up)))
    assert W==(R.one(),R.zero(),R.zero())
    residual=RM*eta5-etav
    assert residual==parse(sample['residual'])
    # The full one-dimensional N-kernel has constant polynomial Wronskian;
    # its arbitrary Sage-normalized generator need not have Wronskian one.
    kv=N.right_kernel().basis()[0]; ktp=poly(TM*kv,monsT)
    kw=sub(mul(up,delta(ktp)),mul(ktp,delta(up)))
    assert kw[0].degree()<=0 and kw[1]==0 and kw[2]==0
    assert kw[0]!=0
    item={'seed':sample['seed'],'U_pole':sample['U_pole'],'N_rank':N.rank(),'N_nullity':N.ncols()-N.rank(),'N_eta5_zero':True,'reconstructed_T_coefficients':enc(tv),'normalized_eta_coefficients':enc(etav),'reconstructed_T_solves_ODE':True,'reconstructed_T_Wronskian':'1','residual_matches_original':True,'kernel_generator':enc(kv),'kernel_generator_Wronskian':str(kw[0]),'residual':enc(residual)}
    if not out['samples']:
        item['N_matrix']=[enc(row) for row in N.rows()]
        item['R_matrix']=[enc(row) for row in RM.rows()]
        item['D_matrix']=[enc(row) for row in D.rows()]
    out['samples'].append(item)
out['elapsed_seconds']=time.monotonic()-started
Path('Research/computations/wronskian_matrix_pencil.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('All matrix and polynomial checks passed',flush=True)
