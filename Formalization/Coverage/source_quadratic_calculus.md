# Source quadratic calculus: checked clauses and remaining scope

Canonical source: `Theorems/cartier_and_spin/source_quadratic_calculus.md`,
Version 1, SHA256
`1820c10b668b9524c6ab252c460bb8053f1df37e5f2365b10513b0bd0c498147`.
The exact Version1 source record is COMPLETE after whole-source review and
focused aggregate verification `verification/20261003T034758Z/report.json`: 904
transitive declarations, standard three axioms only, zero forbidden dependencies
and zero source changes.

The complete coefficient-moment clause is proved by
`SourceTraceDescent.source_coefficient_moments` and the prove2me proposition
`Specifications.SourceCoefficientMoments`. For any characteristic-p field,
p ≥ 2, actual separable F=(X^p+q)H+tau, tau nonzero and degree F ≥ p,
the theorem constructs an actual unit representing phi in K[X]/(F) and proves
Tr(w^j/phi)=0 and Tr(w^j/phi²)=j*s_(p-j)/tau for every j<p, including j=0.
There is no splitting, connectedness, irreducibility or degree-2p assumption.

The proof constructs the complete simple-root product in an algebraic closure,
identifies the actual split quotient with its product algebra, and proves trace
compatibility under coefficient extension using the concrete quotient power
bases. Both families then descend through the injective coefficient-field map.
The residue calculation uses Lagrange interpolation and polynomial division;
all numerator-degree bounds are derived from the source equation.

`SourceDerivation.separable_polynomial_quotient_derivation_exists` and
`separable_polynomial_quotient_derivation_unique` construct the unique extension
of every actual base derivation to the actual quotient. These foundations are
broader: the coefficient ring may be any commutative ring, with separability
expressed by an actual polynomial Bezout identity. `DerivationTrace` proves
Tr(E(x))=D(Tr(x)) on arbitrary finite free commutative algebras by canceling the
two finite connection sums.

`UnsplitSourceEnergy.sourceQuotientDifferentialCalculus` proves the full first
differential-moment family and both twisted-square presentations as actual
quotient traces for every base derivation in odd characteristic. The unit,
quotient derivation, trace compatibility and inverse-square moment are supplied
internally. Its companion proposition contains the exact expressions and
hypotheses. This formalizes the arbitrary-derivation specialization of the
canonical differential assertions. The shared universal-differential foundations
identify these scalar evaluations with genuine Kahler/symmetric coordinates,
as described below. The complete source moments and both twisted-square
presentations now have literal universal tensor consequences.

`UnsplitMomentTranslation.sourceTraceZeroMomentTranslations` proves the full
actual quotient-trace derivative moment translation law and trace-zero
quadratic/discriminant invariance, including the unchanged denominator identity
under w'=w+b, q'=q-b^p. The two vanishing moments follow from the actual source;
the result holds already when p=2. Its `LinearMoments` foundation applies to
every actual linear functional on any commutative algebra.

`CenteredEnergy` proves the split affine-center correction and its cleared
zero-coefficient boundary. Its extra split-root hypothesis remains explicit.

The new `AffineDifferentialEnergy` foundation proves the complete affine
derivative-square expansion for every actual linear functional on a
commutative algebra with compatible derivations. Its
`actual_centered_trace_moments` proves the centered second and cross moments
by actual trace differentiation. `functional_centered_energy_ratio` proves
the center correction directly in every actual algebra.
`source_quotient_centered_affine_scaling` obtains the needed moments from
the original separable source polynomial and proves the exact weight
a²/a^p for centered coordinates aW+b−(a*r+b). The scaling and translation
coefficients may vary under the derivation. No split source is assumed.

