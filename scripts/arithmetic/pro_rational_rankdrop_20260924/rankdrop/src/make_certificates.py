#!/usr/bin/env python3
"""Recreate every certificate and the portable tensor from the exact NPZ arrays.

This producer overwrites certificates and tensor.json.gz. Prefer verify_all.py
for nondestructive verification of an already assembled archive.
"""
import gzip
import json
import subprocess
import sys
from reconstruct import *
from verify_tensor import solve_aux


def main():
    subprocess.run([sys.executable,str(ROOT/'src'/'make_witness.py')],check=True)
    w=json.loads((ROOT/'certificates'/'witness.json').read_text())
    z=np.asarray(w['z'],np.uint8)
    v=linear_comb(z[6:],[LP.mon(i,j) for i,j in vb])
    q=linear_comb(w['auxiliary_coefficients'][123:],[LP.mon(i,j) for i,j in qb])
    H=LP.zero()
    for i,j,c in q.terms():
        assert j==0 and i%5==0
        coefficient=LP.mon(0,0,c)**5
        H=H+LP.mon(i//5,0,coefficient.coeff(0,0))
    assert (H**5).equal(q)
    W=(e**5)*H+v**5
    low=W.minus();high=W.plus()
    assert low.lo==-50 and high.lo==0
    assert all(j==1 for i,j,c in W.terms())
    Dpoly=v*LP.mon(6)
    assert Dpoly.lo==0
    small=dict(format='GF25-univariate-gap-identity-v1',P=P.tolist(),C=list(reversed(C)),D=Dpoly.c[2].tolist(),H=H.c[0].tolist(),K_low=low.c[1].tolist(),J_high=high.c[1].tolist(),identity='P^3*(C^5*H+x^20*D^5)=K_low+x^50*J_high',degree_bounds={'H':8,'K_low':36,'J_high':33},z=w['z'],b=w['b'])
    (ROOT/'certificates'/'polynomial_identity.json').write_text(json.dumps(small,indent=2)+'\n')
    arrays=np.load(ROOT/'data'/'tensor.npz')
    A,L,B,T=[arrays[key] for key in ('A','L','B','T')]
    N=nullspace(T[:,:,23].T)
    line={'format':'exact-linear-fiber-v1','fixed_b_index':23,'fixed_b_description':'f=0, alpha0=1','z_basis':N.tolist(),'auxiliary_basis':[solve_aux(A,B,zz,23).tolist() for zz in N],'transpose_matrix_rank':17,'projective_fiber_dimension':1,'meaning':'All solutions with fixed [b]=[b_23] are [z]=[s*z_basis[0]+t*z_basis[1]], (s,t) != (0,0), over every field extension.'}
    (ROOT/'certificates'/'linear_fiber.json').write_text(json.dumps(line,indent=2)+'\n')
    portable={'format':'gf25-coded-dense-tensor-v1','coefficient_encoding':'c0+5*c1 encodes c0+c1*a with a^2=a+3','indexing':'zero-based; nested arrays in axis order','arrays':{key:{'shape':list(arrays[key].shape),'entries':arrays[key].tolist()} for key in ('A','L','B','T')}}
    with gzip.open(ROOT/'data'/'tensor.json.gz','wt',encoding='utf-8') as f:
        json.dump(portable,f,separators=(',',':'))
    print('Regenerated witness.json, polynomial_identity.json, linear_fiber.json, tensor.json.gz')

if __name__=='__main__':
    main()
