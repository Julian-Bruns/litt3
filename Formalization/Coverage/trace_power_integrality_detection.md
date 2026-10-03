# Trace power integrality clause mapping

Canonical Version 3 snapshot:
`Theorems/cartier_and_spin/trace_power_integrality_detection.md`, SHA256
`4e6b332700408f644b684e87d20759783b78893c4f1af25cbb9a6e9acf2d72cf`.
Status is `complete` for this exact Version3 snapshot. The proof SHA256 is
`e0f0506c68f7855d2b5c6961975735d76855b6f76649f13cd3a88a48ad24fff9`.
The independent [full-source review](trace_power_integrality_detection_scope_review.md)
accepts all clauses, including actual normalized DVR orders. Focused audit
`verification/20261003T011428Z/report.json` checked 226 transitive project
declarations using only standard logical axioms, with zero forbidden escapes
or source changes. Any canonical source or proof hash change invalidates this
snapshot's promotion. All clauses are imported by
`Solutions.CartierAndSpin.TracePowerIntegralityDetection`.

The weighted criterion is proved in a stronger intrinsic form for arbitrary
actual valuation rings and their fraction fields. `ValuationIntegrality`
uses an actual valuation, the actual residue field, and finite counts of
the maximal-value fiber conditional on there being an actual pole.
`ValuationRingIntegrality` constructs the integer-ring hypothesis for the
canonical fraction-field valuation and states both the moment assumptions
and the conclusion as actual descent through `algebraMap R K`.

`CohortPowerSums` evaluates the genuine general Newton identity at a finite
family over any commutative ring. For the cohort contradiction only the
top elementary symmetric function is needed: m times the product of the
nonzero entries is zero, impossible when m is nonzero in the domain.
`WeightedCohorts` separates each cohort by Vandermonde injectivity.
`SupportWeightedCohorts` constructs the actual distinct-weight labeling
from the intrinsic support counts, preserving repeated entries.

`ValuationLeadingMoments` scales by an actual maximal-valued entry, obtains
actual representatives in R, and proves zero residue of every scaled
regular moment. The nonzero scaled residues are exactly the maximal-pole
fiber; a maximal entry scales to one. No formal Laurent expansion or
leading-coefficient hypothesis is assumed.

`EqualPoleCounterexample` proves the cohort restriction is sharp in every
equal-characteristic-p valuation integer ring that has an actual pole:
p equal entries give zero weighted moments for every pair of exponents,
and the tuple has an entry outside R. The theorem explicitly requires p>0.

The full reciprocal degree-2p clause is proved in
`ReciprocalBoundaryConclusion`: actual unit descent or the actual exhaustive
p/p pole-zero partition, reciprocal values, constructed integer
representatives with equal normalized leading residues, and
v(e_p)=v(max)^p>1. `CharacteristicBoundaryCohort` proves equal entries from
the first p−1 power sums through the actual root polynomial and injective
Frobenius. `MaximalSymmetricValue` proves the exact dominant elementary
coefficient identity without characteristic or degree restrictions.

`NewtonCarryCriterion` proves the exact necessary and sufficient
arbitrary-degree carry criterion and its degree-2p+r short list. The Newton
induction is in the actual local ring and uses only residue characteristic,
so it covers mixed characteristic. The reciprocal elementary identity is
proved by actual finite-subset complement; the final integrality argument
uses dominant maximal-pole products, with no assumed integral-closure step.
All natural integers prime to the residue characteristic are proved units.

`IntegralCriticalCohorts` proves the actual residue-derivative degree and
cohort multiplicity bounds without requiring distinct reduced roots or a
unit derivative leading coefficient. `IntegralFirstTraces` gives the
actual first-power trace formula by integral monic division in every
finite degree and for arbitrary integral numerator degree.

`IntegralCriticalModel` assembles the actual quadratic presentation,
derives its factor units and monic derivative, and proves the exact nine
characteristic-five higher-power tests are equivalent to actual quotient
value descent. The result is stronger than the degree-ten application:
the finite split degree and integral numerator degree are unrestricted.
The residue characteristic is derived from the characteristic of R.

`IntegralSplitOrder` embeds the genuine monic polynomial quotient into
the actual integral product algebra and identifies its image with the
actual singly generated order. `IntegralSplitConductor` proves the actual
Mathlib conductor formula, using integral monic remainders and the actual
derivative denominator. `IntegralCriticalConductor` converts the actual
model's unit factors and proves the exact nine tests are equivalent to
the actual quotient class lying in the actual conductor ideal.
`CarryOmissionCounterexample` constructs the carry omission tuple with
actual norm one, every forward and reciprocal trace regular, and e_p
nonregular. `TraceOmissionCounterexample` isolates every individual extra
trace P_(p+i) using an actual primitive-root orbit, retaining e_p and all
other hypotheses. `PrimitiveRootPowerSums`, `TraceOmissionPolynomial` and
`BlockPolynomialCoefficients` prove the exact orbit sums, actual root
polynomial and coefficient formula symbolically.

