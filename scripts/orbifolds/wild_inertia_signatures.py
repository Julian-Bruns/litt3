"""Exact necessary wild-inertia signatures for the fixed genus-nine curve.

Run: python3 scripts/orbifolds/wild_inertia_signatures.py [single|integral|denominator-five|first-layer|all]
The commands verify the single-jump, integral-jump, denominator-five and
first-layer sieves. A shared scaled carry engine handles integral and
fractional upper jumps; its parameter bounds are proved in
Proofs/quotient_geometry/local_actions/wild_jump_atlas_bounds.md.
The first-layer ranges are proved in Proofs/shared_tensors/fixed_x_two_branch_bound.md.
All outputs are necessary signatures; they do not construct covers.
"""
import argparse
from fractions import Fraction
from functools import lru_cache
from math import gcd, isqrt


def divisors(n):
    small = [d for d in range(1, isqrt(n) + 1) if n % d == 0]
    return sorted(set(small + [n // d for d in small]))


def single_jump_signatures(h, p):
    rows = []
    q = p
    while q <= (h + 2) ** 2:
        for D in divisors(h):
            if q > (D + 2) ** 2:
                continue
            max_m = q + (q + D) // (q - 2)
            max_j = (max_m + D) * (q + 1) // (q - 1)
            for j in range(1, max_j + 1):
                c = j * (q - 1) - 1
                for t0 in divisors(c + 1):
                    if t0 % p == 0 or (q * t0 + D) % c:
                        continue
                    m0 = (q * t0 + D) // c
                    if m0 % p == 0 or gcd(t0, m0) != 1:
                        continue
                    assert m0 <= max_m
                    for g0 in divisors((c + 1) // t0):
                        e, m = q * g0 * t0, g0 * m0
                        if g0 % p == 0 or c >= e or m < 2:
                            continue
                        n = (h // D) * q * g0 * t0 * m0
                        assert n % e == n % m == 0
                        assert n * (Fraction(c, e) - Fraction(1, m)) == h
                        assert (c + 1) % (g0 * t0) == 0
                        rows.append((q, j, t0, m0, D, g0, n))
        q *= p
    return rows


def scaled_jump_candidates(D, p, scale, max_m, max_v, min_rank=2):
    """All multijump carry paths in the supplied proved ranges.

    Filtrations store (cumulative rank, scaled upper jump). Cached bit
    masks record all possible remaining path lengths, so no wild rank
    cutoff or upper-jump pattern is guessed.
    """
    hits, states = set(), 0
    for m0 in range(1, max_m + 1):
        for t0 in divisors(m0 + D):
            if t0 <= m0 or gcd(t0, m0) != 1 or (t0 * m0) % p == 0:
                continue
            inverse_m = pow(m0, -1, p)

            @lru_cache(None)
            def lengths(v, carry, changed):
                mask = int(changed and carry == v * m0 - scale * t0)
                for delta in range((-carry * inverse_m) % p, max_v - v + 1, p):
                    next_carry = (carry + m0 * delta) // p
                    assert next_carry > 0
                    mask |= lengths(v + delta, next_carry, changed or delta > 0) << 1
                return mask

            def paths(target, rank, v, carry, breaks):
                remaining = target - rank
                if not lengths(v, carry, bool(breaks)) & (1 << remaining):
                    return
                if remaining == 0:
                    yield breaks + ((rank, v),)
                    return
                for delta in range((-carry * inverse_m) % p, max_v - v + 1, p):
                    next_breaks = breaks + ((rank, v),) if delta else breaks
                    yield from paths(target, rank + 1, v + delta,
                                     (carry + m0 * delta) // p, next_breaks)

            for v1 in range(scale, max_v + 1, scale):
                E = m0 * (v1 + scale) + scale * D
                if E % p:
                    continue
                mask = lengths(v1, E // p, False) << 1
                while mask:
                    bit = mask & -mask
                    rank = bit.bit_length() - 1
                    mask -= bit
                    q = p ** rank
                    if rank < min_rank or (q * t0 + D) % m0:
                        continue
                    c = (q * t0 + D) // m0
                    assert (c + 1) % t0 == 0
                    for filtration in paths(rank, 1, v1, E // p, ()):
                        c1, previous_rank = Fraction(0), 0
                        for end_rank, jump in filtration:
                            c1 += Fraction((p ** end_rank - p ** previous_rank) * jump,
                                           scale)
                            previous_rank = end_rank
                        assert c1 == c + 1
                        hits.add((D, m0, t0, q, filtration, c))
            states += lengths.cache_info().currsize
            lengths.cache_clear()
    return sorted(hits), states


def integral_jump_candidates(D, p):
    """The sharper integral ranges of the shared carry engine."""
    max_m = D * (p * p + 1) // (p * (p - 1) - 2)
    max_v = (p * p * (D + 1) - p + D + 2) // (p * (p - 1))
    return scaled_jump_candidates(D, p, 1, max_m, max_v)


def local_ramification_filter(filtration, p, scale, c, t0):
    """Integral lower breaks, maximal-break residues and subgroup Swan tests."""
    rank = filtration[-1][0]
    lower, previous_rank, previous_v, b = [], 0, 0, Fraction(0)
    for end_rank, v in filtration:
        b += Fraction((v - previous_v) * p ** previous_rank, scale)
        if b.denominator != 1:
            return None
        lower.append((end_rank, int(b)))
        previous_rank, previous_v = end_rank, v
    residue = lower[0][1] % p
    if residue == 0 or any(b % p != residue for _, b in lower):
        return None
    tame_bound, previous_rank = 0, 0
    for i, (end_rank, b) in enumerate(lower):
        drop = end_rank - previous_rank
        tame_bound = gcd(tame_bound, b * (p ** drop - 1))
        epsilon, previous = 0, previous_rank
        for rank_j, break_j in lower[i:]:
            epsilon += break_j * (p ** (rank - previous) - p ** (rank - rank_j))
            previous = rank_j
        if i == 0:
            assert epsilon == c + 1
        excess = epsilon - b * (p ** (rank - previous_rank) - 1)
        if excess % (p ** ((drop + 1) // 2)):
            return None
        previous_rank = end_rank
    return (tuple(lower), tame_bound) if tame_bound % t0 == 0 else None


def translation_dimension_bound(degree, p):
    """Lehr--Matignon Proposition6.6, after dividing group orders by p."""
    assert p >= 2 and degree > 1 and degree % p != 0
    ell, s = degree - 1, 0
    while ell % p == 0:
        ell //= p
        s += 1
    if s == 0:
        return 0
    return 2 * s if ell == 1 else s - int(p == 2)


def verify_denominator_five():
    p, scale, h = 5, 5, 16
    rows, states = [], 0
    for D in divisors(h):
        max_v = scale * (p * p * (D + 1) - p + D + 2) // (p * (p - 1))
        hits, count = scaled_jump_candidates(D, p, scale, 7 * D, max_v,
                                             min_rank=3)
        rows.extend(hits)
        states += count
    reduced = sorted({(D, m0, t0, q, c) for D, m0, t0, q, _, c in rows})
    assert reduced == [(1, 1, 2, 125, 251), (1, 3, 4, 125, 167),
                       (1, 7, 8, 125, 143), (8, 1, 3, 125, 383),
                       (8, 1, 3, 625, 1883), (8, 1, 3, 3125, 9383)]
    full, before_translation = set(), []
    for D, m0, t0, q, filtration, c in rows:
        result = local_ramification_filter(filtration, p, scale, c, t0)
        if result is None:
            continue
        lower, tame_bound = result
        before_translation.append((lower, tame_bound))
        rank = filtration[-1][0]
        assert len(lower) == 2 and lower[0] == (2, 1) and rank == 3
        if lower[0][0] > translation_dimension_bound(lower[-1][1], p):
            continue
        for g0 in divisors(tame_bound // t0):
            e, tame_order = q * g0 * t0, g0 * m0
            if c >= e or tame_order < 2 or g0 % p == 0:
                continue
            n = (h // D) * q * g0 * t0 * m0
            assert n * (Fraction(c, e) - Fraction(1, tame_order)) == h
            full.add((D, q, lower[-1][1], t0, m0, g0, n))
    assert sorted(before_translation) == [(((2, 1), (3, 6)), 24),
                                         (((2, 1), (3, 66)), 24)]
    assert sorted(full) == [(1, 125, 6, 8, 7, 1, 112000),
                            (1, 125, 6, 8, 7, 3, 336000)]
    print('Complete reduced denominator-five rows:', reduced)
    print('After all local constraints:', sorted(full))
    print('PASS:', states, 'carry states; maximum nonintegral atlas degree 336000')


def verify_single_jump():
    rows = single_jump_signatures(16, 5)
    reduced = {}
    for q, j, t0, m0, D, g0, n in rows:
        key = q, j, t0, m0, D
        reduced[key] = max(reduced.get(key, 0), n)
    expected = {
        (5, 1, 4, 7, 1): 2240, (5, 2, 4, 3, 1): 1920,
        (5, 3, 2, 1, 1): 960, (5, 1, 1, 2, 1): 640,
        (5, 2, 1, 1, 2): 320, (5, 1, 1, 3, 4): 240,
        (5, 6, 3, 1, 8): 240, (5, 1, 1, 7, 16): 140,
        (5, 2, 1, 3, 16): 120,
    }
    assert reduced == expected
    assert max(row[-1] for row in rows) == 2240
    for key, degree in sorted(reduced.items(), key=lambda item: -item[1]):
        print(key, "maximum atlas degree", degree)
    print("PASS: complete proved ranges; maximum degree 2240")


def verify_integral_jumps():
    h, p = 16, 5
    assert p * (h + 2) < p * p * (p - 1)  # excludes m0>=t0
    rows, total_nodes = [], 0
    for D in divisors(h):
        hits, nodes = integral_jump_candidates(D, p)
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


def verify_first_layer():
    nonlarge = []
    for D in (1, 2, 4, 8, 16):
        for m in range(1, 26 * D // 18 + 1):
            for t0 in range(m + 1, m + D + 1):
                if (m + D) % t0 or gcd(m, t0) != 1 or m * t0 % 5 == 0:
                    continue
                bound_b = (125 * t0 + D + m) // (124 * m)
                for b in range(1, bound_b + 1):
                    if b % 5 == 0:
                        continue
                    E, valuation = D + (b + 1) * m, 0
                    quotient = E
                    while quotient % 5 == 0:
                        quotient //= 5
                        valuation += 1
                    for r in range(1, 2 * valuation + 1):
                        if b * (5**r - 1) % t0 == 0:
                            nonlarge.append((D, m, t0, b, r, E))
    assert nonlarge == [(2, 1, 3, 2, 2, 5), (8, 1, 3, 1, 2, 10),
                        (8, 1, 9, 6, 2, 15), (16, 2, 3, 1, 2, 20)]
    
    large = []
    for D in (1, 2, 4, 8, 16):
        for t0 in (1, 2, 3, 4, 6, 8, 12, 24):
            for m in range(1, t0):
                if ((m + D) % t0 or gcd(m, t0) != 1 or m % 5 == 0
                        or (D + 2 * m) % 5 or 5 * t0 >= 9 * m):
                    continue
                large.append((D, m, t0))
    assert large == [(1, 2, 3), (1, 7, 8), (16, 2, 3)]
    print('Complete non-large rows:', nonlarge)
    print('Complete large rows:', large)
    print('PASS; the remaining congruences and torsion exclusion are proved in the note.')


if __name__ == "__main__":
    checks = {"single": verify_single_jump, "integral": verify_integral_jumps,
              "denominator-five": verify_denominator_five,
              "first-layer": verify_first_layer}
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("sieve", choices=[*checks, "all"], default="all", nargs="?")
    choice = parser.parse_args().sieve
    for name in checks if choice == "all" else [choice]:
        checks[name]()
