"""Exact finite certificate for genus_two_maximal_four_cover (SageMath).

Run: sage scripts/genus_two/verify_genus_two_four_torsion.sage
No external data, search, sampling, or atlas computation is used.
The proof supplies the separate parameter-height bound needed to transfer
this one specialization to the selected high-degree parameter.
"""
import itertools
import json
import time
import argparse
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--parameter-polynomial', default=None,
                    help='F5 coefficients constant first; choose a root in the fixed F5^6 field')
parser.add_argument('--output', help='Write the executed certificate summary as JSON')
args = parser.parse_args()

started = time.monotonic()
base = PolynomialRing(GF(5), 'z')
z = base.gen()
k = GF(5**6, name='a', modulus=z**6+z**4+4*z**3+z**2+2)
a = k.gen()
assert a.multiplicative_order() == 5**6-1
t = a**126
if args.parameter_polynomial is not None:
    parameter_equation = PolynomialRing(k, 't0')(
        [int(c) for c in args.parameter_polynomial.split(',')])
    roots = parameter_equation.roots(multiplicities=False)
    assert roots, 'Parameter has no root in the fixed six-dimensional field'
    t = roots[0]
assert t.minpoly().degree() == 3
R = PolynomialRing(k, 'u')
u = R.gen()
alpha = [k(0), k(1), k(2), k(3), t**5]
F = prod(u-c for c in [0, 1, 2, 3, t])
F1 = prod(u-c for c in alpha)
zero = (R.one(), R.zero())


def cantor(A, B):
    """General addition, used independently for doubling/order checks."""
    if A == zero:
        return B
    if B == zero:
        return A
    u1, v1 = A
    u2, v2 = B
    g, e1, e2 = u1.xgcd(u2)
    d, c1, c2 = g.xgcd(v1+v2)
    un, rem = (u1*u2).quo_rem(d*d)
    assert not rem
    un = un.monic()
    vn, rem = (c1*e1*u1*v2+c1*e2*u2*v1+c2*(v1*v2+F1)).quo_rem(d)
    assert not rem
    vn %= un
    while un.degree() > 2:
        un, rem = (F1-vn*vn).quo_rem(un)
        assert not rem
        un = un.monic()
        vn = (-vn) % un
    assert (vn*vn-F1) % un == 0
    return un, vn


addition_checks = 0


def coprime_add(A, B):
    """Fixed Sylvester/Cramer formula used by the generic height proof."""
    global addition_checks
    if A == zero:
        return B
    if B == zero:
        return A
    u1, v1 = A
    u2, v2 = B
    n, m = int(u1.degree()), int(u2.degree())
    columns = [u**j*u1 for j in range(m)] + [u**j*u2 for j in range(n)]
    mat = matrix(k, [[p[j] for p in columns] for j in range(n+m)])
    det = mat.det()
    assert det != 0 and n+m <= 4
    rhs = vector(k, [1]+[0]*(n+m-1))
    coefficients = []
    for j in range(n+m):
        replaced = matrix(k, mat)
        replaced.set_column(j, rhs)
        coefficients.append(replaced.det()/det)
    aa, bb = R(coefficients[:m]), R(coefficients[m:])
    assert aa*u1+bb*u2 == 1
    un = u1*u2
    vn = (aa*u1*v2+bb*u2*v1) % un
    if un.degree() > 2:
        un, rem = (F1-vn*vn).quo_rem(un)
        assert not rem and un.degree() == 2
        assert un.leading_coefficient() != 0
        un = un.monic()
        vn = (-vn) % un
    assert (vn*vn-F1) % un == 0
    result = un, vn
    assert result == cantor(A, B)
    addition_checks += 1
    return result


halves = []
for aa in alpha[:4]:
    roots = [(aa-b).sqrt() for b in alpha]
    ss = [k(1)] + [sum(prod(c) for c in itertools.combinations(roots, j))
                   for j in range(1, 6)]
    U = (aa-u)**2+ss[2]*(aa-u)+ss[4]
    V = (ss[3]-ss[1]*ss[2])*(aa-u)-ss[1]*ss[4]
    assert F1-(ss[1]*U+V)**2 == (u-aa)*U**2
    assert (V*V-F1) % U == 0
    H = U, V
    assert cantor(H, H) == (u-aa, R.zero())
    halves.append(H)

