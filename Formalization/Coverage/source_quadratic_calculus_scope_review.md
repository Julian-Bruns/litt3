# Source quadratic calculus: exact scope readback

Status: COMPLETE after focused audit and final whole-source
readback of the aggregate theorem. This is not a
global common-cover claim.

Canonical statement Version1, 30 September2026:
`Theorems/cartier_and_spin/source_quadratic_calculus.md`.
Statement SHA256:
`1820c10b668b9524c6ab252c460bb8053f1df37e5f2365b10513b0bd0c498147`.
Proof SHA256:
`ac687f1cfb9989e3cceb23beee3bad08e7899bd3e75d83644dac70e17f9c3319`.

The original source is retained as the actual quotient `AdjoinRoot F`,
with F=(X^p+C q)H+C tau separable, tau nonzero and degree at least p.
Its actual denominator unit and compatible derivation are constructed.
No irreducibility, connectedness, simultaneous Galois closure or
critical-discriminant inverse is input. The root families used for local
clauses are the actual full source roots; they are not critical roots.

| Exact source clause | Checked formalization | Scope and remaining bridge |
| --- | --- | --- |
| Both complete coefficient-moment families, independently of source degree | `SourceTraceDescent.source_coefficient_moments` | Actual nonmonic, possibly disconnected quotient; no split hypothesis. |
| Linear differential moments | `UnsplitSourceEnergy.sourceQuotientDifferentialCalculus`; `SourceTensorConsequences.source_universal_tensor_calculus` | Actual compatible derivation and literal universal Ω traces. |
| Canonical center c/s and exact correction | `SourceTensorCenteredFormula.source_universal_centered_formula`; `AffineSourceRemainder.affine_source_remainder_center` | No split hypothesis; explicitly s nonzero. Actual transformed monic remainder supplies r'=ar+b. |
| Centered affine weight a^(2-p) | `SourceTensorAffineWeights.source_universal_centered_affine_weight` | Literal actual new quotient and genuine Sym² universal tensor; meromorphic a,b allowed. |
| Cleared R and exact weight N-3p+3, including s=0 | `AffineSourceClearedEnergy.source_frame_cleared_energy`; `SourceTensorAffineWeights.source_universal_cleared_affine_weight`; `SourceTensorCenteredFormula.source_universal_cleared_zero` | No center coefficient inverse in R. Zero boundary is proved separately. |
| E0=E1=0, all binomial moment translations and E2/discriminant invariance | `UnsplitMomentTranslation.sourceTraceZeroMomentTranslations`; `SourceQuotientMomentTranslation.source_quotient_moment_translation` | Entire law in the literal translated quotient; actually works already for p>=2. |
| Characteristic-five discriminant=3I and I invariance | `CharacteristicFiveMomentInvariant.functional_discriminant_eq_three_five_invariant`; `SourceQuotientFiveInvariant.source_quotient_five_invariant_translation` | Exact invariant in the literal new quotient; its literal new-quotient specialization is included in the final aggregate audit. |
| Degree-2p presentation, actual S coefficient c and Qaff weight | `DegreeTwoPSource`; `DegreeTwoPAffineEnergy.degree_two_p_source_affine_energy`; `SourceTensorAffineCorrections.source_universal_affine_correction_weight` | Degree and monic remainder are derived; κ,tau nonzero and deg S<=p-2; c may vanish. The genuine meromorphic tensor transition is exactly the source's corresponding tensor gluing law. |
| Both Qsharp square presentations | `SourceTensorConsequences.source_universal_tensor_calculus` | Actual universal Ω and genuine Sym² product/trace equalities. |
| Qsharp equation-normalization independence and boundary meromorphic translations | `SourceTensorInvariance` | Actual scaled/translated quotient equivalences and actual source denominator units; no scaling weight is asserted for Qsharp. |
| Qsharp local pole at most (p-3)/2 | `LaurentQuotientEndpoint` | Actual continuous Laurent derivative, original quotient trace and all full integral roots. No tau order, small-root count or H-degree condition. |
| Characteristic-five Qtilde identity and simple pole; c read as H coefficient or monic remainder | `CharacteristicFiveTensorCorrections`; `LaurentCorrectedEndpoint`; `LaurentCoefficientChangeEndpoint`; `LaurentQuotientEndpoint` | Actual source and actual Laurent orders; c/H difference is the actual monic quotient term. H-leading-unit assumption is not needed for this stronger pole theorem. |
| Exact degree-ten Qtilde weight a^-3 | `SourceTensorAffineCorrections.source_universal_degree_ten_corrected_weight` | Literal universal tensor in the actual changed quotient. |
| Endpoint e0 nonzero, exactly five small roots, e0*q3+tau3=0 and both quadratic jet sums | `CharacteristicFiveEndpointJets`; `LaurentEndpointJets.laurent_characteristic_five_endpoint_jets` | Actual full Laurent source, integral H and roots, unit leading H, q/tau exact order three. Repeated or zero leading jets retained; actual monic remainder c used. No e0/count input. |
| Constant translation removes q(0) | `ConstantSourceTranslation` | Actual algebraically closed residue field and literal power equation; translated coefficient and zero Laurent derivative proved. |
| Local regularity of R without s unit and Qaff under its integral hypotheses | `ActualSourceSubringIntegrality.actual_source_subring_integrality`; `SubringMonicRemainder` | Literal trace membership in an actual derivation-stable subring. Unit tau supplies actual factor inverses through the original root equation. |
| Boundary E2 and I integral and remain integral after meromorphic translations | `SourceBoundaryQuotientIntegrality.source_boundary_quotient_integrality` | Actual translated polynomial quotient; translated roots need not stay integral. Only original roots and source-factor inverses must lie in the actual subring. |
| Independence from the meromorphic differential coordinate | `SourceTensorFrameIndependence` | All actual source tensor expressions and both square presentations are independent of the chosen genuine Ω coordinate. |