`AffinePolynomialCoefficients` proves top and next affine-substitution
coefficients in every degree over arbitrary commutative rings, retaining
degree drops. Its characteristic-p specialization proves the actual
remainder coefficient ratio transforms as a*r+b.
`AffineSourceRemainder` proves that this is the remainder of the actual
transformed source presentation, with q'=a^p*q−b^p,
tau'=a^N*tau and H'=a^N/a^p*H((W'−b)/a). It preserves all coefficient
boundaries; only the coefficient s used as the ratio denominator must
be nonzero.

`AffineSourceQuotient` constructs the actual quotient-algebra equivalence
for F'=a^N F((W'−b)/a), mapping the new root to aW+b. This broader
foundation needs only a≠0, and needs no separability, irreducibility or
degree equality. `DerivationTransport` constructs actual conjugated
derivations and proves their round trip. `AffineTraceTransport` constructs
the new derivative and scaled denominator unit and transports the
centered energy identity through every actual algebra equivalence.
`AffineSourceCenteredEnergy.source_frame_centered_energy` now combines these
bridges into the literal transformed source-quotient centered-energy law.
`AffineSourceCoefficientWeights` proves the precise individual coefficients
s'=lambda*s, c'=lambda*(a*c+b*s), lambda=a^N*a/a^(2p).
`AffineSourceClearedEnergy.source_frame_cleared_energy` proves the literal
cleared R weight a^(N-3p+3), without inverting s and retaining s=0.

`DegreeTwoPSource` derives the exact degree 2p and remainder S from the
original presentation. `DegreeTwoPAffineEnergy` then proves literal Qaff
covariance with weight a^(2-p), including c=0 and arbitrary meromorphic a,b.
`DegreeTenCorrectedAffineEnergy` proves the exact characteristic-five Qtilde
weight a^-3. These results transport the actual quotient derivation and
denominator unit, with the transformed polynomial presentation explicit.

`SourceNormalizationEnergy` proves Qsharp unchanged under any nonzero
meromorphic equation scale t, through the actual unchanged quotient ideal
and actual scaled remainder. `SourceTranslationTwistedEnergy` proves literal
Qsharp invariance under all meromorphic source translations when s=0.

`LaurentDerivation` proves the actual Leibniz rule for the formal derivative
on the whole Laurent-series field, including infinite positive tails, and
constructs its actual differential-field derivation. `LaurentEndpointBounds`
proves that a lower order bound divisible by the characteristic is preserved
by differentiation, with zero derivatives retained through `orderTop`.
The product, quotient and finite-sum order bounds use the actual valuation.

`LaurentTwistedEndpoint` proves the corrected summand has pole at most
(p−3)/2 for every integral actual Laurent root when q has exact order
(p+1)/2. `SplitDerivationEvaluation` proves every actual root evaluation
commutes with the actual extended source derivation. Thus
`LaurentQuotientEndpoint.actual_source_laurent_endpoint_objects_exist`
constructs the denominator unit and extended derivation and proves the
bound for the literal actual quotient trace. No tau order, source-root
count or leading coefficient unit of H is assumed.

`LaurentIntegralPolynomials` descends integral coefficients to the actual
power-series polynomial ring and proves monic source remainders and quotients
integral. In characteristic five, `LaurentQuotientEndpoint` proves the full
corrected Qtilde literal-trace simple-pole bound when q and tau have order
three and H has integral coefficients. `LaurentCoefficientChangeEndpoint`
and its actual-trace bridge prove the same bound when c is instead H.coeff 3;
the difference from the remainder coefficient is proved divisible by q.
These results cover the local Laurent algebra specializations; identification
with actual curve completions and universal symmetric tensors remains explicit.

`PowerSeriesEndpointRootCount` derives H(0) nonzero, the exact number of
small-root indices and the first endpoint relation from the original full
split source. The foundation works in every characteristic, for any
0<m<p with q vanishing below m and tau_m nonzero. `PowerSeriesNodalBounds`
uses the shared exact uniform-root valuation bound to retain zero roots
and repeated residue roots. `PowerSeriesFactorCoefficients` proves the
triangular coefficient argument modulo any parameter power.

`PowerSeriesEndpointJets` derives both quadratic jet sums by the actual
small-root polynomial and Newton's second identity over commutative rings.
The generic jet statement needs only 2 nonzero. Its canonical specialization
`CharacteristicFiveEndpointJets.characteristic_five_endpoint_jets` has exact
q,tau orders three, the source unit leading coefficient of H and the actual
monic-remainder coefficient c. It proves exactly five small-root indices,
e0*q3+tau3=0, sum(a_i²)=0 and sum(a_i*b_i)=-q3*c(0)/e0. No distinctness
of residue roots or leading coefficients is required. `ConstantSourceTranslation`
chooses an actual constant b with b^p=q(0) over algebraically closed k,
proves the exact translated coefficient q-q(0), and proves its Laurent
derivative is zero.

