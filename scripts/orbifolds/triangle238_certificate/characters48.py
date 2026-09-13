"""Exact symmetric-group character mass. Python standard library only.

Direct Murnaghan--Nakayama and the independent e-quotient/abacus formula
are both implemented. No precomputed character table is used.
"""
from fractions import Fraction
from functools import lru_cache
from math import factorial


def partitions(n, bound=None):
    if n == 0:
        yield ()
        return
    if bound is None:
        bound = n
    for a in range(min(n, bound), 0, -1):
        for rest in partitions(n-a, a):
            yield (a,) + rest


@lru_cache(None)
def hook_product(lam):
    if not lam:
        return 1
    cols = [sum(x > j for x in lam) for j in range(lam[0])]
    result = 1
    for i, row in enumerate(lam):
        for j in range(row):
            result *= row-j + cols[j]-i-1
    return result


@lru_cache(None)
def mn_character(lam, e):
    """chi_lam(e^(|lam|/e)), using direct rim-hook recursion.

    In the beta-set of a partition, replacing b by b-e removes an e-rim
    hook exactly when b>=e and b-e is unoccupied. Its height equals the
    number of beta-set elements strictly between b-e and b.
    """
    if not lam:
        return 1
    assert sum(lam) % e == 0
    L = len(lam)
    beta = [lam[i]+L-1-i for i in range(L)]
    occupied = set(beta)
    answer = 0
    for b in beta:
        if b < e or b-e in occupied:
            continue
        height = sum(b-e < x < b for x in beta)
        new_beta = sorted((occupied-{b}) | {b-e}, reverse=True)
        mu = tuple(x-(L-1-i) for i, x in enumerate(new_beta))
        mu = tuple(x for x in mu if x)
        answer += (-1)**height * mn_character(mu, e)
    return answer


def abacus_character(lam, e):
    """Independent e-quotient formula for the same character value."""
    n = sum(lam)
    assert n % e == 0
    if not n:
        return 1
    L = ((len(lam)+e-1)//e)*e
    beta = [(lam[i] if i < len(lam) else 0)+L-1-i for i in range(L)]
    runners = [[b//e for b in beta if b % e == r] for r in range(e)]
    q = L//e
    if any(len(v) != q for v in runners):
        return 0  # Nonempty e-core.
    denominator = 1
    for v in runners:
        mu = tuple(v[j]-(q-1-j) for j in range(q))
        assert all(x >= 0 for x in mu)
        denominator *= hook_product(tuple(x for x in mu if x))
    residues = [b % e for b in beta]
    vacuum = [b % e for b in range(L-1, -1, -1)]

    def parity(seq):
        return sum(seq[i] > seq[j]
                   for i in range(L) for j in range(i+1, L)) % 2

    sign = -1 if parity(residues) != parity(vacuum) else 1
    numerator = factorial(n//e)
    assert numerator % denominator == 0
    return sign*(numerator//denominator)


def small_cross_checks():
    count = 0
    for n in range(1, 13):
        for e in range(2, n+1):
            if n % e:
                continue
            for lam in partitions(n):
                assert mn_character(lam, e) == abacus_character(lam, e)
                count += 1
    return count


def mass48(character):
    """Weighted count of all pairs of the required cycle types.

    The Frobenius class-product formula, divided by 48!, and the
    hook-length degree formula give
        sum_lam H(lam)*chi_lam(2^24)*chi_lam(3^16)*chi_lam(8^6)
        ------------------------------------------------------ .
                (2^24 24!)(3^16 16!)(8^6 6!)
    Every such pair is automatically transitive, by the orbit-size and
    permutation-sign argument in README.md.
    """
    numerator = 0
    npartitions = 0
    nonzero = 0
    for lam in partitions(48):
        npartitions += 1
        c8 = character(lam, 8)
        if not c8:
            continue
        c3 = character(lam, 3)
        if not c3:
            continue
        c2 = character(lam, 2)
        if not c2:
            continue
        nonzero += 1
        numerator += c2*c3*c8*hook_product(lam)
    denominator = ((2**24*factorial(24)) * (3**16*factorial(16))
                   * (8**6*factorial(6)))
    return Fraction(numerator, denominator), npartitions, nonzero
