# Critical additive translation clause mapping

Canonical Version2 statement SHA256:
`225526c5fb65ecedcb67f1bce1aeafa6a66274610a22306cb7e73260e3f3042c`.
Proof SHA256:
`3558fd88a1583b2cb297ea6098c4dafbb1caf0eafbec626382ebda5a5bbb6f9e`.
Status is `complete`: independent root readback accepts every literal
Version2 clause. The canonical clarification records constants k× for the
local boundary and all scalars in K(z) for the algebraic package.
The full literal actual-source aggregate is
`Solutions.CartierAndSpin.AnnihilatorCriticalTranslationSource` with its
quantified proposition in `Theorems.CartierAndSpin.AnnihilatorCriticalTranslation`.
The earlier actual-field aggregate is
`Solutions.CartierAndSpin.ActualCriticalTranslationPackage`.
Focused audit `20261003T052408Z` checked both roots and 280 transitive
declarations: standard three axioms only, zero forbidden dependencies and
zero source changes.

The generic foundation `separable_quotient_low_residue_trace` proves actual
Tr(J(W)/F′(W))=0 when deg J<deg F−1, in the original actual separable
polynomial quotient. It constructs the derivative unit from Bezout
separability, constructs the simple-root splitting equivalence after an
actual algebraic-closure extension, proves interpolation there, and descends
the actual trace injectively. F may be nonmonic, unsplit or disconnected;
its actual leading coefficient need only be nonzero.

`critical_trace_translation_degree_ten` derives the two actual denominator
units from F′=phi*D, proves the needed lower trace moments from the real
degree bounds deg D≤3 and deg U≤5, and proves exactly the five canonical
translation invariants in characteristic five. No lower-moment vanishing
or desired translation invariant is an input. The scalar-extension theorem
does this over every actual coefficient-field extension, hence over K(z).

`powerBasisRawQuotientEquiv` constructs an equivalence to any actual primitive
algebra from its actual power basis and raw minimal polynomial
F=C(v)*minpoly(W), v≠0. `critical_trace_translation_power_basis` then gives the
five trace invariants in that actual algebra for its actual u satisfying
U(W)=uD(W). It proves that the given u equals the unique quotient U/D.
This supplies actual trace transport rather than merely a root-sum analogy.

The explicit `criticalQuadraticFromMoments` is the canonical cubic-critical
formula from `admissible_critical_quadratic_incidence`:
constant coefficient v*rho²−δ₃μ₂−δ₂μ₁−δ₁μ₀, linear coefficient
−δ₃μ₁−δ₂μ₀, quadratic coefficient −δ₃μ₀. Actual trace invariance proves
its polynomial invariance. The actual numerator equation after translation
is proved exactly; the two changed formal resultants retain degrees 3/5
and 3/2. Res(F,D) retains its identical inputs. No discriminant of D is
assumed or inverted, and degree drops are retained.

The selected-point boundary is an actual DVR theorem. Its actual
maximal-ideal height-one valuation is normalized by order one on an
irreducible uniformizer. An actual element of order two minus an actual
R-unit is proved to descend as an R-unit, remain nonzero and have order
zero. Every nonzero constant-field scalar automatically supplies this unit
input. Thus a prescribed local double zero is lost on the same local field.

| Canonical clause | Checked implementation |
| --- | --- |
| Actual trace-dual interpolation, arbitrary leading coefficient | `separable_quotient_low_residue_trace`, `SeparableResidueTrace` |
| Five traces invariant without lower-moment assumptions | `critical_trace_translation_degree_ten`, `CriticalTraceTranslation` |
| Extension to K(z) | `critical_trace_translation_degree_ten_scalar_extension`, `CriticalTraceTranslation` |
| Actual original primitive-source trace | `critical_trace_translation_power_basis`, `PowerBasisSourceQuotient`; actual raw-polynomial quotient equivalence constructed |
| Actual U_z(W)=u_z D(W) | `quotient_numerator_translation_value`, `CriticalQuadraticTranslation`, together with `numerator_equation_value_unique` |
| Explicit critical Q invariant | `critical_quadratic_translation_of_trace_outcome` and `algebra_critical_quadratic_translation`, `CriticalQuadraticTranslation` |
| Fixed formal resultants invariant with repeated roots/degree drops | `critical_quadratic_resultants_translation_of_trace_outcome`, `CriticalQuadraticTranslation`; generic `criticalResultantTranslationInvariant` |
| Exact transformed polynomial identity | `criticalSquareTranslation`, `CriticalTranslation`, takes the original displayed identity as input |
| Nonzero scalar loses every old finite double zero | `dvr_nonzero_scalar_translation_zero_order`, `SelectedTranslationBoundary` |

`primitive_field_power_basis` now constructs the actual basis from literal
K(w)=L and F(w)=0. Matching polynomial and actual extension degrees derive
the raw minimal-polynomial identity. Neither is an aggregate input.
`rational_constant_generator` constructs the generator in literal
RatFunc L/RatFunc K; `primitive_rational_field_trace_constant_extension`
proves its trace compatibility. All five rational-extension traces and
the literal Q coefficient-extension identity are checked there.

`scheme_selected_double_zero_translation` uses an actual integral Scheme,
its actual function field, actual closed point and actual stalk. It
constructs the actual unit germ representing u-z and proves order zero.
`smooth_curve_selected_double_zero_translation` now derives the DVR class
from the actual smooth structure morphism of relative dimension one over
the algebraically closed constant field. Its stalk and generic scalar maps
come from that same structure morphism. Neither a DVR class, compatible
algebra structure nor scalar tower is an input. The aggregate also proves
that a nonempty collection of old selected double zeros cannot all remain
double zeros after such a nonzero constant translation.

The local scalar scope is exactly the nonzero constant field k. The
algebraic identities hold for every scalar in literal K(z), including its
independent indeterminate. An arbitrary nonzero element of K=k(X) may
have positive order at the selected point and need not destroy a double
zero; no such false local claim is made. This interpretation of the
canonical phrase “nonzero scalar” is now explicit in Version2 and accepted
in the [independent scope review](../../Research/audits/CRITICAL_TRANSLATION_SCALAR_SCOPE_2026_10_03.md).

`independent_rational_critical_translation_package` constructs the actual
primitive generator, extension degree and presentation after literal
RatFunc extension, then proves every algebraic clause for all scalars in
RatFunc K. Focused audit `20261003T054150Z` checked it together with the
smooth selected-point specialization: 340 declarations, standard three
axioms only and zero forbidden dependencies or source changes. The new
whole aggregate passes focused audit `20261003T055358Z`: 345 transitive
declarations, standard three axioms only and zero forbidden dependencies
or captured-source changes. The evidence is
[the focused report](../../../litt3-computation-data/formalization-20261003/verification/20261003T055358Z/report.json).
The transformed identity is proved from the original
displayed critical identity, whose separate derivation is not supplied by
the translation modules. No reciprocal-trace equation, admissible
deformation, source existence or source exclusion is asserted.

All listed proof modules build. The proofs use symbolic interpolation,
trace transport, degree inequalities and actual local-ring operations;
there are no external certificates or numerical root computations.