`SourceSeparatingFunctionTensors` uses the root's actual
`separatingFunctionKaehlerCoordinate`: any supplied actual rational-function
subfield with separable extension constructs Ω's coordinate; the coordinate
itself is not an input. It also proves that any given derivation normalized
at the actual separating parameter equals that universal coordinate.
The root's actual coordinate construction passed its own focused audit,
`verification/20261003T032421Z/report.json` (145 transitive declarations,
standard three axioms, zero forbidden dependencies or source changes).
`OneVariableSourceTensors.one_variable_source_universal_calculus` now removes
the supplied separating subfield altogether. The root's
`OneVariableKaehler.one_variable_kaehler_coordinate_exists` derives the actual
coordinate from a perfect base, finite generation and transcendence degree
one, using Mathlib's separating-transcendence-basis theorem and an actual
polynomial/fraction-field construction. No accepted-literature existence
premise remains. Both the wrapper and the aggregate build successfully.
No project axiom, opaque conclusion assumption or rank-one Laurent Ω
assumption is introduced. Full algebraic Ω of k((u)) is not identified with
its continuous rank-one differentials; the local proofs use the actual
continuous Laurent derivative.

Focused audit `verification/20261003T032337Z/report.json` built eleven exact
source tensor/local roots and audited 838 transitive Litt3 theorem declarations.
Its only axioms are Classical.choice, Quot.sound and propext; zero forbidden
dependencies and zero source changes occurred. The newer separating-function wrapper, general one-variable-field wrapper
and literal new-quotient I specialization are included in the final aggregate
audit below.

`Specifications.SourceQuadraticCalculus` is the conjunction of thirty-one
explicit universally quantified mathematical clauses. Its proof
`SourceQuadraticCalculus.source_quadratic_calculus` assembles exactly the
checked actual source, tensor, boundary and local results above, including
the general one-variable-field coordinate construction. Its components
use the real nonmonic quotient, actual universal tensors, actual Laurent
orders and actual subring membership, rather than opaque named propositions.
The parent read the exact canonical statement and proof, this eighteen-clause
mapping and all thirty-one literal clauses, accepting their full scope.
Focused verification `verification/20261003T034758Z/report.json` built the
aggregate and audited 904 transitive Litt3 theorem declarations. The only
axioms are Classical.choice, Quot.sound and propext; zero forbidden
dependencies and zero source changes occurred. No accepted-literature
existence premise, numerical certificate or bounded scope is needed.

The source's tensor gluing clause asserts the meromorphic frame law
Qaff'=a^(2-p)Qaff and explicitly presumes no regularity across frame poles.
The genuine Sym² transition identity above covers that exact clause; the
source does not assert an additional Picard or line-bundle existence theorem.

The source statement expressly leaves global pole bounds and the unmarked
common-cover problem separate. No result here replaces either of its two
actual finite étale maps from the same source.
