#!/usr/bin/env python3
"""Compute the fixed nine-dimensional lower numerator multiplication space."""
import argparse,json,sys
from itertools import combinations_with_replacement
from pathlib import Path
import numpy as np
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,Curve,monomials,B0_CODES,L0_CODES

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);a=ap.parse_args()
    k=Field(a.work/'cache');p=Poly(k);C=Curve(k)
    d=json.loads((a.work/'data/annihilator_endpoint_projection.json').read_text())
    ker=np.array(d['kernel'],dtype=np.uint32);labels=d['rlabels'];z=p.sub(B0_CODES,L0_CODES)
    assert len(ker)==9
    def pi(c,n):
        raw=C.mul(C.polyx(p.power(z,n)),c);out=C.zero()
        for r,comp in enumerate(raw):
            q,target=divmod(r-n,3)
            out[target]=p.mul(comp,p.power(C.P,q)) if q>=0 else p.divmod(comp,p.power(C.P,-q))[0]
        return out
    U=[]
    for vector in ker:
        rs=[C.zero() for _ in range(4)]
        for scalar,(j,b,r) in zip(vector,labels):
            if scalar:rs[j]=C.add(rs[j],C.monomial(b,r,int(scalar)))
        c3=rs[3]
        c2=C.add(C.scale(pi(c3,1),2),rs[2])
        c1=C.add(C.neg(C.add(C.scale(pi(c2,1),2),C.scale(pi(c3,2),3))),rs[1])
        c0=C.add(C.neg(C.add(C.add(pi(c1,1),pi(c2,2)),pi(c3,3))),rs[0])
        U.append([c0,c1,c2,c3])
    def flatten(functions):
        tags=[]
        for degree in range(len(functions[0])):
            for char in range(3):
                maximum=max(len(f[degree][char]) for f in functions)
                tags.extend((degree,char,i) for i in range(maximum))
        matrix=np.array([[f[degree][char][i] if i<len(f[degree][char]) else 0 for f in functions] for degree,char,i in tags],dtype=np.uint32)
        return matrix,tags
    pairs=list(combinations_with_replacement(range(9),2));products=[]
    for i,j in pairs:
        out=[C.zero() for _ in range(7)]
        for aa in range(4):
            for bb in range(4):out[aa+bb]=C.add(out[aa+bb],C.mul(U[i][aa],U[j][bb]))
        products.append([C.scale(c,1 if i==j else 2) for c in out])
    pm,ptags=flatten(products);pk,piv,_=k.kernel(pm)
    assert len(pk)==1 and len(piv)==44 and not np.any(k.matmul(pm,pk.T))
    zz=np.zeros((9,9),dtype=np.uint32)
    for scalar,(i,j) in zip(pk[0],pairs):zz[i,j]=int(scalar);zz[j,i]=int(scalar)
    assert len(k.rref(zz)[1])==4
    x=C.monomial(1,0)
    mult=[ [C.mul(x,c) for c in f] for f in U]
    allm,utags=flatten(mult+[[C.neg(c) for c in f] for f in U])
    stable,_,_=k.kernel(allm)
    assert not np.any(k.matmul(allm,stable.T))
    assert len(stable)==2
    # x*g=h_g and x*h=h_h give the split rank-four identity g*h_h-h*h_g.
    aa,bb=stable[0][:9],stable[0][9:]
    cc,dd=stable[1][:9],stable[1][9:]
    split=k.addv(k.addv(k.mulv(aa[:,None],dd[None,:]),k.mulv(dd[:,None],aa[None,:])),
                 k.mulv(k.addv(k.mulv(cc[:,None],bb[None,:]),k.mulv(bb[:,None],cc[None,:])),4))
    # Tensor symmetrization is twice the symmetric quadratic coefficient form.
    assert len(k.rref(split)[1])==4
    pos=int(np.flatnonzero(zz)[0]);scale=k.div(int(split.flat[pos]),int(zz.flat[pos]))
    assert np.array_equal(split,k.mulv(zz,scale))
    def combine(vector):
        out=[C.zero() for _ in range(4)]
        for scalar,f in zip(vector,U):
            if scalar:
                for j in range(4):out[j]=C.add(out[j],C.scale(f[j],int(scalar)))
        return out
    generators=[combine(v) for v in (aa,bb,cc,dd)]
    assert generators[1]==[C.mul(x,c) for c in generators[0]]
    assert generators[3]==[C.mul(x,c) for c in generators[2]]
    result={
        'scope':'exact fixed lower numerator space, no actual-source existence decision',
        'dimension':9,'symmetric_square_dimension':45,'multiplication_rank':44,
        'multiplication_kernel_dimension':1,'kernel_symmetric_rank':4,
        'x_stable_subspace_dimension':2,'numerator_coefficients':U,
        'quadratic_pairs':pairs,'quadratic_kernel':pk[0].tolist(),
        'quadratic_symmetric_matrix':zz.tolist(),'x_stable_vectors':stable.tolist(),
        'split_generators_g_xg_h_xh':generators,
        'multiplication_rows':ptags,'multiplication_matrix':pm.tolist(),
    }
    (a.work/'data/lower_numerator_product_space.json').write_text(json.dumps(result,separators=(',',':'))+'\n')
    print(json.dumps({key:result[key] for key in ('scope','dimension','symmetric_square_dimension','multiplication_rank','multiplication_kernel_dimension','kernel_symmetric_rank','x_stable_subspace_dimension')},indent=2))
    print(json.dumps({'g_h_finite_coefficient_poles':[[C.pole(c) for c in generators[i]] for i in (0,2)]}))

if __name__=='__main__':main()