twos = {}
for bits in itertools.product(range(2), repeat=4):
    indices = {i for i, bit in enumerate(bits) if bit}
    if len(indices) > 2:
        indices = set(range(5))-indices
    twos[bits] = (R(prod(u-alpha[i] for i in indices)), R.zero())

binary = {0: zero}
for mask in range(1, 16):
    i = int(mask).bit_length()-1
    binary[mask] = coprime_add(binary[mask-(1 << i)], halves[i])

points = {}
for mask, half in binary.items():
    for bits, two in twos.items():
        code = tuple(((mask >> i) & 1)+2*bits[i] for i in range(4))
        point = coprime_add(half, two)
        assert point not in points
        points[point] = code
assert len(points) == 256

F2 = F*F
top = matrix(k, [[F2[5*i+4-j] if 0 <= 5*i+4-j <= 10 else 0
                 for j in range(7)] for i in range(3)])
aa_basis = top.right_kernel().basis_matrix()
assert aa_basis.nrows() == 4
cs = [R(row.list())*F2 for row in aa_basis]
# Q_t is on J(Y_t^(1)): its coefficients use t, but F1 uses t^5.
co = [t**8*(t+1)*(t**5-2*t**4+t**2-2*t-1),
      -2*t**7*(t+1)*(t**4-t**3-t**2-t+1),
      t**2*(-2*t**10+t**9+2*t**7-2*t**6-2*t**4+2*t**3+t-2),
      t**4*(t+1)*(t**4-2*t**3+t**2-1), t**6*(t**2+t+1),
      t**2*(t+1)*(-2*t**4+2*t**3+2*t**2+2*t-2),
      -t**3*(t+1)*(2*t**2+t+2),
      (t+1)*(-t**5-2*t**4+t**3-2*t+1),
      (t+1)*(-t**4+t**2-2*t+1), (t+1)**4]
tested = 0
for (U, V), code in points.items():
    twice = cantor((U, V), (U, V))
    assert cantor(twice, twice) == zero
    if all(c % 2 == 0 for c in code):
        assert twice == zero
        continue
    assert twice != zero
    tested += 1
    assert U.degree() == 2 and U.gcd(F1) == 1
    S, P, q0, q1 = -U[1], U[0], V[0], V[1]
    w = q1*q1-F1[2]-F1[3]*S-F1[4]*S*S-S*(S*S-P)
    coords = [k(1), S, P, w]
    qvalue = sum(c*coords[i]*coords[j] for c, (i, j) in
                 zip(co, itertools.combinations_with_replacement(range(4), 2)))
    cartier = matrix(k, [[
        q1*(c[r]-P*c[r+10]-S*P*c[r+15])
        -q0*(c[r+5]+S*c[r+10]+(S*S-P)*c[r+15])
        for c in cs] for r in range(4)])
    # Both the compressed quadric and the original matrix MUST pass.
    assert qvalue != 0 and cartier.det() != 0
assert tested == 240
result = {
    'status': 'PASS', 'field_modulus': str(k.modulus()),
    'parameter': str(t), 'parameter_degree_over_F25': 3,
    'parameter_minpoly_over_F5': [int(c) for c in t.minpoly()],
    'distinct_J4_classes': 256, 'exact_order_four_tests': tested,
    'coprime_Cramer_additions_replayed': addition_checks,
    'nonzero_quadric_and_original_determinants': tested,
    'seconds': float(time.monotonic()-started),
    'scope': 'Complete J[4] check at the stated parameter; a family claim additionally uses the proof height bound.'
}
if args.output:
    Path(args.output).write_text(json.dumps(result, indent=2, default=int)+'\n')
print(json.dumps(result, indent=2, default=int))
