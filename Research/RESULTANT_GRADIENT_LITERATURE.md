# Resultant and Bezout literature: retained primary references

2026-09-07. The global gradient identity and cohomological Bezout matrix
are now proved and independently audited in the canonical library.
The former speculative conormal template has been removed as superseded.
Use `resultant_gradient_atlas` and `cohomological_bezout` for the actual
proofs; this file records only literature placement and scope.

[Laurent Buse, *Determinantal resultant*](https://arxiv.org/pdf/math/0209404),
Theorem2.1, Section3 principal case, Theorem4.4 and Remark4.5:
length-two separation gives irreducible incidence and a reduced resultant;
the principal Koszul case is characteristic-free. The general Lascoux
resolution elsewhere requires characteristic zero and is not imported.
The relevant incidence and determinant proof steps were read. Our direct
Cech proof supplies the particular matrix and its exact corank.

[Eisenbud--Schreyer, *Resultants and Chow forms via Exterior Syzygies*](https://arxiv.org/pdf/math/0111040),
Theorems1.2--1.4 and Section4: Chow complexes compute a derived incidence
pushforward, and their determinants recover resultant divisors. Acyclic
sheaves on curves give small Bezout formulas. The relevant proofs were
read; the mechanism supports our construction, without asserting that
their stated examples are the genus-nine oper calculation.

[Bielawski, *Nonnegative polynomials from vector bundles on real curves*](https://arxiv.org/pdf/1208.6456),
Section2: complex-curve resultant conormal geometry. Useful context,
but its complex biduality statement is not a characteristic-five input.

[Laszlo--Pauly, *The Frobenius map, rank2 vector bundles and Kummer's quartic surface in characteristic2 and3*](https://math.univ-cotedazur.fr/~pauly/kummer23.pdf),
Theorem6.1(2): an exact Frobenius-polar precedent in genus2,
characteristic3. Its proof uses the special Heisenberg/Kummer equations;
it does not transfer to genus9 or characteristic5.

The bounded review found no published theorem directly identifying our
oper retraction with the resultant gradient, nor an atlas-emptiness
result. These references explain mechanisms, not a common-cover solution.
