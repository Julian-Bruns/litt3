# Proof: a ramification bound makes a finite character test exhaustive

27 September2026. Encode [a+5b]=a+b beta, beta^2=beta+3, and use
ascending coefficient rows
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\qquad
A=(1,21,14,22,13).
\]
The polynomial P is squarefree of degree10, A is squarefree of degree4,
and gcd(P,A)=1. The smooth curve y^3=P has genus9, unique infinity O,
and pole orders3 and10 for x and y. Its marked finite set Z consists
of the twelve unramified points over A=0.

## The infinite-degree reduction

If a nonpolynomial supported function omits a cubic character, choose
one with least pole degree, allowing either nonconstant character.
It cannot omit the constant character, since it would then vanish
at every cubic branch point. Dividing common polynomial content and
extracting a fifth root both preserve the relevant class, so the
minimal witness is primitive and not a fifth power.

The [three-conjugate ramification proof](two_character_supported_unit_bound.md)
shows that its pole is at most28. The ratio of two conjugates is
separating; its complete fibres over0,1,infinity are disjoint and each
has at most four points. Riemann--Hurwitz bounds the total degree.
The same proof counts the ten additional cubic branch contributions
for the character y^2 and excludes that possibility without computation.
Thus the witness has the form U+Vy, gcd(U,V)=1, and pole degree in
\[
10,12,13,15,16,18,19,21,22,24,25,27,28.
\]
At each occupied root of A it vanishes on exactly one cubic sheet.

## Exhaustive finite certificate

For each displayed degree n, enumerate compositions of n into four
nonnegative zero multiplicities and choose one sheet at each occupied
fibre. Rotation by arithmetic25th-power conjugation and a common cubic
phase reduce to the same complete representatives used in the
[pole16 proof](pole_sixteen_norm_exclusion.md). On every representative
impose the indicated vanishing jets on
\[
\{x^i:3i\le n\}\ \cup\ \{x^i y:3i+10\le n\}.
\]
Every resulting matrix has full column rank. These are exact geometric
linear systems: no restriction is placed on the unknown coefficients.
The counts, one nonzero square minor per system, are:

| Pole n | Systems |
| ---: | ---: |
| 10 | 961 |
| 12 | 1708 |
| 13 | 2134 |
| 15 | 3340 |
| 16 | 4147 |
| 18 | 5947 |
| 19 | 6967 |
| 21 | 9496 |
| 22 | 11032 |
| 24 | 14425 |
| 25 | 16255 |
| 27 | 20593 |
| 28 | 23128 |

The [generator](../../scripts/arithmetic/supported_one_sheet_jets.py)
constructs jets by the cubic coefficient recurrence. The
[independent verifier](../../scripts/arithmetic/verify_supported_one_sheet_jets.py)
uses exponentiation of truncated power series, checks all representative
indices and reconstructs exactly the certified minors, without pivot
selection. Both verify the field and marked-point data. All listed
systems and independent checks passed.

There is a field-size simplification, not a change of the geometry.
Choose alpha_0 among the four roots, alpha_i=alpha_0^(25^i), and
y_0^3=P(alpha_0). Then
\[
y_i/y_0=P(\alpha_0)^{(25^i-1)/3}\in\mathbf F_{5^8}.
\]
Dividing each character-y column by y_0 puts every matrix over F_(5^8).
The actual points may require F_(5^24); column scaling by a nonzero
scalar preserves rank over the full algebraic closure.

The [exact data directory](../../../litt3-computation-data/small_supported_jets_20260927/)
contains pole12,15,18,19 certificates and independent results at its root.
The remaining cases are in its
[two_character subdirectory](../../../litt3-computation-data/small_supported_jets_20260927/two_character/),
named poleN_char01.json and poleN_char01_verified.json. The executed
command lists are small_executed.json and executed.json there; they
also retain supplementary character02 checks, which are not needed
in this proof. Sage10.9 with Python3.14.3 was used.

For a listed n, generate with
`sage -python scripts/arithmetic/supported_one_sheet_jets.py n certificate.json --characters 01`,
then verify with
`sage -python scripts/arithmetic/verify_supported_one_sheet_jets.py certificate.json verification.json`.
For n<20 the default characters012 have exactly the same columns.

The full ranks exclude the least-degree witness. This proves the
unrestricted statement, including arbitrary polynomial content and
fifth powers of the original function. The argument does not exclude
the genuine three-character case, which is a separate problem.