`PowerSeriesSharpness` realizes all three sharpness families in the actual
power-series DVR k[[X]] and its actual Laurent fraction field. It proves an
actual uniformizer inverse is a pole and derives primitive-root existence
over every algebraically closed characteristic-p coefficient field.
No global source pole bound or source exclusion is claimed.

The full-source review mapping is:

| Canonical clause | Actual proved declaration and module |
| --- | --- |
| Maximal-pole weighted trace criterion, arbitrary total degree and other residue groups | `valuationRing_weightedPowerTraceIntegrality`, `ValuationRingIntegrality` |
| p equal poles show r<p is necessary | `powerSeries_equal_pole_counterexample`, `PowerSeriesSharpness` |
| Unit tuple below degree 2p, or exhaustive p/p boundary at degree 2p | `valuationRing_reciprocalTraceBoundaryOutcome`, `ValuationRingNewtonDetection`; its `ReciprocalTraceBoundaryOutcome` specification |
| Each cohort's leading coefficients agree and e_p has exact pole pM | `dvr_normalized_reciprocal_boundary`, `NormalizedDVRBoundary`, explicitly gives integer orders −M and M with M>0 and exact order(e_p)=−pM, preserving actual normalized ratios with residue one |
| A regular e_p excludes the degree-2p boundary | `reciprocal_power_traces_and_carry_force_units`, `ReciprocalBoundaryConclusion` |
| Arbitrary-degree carry iff, including mixed characteristic | `valuationRing_newtonCarry_unit_iff_conditions`, `ValuationRingNewtonDetection` |
| Exact 2p+r extra list and degree-eleven/characteristic-five specialization | `valuationRing_newtonCarry_unit_iff_short_conditions` and `valuationRing_degree_eleven_char_five_unit_iff`, `ValuationRingNewtonDetection` |
| e_p is individually indispensable even with every power trace retained | `powerSeries_carry_omission_counterexample`, `PowerSeriesSharpness` |
| Every individual extra trace is indispensable with all other data retained | `powerSeries_higher_trace_omission_counterexample`, `PowerSeriesSharpness`; explicit witness proposition `OmittedHigherTraceWitness` |
| Integral characteristic-five cubic model, repeated critical roots, nonunit derivative leading coefficient | `integral_characteristic_five_cubic_criterion`, `IntegralCriticalModel`; actual residue multiplicity bound in `IntegralCriticalCohorts` |
| k=1 traces are automatically integral by the displayed coefficient formula | `integral_first_power_trace_formula` and `integral_first_power_trace_regular`, `IntegralFirstTraces` |
| Actual quotient order and conductor interpretation | `integralSplitQuotientMap_injective` and `integralSplitQuotientMap_range`, `IntegralSplitOrder`; `integral_characteristic_five_cubic_tests_iff_conductor`, `IntegralCriticalConductor` |

Hypothesis bridges are explicit. The valuation-ring wrappers construct
the integer-ring property of the canonical fraction-field valuation and
derive its norm value from actual descent as a unit. Cubic-model units
are `Rˣ`; the canonical unit elements are represented by their associated
units. The split polynomial is the actual product of the actual integral
root family, and the hypothesis is separability of its actual scalar
multiple mapped to K. The source's degree-ten and degree-less-than-ten
numerator scope is contained in the stronger arbitrary finite-degree and
arbitrary integral numerator statements. `S.natDegree≤4` implies the
actual nonzero reduction of S' has degree at most three.

`NormalizedDVRBoundary` proves the literal additive-order specialization.
It constructs the actual height-one valuation at the DVR's maximal ideal,
proves that the original DVR is its actual integer ring, and proves that
an actual irreducible uniformizer has integer order one. The integer-order
function agrees on every field unit with the actual additive homomorphism
`Jacobians.valuationOrder`.
The complete boundary states M>0, exactly p entries of order −M and p
entries of order M, no other entries, equal normalized leading residues
in each cohort, a nonzero actual e_p and exact order(e_p)=−pM. Every tuple
entry is proven nonzero from the actual unit norm; the auxiliary function's
irrelevant value at zero is never used as an order. The general valuation
theorem remains available without discreticity.

The final admissible-source application supplies exactly the local model
inputs when w is integral, v and t are units, and the nonzero residue D
condition holds; tau=t^3 is then a unit. No conclusion is made at the
selected endpoints, nonintegral charts, zeros of v, or zero residue D.
The local algebra statements introduce no replacement maps or sources.

The complete entry point and every listed component build passed. All proofs use
only imported kernel-checked Mathlib and symbolic algebra; there are no
project axioms, admissions, external certificates or native evaluation.
