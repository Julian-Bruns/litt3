"""Recompute the two cubic Kummer examples and their geometric Jacobian tests.

Run with sage -python. --genus selects one example; the default checks both.
"""
import argparse
import json
from sage.all import GF, PolynomialRing, QQ, ZZ, euler_phi

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--genus', type=int, choices=[3, 4])
args = parser.parse_args()
genera = [args.genus] if args.genus else [3, 4]
R0 = PolynomialRing(GF(5), 'b')
b = R0.gen()
k = GF(25, 'a', modulus=b*b+2)
a = k.gen()
R = PolynomialRing(k, 't')
t = R.gen()
models = {
    3: (t, (t-1)*(t-a)*(t-a-2)),
    4: (t**3+4*a*t**2+t+2*a+4,
        t**3+(4*a+3)*t**2+(a+4)*t+4*a+1),
}
expected_counts = {
    3: [[26, 17], [590, 509], [15431, 15566]],
    4: [[33, 33], [615, 657], [16095, 15726], [392427, 391017]],
}
expected_polynomials = {
    3: [[15625, 0, -450, -65, -18, 0, 1],
        [15625, -5625, -450, 385, -18, -9, 1]],
    4: [[390625, 109375, 11875, 4375, 1525, 175, 19, 7, 1],
        [390625, 109375, 25000, 4975, 931, 199, 40, 7, 1]],
}
moduli = {2: b**4+4*b**2+4*b+2,
          3: b**6+b**4+4*b**3+b**2+2,
          4: b**8+b**4+3*b**2+4*b+2}
counts = {g: [] for g in genera}


def evaluate(coefficients, value):
    result = value.parent().zero()
    for coefficient in reversed(coefficients):
        result = result*value+coefficient
    return result


for g in genera:
    A, B = models[g]
    assert A.is_monic() and B.is_monic() and (A*B).is_squarefree()
    assert A.gcd(B) == 1

# Reuse each finite field and its cube set for both examples.
for n in range(1, max(genera)+1):
    E = k if n == 1 else GF(5**(2*n), 'e%d' % n, modulus=moduli[n])
    if n == 1:
        ae = a
    else:
        RE = PolynomialRing(E, 'r')
        ae = min((RE.gen()**2+2).roots(multiplicities=False),
                 key=lambda c: tuple(int(v) for v in c.polynomial().list()))
    cubes = {c**3 for c in E if c}
    for g in genera:
        if n > g:
            continue
        A, B = models[g]
        ac, bc = [[E(int(c[0]))+int(c[1])*ae for c in P.list()]
                  for P in (A, B)]
        plus = 3 if (A.degree()+B.degree()) % 3 == 0 else 1
        minus = 3 if (A.degree()-B.degree()) % 3 == 0 else 1
        for value in E:
            av, bv = evaluate(ac, value), evaluate(bc, value)
            if not av or not bv:
                plus += 1
                minus += 1
            else:
                plus += 3 if av*bv in cubes else 0
                minus += 3 if av/bv in cubes else 0
        counts[g].append([int(plus), int(minus)])
    print('Counted extension degree', n, flush=True)

RX = PolynomialRing(ZZ, 'X')
X = RX.gen()
RZ = PolynomialRing(QQ, 'z')
z = RZ.gen()
RT = PolynomialRing(RZ, 'T')
T = RT.gen()


def weil(point_counts):
    g, q = len(point_counts), ZZ(25)
    powers = [None]+[q**n+1-point_counts[n-1] for n in range(1, g+1)]
    coefficients = [ZZ(1)]
    for n in range(1, g+1):
        value = -sum(coefficients[n-i]*powers[i] for i in range(1, n+1))
        assert value % n == 0
        coefficients.append(value//n)
    result = sum(coefficients[i]*X**(2*g-i) for i in range(g+1))
    result += sum(q**(g-i)*coefficients[i]*X**i for i in range(g))
    return result


def root_ratios(P, Q, diagonal=False):
    degree = int(P.degree())
    assert Q.degree() == degree
    resultant = RZ(RT(P.list()).resultant(
        sum(RT(Q[i])*z**(degree-i)*T**i for i in range(degree+1))))
    if diagonal:
        resultant, remainder = resultant.quo_rem((z-1)**degree)
        assert remainder == 0 and resultant(1) != 0
    bound = int(resultant.degree())
    orders = [m for m in range(1, 2*bound**2+1) if euler_phi(m) <= bound]
    for m in orders:
        assert resultant.gcd(RZ.cyclotomic_polynomial(m)).degree() == 0
    return len(orders)


for g in genera:
    assert counts[g] == expected_counts[g]
    P, Q = [weil([row[i] for row in counts[g]]) for i in range(2)]
    assert [P, Q] == [RX(c) for c in expected_polynomials[g]]
    assert P.is_irreducible() and Q.is_irreducible()
    p_ranks = [max(i for i in range(2*g+1) if W[2*g-i] % 5) for W in (P, Q)]
    assert p_ranks == ([2, 2] if g == 3 else [2, 4])
    tests = [root_ratios(P, P, True), root_ratios(Q, Q, True)]
    if g == 3:
        tests.append(root_ratios(P, Q))
    # In genus4, absolute simplicity and unequal p-ranks already give Hom=0.
    print(json.dumps(dict(status='kummer_example_PASS', genus=g,
                          counts=counts[g], p_ranks=p_ranks,
                          cyclotomic_orders_per_test=tests)), flush=True)
