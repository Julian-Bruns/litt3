#!/usr/bin/env sage -python
"""Polynomial cohomology matrices for genus-two pointed Frobenius tests.

This builder uses the Cech basis v/u, v/u^2, v/u^3 of H1(omega^-1),
not the Laurent basis used by verify_pointed_extensions.sage. Matrix
comparison requires its full parameter and target basis changes.
No numerical verdict is inferred by this module alone.
"""
from sage.all import matrix


def build_polynomial_blocks(F, R, P):
    """Return both parity blocks at any odd Frobenius power P.

    F is monic squarefree degree five, R is a monic squarefree divisor
    of degree 0,1 or2 specifying a two-torsion label. Characteristic
    must be odd; P>=5 must be a positive power of that characteristic.
    All scalar matrices explicitly select generic arithmetic.
    """
    ring = F.parent()
    field = ring.base_ring()
    p = int(field.characteristic())
    P = int(P)
    assert p > 2 and P >= max(p,5)
    power = P
    while power % p == 0:
        power //= p
    assert power == 1
    assert F.degree() == 5 and F.is_monic() and F.gcd(F.derivative()) == 1
    assert R.parent() is ring and R.is_monic() and 0 <= R.degree() <= 2
    S, remainder = F.quo_rem(R)
    assert not remainder
    d = int(R.degree())
    A = F**((P-1)//2)
    components = [(d, 5-d, R, 'kappa'), (5-d, d, S, 'v/kappa')]
    blocks = []
    for source_weight, target_weight, multiplier, label in components:
        source_degree = (P-1-source_weight)//2
        target_degree = (-P-1-target_weight)//2
        indices = list(range(1, -target_degree))
        polynomial = multiplier*A
        coefficients = []
        for shift in [2*P, P, 0]:
            coefficients.append(matrix(
                field, len(indices), source_degree+1,
                [polynomial[3*P-i-j-shift]
                 if 3*P-i-j-shift >= 0 else field(0)
                 for j in indices for i in range(source_degree+1)],
                implementation='generic'))
        assert len(indices) == source_degree+3
        blocks.append(dict(
            matrices=coefficients,
            weights=[source_weight+2*i for i in range(source_degree+1)],
            exponents=[2*j-target_weight for j in indices],
            source_component=label, target_weight=target_weight,
            cech_indices=indices))
    blocks.sort(key=lambda b: b['weights'][0] % 2 if b['weights'] else 1)
    return blocks


def coefficient_digit_matrices(F):
    """Three-state semilinear digit matrices for F^((p^h-1)/2)."""
    field=F.parent().base_ring()
    p=int(field.characteristic())
    assert p>2 and F.degree()==5
    A=F**((p-1)//2)
    return [matrix(field,3,3,
                   [A[r-j+p*t] if r-j+p*t>=0 else field(0)
                    for j in range(3) for t in range(3)],
                   implementation='generic')
            for r in range(p)]
