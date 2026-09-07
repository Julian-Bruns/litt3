# Exact Picard-pair arithmetic certificate

Date: 2026-09-07. Author computation by the bounded
`/root/picard_cubic_common_cover_search` agent; not independently audited.
No claim to solve Litt3, and no library/state promotion.

The requested arithmetic example exists. Put
`F25 = F5[a]/(a^2+2)`, `lambda=a`, `mu=a+2`. Both parameters are outside
F5, nonzero, distinct, and different from 1. For the smooth projective
models

```
C+: w^3 = t(t-1)(t-a)(t-a-2),
C-: z^3 = x(1-x)(1-a*x)(1-(a+2)*x),
```

the point counts and Frobenius characteristic polynomials are:

| Field | C+ | C- |
| --- | ---: | ---: |
| F25 | 26 | 17 |
| F625 | 590 | 509 |
| F15625 | 15431 | 15566 |

```
P+(X) = X^6 - 18X^4 - 65X^3 - 450X^2 + 15625,
P-(X) = X^6 - 9X^5 - 18X^4 + 385X^3 - 450X^2 - 5625X + 15625.
```

Both are irreducible over Q. The script counts each affine fiber exactly
as 1 for zero, 3 for a nonzero cube, or 0 otherwise, then adds the single
point at infinity. Its three power sums and the genus-three functional
equation reconstruct each displayed polynomial.

For each ordered pair P,Q among (P+,P+), (P-,P-), (P+,P-), it computes

```
R(z) = Res_T(P(T), z^6 Q(T/z)).
```

The roots of R are all eigenvalue ratios alpha/beta. Each self-resultant
has exactly six factors z-1. After removing them, its factorization has
three distinct irreducible factors of degree 6 with multiplicities 1,2,2.
The cross-resultant has two irreducible factors of degree 18. None of
these factors is cyclotomic.

A second exact check computes gcds with every cyclotomic polynomial
Phi_m of degree at most 36: all 72 eligible orders give gcd 1 for all
three remaining resultants. This list is exhaustive: the elementary
prime-factor formula gives m/phi(m)^2 <= 2, so phi(m)<=36 implies m<=2592.
Both the full resultant coefficients and irreducible factor coefficients
are saved in the JSON. No numerical approximation enters either test.

Consequently every positive power of each Frobenius eigenvalue has degree
6 over Q: irreducibility makes the original six roots one Galois orbit,
and the self-ratio test says taking a power never identifies two roots.
Thus every finite extension has an irreducible degree-six Frobenius
polynomial, which excludes a proper abelian subvariety after any finite
extension. Every geometric abelian subvariety descends to a finite
extension, so both Jacobians are absolutely simple.

The cross-ratio test says no positive powers of an eigenvalue of one
Jacobian and an eigenvalue of the other coincide. A nonzero geometric
homomorphism descends to a finite extension and induces a nonzero
Frobenius-equivariant map on rational Tate modules; disjoint spectra
exclude such a map. Hence geometric Hom is zero, in particular the two
Jacobians are not geometrically isogenous. These implications use the
usual Frobenius characteristic polynomial and faithfulness of the Tate
module; the point-count script itself does not formalize those theorems.

The common-source geometry is deliberately left for the main proof:
the intended source is the normalization with
`u^3=t`, `v^3=(t-1)(t-a)(t-a-2)`. The arithmetic computation does not
replace verification that both displayed genus-three curves are its
actual finite etale quotients.

Reproduce with:

```
/usr/local/bin/sage -python scripts/picard_cubic_common_cover_certificate.py
```

The fixed-pair verifier recomputes only the successful pair and its exact
certificates, and completes in a few seconds.
All finite-field moduli, embeddings, parameter encodings, intermediate
point counts, and the script SHA256 are recorded in
`Research/computations/picard_cubic_common_cover_certificate.json`.
The matching script SHA256 is embedded in that certificate.
The superseded search script and its trial log were retired recoverably to
`/Users/julian/.Trash/litt3-cubic-exploration.98VZ95`.
