#!/usr/bin/env sage
"""Bounded homogeneous degree-one left-syzygy search for A(gamma)."""
import json,time
from pathlib import Path
started=time.monotonic()
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
parse=lambda row:vector(k,[sage_eval(c,locals={'a':a}) for c in row])
enc=lambda row:[str(c) for c in row]
mat=lambda rows:matrix(k,[parse(row) for row in rows])
d=json.loads(Path('Research/computations/canonical_atlas_system.json').read_text())
Ns=[mat(M) for M in d['N_tensor']]; Rs=[mat(M) for M in d['R_tensor']]
AG=[matrix(k,[[Ns[h][r,j] if r<64 else Rs[h][r-64,j] for h in range(32)] for r in range(96)]) for j in range(32)]
def equation(i,j,h):
    row={96*i+r:AG[j][r,h] for r in range(96) if AG[j][r,h]}
    if i!=j:row.update({96*j+r:AG[i][r,h] for r in range(96) if AG[i][r,h]})
    return row
labels=[(i,i+gap,h) for gap in range(32) for i in range(32-gap) for h in range(32)]
equations=[equation(*lab) for lab in labels]
def axpy(d,c,other):
    for h,v in other.items():
        new=d.get(h,k.zero())+c*v
        if new:d[h]=new
        elif h in d:del d[h]
pivots={}; pivot_sources=[]; timedout=False; adaptive=False; residual_certificate=None
def current_kernel():
    free=[h for h in range(3072) if h not in pivots]
    K=zero_matrix(k,3072,len(free))
    for j,h in enumerate(free):K[h,j]=1
    for p in sorted(pivots,reverse=True):
        row=pivots[p]
        K.set_row(p,-sum((v*K.row(h) for h,v in row.items() if h!=p),vector(k,len(free))))
    return K
for q,original in enumerate(equations):
    if time.monotonic()-started>530:
        timedout=True;break
    row=original.copy()
    while row:
        p=min(row)
        if p not in pivots:
            c=1/row[p]; pivots[p]={h:c*v for h,v in row.items()}
            pivot_sources.append(q);break
        axpy(row,-row[p],pivots[p])
    if q%512==511:print('processed',q+1,'rank',len(pivots),flush=True)
    if len(pivots)==3072:break
    if q>=3071 and q%512==511 and 3072-len(pivots)<=96:
        K=current_kernel()
        # Restrict every remaining equation to the small residual unknown space.
        # This avoids repeatedly eliminating thousands of dependent long rows.
        print('switching to exact residual system dimension',K.ncols(),flush=True)
        small=[]
        for erow in equations:
            small.append(sum((c*K.row(h) for h,c in erow.items()),vector(k,K.ncols())))
        SM=matrix(k,small)
        rp=list(SM.transpose().pivots())
        cp=list(SM.pivots())
        minor=SM.matrix_from_rows_and_columns(rp,cp)
        assert minor.det()!=0
        residual_certificate={'rank':len(rp),'equation_labels':[labels[h] for h in rp],'free_parameter_columns':cp,'minor':[enc(row) for row in minor.rows()],'minor_determinant':str(minor.det())}
        SK=SM.right_kernel().basis_matrix().transpose()
        assert SM*SK==0
        K=K*SK
        adaptive=True;break
if not adaptive:K=current_kernel()
out={'scope':'Degree-one homogeneous left syzygies only; no determinant inversion or atlas exclusion','matrix':'A(gamma)=[N_gamma;R_gamma], shape96x32, gamma_j=beta_j^5','unknown_order':'ell coefficient at gamma_i and A-row r has index96*i+r','coefficient_equations':len(equations),'streamed_equations':q+1,'streamed_rank':len(pivots),'pivot_equation_labels':[labels[h] for h in pivot_sources],'adaptive_small_system_used':adaptive,'timed_out':timedout,'syzygy_dimension':K.ncols(),'basis':[]}
if not timedout:
    for j in range(K.ncols()):
        v=K.column(j)
        assert all(sum(c*v[h] for h,c in row.items())==0 for row in equations)
        coeff=matrix(k,32,96,list(v))
        # beta_i^5 beta_h are distinct monomials for every ordered(i,h).
        terms=[{'beta_fifthpower':i,'beta_linear':h,'coefficient':str(coeff[i,64+h])} for i in range(32) for h in range(32) if coeff[i,64+h]]
        out['basis'].append({'ell_coefficients':[enc(row) for row in coeff.rows()],'beta_only_polynomial_terms':terms,'beta_only_polynomial_nonzero':bool(terms)})
    out['all_coefficient_syzygy_checks_verified']=True
    out['full_system_rank']=3072-K.ncols()
    out['nonzero_beta_only_polynomials']=sum(x['beta_only_polynomial_nonzero'] for x in out['basis'])
out['elapsed_seconds']=time.monotonic()-started
out['residual_rank_certificate']=residual_certificate
Path('Research/computations/wronskian_left_linear_syzygies.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('DONE dimension',K.ncols(),'timeout',timedout,'elapsed',out['elapsed_seconds'],flush=True)