The shared `SourceUniversalDifferentials` module proves the actual separable
nonmonic original quotient is finite and etale, identifies its constructed
derivation with the actual universal-differential coordinate, and identifies
the actual weighted symmetric trace product with the scalar source energy.
`EtaleSymmetricTrace` constructs a frame-independent trace on the genuine
symmetric tensor quotient, over commutative rings without inverting two.
`EtaleDifferentialTrace` supplies the corresponding actual linear trace,
its frame independence and weighted derivative-coordinate identity.
The root's focused audit of `SourceUniversalDifferentials` and
`UniformRootValuationBounds` checked 194 transitive declarations with only
the three standard axioms and no forbidden dependencies or source changes;
its evidence is `verification/20261003T024116Z`. The separate differential
trace audit checked 129 declarations, with evidence `verification/20261003T024630Z`.

`SourceTensorConsequences.source_universal_tensor_calculus` explicitly applies
those genuine equivalences to the original source. Its prove2me proposition
`Specifications.SourceUniversalTensorCalculus` constructs the actual denominator
unit and proves the whole linear universal-differential moment family and
both Qsharp presentations as actual Sym² tensor-trace equalities. These are
literal tensor equalities, rather than scalar formulas renamed as tensors;
the source algebra remains the original nonmonic, possibly disconnected quotient.
This new module was created after the 02:55 frozen checkpoint and is outside
that earlier snapshot; it is included in the final aggregate audit.

`LaurentEndpointJets.laurent_characteristic_five_endpoint_jets` now proves
the endpoint identities directly for the actual Laurent-series source.
It descends the integral coefficients and roots through the actual
power-series embedding, preserves their exact orders and every needed
coefficient, and transfers the actual monic remainder. No extra e0 or
small-root count hypothesis is supplied.

`SubringMonicRemainder` proves actual remainder coefficient membership
in any subring, without a leading-coefficient unit. The literal quotient
trace, cleared R and Qaff are regular in `ActualSourceSubringIntegrality`,
with no s inverse. `ActualSourceUnitMomentIntegrality` proves all actual
quotient derivative moments integral from root integrality, a
derivation-stable subring and actual unit source-factor values.
`SourceBoundarySubringIntegrality` proves the characteristic-five E2 and
I invariants remain integral after arbitrary meromorphic translation,
including translations whose roots leave the local subring.

The entire canonical Version1 record passed the aggregate theorem's
focused review and axiom audit.
The translated-polynomial quotient
specialization of the boundary subring theorem has now passed in
`SourceBoundaryQuotientIntegrality`. `SourceTensorAffineWeights` proves
both literal universal centered/cleared frame weights;
`SourceTensorAffineCorrections` proves the Qaff and degree-ten Qtilde
weights. `SourceTensorInvariance` proves literal Qsharp invariance under
equation scaling and boundary translations. The actual tensor expressions
and both square presentations are coordinate independent in
`SourceTensorFrameIndependence`. Arbitrary one-variable function-field
coordinate existence is proved from Mathlib's actual separating
transcendence basis in `OneVariableKaehler` and specialized to the full
source calculus in `OneVariableSourceTensors`. The source's tensor gluing clause is its literal
meromorphic frame transition, now proved for the genuine symmetric tensor;
it assumes no regularity across frame poles and asserts no extra Picard
existence theorem.

`SourceQuadraticCalculus.source_quadratic_calculus` now proves the aggregate
of thirty-one literal quantified clauses, including this arbitrary
perfect-base finitely generated transcendence-degree-one construction.
The aggregate build, focused axiom audit and parent whole-source readback
passed, completing the exact canonical statement.
No conclusion about a global common cover is claimed.

All 132 owned solution modules passed a combined build at 02:55 UTC on
3 October 2026. The modules build through their individually named targets,
including `lake build Solutions.CartierAndSpin.CharacteristicFiveEndpointJets`.
No accepted literature assumptions, new axioms, admitted proofs, bounded
arithmetic certificates or `native_decide` occur in this chain.
