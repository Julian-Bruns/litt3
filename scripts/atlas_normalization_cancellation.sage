#!/usr/bin/env sage
"""Exact b-linear, normalization-assisted cancellation test; no Groebner solve.

For T=[N;R], test sum lambda_(i,r)b_i T_r(U,b^5)
+ sum h_j b_j^5 (U.b)=0. Distinct b_i*b_j^5 monomials reduce this
to e_i tensor h in rowspan(T) for every i, with a minus sign on lambda.
"""
import hashlib, json, resource, time
from pathlib import Path

t0=time.monotonic()
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
source=Path('Research/computations/canonical_atlas_system.json')
d=json.loads(source.read_text())
cache={}
def parse(c):
    if c not in cache: cache[c]=k(sage_eval(c,locals={'a':a}))
    return cache[c]
T=matrix(k,96,1024,lambda r,c:parse(d['N_tensor' if r<64 else 'R_tensor'][c//32][r if r<64 else r-64][c%32]))
E=T.echelon_form(); piv=list(E.pivots())
assert len(piv)==96
nonpiv=[c for c in range(1024) if c not in piv]
rows=[]; cert=[]; basis=zero_matrix(k,0,32)
for i in range(32):
    for c in nonpiv:
        # w annihilates every T row; <e_i tensor h,w>=constraint.h.
        w=vector(k,1024); w[c]=1
        for r,p in enumerate(piv): w[p]=-E[r,c]
        v=w[32*i:32*i+32]
        if not v: continue
        trial=basis.stack(matrix(k,[v]))
        if trial.rank()>basis.nrows():
            assert T*w==zero_vector(k,96)
            rows.append(v); cert.append((i,c,w)); basis=trial
            if basis.nrows()==32: break
    if basis.nrows()==32: break
assert basis.rank()==32, 'Nontrivial kernel requires complete intersection and lambda certificates.'
det=basis.det(); assert det
alphabet='0123456789abcdefghijklmno'
def enc(v):
    s=''.join(alphabet[int(c.polynomial()[0])+5*int(c.polynomial()[1])] for c in v)
    assert vector(k,[k(alphabet.index(c)%5)+a*(alphabet.index(c)//5) for c in s])==v
    return s
out={
 'scope':'First cached genus-nine oper only; b-linear multipliers plus b^5 times normalization. No nonzero identity in this ansatz; no exclusion of an atlas or of higher consequences.',
 'field':'F5[a]/(a^2+4a+2)',
 'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
 'tensor_shape':[96,1024], 'tensor_rank':96,
 'tensor_column_order':'32*U_index+b5_index; rows N_0..N_63,R_0..R_31',
 'constraint_rank':32, 'h_kernel_dimension':0,
 'full_lambda_h_identity_kernel_dimension':0,
 'degree_at_most_5_consequences_in_this_ansatz':[],
 'certificate_explanation':'Each saved w annihilates all 96 original tensor rows exactly. Thus e_i tensor h in their span forces dot(w[32*i:32*i+32],h)=0. These 32 constraints have nonzero determinant, forcing h=0. Tensor rank96 then forces every lambda_i=0.',
 'constraint_determinant':str(det),
 'encoding':{'alphabet':alphabet,'value':'index%5+a*(index//5)','roundtrip_verified':True},
 'constraints':[{'i':i,'nonpivot_column':c,'w':enc(w),'h_constraint':enc(w[32*i:32*i+32])} for i,c,w in cert],
 'all_saved_annihilators_verified_against_original_tensor':True,
 'original_ideal_consequence_formula':'-sum_(i,j) lambda_(i,64+j)b_i*b_j - 2 sum_j h_j*b_j^5',
 'elapsed_seconds':time.monotonic()-t0,
 'maxrss_bytes':resource.getrusage(resource.RUSAGE_SELF).ru_maxrss}
Path('Research/computations/atlas_normalization_cancellation.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print(json.dumps({q:out[q] for q in ['tensor_rank','constraint_rank','h_kernel_dimension','full_lambda_h_identity_kernel_dimension','constraint_determinant','elapsed_seconds','maxrss_bytes']},default=int),flush=True)
