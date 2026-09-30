# Proof: separate the selected root from its two companions

[Statement](../../Theorems/cartier_and_spin/degree140_root9_companion_discriminant.md).
Retain all coefficients, source equations and old units of the
[root-nine cubic atlas](degree140_linear_cubic_cusp_exclusion.md).
Write a=a0-sd. Since f(u)=0 and u is a unit,
\[
a=-(bu^2+cu+e)/u^3,\qquad
f(U)=(U-u)\bigl(aU^2+(b+au)U-e/u\bigr).
\]
The discriminant of the quadratic factor is J/u^4 and f'(u)=-g/u.
The polynomial discriminant identity for a product gives
Disc(f)=g^2 J/u^6. This identity still holds at a=0; in homogeneous
coordinates it also detects roots at infinity. The new ramification
theorem makes g a unit modulo the complete square ideal. It therefore
leaves J=0 as the precise unresolved part over the base discriminant.

## The normalized companion curve

Direct calculation in characteristic five gives
\[
\operatorname{Disc}_u(J)=e^2 C,\qquad
(2\Delta_2u+3ce)^2-e^2 C=4\Delta_2J.
\]
The exact coefficient identity gcd(e,c)=1 implies e is a unit in the
J=0 ring with u inverted: modulo e, the equation is c^2u^2=0 and
both c,u are units. On C=0, b,c,e are units by the already verified
coefficient identities. Then J=0 forces u=2e/c=-c/b up to its
nilpotent thickening, which is the previously excluded triple-root
case. Thus C is a unit on this square quotient.

After the complete Delta2 boundary exclusion below, set
xi=(2Delta2u+3ce)/e. The inverse is
u=e(c+3xi)/Delta2. These are inverse ring maps, including nilpotents;
the equation becomes xi^2=C. Its smooth projective model has genus6
since C is squarefree of degree14. Both sheets are retained.

For comparison, a repeated root r on the original critical curve
b r^2+2cr+3e=0 has simple companion
\[
u=-er/(cr+2e),\qquad
r=-u(cu+e)/(2(bu^2+cu+e)).
\]
On b e Delta2 C invertible these are inverse maps and preserve the
same cubic value s. Indeed Norm(cr+2e)=-e Delta2/b and
Norm(cr+3e)=2e C/b, so the needed denominators and u-r are units.
With eta=br+c, one has eta^2=C and u=e(c+2eta)/Delta2.
Our xi is -eta. The formulas compare ratio coordinates, not square
residuals: no equivalence between squareness at r and at u is assumed.

## Complete boundary coverage with the scale retained

Delta2 is squarefree of degree14, with irreducible factor degrees1,3,10,
and is coprime to c,e,C. On Delta2=0 the equation J=0 becomes linear
and forces u=e/c. All original units hold on its14 geometric points.
The reconstructed ACTUAL tails C71,C72 satisfy polynomial identities
U(mu)C71+W(mu)C72=1 over every complete coefficient-field factor.
The scale is not specialized.

The polynomial b is squarefree of degree5, with factor degrees1,1,3,
and is coprime to c,e,C. Modulo b,
\[
J=(cu+e)(cu+2e).
\]
The roots u=-e/c and u=-2e/c are distinct and both satisfy all old
units and g invertible. Thus these are exactly ten geometric ratios,
with no missed branch at infinity. All six complete field/branch
blocks again have C71,C72 Bezout identity1. In particular the a=0,
b=0 projective double-root-at-infinity case is included here.

There are nine certificate blocks and24 geometric ratios in total.
Each finite q algebra is reduced; the two b-boundary roots are simple.
These identities prove(I,Delta2)=(1) and(I,b)=(1), so the new factors
are genuine units in the whole square quotient, also if that quotient
has nilpotents. No other q-factor becomes a unit by this calculation.

## Independent checks and exact data

[The universal Sage check](../../scripts/arithmetic/root9_companion_identities_20260928.sage)
uses independent formal variables and verifies the discriminant,
factorization, companion map, inverse and common cubic-value identities.
[The boundary generator/verifier](../../scripts/arithmetic/root9_companion_boundary_20260928.py)
reconstructs the source from the received exact Cramer circuit, verifies
all factor coverage and open conditions, and checks every identity by
multiplication. For the largest field in each boundary it also compares
all75 reciprocal coefficients against a separate full residual path.
The verification mode does not rerun extended Euclid.

Exact certificates, factor rows, coefficient Bezout identities and
executed checks are in
[the external evidence directory](../../../litt3-computation-data/root9_companion_local_20260928/).
The [integration audit](../../Research/audits/FROBENIUS_RATIO_COMPLETE_2026_09_28.md)
records commands and outcomes. The subsequent
[actual companion calculation](degree140_root9_full_discriminant_exclusion.md)
excludes the rest of this curve. The discriminant-nonzero part of the
root-nine square problem remains open.
