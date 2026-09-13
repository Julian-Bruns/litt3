#!/usr/bin/env sage
"""Bounded coefficient-space and fixed-pairing symmetry calculation."""
import json,time
from pathlib import Path
started=time.monotonic()
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
parse=lambda row:vector(k,[sage_eval(c,locals={'a':a}) for c in row])
enc=lambda row:[str(c) for c in row]
d=json.loads(Path('Research/computations/wronskian_linear_sieve.json').read_text())
Ns=[matrix(k,[parse(row) for row in M]) for M in d['N_tensor']]
B=matrix(k,[parse(row) for row in d['iterations'][-1]['image_basis_columns_as_rows']]).transpose()
B5=matrix(k,[[c**5 for c in row] for row in B.rows()])
NB=[N*B5 for N in Ns]
forms=[matrix(k,[[NB[i][r,h] for h in range(32)] for i in range(32)]) for r in range(64)]
flat=matrix(k,[M.list() for M in forms])
ind=list(flat.transpose().pivots())
data={'scope':'Coefficient-space and fixed pairing test only; no atlas exclusion','coefficient_space_dimension':flat.rank(),'individual_form_ranks':[M.rank() for M in forms],'individual_form_traces':[str(M.trace()) for M in forms],'independent_form_indices':ind,'pairing_tests':[]}
print('coefficient space dimension',flat.rank(),'individual ranks',sorted(set(data['individual_form_ranks'])),flush=True)
for sign,label in [(1,'symmetric'),(-1,'skew_symmetric')]:
    K=identity_matrix(k,1024)
    dims=[]; timedout=False
    for r in ind:
        if time.monotonic()-started>270:
            timedout=True; break
        M=forms[r]
        pairs=[(i,j) for i in range(32) for j in range(i if sign==-1 else i+1,32)]
        entries={}
        for h,(i,j) in enumerate(pairs):
            for l in range(32):
                p=32*l+j; q=32*l+i
                if M[i,l]: entries[h,p]=entries.get((h,p),k.zero())+M[i,l]
                if M[j,l]: entries[h,q]=entries.get((h,q),k.zero())-sign*M[j,l]
        constraints=matrix(k,len(pairs),1024,entries,sparse=True)
        reduced=constraints*K
        step=reduced.right_kernel().basis_matrix().transpose()
        K=K*step
        dims.append([r,K.ncols()])
        print(label,'after form',r,'solution dimension',K.ncols(),flush=True)
        if not K.ncols(): break
    item={'kind':label,'successive_dimensions':dims,'solution_dimension':K.ncols(),'timed_out':timedout}
    if K.ncols():
        candidates=[]
        for h in range(K.ncols()):
            C=matrix(k,32,32,list(K.column(h)))
            valid=all(M*C==sign*(M*C).transpose() for M in forms)
            candidates.append({'rank':C.rank(),'verified_all64':bool(valid),'matrix':[enc(row) for row in C.rows()]})
        item['basis_candidates']=candidates
    data['pairing_tests'].append(item)
    if timedout: break
data['elapsed_seconds']=time.monotonic()-started
Path('Research/computations/wronskian_incidence_symmetry.json').write_text(json.dumps(data,indent=2,default=int)+'\n')
