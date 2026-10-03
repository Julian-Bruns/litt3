# Proof: boundary automorphisms and direct smooth reductions

[Combined atlas theorem](../../Theorems/curve_arithmetic/backup_characteristic_zero_atlases.md).
Use the [exact model theorem](triangle245_model_space.md), including
its converse and its independent count of $236$ geometric models.
Its notation $B,C,F,s$ is retained; the source curve is $y^2=xF$.

## Exact completeness is an established input

The [number-field verifier](../../scripts/orbifolds/verify_triangle245_parametrization.py)
checks every original equation, square identity and open condition,
with a separating parameter. Its five \(C_3=1\) fields have degrees
2,3,3,6,42; the \(C_3=0,C(0)=1\) fields have degrees2,4,6.
Four distinct scalings of the first56 models, plus the twelve boundary
models, exhaust the independent count236 in the model theorem.
No modular solver status or characteristic-zero ideal degree is used.

The exact summaries are
[open chart](../../../litt3-computation-data/triangle245_models_20260921/rational_c0_long/verification_summary.json)
and [boundary](../../../litt3-computation-data/triangle245_models_20260921/rational_c3_zero/verification_summary.json).
The source equations are reconstructed by the
[equation generator](../../scripts/orbifolds/triangle245_square_factor_models.py).

## The boundary is excluded before reduction

The exact boundary verification gives \(B_1=B_3=C_1=0\), with
\(C_3=0\). Thus B,C and A are even; their square identity makes F
even. The smooth curve \(y^2=xF(x)\) consequently has the order-four
automorphism
\[
(x,y)\longmapsto(-x,\iota y),\qquad \iota^2=-1.
\]
Its square is the hyperelliptic involution. This contradicts
\(\operatorname{Aut}(C)=C_2\) from the backup specialization filter.
All twelve boundary models are excluded, without any invariant
minimal-polynomial calculation or good-reduction assertion.

## Every place of an open-chart model is covered by a small residue test

For each of the five verified \(C_3=1\) model fields, choose the
displayed generator theta. Its monic defining polynomial and all
coefficients of F in the theta power basis are integral at five.
At ANY place over five, theta therefore has a residue satisfying
one of the irreducible factors of that polynomial modulo five.
The reduced curve coefficients are the corresponding polynomial
evaluations. This covers every place even if the power basis is
not a maximal order: we use the residue of the integral generator,
not a Dedekind factorization assertion.

The [direct checker](../../scripts/orbifolds/check_triangle245_reduction.py)
verifies these integrality claims and that \(I_{10}\ne0\) at
every residue factor. In Sage's normalization,
\(I_{10}=F(0)^2\operatorname{disc}(F)/16\).
Thus the displayed hyperelliptic curve has smooth genus-two
reduction there. The factor degrees are:

| Model field degree | Residue-generator degrees, with multiplicities |
| --- | --- |
|2|1, multiplicity2|
|3|1, multiplicity3|
|3|1, multiplicity3|
|6|2, multiplicity3|
|42|3,6,8, with multiplicities2,2,3|

These are degrees of the fields containing the REDUCED COEFFICIENTS,
not claimed residue degrees of the number fields. When a degree d
in this table is not divisible by3, the source's moduli orbit divides
d and cannot equal the backup's orbit of length3. Only the degree3
and degree6 factors of the final field need a further test.

Use the absolute invariant \(j_*=I_4^5/I_{10}^2\).
Its formulas are integral at five and its denominator is a unit on
these smooth reductions. The
[backup calculation](../../scripts/orbifolds/backup_reduction_invariant.py)
gives
\[
j_*(Y)=2\alpha^2+3\alpha+4,\qquad
m_Y(J)=J^3+2J^2+2J+2.
\]
The retained exact residue checks give \(m_Y(j_*)\ne0\) on both
remaining factors. Hence no reduced curve is isomorphic to Y.
A matching invariant would be only necessary; no converse is used.

The [executed open-chart receipt](../../../litt3-computation-data/triangle245_models_20260921/rational_c0_long/independent_mod5_check.json)
records all five integrality tests, all seven discriminant units
and the invariant exclusions. No characteristic-zero invariant
minimal polynomial is needed. Those original polynomials remain
as external evidence; their source algorithm is retired.

This argument uses actual smooth reductions of the source models,
then stable-model uniqueness for any potentially good geometric
copy or twist. It assumes no good reduction of the triangle map.
One boundary family has ordinary potential reduction, so neither
the automorphism argument nor the open-chart test is replaced by
a claim that every triangle245 source reduces supersingularly.
