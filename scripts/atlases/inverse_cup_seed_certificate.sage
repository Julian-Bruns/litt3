#!/usr/bin/env sage
"""Exact shared coefficient certificate; no Groebner computation or tensor rebuild."""
import json,time,hashlib,resource
from pathlib import Path
t0=time.monotonic()
def log(*s): print(round(time.monotonic()-t0,2),*s,flush=True)
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
cache={}
def parse(c):
    if c not in cache: cache[c]=k(sage_eval(c,locals={'a':a}))
    return cache[c]
def mat(rows): return matrix(k,[[parse(c) for c in row] for row in rows])
paths=['canonical_atlas_system','wronskian_quadratic_bezout','wronskian_serre_dual']
data=[json.loads(Path('Research/computations/'+p+'.json').read_text()) for p in paths]
canon,bez,dual=data
Nc=[mat(M) for M in canon['N_tensor']]; Rc=[mat(M) for M in canon['R_tensor']]
Bc=mat(canon['Bc']); S=mat(dual['S_matrix'])
tensor=[(tuple(item['pair']),mat(item['matrix'])) for item in bez['tensor']]
pairs=[ij for ij,M in tensor]; pos={ij:h for h,ij in enumerate(pairs)}
assert pairs==[(i,j) for i in range(32) for j in range(i,32)]
R=PolynomialRing(k,'x'); x=R.gen()
F=R([2*a+1,4*a+2,3*a+3,a,3*a+4,4*a,3*a,3*a+1,a+4,4*a+2,1])
mons32=[tuple(m) for m in bez['L32_monomials']]
pos64={tuple(m):h for h,m in enumerate(dual['monomials_L64'])}
products=[]
for p,q in mons32:
    for r,s in mons32:
        v=vector(k,56)
        for h,c in enumerate((x**(p+r)*F**((q+s)//3)).list()):
            if c:v[pos64[h,(q+s)%3]]=c
        products.append(v)
P=matrix(k,products)
Gs=[]
for h in range(32):
    v=P*(Bc.column(h)*S)
    Gs.append(matrix(k,24,24,[c**5 for c in v]))
log('loaded cached tensors and constructed Gamma')
N=zero_matrix(k,2048,16896)
for m in range(32):
    for i in range(32):
        start=32*pos[tuple(sorted((m,i)))]
        for r in range(64):
            for j in range(32):
                c=Nc[i][r,j]
                if c:N[64*m+r,start+j]+=c
log('N built',N.nrows(),N.ncols(),type(N).__name__)
E=N.augment(identity_matrix(k,2048))
E.echelonize()
piv=[c for c in E.pivots() if c<16896]; rank=len(piv)
log('N rank',rank,'augmented reduction done')
H=zero_matrix(k,576,16896)
counts=[0]*576
for h,((i,j),B) in enumerate(tensor):
    for l,G in enumerate(Gs):
        T=B*G
        for r,c in enumerate(T.list()):
            H[r,32*h+l]=c
            if c:counts[r]+=1
log('B Gamma built','nonzero terms',sum(counts),'range',min(counts),max(counts))
D=copy(H)
for h,(i,j) in enumerate(pairs):
    for l in range(32):
        c=(Rc[j][i,l]+(Rc[i][j,l] if i!=j else 0))/2
        for b in range(24):D[25*b,32*h+l]-=c
# E's first rank rows are the reduced coefficient rows, with their
# exact original-row multipliers stored in the final2048 columns.
erows=list(range(rank))
coeff=D.matrix_from_columns(piv)
mult=coeff*E.matrix_from_rows_and_columns(erows,list(range(16896,18944)))
log('multipliers formed; checking EVERY coefficient')
assert mult*N==D
log('all coefficient identities PASS')
# Homogeneous rank and affine rank of all576 inverse-cup equations.
hrank=H.rank()
constants=matrix(k,576,1,[-1 if r%25==0 else 0 for r in range(576)])
HA=H.augment(constants)
basis=list(HA.transpose().pivots())
log('seed homogeneous rank',hrank,'affine rank',len(basis))
rows=[]
alphabet='0123456789abcdefghijklmno'
def code(c):
    pp=c.polynomial()
    return alphabet[int(pp[0])+5*int(pp[1])]
multiplier_nonzeros=0
for r in basis:
    vv=mult.row(r)
    multiplier_nonzeros+=sum(bool(c) for c in vv)
    encoded=''.join(code(c) for c in vv)
    decoded=vector(k,[k(alphabet.index(c)%5)+a*(alphabet.index(c)//5) for c in encoded])
    assert decoded==vv
    rows.append({'matrix_entry':[r//24,r%24],'U_times_N_multipliers':encoded})
termcounts=[c+(1 if r%25==0 else 0) for r,c in enumerate(counts)]
ordered=sorted(range(576),key=lambda r:(termcounts[r],r))
out={'scope':'First saved acyclic genus9 oper only. Complete coefficient identity, no solver or exclusion.',
 'field':'F5[a]/(a^2+4a+2)',
 'identity':'(B Gamma)_(a,b) - delta_(a,b)*(U dot R)/2 = sum_(i,r) c_(a,b,i,r)*U_i*N_r',
 'original_generator_seed_identity':'(B Gamma-I)_(a,b)=sum c*U_i*N_r + delta_(a,b)/2*(sum_i U_i*(R_i-beta_i)+(U dot beta-2))',
 'source_sha256':{p:hashlib.sha256(Path('Research/computations/'+p+'.json').read_bytes()).hexdigest() for p in paths},
 'coefficient_matrix_shape':[2048,16896], 'coefficient_matrix_rank':rank,
 'all_576_by_16896_coefficients_verified':True,'seed_homogeneous_rank':hrank,'seed_affine_rank':len(basis),
 'seed_nonzero_terms':sum(counts)+24,'seed_terms_per_equation':termcounts,
 'multiplier_encoding':{'alphabet':alphabet,'character_value':'index%5 + a*(index//5)','row_order':'position64*i+r is multiplier of U_i*N_r','roundtrip_verified':True},
 'smallest_support_subsets':[{'size':n,'nonzero_terms':sum(termcounts[r] for r in ordered[:n]),'entries':[[r//24,r%24] for r in ordered[:n]],'scope':'Certified additional seeds only; not asserted equivalent to full matrix equations.'} for n in [8,24,32,64,128]],
 'basis_entries':[row['matrix_entry'] for row in rows], 'basis_certificates':rows,
 'basis_multiplier_nonzeros':multiplier_nonzeros,
 'elapsed_seconds':time.monotonic()-t0,'maxrss_bytes':resource.getrusage(resource.RUSAGE_SELF).ru_maxrss}
Path('Research/computations/inverse_cup_seed_certificate.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
log('saved certificates',len(rows),'maxrss',out['maxrss_bytes'])
