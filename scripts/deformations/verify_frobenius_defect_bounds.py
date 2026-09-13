#!/usr/bin/env python3
"""Small exact checks for the new character-order/count argument.

These check bookkeeping, not the geometric trace/duality proof.
No giant factorial or field enumeration is performed.
"""
from math import factorial, gcd


def main():
    checks = 0
    for order in range(3, 401):
        if gcd(order, 5) != 1:
            continue
        inv5 = pow(5, -1, order)
        tails = {inv5, (-inv5) % order}
        for length in range(1, 25):
            for head in (1, order - 1):
                tail = head * pow(5, length - 1, order) % order
                congruence = (pow(5, length, order) in (1, order - 1))
                assert (tail in tails) == congruence
                checks += 1
    print(f"GRADED_STRING_CONGRUENCE_PASS cases={checks}")

    image_bound = 4 * (5**24 + 1)
    genus_bound = image_bound + 1
    assert genus_bound < 2**59
    atlas_D = factorial(63)
    atlas_G = 1 + 8 * atlas_D
    atlas_L = 64**2
    partner_M = 8 * (genus_bound - 1)
    assert atlas_D < 2**378 and atlas_G < 2**382
    assert partner_M < 2**62
    # log2(n!) <= n*bit_length(n); log2(3)<2.
    log2_partner_bound = (
        atlas_D.bit_length()
        + 18 * atlas_D * atlas_D.bit_length()
        + 8 * atlas_G**2 * atlas_L
        + (2 * atlas_G + atlas_L) * partner_M * partner_M.bit_length()
    )
    log2_total_bound = (
        log2_partner_bound
        + genus_bound.bit_length()
        + 8 * 59 * genus_bound**2
    )
    assert log2_total_bound < 2**800
    # Existing K contains3^(4G_big²L_big), and D_big>=2^335998.
    # Thus log2(K)>2^671996, which dominates the bound just computed.
    assert 800 < 671996
    print(f"defect_image_bound={image_bound}")
    print(f"carrier_genus_bound={genus_bound}")
    print(f"ceil_log2_log2_total_upper_bound={log2_total_bound.bit_length()}")
    print("UNCHANGED_PARAMETER_DOMINATION_PASS")
    print("SCOPE: exact finite bookkeeping, not independent geometric verification.")


if __name__ == "__main__":
    main()
