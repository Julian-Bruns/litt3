# Differential-ratio joint field: exact current scope

Canonical statement: `Theorems/shared_tensors/differential_ratio_joint_field.md`,
Version2, SHA256 `9bdf2ebdf5f8f09e8ab1d38184ebcc44b8cbb40d2169ba4376789fd3e730b3f9`.
The full statement and proof were read on 3 October2026. Status is **partial**.

`CurveArithmetic.EmbeddedFields` proves that the actual compositum of two
subfields of the same ambient field has index dividing both actual indices.
Coprime actual indices make that compositum the whole field. Finiteness
over the constant field is not imposed; no normal closure is chosen.

`SharedTensors.CyclicFieldAmbiguities` proves that every automorphism of
an actual finite field extension has order dividing its actual degree.
This holds without separability or a Galois condition on that extension.
A cyclic power relation coprime to the actual degree forces identity;
the cubic/degree-five and quadratic/odd-degree cases follow.

The same module proves that an automorphism fixing the actual function q
fixes its entire actual generated subfield, including inverses. It
constructs the genuine automorphism over k(q) using the actual fixing
subgroup, and proves its power relation transfers. Thus the cyclic
obstruction requires only finite actual function degree; finiteness over
the constant field is not smuggled into that application.

`SharedTensors.FrobeniusCoordinates` uses the literal p-th-power subfield
and literal power bases of the entire actual field. `RationalCartierExact`
constructs coefficient extraction and proves that it kills every exact
differential, without truncation. `RationalCartierFormula` proves that
the standard intrinsic Cartier properties force this coordinate formula
and uniqueness on the actual universal differential module.

`RationalCartierBaseChange` derives actual separable field base change
from those properties and compatible literal p-bases. `DifferentialRatios`
proves that actual differential ratios are coordinate independent.
`CartierFieldRecovery.actual_cartier_differential_field_recovery` constructs
the actual Cartier ratio q and actual derivative ratio r, proves both
descend, and uses their coprime actual function degrees to prove that the
actual field inclusion is surjective. Neither descent nor field generation
is supplied as an assumption. Its generic formulation retains literal
compatible p-bases as inputs; the stronger one-variable formulation below
constructs them and the intrinsic operators.

The actual rank-one differential module for any finitely generated
one-variable field over perfect constants is constructed by
`OneVariableKaehler`, using Mathlib's separating-parameter theorem and
the genuine polynomial/fraction-field embedding. This is a field theorem;
it does not identify full algebraic Laurent differentials with continuous
Laurent differentials. Focused audit
`verification/20261003T034129Z/report.json` checks these actual Cartier
and one-variable roots and 182 transitive theorem declarations, with only
the standard three logical axioms and zero forbidden dependencies or
source changes.

`SeparatingPBasisExistence` constructs the actual p-basis from the actual
separating parameter, with minimal polynomial X^p-t^p.
`SeparablePBasisTransport` constructs its transport through every actual
separable extension, including infinite extensions, without finite generation
upstairs. `RationalCartierConstruction` constructs the actual additive map
on universal differentials; its kernel is exactly the actual exact forms
and it is surjective. `CartierBinomialPrimitive`,
`CartierFrobeniusDifferential` and `RationalCartierLogarithmic` prove full
logarithmic fixedness using an explicit uniform binomial primitive with
no division by p. They construct the intrinsic operator itself.
`OneVariableCartier` proves existence, uniqueness and parameter independence.

`OneVariableCartierRecovery.one_variable_cartier_differential_field_recovery`
proves actual field recovery from only downstairs finite generation,
transcendence degree one, perfect constants, the actual separable field
inclusion and coprime degrees of the two actual recovery functions.
No p-basis, normalized parameter, Cartier existence, descent or field
generation conclusion is input. The displayed coordinate expresses literal
differential ratios; its existence and independence are proved separately.
Focused audit `verification/20261003T041926Z/report.json` builds this root
and checks 260 transitive declarations with only standard logical axioms,
zero forbidden dependencies and zero source changes. The new intrinsic
construction also passed independent mathematical readback in
`Coverage/cartier_operator_independent_scope_review.md`.

