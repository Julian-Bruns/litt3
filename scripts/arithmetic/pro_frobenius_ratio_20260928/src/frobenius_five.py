"""Complete Frobenius-five square test; exact over any selected finite K-algebra.

For a(0)=1, reconstruct B_0,...,B_70 via B*a^2=B^5.
The 70 defects in degrees 71,...,140 are a unit-triangular change of
all 70 corrected original tails, not just an ordinary derivative test.
"""
from ext import EP


def square_coefficients(A, nmax=140):
    """Coefficients of a(T)^2, retaining scale as an indeterminate."""
    assert A[0] == 1 and len(A) > nmax
    D = []
    for n in range(nmax + 1):
        acc = EP()
        for i in range(n // 2 + 1):
            term = A[i] * A[n - i]
            acc = acc + (term if 2*i == n else 2*term)
        D.append(acc)
    return D


def root_prefix(D, nmax=70):
    """Monic recurrence; no ratio, scale, or middle-coefficient inversions."""
    assert D[0] == 1 and len(D) > nmax
    B = [EP(1)]
    for n in range(1, nmax + 1):
        acc = B[n // 5].frob() if n % 5 == 0 else EP()
        for i in range(1, n + 1):
            acc = acc - D[i] * B[n-i]
        B.append(acc)
    return B


def defects(D, B, lo=71, hi=140):
    """[T^n](B*a^2-B^5); B has degree at most 70 in T."""
    assert len(B) == 71 and len(D) > hi
    out = []
    for n in range(lo, hi + 1):
        acc = EP()
        for j in range(min(n,70) + 1):
            acc = acc + D[n-j]*B[j]
        if n % 5 == 0:
            acc = acc - B[n//5].frob()
        out.append(acc)
    return out


def test_polynomials(A):
    D = square_coefficients(A)
    B = root_prefix(D)
    E = defects(D, B)
    return B, E, D


def linear_model(A):
    """112 rows M*b = rhs; b=(B29,...,B70), coefficients scale degree <=12.

    Only B0,...,B28 are reconstructed, to fix the right hand side. The
    first 42 rows form a unit lower-triangular block.
    """
    D = square_coefficients(A)
    prefix = root_prefix(D, 28)
    rows, rhs = [], []
    for n in range(29,141):
        rows.append([D[n-j] if 0 <= n-j < len(D) else EP()
                     for j in range(29,71)])
        acc = prefix[n//5].frob() if n % 5 == 0 else EP()
        for j in range(29):
            acc = acc - D[n-j]*prefix[j]
        rhs.append(acc)
    return rows, rhs, prefix
