"""Complete h16, p5, upper-denominator-dividing5 local signature sieve.

Standard-library Python only. All search limits are proved in
BOUNDED_WILD_JUMP_DENOMINATORS_BOUND_ATLAS_DEGREES.md, Section 5.
No rank cutoff: path lengths are computed exactly in a finite carry DAG.
"""
from fractions import Fraction
from functools import lru_cache
from math import gcd, isqrt

P, L, H = 5, 5, 16


def divisors(n):
    small = [d for d in range(1, isqrt(n) + 1) if n % d == 0]
    return sorted(set(small + [n // d for d in small]))


def jump_limit(D):
    return L * (P * P * (D + 1) - P + D + 2) // (P * (P - 1))


def reduced_signatures():
    hits, total_states = set(), 0
    for D in divisors(H):
        V = jump_limit(D)
        for m in range(1, 7 * D + 1):
            for t0 in divisors(m + D):
                if t0 <= m or gcd(t0, m) != 1 or (t0 * m) % P == 0:
                    continue
                inverse_m = pow(m, -1, P)

                @lru_cache(None)
                def tails(v, carry, changed):
                    mask = int(changed and carry == v * m - L * t0)
                    for dv in range((-carry * inverse_m) % P, V - v + 1, P):
                        next_carry = (carry + m * dv) // P
                        assert next_carry > 0
                        mask |= tails(v + dv, next_carry, changed or dv > 0) << 1
                    return mask

                for v1 in range(L, V + 1, L):
                    E = m * (v1 + L) + L * D
                    if E % P:
                        continue
                    mask = tails(v1, E // P, False) << 1
                    while mask:
                        bit = mask & -mask
                        rank = bit.bit_length() - 1
                        mask -= bit
                        if rank < 3:
                            continue  # q=5,25 separately settled by integrality
                        q = P ** rank
                        if (q * t0 + D) % m:
                            continue
                        c = (q * t0 + D) // m
                        if (c + 1) % t0 == 0:
                            hits.add((D, m, t0, rank, c))
                total_states += tails.cache_info().currsize
                tails.cache_clear()
    return sorted(hits), total_states


def all_filtrations(D, m, t0, rank, c):
    """Reconstruct all finite paths for an already found terminal rank."""
    V, inverse_m, paths = jump_limit(D), pow(m, -1, P), []

    def visit(n, v, carry, breaks):
        if n == rank:
            if breaks and carry == v * m - L * t0:
                paths.append(breaks + ((n, v),))
            return
        for dv in range((-carry * inverse_m) % P, V - v + 1, P):
            next_breaks = breaks + ((n, v),) if dv else breaks
            visit(n + 1, v + dv, (carry + m * dv) // P, next_breaks)

    for v1 in range(L, V + 1, L):
        E = m * (v1 + L) + L * D
        if E % P == 0:
            visit(1, v1, E // P, ())
    return paths


def local_filter(filtration, rank, c, t0):
    lower, previous_rank, previous_v, b = [], 0, 0, Fraction(0)
    for end_rank, v in filtration:
        b += Fraction((v - previous_v) * P ** previous_rank, L)
        if b.denominator != 1:
            return None
        lower.append((end_rank, int(b)))
        previous_rank, previous_v = end_rank, v
    residue = lower[0][1] % P
    if residue == 0 or any(b % P != residue for _, b in lower):
        return None
    T, previous_rank = 0, 0
    for i, (end_rank, b) in enumerate(lower):
        drop = end_rank - previous_rank
        T = gcd(T, b * (P ** drop - 1))
        epsilon, previous = 0, previous_rank
        for rank_j, break_j in lower[i:]:
            epsilon += break_j * (P ** (rank - previous) - P ** (rank - rank_j))
            previous = rank_j
        if i == 0:
            assert epsilon == c + 1
        excess = epsilon - b * (P ** (rank - previous_rank) - 1)
        if excess % (P ** ((drop + 1) // 2)):
            return None
        previous_rank = end_rank
    return (tuple(lower), T) if T % t0 == 0 else None


if __name__ == "__main__":
    reduced, states = reduced_signatures()
    assert reduced == [(1, 1, 2, 3, 251), (1, 3, 4, 3, 167),
                       (1, 7, 8, 3, 143), (8, 1, 3, 3, 383),
                       (8, 1, 3, 4, 1883), (8, 1, 3, 5, 9383)]
    full, survivors = set(), []
    for row in reduced:
        D, m, t0, rank, c = row
        paths = all_filtrations(*row)
        for path in paths:
            result = local_filter(path, rank, c, t0)
            if result is None:
                continue
            lower, T = result
            survivors.append((row, lower, T))
            q = P ** rank
            for g0 in divisors(T // t0):
                e, tame_order = q * g0 * t0, g0 * m
                if c >= e or tame_order < 2 or g0 % P == 0:
                    continue
                n = (H // D) * q * g0 * t0 * m
                assert n * (Fraction(c, e) - Fraction(1, tame_order)) == H
                full.add((D, q, lower[-1][1], t0, m, g0, n))
    assert len(survivors) == 2
    assert sorted(full) == [(1, 125, 6, 8, 7, 1, 112000),
                            (1, 125, 6, 8, 7, 3, 336000),
                            (8, 125, 66, 3, 1, 2, 1500),
                            (8, 125, 66, 3, 1, 4, 3000),
                            (8, 125, 66, 3, 1, 8, 6000)]
    print("Exact carry states:", states)
    print("Surviving local filtrations:", survivors)
    print("Complete full necessary signatures:", sorted(full))
    print("PASS: maximum atlas degree", max(row[-1] for row in full))