The whole Laurent-field foundation is now checked separately.
`LaurentPBasisGeneration` constructs its full literal p-basis from entire
power-series residue digits and integer order shifts. `LaurentKaehlerCoordinate`
constructs the actual algebraic differential coordinate agreeing with the
Laurent derivation, over perfect coefficients in positive characteristic.
`LaurentIntrinsicCartier` proves the pn+p−1 coefficient formula at every
integer exponent and residue transport. `LaurentCartierRegularity` proves
preservation of the entire power-series differential lattice.
No finite-support, finite-generation or characteristic-zero extension is
asserted. Focused audit `verification/20261003T045038Z/report.json` checks
266 declarations with standard axioms only, zero forbidden dependencies
and zero source changes. Independent mathematical readback is in
`Coverage/laurent_cartier_independent_scope_review.md`.

`PBasisCartierTransport` proves actual intrinsic Cartier transport through
any inclusion with compatible full p-bases, without algebraicity.
`LaurentUniformizerCartier` derives the entire original field's coefficient
formula through any Laurent embedding taking its actual parameter to t.
`DVRIntrinsicCartier` applies this to the actual constructed DVR completion;
`DVRCompletionRegularity` proves that original regularity is equivalent to
full power-series membership via the actual normalized valuation.
`DVRCartierRegularity` therefore preserves the original DVR lattice R dt.
Neither completion charts, differential realization nor algebraicity or
separability of the completion is supplied. Focused audit
`verification/20261003T051617Z/report.json` checks 480 declarations with the
standard three axioms, zero forbidden dependencies and zero source changes.

`DVRRegularDifferentials` now identifies the original universal differential
image with the original parameter lattice, deriving derivative regularity
through actual full-field p-basis transport and exact valuation descent.
`DVRCartierDifferentials` preserves that original image. `SmoothLocalCotangent`
derives the actual rational-point cotangent fiber by the conormal sequence;
`SmoothLocalizationDVR` proves that the true smooth one-dimensional local
domain is a DVR. `SmoothCurveDVRStalks` applies this to every original closed
point of the actual smooth integral curve over algebraically closed coefficients;
`SmoothCurveCompletions` constructs its genuine residue-compatible parameters.
The smooth-to-DVR portion is characteristic independent. The rational Cartier
portion retains perfect positive-characteristic FG/trdeg1 field hypotheses.
Focused audit `verification/20261003T054411Z/report.json` checks 570 declarations,
standard three axioms only, zero forbidden dependencies/source changes.
Its independent source readback is recorded in
`Coverage/smooth_dvr_regular_cartier_independent_scope_review.md`.

`SchemeFunctionFieldGeneration` now derives finite generation of the true
generic field from an actual locally finite-type structure morphism. True
smooth relative dimension n over perfect coefficients gives true generic
transcendence degree n through the actual universal differential rank.
`SmoothCurveCartier` therefore constructs the original smooth curve's
intrinsic rational Cartier operator and preserves the literal intersection
of original closed-stalk universal differential images. Its genuine additive
restriction has constant pth-inverse semilinearity and kernel exactly
rational exact forms. No supplied generic FG/trdeg, local DVR, parameter,
coefficient coordinate or stable-lattice hypothesis remains. This is not
yet an H0 identification with the actual differential sheaf, and no global
Cartier surjectivity is asserted. Focused audit
`verification/20261003T060427Z/report.json` checks 623 declarations, standard
three axioms only, zero forbidden dependencies and source changes. The
complete six-module independent readback is in
`Coverage/scheme_function_field_global_cartier_independent_scope_review.md`.

Remaining clauses include the trigonal/hyperelliptic
function-degree and nonvanishing statements,
the actual Kummer automorphisms and their endpoint restrictions, actual
joint normalization preserving both original étale maps, genera/divisors,
spin sections and selected-family computations. The field lemmas alone
do not provide these geometric clauses or exclude a common cover.
