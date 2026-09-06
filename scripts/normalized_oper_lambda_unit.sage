#!/usr/bin/env sage
"""Certify that the normalized scale Lambda never vanishes.

At Lambda=0, B is one of the55 invariant opers and the homogeneous
linear C-block must kill the monic degree4 polynomial Chat. We verify
that this block is injective on every invariant geometric point.
"""
import json
from pathlib import Path

Inv,GB=load('Research/computations/invariant_oper_groebner.sobj')
k=Inv.base_ring(); a=k.gen()
J=Inv.ideal(GB)
assert J.dimension()==0 and J.vector_space_dimension()==55
saved=json.loads(Path('Research/computations/invariant_oper_solutions.json').read_text())
R=PolynomialRing(k,'b7'); b7=R.gen()
factors=[]; records=[]
for orbit in saved['orbits']:
    h=R(sage_eval(orbit['factor'],locals={'a':a,'b7':b7}))
    assert h.is_irreducible() and h.degree()==orbit['degree']
    assert all(h.gcd(hh)==1 for hh in factors)
    factors.append(h)
    K=R.quotient(h,names='u'); u=K.gen()
    row=next(v for v in saved['solutions']
             if v['orbit_id']==orbit['orbit_id'] and v['frobenius_exponent']==0)
    bv=[K(sage_eval(c,locals={'a':K(a),'u':u})) for c in row['coordinates'][:8]]
    ev=Inv.hom(bv,K)
    assert all(ev(g)==0 for g in GB)
    X=PolynomialRing(K,'x'); x=X.gen(); ak=K(a)
    F=(x**10+(4*ak+2)*x**9+(ak+4)*x**8+(3*ak+1)*x**7+3*ak*x**6
       +4*ak*x**5+(3*ak+4)*x**4+ak*x**3+(3*ak+3)*x**2+(4*ak+2)*x+2*ak+1)
    B=sum(c*x**i for i,c in enumerate(bv))
    N0=2*F.derivative(2)*F+2*F.derivative()**2+2*x**8*F+F*B
    images=[F*(x**j*F).derivative(2)-N0*x**j for j in range(5)]
    degree=max(f.degree() for f in images)
    mat=matrix(K,[[f[i] for f in images] for i in range(degree+1)])
    pivots=list(mat.transpose().pivots())
    assert len(pivots)==5
    determinant=mat.matrix_from_rows(pivots).determinant()
    assert determinant!=0
    records.append({'orbit_id':orbit['orbit_id'],'residue_degree':int(h.degree()),
                    'factor':str(h),'rank':5,'pivot_rows':pivots,
                    'nonzero_minor':str(determinant)})
    print('degree',h.degree(),'C-block rank5',flush=True)
assert sum(h.degree() for h in factors)==55
result={'field':'F5[a]/(a^2+4a+2)',
        'invariant_scheme_length':55,'all_invariant_points_covered':True,
        'certificate':records,
        'conclusion':'Lambda=0 is impossible in the normalized equations before adjoining its inverse: e0 makes B invariant, e1 forces Chat=0, contradicting its monic coefficient. Lambda is already a unit. Removing inv*Lambda-1 preserves the entire scheme, including local multiplicities.'}
Path('Research/computations/normalized_oper_lambda_unit.json').write_text(json.dumps(result,indent=2,default=int)+'\n')
print('PASS: inverse variable is redundant on the whole normalized scheme',flush=True)
