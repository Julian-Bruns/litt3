"""Exact fixed-target global-morphism computation at an F25 source.
This is NOT an exhaustive geometric fixed-point solver.
"""
from pathlib import Path
import itertools,json
import numpy as np
from exact import *
ROOT=Path(__file__).resolve().parents[1]
D=np.load(ROOT/'data'/'tensors.npz')

def combine_tensor(cs,t):
    out=np.zeros(t.shape[1:],dtype=np.uint8)
    for c,a in zip(cs,t):
        if c:out=ADD[out,MUL[c,a]]
    return out

def recover_phi(z,w):
    f=linear_combination(w[:23],[LP.term(i,j) for i,j in basis(31)])
    alpha=linear_combination(w[23:],[LP.term(i,j) for i,j in basis(20)])
    rec=matmul(combine_tensor(z,D['REC']),w[:,None])[:,0]
    g0=linear_combination(rec[:123],[LP.term(i,j) for i,j in basis(131)])
    q0=linear_combination(rec[123:],[LP.term(i,j) for i,j in basis(120)])
    u,v=uv(z);phi,res=lower(u**25,v**25,f,alpha,g0,q0)
    assert not res.any()
    return phi

def determinant_poly(hs):
    """det(sum c_i H_i(P_*)) as a sparse homogeneous cubic."""
    ev=np.array([[[p.eval(5,14) for p in row] for row in h] for h in hs],dtype=np.uint8)
    out={}
    for perm in itertools.permutations(range(3)):
        sign=4 if sum(perm[i]>perm[j] for i in range(3) for j in range(i+1,3))%2 else 1
        for ii in itertools.product(range(len(hs)),repeat=3):
            c=sign
            for row in range(3):c=int(MUL[c,ev[ii[row],row,perm[row]]])
            key=tuple(sorted(ii));out[key]=int(ADD[out.get(key,0),c])
    return {k:v for k,v in out.items() if v}

def test_fixed(xi,details=False):
    if len(xi)!=19 or not any(xi) or any(not 0<=int(c)<25 for c in xi):
        raise ValueError('a nonzero F25 19-vector is required')
    xi=np.array(xi,dtype=np.uint8)
    # Here the source is restricted to F25, so z=xi. This restriction is explicit.
    z=xi.copy();u,v=uv(xi);U=u**25;V=v**25
    tz=combine_tensor(z,D['T']);qz=combine_tensor(z,D['Q'])
    kw=kernel(tz);result={'xi':xi.tolist(),'rank_T':35-kw.shape[1],'rank_Q':len(rref(qz)[1]),'field':'F25'}
    if not kw.shape[1] and result['rank_Q']==16:
        result.update(hom_dimension=0,invertible_morphism=False);return result
    phis=[recover_phi(z,kw[:,j]) for j in range(kw.shape[1])]
    sb=[LP.term(i,j) for i,j in basis(24)];tb=[LP.term(i,j) for i,j in basis(124)]
    raw=np.column_stack([top_res(U,V,xi,phi)[1] for phi in phis]+[top_res(U,V,xi,(ZERO,)*6,s)[1] for s in sb])
    cm=matmul(D['CQc'],raw);kh=kernel(cm)
    hs=[]
    for j in range(kh.shape[1]):
        phi=tuple(linear_combination(kh[:len(phis),j],[p[i] for p in phis]) for i in range(6))
        s=linear_combination(kh[len(phis):,j],sb)
        tp,res=top_res(U,V,xi,phi,s)
        tcs=NEG[matmul(D['RQ'],res[:,None])[:,0]]
        t0=linear_combination(tcs,tb)
        top,res=top_res(U,V,xi,phi,s,t0)
        assert not res.any()
        a,q,r,f,g,h=phi
        hs.append((top,(a,q,r),(f,g,h)))
    dp=determinant_poly(hs)
    result.update(hom_dimension=len(hs),invertible_morphism=bool(dp),determinant_terms=[{'monomial':list(k),'coefficient':v} for k,v in sorted(dp.items())])
    if details:
        result['H_basis']=[[[p.terms() for p in row] for row in h] for h in hs]
        result['fixed_compressed_matrix']=cm.tolist()
        result['fixed_kernel']=kh.tolist()
    return result
if __name__=='__main__':
    xi=[0]*13+[24,2,10,11,1,0]
    r=test_fixed(xi,True)
    (ROOT/'certificates'/'regression_point.json').write_text(json.dumps(r,indent=2)+'\n')
    print({k:v for k,v in r.items() if k not in ['H_basis','fixed_compressed_matrix','fixed_kernel']})
