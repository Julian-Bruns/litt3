#!/usr/bin/env sage
"""One exact tangent witness for the saved extension map, not a solver."""
import json, hashlib, time
from pathlib import Path
t0=time.monotonic()
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
cache={}
def parse(s):
    if s not in cache: cache[s]=k(sage_eval(s,locals={'a':a}))
    return cache[s]
def mat(M):return matrix(k,[[parse(c) for c in row] for row in M])
paths=[Path('Research/computations/'+s+'.json') for s in ['wronskian_linear_sieve','wronskian_universal_image','canonical_atlas_system']]
d,dr,dc=[json.loads(p.read_text()) for p in paths]
Ns=[mat(M) for M in d['N_tensor']]; Rs=[mat(M) for M in dr['R_tensor']]
Bc=mat(dc['Bc']); Iproj=mat(dc['Iproj'])
Bc5=Bc.apply_map(lambda c:c**5)
Aout=Bc5.left_kernel().basis_matrix()
assert Aout.nrows()==24 and Aout*Bc5==0
set_random_seed(20260907)
out={'field':'F5[a]/(a^2+4a+2)', 'scope':'Exact pointwise derivatives, not a global exclusion or a proof from generic samples.',
 'source_sha256':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
 'normal_space':'annihilator of coefficient-Frobenius Bc^[5], not Bc', 'samples':[]}
for sample in range(1):
    U=vector(k,[k.random_element() for _ in range(32)])
    N=sum((U[i]*Ns[i] for i in range(32)),zero_matrix(k,64,56))
    R=sum((U[i]*Rs[i] for i in range(32)),zero_matrix(k,56))
    assert N.rank()==55
    c=N.right_kernel().basis()[0]
    wrow=(U*Iproj*R)*k(3)
    w=wrow*c
    assert w
    c=c/w
    Aug=N.stack(matrix(k,[wrow]))
    rhsN=matrix(k,[-Ns[i]*c for i in range(32)]).transpose()
    rhsW=vector(k,[-k(3)*((Iproj*R).row(i)*c+U*Iproj*Rs[i]*c) for i in range(32)])
    RHS=rhsN.stack(matrix(k,[rhsW]))
    DC=Aug.solve_right(RHS)
    assert Aug*DC==RHS and DC*U==-2*c and wrow*c==1 and N*c==0
    psi=Aout*c; Dpsi=Aout*DC
    record={'U':[str(x) for x in U],'normalized_extension':[str(x) for x in c],
      'N_rank':N.rank(),'augmented_rank':Aug.rank(),'extension_derivative_rank':DC.rank(),
      'extension_projective_differential_rank':matrix(k,c).transpose().augment(DC).rank()-1,
      'projection_value_nonzero':bool(psi),'projection_derivative_rank':Dpsi.rank(),
      'projection_projective_differential_rank':matrix(k,psi).transpose().augment(Dpsi).rank()-1,
      'exact_linearized_identities_verified':True,'Euler_derivative_verified':True}
    piv=list(Dpsi.pivots())
    minor=Dpsi.matrix_from_columns(piv)
    assert len(piv)==24 and minor.det()!=0
    record['projection_rank24_minor_columns']=piv
    record['projection_rank24_minor_determinant']=str(minor.det())
    out['samples'].append(record)
    print('sample',sample,'full differential',record['extension_projective_differential_rank'],'projected',record['projection_projective_differential_rank'],flush=True)
out['elapsed_seconds']=time.monotonic()-t0
Path('Research/computations/extension_projection_differential.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print('elapsed',out['elapsed_seconds'],flush=True)
