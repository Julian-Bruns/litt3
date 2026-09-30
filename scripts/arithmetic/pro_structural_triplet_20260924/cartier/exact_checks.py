"""Exact, dependency-free checks. No cover or horizontal-lift search is performed."""
from __future__ import annotations
import itertools
from fractions import Fraction
from typing import Any

Poly = list[int]


def add(a: int, b: int) -> int:
    return (a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)


def neg(a: int) -> int:
    return (-a % 5) % 5 + 5 * ((-(a // 5)) % 5)


def mul(a: int, b: int) -> int:
    a0, a1, b0, b1 = a % 5, a // 5, b % 5, b // 5
    return (a0*b0 + 3*a1*b1) % 5 + 5*((a0*b1+a1*b0+a1*b1) % 5)


def power(a: int, n: int) -> int:
    if n < 0:
        if not a:
            raise ZeroDivisionError("negative power of zero")
        return power(power(a, 23), -n)
    ans = 1
    while n:
        if n & 1:
            ans = mul(ans, a)
        a = mul(a, a)
        n >>= 1
    return ans


def inv(a: int) -> int:
    if not a:
        raise ZeroDivisionError("inverse of zero")
    return power(a, 23)


def trim(a: Poly) -> Poly:
    a = a[:]
    while a and a[-1] == 0:
        a.pop()
    return a


def padd(a: Poly, b: Poly) -> Poly:
    return trim([add(a[i] if i < len(a) else 0, b[i] if i < len(b) else 0)
                 for i in range(max(len(a), len(b)))])


def pneg(a: Poly) -> Poly:
    return [neg(c) for c in a]


def psub(a: Poly, b: Poly) -> Poly:
    return padd(a, pneg(b))


def pscale(a: Poly, c: int) -> Poly:
    return trim([mul(x, c) for x in a])


def pmul(a: Poly, b: Poly) -> Poly:
    if not a or not b:
        return []
    ans = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            ans[i+j] = add(ans[i+j], mul(x, y))
    return trim(ans)


def pdivmod(a: Poly, b: Poly) -> tuple[Poly, Poly]:
    a, b = trim(a), trim(b)
    if not b:
        raise ZeroDivisionError("polynomial division by zero")
    quotient = [0] * max(0, len(a)-len(b)+1)
    bi = inv(b[-1])
    while a and len(a) >= len(b):
        j = len(a)-len(b)
        c = mul(a[-1], bi)
        quotient[j] = c
        for i, x in enumerate(b):
            a[i+j] = add(a[i+j], neg(mul(c, x)))
        a = trim(a)
    return trim(quotient), a


def mod(a: Poly, b: Poly) -> Poly:
    return pdivmod(a, b)[1]


def monic(a: Poly) -> Poly:
    a = trim(a)
    return pscale(a, inv(a[-1])) if a else []


def pgcd(a: Poly, b: Poly) -> Poly:
    while b:
        a, b = b, mod(a, b)
    return monic(a)


def ppow(a: Poly, n: int, modulus: Poly | None = None) -> Poly:
    if n < 0:
        raise ValueError("negative polynomial exponent")
    ans = [1]
    while n:
        if n & 1:
            ans = pmul(ans, a)
            if modulus is not None:
                ans = mod(ans, modulus)
        a = pmul(a, a)
        if modulus is not None:
            a = mod(a, modulus)
        n >>= 1
    return ans


def derivative(a: Poly) -> Poly:
    return trim([mul(i % 5, a[i]) for i in range(1, len(a))])


def check_field() -> dict[str, Any]:
    for a in range(25):
        assert add(a, neg(a)) == 0
        assert power(a, 25) == a
        if a:
            assert mul(a, inv(a)) == 1
        for b in range(25):
            assert add(a,b) == add(b,a)
            assert mul(a,b) == mul(b,a)
            for c in range(25):
                assert add(add(a,b),c) == add(a,add(b,c))
                assert mul(mul(a,b),c) == mul(a,mul(b,c))
                assert mul(a,add(b,c)) == add(mul(a,b),mul(a,c))
    assert mul(5,5) == add(5,3)
    return {"elements":25, "associativity_distributivity_triples":25**3,
            "quadratic_has_F5_root": any((a*a-a-3) % 5 == 0 for a in range(5)),
            "beta_squared_code":mul(5,5)}


def input_checks(data: dict[str, Any]) -> dict[str, Any]:
    P,A,Q,B = [data[key] for key in ("P","A","Q","B0")]
    gcds = {"gcd_P_Pprime":pgcd(P,derivative(P)),
            "gcd_A_Aprime":pgcd(A,derivative(A)), "gcd_P_A":pgcd(P,A)}
    assert all(g == [1] for g in gcds.values())
    rhs = pmul(P,pmul(A,A))
    assert derivative(Q) == rhs
    boundary = mod(padd(ppow(B,5),Q),P)
    assert boundary == []
    X = [0,1]
    frob = {str(j):ppow(X,25**j,A) for j in (1,2,3,4)}
    small_gcds = {str(j):pgcd(A,psub(frob[str(j)],X)) for j in (1,2)}
    irreducible = frob['4'] == X and small_gcds['2'] == [1]
    assert irreducible
    result = {"gcds":gcds, "Qprime":derivative(Q), "P_times_A_squared":rhs,
              "B0_fifth_plus_Q_mod_P":boundary, "A_monic":monic(A),
              "x_Frobenius_mod_A":frob, "A_small_factor_gcds":small_gcds,
              "A_irreducible_degree_four":irreducible,
              "R_degree":1+3*(len(A)-1),
              "genus_Kummer_3_degree_10":(3-1)*(10-1)//2}
    if irreducible:
        cube_test = ppow(mod(P,A),(25**4-1)//3,A)
        assert cube_test == [11]
        result['P_at_root_A_cubic_residue_test'] = cube_test
        result['P_at_root_A_is_cube_in_F25pow4'] = cube_test == [1]
        result['sufficient_RX_definition_field_degree_over_F25'] = 4 if cube_test == [1] else 12
    return result


def local_valuation_check() -> dict[str, Any]:
    """Finite sanity check only. The report proves the result for all g_i,g_j."""
    total = 0
    for e1,e2,h,g1,g2 in itertools.product(range(2),range(2),range(2),range(13),range(13)):
        if e1*g1 or e2*g2:
            continue
        v1, v2 = 3*e1-5*g1-10*h, 3*e2-5*g2-10*h
        lower = -((-min(v1,v2))//5)  # ceil(min(v1,v2)/5)
        wanted = min(e1,e2)-2*h-max(g1,g2)
        assert lower >= wanted, (e1,e2,h,g1,g2,lower,wanted)
        total += 1
    return {"cases":total,"max_G_multiplicity_tested":12,
            "scope":"bounded sanity check; universal proof is REPORT.md, Theorem 3.1"}


def orbit_profiles() -> dict[str, Any]:
    answer: dict[str,Any] = {}
    for m in (4,6):
        profiles = []
        for row in itertools.combinations_with_replacement(range(1,m+1),6):
            if sum(row) == 5*m and sum(a*a for a in row) <= 4*m*m+m:
                profiles.append(list(reversed(row)))
        expected = [[4,4,3,3,3,3]] if m == 4 else [[5,5,5,5,5,5]]
        assert profiles == expected
        answer[str(m)] = profiles
    # These rational manipulations, not a bounded degree search, prove m<=6.
    assert Fraction(25,6)-4 == Fraction(1,6)
    assert Fraction(25,5) > 4+Fraction(1,4)
    return {"six_support_integer_profiles_on_degree_m_quotient":answer,
            "support_five_exclusion_gap":str(Fraction(25,5)-(4+Fraction(1,4))),
            "support_six_lower_bound_for_one_over_m":str(Fraction(25,6)-4)}


# The following exact Cartier calculation is used in the arithmetic support theorem.
Matrix = list[list[int]]


def fsum(items: Any) -> int:
    ans = 0
    for x in items:
        ans = add(ans,x)
    return ans


def identity(n: int) -> Matrix:
    return [[int(i == j) for j in range(n)] for i in range(n)]


def madd(A: Matrix, B: Matrix) -> Matrix:
    return [[add(x,y) for x,y in zip(r,s)] for r,s in zip(A,B)]


def mscale(A: Matrix, a: int) -> Matrix:
    return [[mul(a,x) for x in r] for r in A]


def mmul(A: Matrix, B: Matrix) -> Matrix:
    return [[fsum(mul(x,y) for x,y in zip(row,col)) for col in zip(*B)] for row in A]


def mpow(A: Matrix, n: int) -> Matrix:
    ans = identity(len(A))
    while n:
        if n & 1:
            ans = mmul(ans,A)
        A = mmul(A,A)
        n >>= 1
    return ans


def rref(A: Matrix) -> tuple[Matrix, list[int]]:
    A = [r[:] for r in A]
    row = 0
    pivots = []
    for col in range(len(A[0])):
        pivot = next((i for i in range(row,len(A)) if A[i][col]),None)
        if pivot is None:
            continue
        A[row], A[pivot] = A[pivot], A[row]
        A[row] = [mul(x,inv(A[row][col])) for x in A[row]]
        for i in range(len(A)):
            if i != row:
                c = A[i][col]
                A[i] = [add(x,neg(mul(c,y))) for x,y in zip(A[i],A[row])]
        pivots.append(col)
        row += 1
        if row == len(A):
            break
    return A, pivots


def minverse(A: Matrix) -> Matrix:
    n = len(A)
    aug = [row+eye for row,eye in zip(A,identity(n))]
    rr,piv = rref(aug)
    if piv[:n] != list(range(n)) or [r[:n] for r in rr] != identity(n):
        raise ValueError('singular matrix')
    ans = [r[n:] for r in rr]
    assert mmul(A,ans) == identity(n) == mmul(ans,A)
    return ans


def mdet(A: Matrix) -> int:
    A = [r[:] for r in A]
    ans = 1
    for col in range(len(A)):
        pivot = next((i for i in range(col,len(A)) if A[i][col]),None)
        if pivot is None:
            return 0
        if pivot != col:
            A[pivot], A[col] = A[col], A[pivot]
            ans = neg(ans)
        a = A[col][col]
        ans = mul(ans,a)
        for i in range(col+1,len(A)):
            c = mul(A[i][col],inv(a))
            A[i] = [add(x,neg(mul(c,y))) for x,y in zip(A[i],A[col])]
    return ans


def cartier_checks(data: dict[str, Any]) -> dict[str, Any]:
    P = data['P']
    basis = [(1,i) for i in range(3)] + [(2,i) for i in range(6)]
    H = [[0]*9 for _ in range(9)]
    for col,(j,i) in enumerate(basis):
        jt = 2 if j == 1 else 1
        a = (5*jt-j)//3
        poly = [0]*i + ppow(P,a)
        for row,(jr,l) in enumerate(basis):
            if jr == jt and 5*l+4 < len(poly):
                H[row][col] = power(poly[5*l+4],5)
    H5 = [[power(a,5) for a in row] for row in H]
    M = mmul(H,H5)
    M4, M8, M12 = (mpow(M,d) for d in (4,8,12))
    S = madd(madd(identity(9),M4),M8)
    Sinv = minverse(S)
    ds = mdet(S)
    assert ds == 2
    assert mmul(madd(M4,mscale(identity(9),4)),S) == madd(M12,mscale(identity(9),4))
    nullities = {str(d):9-len(rref(madd(mpow(M,d),mscale(identity(9),4)))[1])
                 for d in (1,2,3,4,6,12)}
    assert nullities == {'1':0,'2':2,'3':0,'4':2,'6':2,'12':2}
    assert power(11,3) == 1 and 11 != 1
    return {'basis': [{'j':j,'i':i,'form':'x^i dx/y^j'} for j,i in basis],
            'convention':'C(v)=H*v^(1/5); C^2(v)=M*v^(1/25). Coefficientwise inverse fifth power equals fifth power on F25 only.',
            'H':H,'M':M,'M4':M4,'M8':M8,
            'S_I_plus_M4_plus_M8':S,'S_inverse':Sinv,'det_S':ds,
            'nullities_M_power_minus_I':nullities,
            'rank_H':len(rref(H)[1]),'rank_M':len(rref(M)[1]),
            'cube_multiplier_code':11,'cube_multiplier_cubed':power(11,3),
            'scope':'Exact finite-field matrix certificate. The relation to divisor torsion is proved in REPORT.md.'}

def counting_model_checks() -> dict[str, Any]:
    N = 13
    E = {(p,j) for p in range(13) for j in range(5)}
    G = {(p,0) for p in range(13,26)}
    intersections = []
    for shift in range(N):
        Es = {(p,(j+shift)%N) for p,j in E}
        Gs = {(p,(j+shift)%N) for p,j in G}
        e,g = len(E & Es),len(G & Gs)
        if shift:
            assert e+g <= 4*N
        intersections.append({'shift':shift,'E_intersection':e,'G_intersection':g})
    assert len(E) == 5*N and len(G) == N
    assert sum(a['E_intersection']+a['G_intersection'] for a in intersections) == 338
    assert 338 <= 4*N*N+2*N
    return {'N':N,'m':13,'r':13,'E_degree':len(E),'G_degree':len(G),
            'pairwise_intersections':intersections,'energy':338,'energy_upper_bound':702,
            'status':'COMBINATORIAL MODEL ONLY; NOT A GEOMETRIC WITNESS'}


# Aggregate the exact checks used in the archive.
def all_results(data: dict[str, Any]) -> dict[str, Any]:
    return {'field':check_field(), 'input':input_checks(data),
            'cartier':cartier_checks(data),
            'local_valuation':local_valuation_check(), 'orbit_profiles':orbit_profiles(),
            'counting_model':counting_model_checks()}

