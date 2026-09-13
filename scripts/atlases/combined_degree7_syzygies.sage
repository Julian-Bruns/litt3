#!/usr/bin/env sage
"""Complete degree-seven left syzygies of U_i[N;R], over the saved F25.

No sampling, tensor rebuilding, or Groebner computation.  The last 1024
coordinates of each syzygy are its degree-two original-ideal consequence.
"""
import json, time, hashlib, resource
from pathlib import Path
t0=time.monotonic()
def log(*s): print(round(time.monotonic()-t0,2),*s,flush=True)
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
cache={}
def parse(c):
    if c not in cache: cache[c]=k(sage_eval(c,locals={'a':a}))
    return cache[c]
def mat(rows): return matrix(k,[[parse(c) for c in row] for row in rows])
source=Path('Research/computations/canonical_atlas_system.json')
d=json.loads(source.read_text())
Nc=[mat(M) for M in d['N_tensor']]; Rc=[mat(M) for M in d['R_tensor']]
pairs=[(i,j) for i in range(32) for j in range(i,32)]
pos={p:h for h,p in enumerate(pairs)}
# Rows 64*m+r are U_m*N_r; rows 2048+32*m+r are U_m*R_r.
M=zero_matrix(k,3072,16896)
for m in range(32):
    for i in range(32):
        start=32*pos[tuple(sorted((m,i)))]
        for r in range(64):
            for j in range(32):
                c=Nc[i][r,j]
                if c:M[64*m+r,start+j]+=c
        for r in range(32):
            for j in range(32):
                c=Rc[i][r,j]
                if c:M[2048+32*m+r,start+j]+=c
log('built',M.nrows(),M.ncols())
E=M.augment(identity_matrix(k,3072))
E.echelonize()
rank=sum(c<16896 for c in E.pivots())
K=E.matrix_from_rows_and_columns(list(range(rank,3072)),list(range(16896,19968)))
assert K.rank()==3072-rank
assert K*M==zero_matrix(k,K.nrows(),16896)
Q=K.matrix_from_columns(list(range(2048,3072)))
qr=Q.rank()
normal=vector(k,[1 if i==j else 0 for i in range(32) for j in range(32)])
normal_in_span=Q.stack(matrix(k,[normal])).rank()==qr
log('coefficient rank',rank,'left nullity',K.nrows(),'quadratic rank',qr,'normalization in span',normal_in_span)
alphabet='0123456789abcdefghijklmno'
def encode(v):
    s=''.join(alphabet[int(c.polynomial()[0])+5*int(c.polynomial()[1])] for c in v)
    assert vector(k,[k(alphabet.index(c)%5)+a*(alphabet.index(c)//5) for c in s])==v
    return s
out={'scope':'Exact complete coefficient calculation for first saved genus-nine oper only; no atlas exclusion or Groebner computation.',
 'field':'F5[a]/(a^2+4a+2)', 'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
 'matrix_shape':[3072,16896], 'rank':rank,'left_nullity':K.nrows(),
 'all_kernel_coefficients_verified':True,'kernel_rows_independent_verified':True,
 'quadratic_consequence_rank':qr,'U_dot_beta_in_consequence_span':normal_in_span,
 'identity':'For every saved row (c,d): sum c_(m,r) U_m N_r + sum d_(m,j) U_m R_j = 0; hence sum d_(m,j) U_m beta_j belongs to the original ideal.',
 'encoding':{'alphabet':alphabet,'value':'index%5+a*(index//5)','row_order':'first2048 positions64*m+r for U_m*N_r; last1024 positions32*m+j for U_m*R_j','column_order':'U_i*U_j*beta_l^5 for (i,j) lexicographic with i<=j, then l=0..31','roundtrip_verified':True},
 'left_kernel_basis':[encode(v) for v in K.rows()],
 'quadratic_basis':[encode(v) for v in Q.row_space().basis()],
 'elapsed_seconds':time.monotonic()-t0,'maxrss_bytes':resource.getrusage(resource.RUSAGE_SELF).ru_maxrss}
Path('Research/computations/combined_degree7_syzygies.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
log('saved','maxrss',out['maxrss_bytes'])
