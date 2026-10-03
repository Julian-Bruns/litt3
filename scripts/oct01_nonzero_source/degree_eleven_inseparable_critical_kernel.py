#!/usr/bin/env python3
"""Tiny F''=0 restriction of the retained degree-eleven source kernel."""
import argparse,json,sys,time
from pathlib import Path
from math import comb,ceil
import numpy as np
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,P_CODES,Q_CODES,L0_CODES
from infinity import row_combination
p=argparse.ArgumentParser();p.add_argument('--work',type=Path,required=True);a=p.parse_args();start=time.time();k=Field(a.work/'cache');pp=Poly(k);data=a.work/'data';old=json.loads(Path('/Users/julian/Documents/litt3-computation-data/cubic_full_return_boundary_replies_20260924/admissible_11_collision.json').read_text());finite=old['finite_certificate'];labels=finite['column_labels'];fk=np.array(finite['kernel'],dtype=np.uint32);assert fk.shape==(66,275)
Ns=[]
for vec in fk:
    N=[[[] for r in range(3)] for i in range(7)]
    for c,(i,r,e) in zip(vec,labels):
        if c:
            while len(N[i][r])<=e:N[i][r].append(0)
            N[i][r][e]=int(c)
    Ns.append(N)
L=list(L0_CODES);qdiff=pp.sub(Q_CODES,pp.power(L,5));Lp=[pp.power(L,j) for j in range(7)];t=json.loads((data/'adapted_family.json').read_text())['t'];t=pp.scale(t,k.inv(t[-1]));assert len(t)==4
constant=pp.mul(pp.power(t,3),pp.power(P_CODES,3));Cs=[]
for N in Ns:
    J=[[[] for r in range(3)] for j in range(7)]
    for j in range(7):
        for i in range(7-j):
            factor=comb(6-i,j)*((-1)**(6-i-j))%5
            for r in range(3):J[j][r]=pp.add(J[j][r],pp.scale(pp.mul(Lp[6-i-j],N[i][r]),factor))
    Cs.append([[pp.mul(qdiff,J[j][r]) for r in range(3)] for j in range(5)])
rows=[];tags=[]
for j in range(5):
    mod=pp.power(t,5-j);length=len(mod)-1
    for r in range(3):
        polys=[pp.mod(C[j][r],mod) for C in Cs];extra=pp.mod(constant,mod) if j==0 and r==2 else []
        for e in range(length):rows.append([(f[e] if e<len(f) else 0) for f in polys]+[extra[e] if e<len(extra) else 0]);tags.append(['finite',j,r,e])
for j in range(1,12):
    bound=12+11*j
    for r in range(3):
        polys=[pp.add(N[j][r] if j<=6 else [],pp.mul(Q_CODES,N[j-5][r]) if 0<=j-5<=6 else []) for N in Ns];extra=constant if j==11 and r==2 else []
        for e in range(max(map(len,polys+[extra]))):
            if 3*e+10*r>bound:rows.append([(f[e] if e<len(f) else 0) for f in polys]+[extra[e] if e<len(extra) else 0]);tags.append(['infinity',j,r,e])
matrix=np.array(rows,dtype=np.uint32);kernel,piv,_=k.kernel(matrix);assert len(kernel)==14,'must reproduce retained14-coordinate source kernel'
zero_rows=[];zero_tags=[]
for col,(i,r,e) in enumerate(labels):
    if i in (2,3,4):zero_rows.append(list(fk[:,col])+[0]);zero_tags.append(['Fsecond_derivative',i,r,e])
zeros=np.array(zero_rows,dtype=np.uint32);small=k.matmul(zeros,kernel.T);reduced,rpiv,_=k.kernel(small);lift=k.matmul(reduced,kernel);kappa=lift[:,-1];target=np.zeros(14,dtype=np.uint32);target[:]=kernel[:,-1];witness=row_combination(k,small,target)
report={'scope':'necessary source kernel only; not etale irreducible realization','n':11,'support':'three distinct finite cubic fibers, omittedalpha; t monic','retained_source_kernel_dimension':14,'critical_second_derivative_condition':'N2=N3=N4=0, equivalently H4=H3=H2=0 in any translated frame','extra_rank':len(rpiv),'new_homogeneous_dimension':len(lift),'kappa_can_be_nonzero':bool(np.any(kappa)),'affine_kappa1_dimension':len(lift)-1 if np.any(kappa) else None,'source_matrix':matrix.tolist(),'source_row_tags':tags,'source_kernel':kernel.tolist(),'extra_rows_in14coordinates':small.tolist(),'extra_row_tags':zero_tags,'restricted_kernel':reduced.tolist(),'lifted_kernel':lift.tolist(),'kappa_functional_in14coordinates':target.tolist(),'kappa_exclusion_witness':witness,'seconds':time.time()-start}
(data/'degree_eleven_inseparable_critical_kernel.json').write_text(json.dumps(report,separators=(',',':'))+'\n');print(json.dumps({key:report[key] for key in ('retained_source_kernel_dimension','extra_rank','new_homogeneous_dimension','kappa_can_be_nonzero','affine_kappa1_dimension','seconds')}))
