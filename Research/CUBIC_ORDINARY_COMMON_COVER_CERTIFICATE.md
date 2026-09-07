# Exact genus-four ordinary/nonordinary pair

Date: 2026-09-07. Author computation by
`/root/picard_cubic_common_cover_search`; not independently audited.
No library/state promotion and no claim to solve Litt3.

The restriction that all six branch points be F25-rational was unnecessary
and obstructed the preceding small test. Allowing arbitrary coprime monic
cubics immediately yields the requested arithmetic certificate. This
does not assert that rational branch points always obstruct it.

Put `F25=F5[a]/(a^2+2)` and

```
A(t) = t^3 + 4a*t^2 + t + 2a + 4,
B(t) = t^3 + (4a+3)*t^2 + (a+4)*t + 4a + 1.
```

The verifier checks that both cubics are monic, squarefree, and coprime.
For the smooth projective models `C+: y^3=A*B` and `C-: w^3=A/B`, it
computes the following exact counts:

| Field | C+ | C- |
| --- | ---: | ---: |
| F25 | 33 | 33 |
| F625 | 615 | 657 |
| F15625 | 16095 | 15726 |
| F390625 | 392427 | 391017 |

Each rational zero of A or B contributes one point to each curve,
including poles of A/B. Elsewhere an affine fiber contributes three or
zero points according to the nonzero cube test. Both curves have three
rational points over infinity because A and B are monic cubics.

Newton identities and the genus-four functional equation give

```
P+(X) = X^8 + 7X^7 + 19X^6 + 175X^5 + 1525X^4
          + 4375X^3 + 11875X^2 + 109375X + 390625,
P-(X) = X^8 + 7X^7 + 40X^6 + 199X^5 + 931X^4
          + 4975X^3 + 25000X^2 + 109375X + 390625.
```

Both polynomials are irreducible over Q. Since their middle coefficients
are respectively divisible and not divisible by 5, the plus Jacobian is
nonordinary and the minus Jacobian is ordinary. More precisely their
p-ranks are 2 and 4, read from the degrees of their reciprocal polynomials
modulo 5.

For each of the two self-pairs and the cross-pair, the verifier computes
`Res_T(P(T), z^8 Q(T/z))` exactly. The self-resultants contain exactly
`(z-1)^8`; after its removal, no remaining irreducible factor is
cyclotomic. The cross-resultant has no cyclotomic factor either.
Independent gcd tests against all 127 cyclotomic polynomials of degree
at most 64 return 1. This finite list is exhaustive because
`m/phi(m)^2 <= 2`, hence `phi(m)<=64` forces `m<=8192`.
Full resultant and factor coefficients are retained in the certificate.

The irreducible-polynomial and self-ratio tests imply that each positive
power of Frobenius still has an irreducible degree-eight characteristic
polynomial. Consequently both Jacobians are absolutely simple. The
cross-ratio test excludes a common eigenvalue over every finite
extension, hence geometric Hom is zero. In particular these Jacobians
are geometrically nonisogenous; their differing ordinarity also implies
this once absolute simplicity is known. These standard implications use
Frobenius characteristic polynomials and the faithful rational Tate
module, not numerical roots.

The intended common source is the normalization with function field
`u^3=A(t)`, `v^3=B(t)`. The main proof must verify its connectedness,
genus 10, and the two free diagonal C3 actions whose genus-four quotients
are exactly the displayed curves. The arithmetic certificate alone
does not replace these actual two-leg checks.

Reproduce the fixed pair with:

```
/usr/local/bin/sage -python scripts/cubic_ordinary_common_cover_certificate.py
```

Output: `Research/computations/cubic_ordinary_common_cover_certificate.json`.
The script SHA256 is
`f056d9192fec281810d58eba184adf60d3b4c93a1ad91d7b062ba12856cca9c3`.
All finite-field moduli and the selected images of a are recorded.

The bounded deterministic coefficient search succeeded on its first
trial in 11.6 seconds, and the retained fixed verifier independently
recomputed that trial and added the cross-ratio test. The temporary
search prototype and its superseded one-trial JSON were moved recoverably
to `/Users/julian/.Trash/litt3-cubic-exploration.98VZ95`. No search runs
remain active and no old-path aliases were created.
