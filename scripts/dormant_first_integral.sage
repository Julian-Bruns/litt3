#!/usr/bin/env sage
"""Exact D^4 first-integral map, not a replacement/global solution search.

The output gives the affine linear map before taking coefficient fifth
roots. Its kernel is exactly the first-integral-zero affine slice.
"""
import json
import sys
import itertools
from pathlib import Path

sys.argv=['fixed_x_dormant_opers.sage','--build-only']
exec(compile(Path('scripts/fixed_x_dormant_opers.sage').read_text(),'fixed','exec'))

def d4_numerator(n,j):
    for shift in range(4):
        n=F*n.derivative()+(2*j-2-shift)*Fp*n
    return n

quotients=[]
for j,n,power in [(0,n0,1),(1,n1,4),(2,n2,2)]:
    q,remainder=d4_numerator(n,j).quo_rem(F**power)
    assert not remainder
    assert all(not coefficient or degree%5==0 for degree,coefficient in enumerate(q.list()))
    quotients.append(q)
# gamma=(G0+G1*y+G2*y^2)/F, with degG0<=8,degG1<=5,degG2<=2.
entries=([quotients[0][5*i] for i in range(9)]+
         [quotients[2][5*i] for i in range(6)]+
         [quotients[1][5*i] for i in range(3)])
assert all(f.total_degree()<=1 for f in entries)
matrix_map=matrix(k,[[f.monomial_coefficient(v) for v in P.gens()] for f in entries])
offset=vector(k,[f.constant_coefficient() for f in entries])
rank=matrix_map.rank()
aug_rank=matrix_map.augment(matrix(k,len(offset),1,list(offset))).rank()
print('FIRST_INTEGRAL_MAP',matrix_map.dimensions(),'rank',rank,
      'augmented_rank',aug_rank,'kernel_dimension',P.ngens()-rank,flush=True)

certificate={
 'convention':'D=d/dx; c=D^4r; gamma^5=c. Rows give coefficients of G0^5,G1^5,G2^5 before inverse Frobenius.',
 'gamma_numerator_bounds':[int(8),int(5),int(2)],
 'coordinate_order':list(P.variable_names()),
 'linear_map':[[str(c) for c in row] for row in matrix_map.rows()],
 'offset':[str(c) for c in offset],
 'rank':int(rank),'augmented_rank':int(aug_rank),
 'zero_slice_affine_dimension':int(P.ngens()-rank) if rank==aug_rank else None,
 'method':'Four exact differentiations and exact F-divisibility; all remaining x exponents multiples of5.'}
if rank+1==len(entries) and aug_rank==len(entries):
    witness=matrix_map.left_kernel().basis()[0]
    witness/=witness.dot_product(offset)
    assert witness*matrix_map==0 and witness.dot_product(offset)==1
    certificate['nonvanishing_witness']=[str(c) for c in witness]
    print('NONVANISHING_WITNESS',[(i,str(c)) for i,c in enumerate(witness) if c],flush=True)
    pivot_columns=list(matrix_map.pivots())
    pivot_rows=list(matrix_map.matrix_from_columns(pivot_columns).transpose().pivots())
    determinant=matrix_map.matrix_from_rows_and_columns(pivot_rows,pivot_columns).determinant()
    assert determinant
    certificate['rank_minor']={'rows':[int(i) for i in pivot_rows],
                              'columns':[int(i) for i in pivot_columns],
                              'determinant':str(determinant)}

# Check the general rational reconstruction on a varied exact family in F5(z).
# This is a test of identities, not an enumeration of fixed-X solutions.
Rf=PolynomialRing(GF(5),'z'); Kf=Rf.fraction_field(); z=Kf.gen()
# Sage10.9 can return D(1/(z^15+4)) as unreduced0/(z^15+4), with bool=True.
# Test numerators, not FractionFieldElement truthiness, throughout this check.
def zero(f): return f.numerator().is_zero()
def same(f,g): return zero(f-g)
counts={'zero':int(0),'singular_cubic':int(0),'smooth_cubic':int(0)}
for abc in itertools.product(GF(5),repeat=3):
    u=z+abc[0]*z**2+abc[1]*z**3+abc[2]*z**4
    u1=u.derivative()
    rtest=2*u.derivative(3)/u1+2*(u.derivative(2)/u1)**2
    assert same(rtest.derivative(2),3*rtest**2)
    ct=rtest.derivative()**2-2*rtest**3
    assert same(ct,rtest.derivative(4)) and zero(ct.derivative())
    if zero(rtest):
        counts['zero']+=int(1)
    elif zero(ct):
        bt=z-3*rtest/rtest.derivative()
        assert zero(bt.derivative()) and same(rtest,2/(z-bt)**2)
        counts['singular_cubic']+=int(1)
    else:
        ht=rtest**5; bt=z-rtest*rtest.derivative()/ct; st=z-bt
        assert zero(bt.derivative())
        qt=ct*st**2+3*ht/ct
        assert same(qt**5,ht**2) and same(rtest,qt**3/ht)
        assert zero(3*ht**5-ct**5*ht**2+ct**10*(z**5-bt**5)**2)
        counts['smooth_cubic']+=int(1)
certificate['rational_reconstruction_identity_tests']=counts
print('RECONSTRUCTION_IDENTITY_TESTS',counts,flush=True)
Path('Research/computations/dormant_first_integral.json').write_text(json.dumps(certificate,indent=2)+'\n')
save((P,entries,matrix_map,offset),'Research/computations/dormant_first_integral.sobj')

# Reuse the verified rational points; do not launch a second point search.
known=json.loads(Path('Research/computations/invariant_oper_solutions.json').read_text())
rational_orbits={row['orbit_id'] for row in known['orbits'] if row['degree']==1}
for point in known['solutions']:
    if point['orbit_id'] not in rational_orbits: continue
    values=[k(sage_eval(c,locals={'a':a})) for c in point['coordinates']]
    vfirst=matrix_map*vector(k,values)+offset
    assert all(f(*values)==0 for f in coefficients)
    print('INVARIANT_F25',str(values[7]),'first_integral_zero',not any(vfirst),flush=True)
