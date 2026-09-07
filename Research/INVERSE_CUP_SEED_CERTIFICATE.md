# Certified inverse-cup seeds for the saved genus-nine oper

2026-09-07. This is an exact coefficient computation for the first saved
acyclic oper, not an atlas exclusion or a solution of Litt3.

The cached quadratic tensor in `wronskian_quadratic_bezout.json` and the
Serre cup pairing give all32 coefficient matrices of Gamma(beta^[5]).
No quadratic tensor was rebuilt. In the canonical atlas coordinates,
write N_r for the64 homogeneous equations and R_i-beta_i for the32
inhomogeneous equations, with normalization U.beta-2.

For EVERY matrix entry(a,b), the script verifies the polynomial identity

    (B(U) Gamma(beta^[5]))_(a,b) - delta_(a,b)*(U.R)/2
      = sum_(i,r) c_(a,b,i,r) U_i N_r.

Consequently the original97 equations have the explicit consequences

    (B Gamma-I)_(a,b)
      = sum c_(a,b,i,r) U_i N_r
        + delta_(a,b)/2 * [sum_i U_i(R_i-beta_i)+(U.beta-2)].

All multipliers have degree at most one in U, and the normalization
multiplier is constant. Degree7 means degree over F25; introducing the
field generator as an extra prime-field variable can raise total degree.

Verification uses complete coefficient linear algebra, with columns
U_j U_k beta_l^5 for j<=k. The2048 by16896 coefficient matrix of U_i N_r
has rank2039. A single augmented echelonization tracks its row operations.
The576 resulting target certificates are then multiplied back into the
ORIGINAL coefficient matrix and checked in all9,732,096 entries. No
sampled atlas point is used as evidence.

All576 homogeneous B Gamma entries are linearly independent; adjoining
their diagonal constant terms preserves rank576. Thus constant row
combinations cannot shrink this entire seed set. The equations contain
6,724,943 nonzero terms altogether, including24 constants, and may be
expensive to add all at once. The saved artifact lists smallest-support
subsets of8,24,32,64,128 entries. Those are certified optional additional
seeds, not assertions that a subset replaces the full inverse-cup system.

The complete certificates have697,260 nonzero multipliers. They are stored
compactly as576 strings of2048 field characters, each character encoding
c0+a*c1 with index c0+5*c1 in the displayed25-character alphabet.
Position64*i+r denotes the coefficient of U_i N_r. The encoding is checked
by exact roundtrip. Source hashes bind the certificate to its inputs.

Reproduce with `sage scripts/inverse_cup_seed_certificate.sage`. The first
full exact run took21seconds and peaked at675MB resident memory. The
artifact is `Research/computations/inverse_cup_seed_certificate.json`.
This supplies the previously missing explicit original-ideal membership
certificates for degree7 inverse-cup seeds. It does not predict whether
seeding a Groebner computation is beneficial; no solver was launched.
