#!/usr/bin/env sage
"""Exact five-oper test on C: v^2=t^6+3 in characteristic five.

This computes the complete regular projective-connection chart, and
identifies the oper pulled back from the actual Hermitian quotient.
No genus-nine semigroup, numerical inference, or large solver is used.
See Research/GENUS_TWO_HERMITIAN_OPERS.md for the regularity argument.
"""
import json
from itertools import permutations
from pathlib import Path

k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'z')([2,4,1]))
P = PolynomialRing(k, names=['b0','b1','b2'], order='lex')
b0,b1,b2 = P.gens()
R = PolynomialRing(P, 't')
t = R.gen()
F = t**6+3
n = 4*t**4+(b0+b1*t+b2*t**2)*F
E = (F**2*n.derivative(2)-4*F*F.derivative()*n.derivative()
     +(6*F.derivative()**2-2*F*F.derivative(2))*n-3*n**2)
I = P.ideal(E.list())
G = list(I.groebner_basis())
expected = [b0+b2**2,b1**2-2*b2**3-1,b1*b2,b2**4-2*b2]
assert G == expected
points = I.variety()
assert I.vector_space_dimension() == len(points) == 5
assert all(all(eq.subs(pt)==0 for eq in E.list()) for pt in points)
assert all(matrix(k, [[eq.derivative(b).subs(pt) for b in P.gens()]
                     for eq in E.list()]).rank()==3 for pt in points)

# Actual quotient function field. Derivation is d/dx on H, and d^2y=0.
K = FunctionField(k, 'x')
x = K.gen()
KY = PolynomialRing(K, 'Y')
Y = KY.gen()
H = K.extension(Y**6+x**6+1, names='y')
y = H.gen()
x = H(x)
yp = -x**5/y**5
def D(f):
    return sum(H(c.derivative())*y**i+H(c)*i*y**(i-1)*yp
               for i,c in enumerate(H(f).list()) if c)
assert D(y)==yp and D(yp)==0
tt = (x**3+y**3+1)/(x*y)
vv = (x**3-y**3)*(y**3-1)*(1-x**3)/(x*y)**3
assert vv**2 == tt**6+3
dt = D(tt)
ddt = D(dt)
dddt = D(ddt)
schwarzian = dddt/dt-k(3)/k(2)*(ddt/dt)**2
pulled_potential = schwarzian/(2*dt**2)
matched = []
for pt in points:
    candidate = (4*tt**4/(tt**6+3)**2
                 +(pt[b0]+pt[b1]*tt+pt[b2]*tt**2)/(tt**6+3))
    if candidate == pulled_potential:
        matched.append(pt)
assert len(matched)==1

# All branch-preserving Mobius transformations, with exact potential pullback.
Kt = FunctionField(k, 's')
st = Kt.gen()
branch = [q for q in k if q**6 == 2]
assert len(branch) == 6
def triple_matrix(xs):
    u,v,w = xs
    return matrix(k, [[v-w,-u*(v-w)],[v-u,-w*(v-u)]])
base = triple_matrix(branch[:3])
rstar = 4*st**4/(st**6+3)**2
mobius_orbit = {}
mobius_count = 0
for triple in permutations(branch,int(3)):
    mat = triple_matrix(triple).inverse()*base
    aa,bb,cc,dd = mat.list()
    if any(cc*q+dd==0 for q in branch):
        continue
    if {(aa*q+bb)/(cc*q+dd) for q in branch} != set(branch):
        continue
    mobius_count += 1
    phi = (aa*st+bb)/(cc*st+dd)
    cover_multiplier = (phi**6+3)*(cc*st+dd)**6/(st**6+3)
    assert cover_multiplier in k and cover_multiplier != 0
    pulled = phi.derivative()**2*(4*phi**4/(phi**6+3)**2+phi/(phi**6+3))
    coeff_poly = (pulled-rstar)*(st**6+3)
    assert coeff_poly.denominator().degree() == 0
    pol = coeff_poly.numerator()/coeff_poly.denominator()[0]
    assert pol.degree() <= 2
    tup = tuple(pol[i] for i in range(3))
    assert tup in [tuple(pt[b] for b in P.gens()) for pt in points]
    mobius_orbit[tup] = mobius_orbit.get(tup,0)+1
assert mobius_count == 120
assert sorted(mobius_orbit.values()) == [24]*5
result = {
    'field': 'F5[a]/(a^2+4a+2)',
    'curve': 'v^2=t^6+3',
    'potential': '4*t^4/(t^6+3)^2+(b0+b1*t+b2*t^2)/(t^6+3)',
    'groebner_basis': [str(g) for g in G],
    'length': int(5),
    'points': [[str(pt[b]) for b in P.gens()] for pt in points],
    'all_original_curvatures_zero': True,
    'all_jacobian_ranks': int(3),
    'quotient_equation_verified_in_H': True,
    'atlas_oper': [str(matched[0][b]) for b in P.gens()],
    'atlas_identification': 'Exact Schwarzian identity in k(H); D=d/dx, D^2y=0.',
    'branch_mobius_group_order': int(mobius_count),
    'actual_atlas_oper_orbit': [{'point':[str(x) for x in q], 'multiplicity':int(v)}
                                for q,v in mobius_orbit.items()],
    'all_five_opers_realized_by_actual_atlases': True,
    'limitations': 'One actual genus-two atlas example; no common-cover exclusion or intrinsic incidence tensor computed.'
}
Path('Research/computations/genus_two_hermitian_opers.json').write_text(
    json.dumps(result, indent=2)+'\n')
print(json.dumps(result, indent=2))
