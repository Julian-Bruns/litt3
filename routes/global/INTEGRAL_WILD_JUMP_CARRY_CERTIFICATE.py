"""Exact integral-upper-jump sieve; Python 3 standard library only.

Completeness and termination: ../../Solutions/Sol_integral_jump_bound.md.
No search cutoff in rank, number of jumps, or group order is imposed.
Rows are necessary signatures, NOT a construction of local/global covers.
"""
from math import gcd, isqrt


def divisors(n):
    small = [d for d in range(1, isqrt(n) + 1) if n % d == 0]
    return sorted(set(small + [n // d for d in small]))


def small_side_candidates(D, p):
    """All multijump integer data with m0<t0 for this D and p>=3."""
    max_m = D * (p * p + 1) // (p * (p - 1) - 2)
    max_u = (p * p * (D + 1) - p + D + 2) // (p * (p - 1))
    hits, nodes = [], 0
    for m0 in range(1, max_m + 1):
        for t0 in divisors(m0 + D):
            if t0 <= m0 or gcd(t0, m0) != 1 or (t0 * m0) % p == 0:
                continue
            for u1 in range(1, max_u + 1):
                E = m0 * (u1 + 1) + D
                if E % p:
                    continue
                B = 2 * m0 * max_u + D
                stack = [(1, u1, E // p, ())]
                while stack:
                    rank, u, carry, breaks = stack.pop()
                    nodes += 1
                    assert 0 < carry <= B
                    if breaks and carry == u * m0 - t0:
                        q = p ** rank
                        filtration = breaks + ((rank, u),)
                        c1, previous_rank = 0, 0
                        for end_rank, jump in filtration:
                            c1 += (p ** end_rank - p ** previous_rank) * jump
                            previous_rank = end_rank
                        c = c1 - 1
                        assert c * m0 - q * t0 == D
                        assert (c + 1) % t0 == 0
                        hits.append((D, m0, t0, q, filtration, c))
                    for delta in range(max_u - u + 1):
                        numerator = carry + m0 * delta
                        if numerator % p:
                            continue
                        next_breaks = breaks + ((rank, u),) if delta else breaks
                        stack.append((rank + 1, u + delta, numerator // p,
                                      next_breaks))
    return hits, nodes


if __name__ == "__main__":
    h, p = 16, 5
    assert p * (h + 2) < p * p * (p - 1)  # excludes m0>=t0
    rows, total_nodes = [], 0
    for D in divisors(h):
        hits, nodes = small_side_candidates(D, p)
        rows.extend(hits)
        total_nodes += nodes
        print("D", D, "states", nodes, "candidates", len(hits))
    expected = [(8, 1, 3, 25, ((1, 1), (2, 4)), 83)]
    assert rows == expected
    print("Complete necessary tuple:", rows[0])
    for D, m0, t0, q, filtration, c in rows:
        assert filtration[0] == (1, 1)
        assert (p - 1) % t0 != 0  # first lower graded quotient forces t|p-1
    print("PASS:", total_nodes, "states; every multijump tuple locally impossible")
