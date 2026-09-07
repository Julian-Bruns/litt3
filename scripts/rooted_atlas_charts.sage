#!/usr/bin/env sage
"""Bounded actual genus-two check of reduced rooted atlas/projective charts."""
import json
from pathlib import Path
root=Path(__file__).resolve().parents[1]
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
P=PolynomialRing(k,'u,v,x,y'); u,v,x,y=P.gens()
N=u*(x**5+(a+2)*y**5)+v*((-2*a+2)*x**5+(-a-1)*y**5)
rx=u*x**5+(2*a+2)*v*x**5-(2*a+1)*u*y**5-(2*a-1)*v*y**5
ry=(a+1)*u*x**5+2*a*v*x**5+2*u*y**5-(2*a-2)*v*y**5
ell=(-a-1)*u*x+(2*a-1)*v*x+(-2*a-1)*u*y-a*v*y
# Independently match these equations to all thirteen actual tensor equations
# after the four already-certified linear restrictions.
d=json.loads((root/'Research/computations/genus_two_intrinsic_tensor.json').read_text())
get=lambda z:k(sage_eval(z,locals={'a':a}))
pp=[-(2*a+1)*v,a*u-v,u,v]
bb=[-(2*a+1)*x+(2*a+2)*y,-(2*a+1)*x+(2*a+1)*y,x,y]
eq=[sum(get(d['I'][h][j])*bb[j] for j in range(4))+
    sum(get(d['tensor_plus_Jinverse_alpha5_p'][i][j][h])*pp[i]*bb[j]**5
        for i in range(4) for j in range(4)) for h in range(12)]
norm=sum(get(d['ell'][i][j])*pp[i]*bb[j] for i in range(4) for j in range(4))
assert norm==ell
base=[N,x-rx,y-ry]
mons=sorted(set(m for f in eq+base for m in f.monomials()))
mat=lambda fs:matrix(k,[[f.monomial_coefficient(m) for m in mons] for f in fs])
assert mat(eq).row_space()==mat(base).row_space()

def tensor_root(f):
    out=P.zero()
    for ex,c in f.dict().items():
        assert ex[2]%5==ex[3]%5==0
        out+=c**5*u**ex[0]*v**ex[1]*x**(ex[2]//5)*y**(ex[3]//5)
    return out
n,sx,sy=map(tensor_root,[N,rx,ry])
assert n**5==N(u**5,v**5,x,y)
assert sx**5==rx(u**5,v**5,x,y)
assert sy**5==ry(u**5,v**5,x,y)
ellroot=P({ex:c**5 for ex,c in ell.dict().items()})
c=ellroot(u,v,sx,sy)
assert c**5==ell(u**5,v**5,sx**5,sy**5)
normalized=P.ideal([n,x-sx**5,y-sy**5,c-1])
assert normalized.dimension()==0
assert normalized.vector_space_dimension()==33
# Verify reducedness by full Jacobian rank via its maximal minors.
def reduced_zero_dim(I):
    pol=list(I.gens()); jac=matrix(I.ring(),[[f.derivative(z) for z in I.ring().gens()] for f in pol])
    return (I+I.ring().ideal(jac.minors(I.ring().ngens()))).is_one()
assert reduced_zero_dim(normalized)

T=PolynomialRing(k,'u,v,x,y,w'); U,V,X,Y,W=T.gens()
emb=P.hom([U,V,X,Y],T)
nn,ssx,ssy,cc=map(emb,[n,sx,sy,c])
# First-nonzero coordinate charts in [x:y]. Earlier zero coordinate is
# imposed through its root sy/sx; the selected coordinate root equals one.
charts=[T.ideal([nn,X-1,ssx-1,Y-ssy**5,W*cc-1]),
        T.ideal([nn,X,ssx,Y-1,ssy-1,W*cc-1])]
lengths=[]
for I in charts:
    if I.is_one(): lengths.append(int(0)); continue
    assert I.dimension()==0 and reduced_zero_dim(I)
    lengths.append(int(I.vector_space_dimension()))
assert sum(lengths)==11
out={'actual_tensor_restriction_verified':True,
     'rooted_normalized_length':int(33),'rooted_normalized_reduced':True,
     'projective_chart_coordinates':'first nonzero among b2=x,b3=y',
     'disjoint_chart_lengths':lengths,'projective_length':int(11),
     'all_nonempty_charts_reduced':True,
     'scope':'Actual genus-two untwisted test only; no genus-nine exclusion or all-torsion claim.'}
(root/'Research/computations/rooted_atlas_charts.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
