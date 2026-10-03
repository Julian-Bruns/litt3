# Logarithmic Cartier, actual quotient torsion and two-leg images

This records complete new foundations for the characteristic-primary
and logarithmic-decomposition clauses of
`Theorems/shared_tensors/saturated_divisor_relations.md`. It is a
component mapping, not a claim that this entire original source has
been formalized. Its Picard rank, finite group schemes, clumps and shared
regularity conclusions remain distinct geometric clauses owned by their
respective modules. The literal shared rational dimension bound is now
derived algebraically below.

## Full logarithmic converse

`Solutions.CartierAndSpin.RationalCartierLogarithmicConverse` proves
`one_variable_cartier_fixed_iff_logarithmic`: for an actual field `K`
finitely generated with transcendence degree one over a perfect
prime-characteristic field `k`, every intrinsic rational Cartier
operator on the ORIGINAL `KaehlerDifferential k K` satisfies
`C omega = omega` if and only if
`omega = u^-1 * d u` for an ACTUAL nonzero `u` in `K`.

The more general full-p-basis version needs no perfectness assumption on
`K` and permits any constant ring `k` for which the actual normalized
universal coordinate exists. The one-variable wrapper constructs both
the full p-basis and that coordinate from finite generation and
transcendence degree one. It does not assume a separating presentation,
logarithmic primitive, connection kernel, matrix singularity or
p-curvature formula.

The construction uses the genuine universal truncated ODE described in
`truncated_logarithmic_ode_scope_review.md` and the independently read
literal Taylor scalar-extension/descent chain described in
`taylor_connection_independent_scope_review.md`. The original field is
not presumed perfect. All arguments are symbolic in the prime `p`,
including `p=2`, with no matrix enumeration or sampled coefficient oracle.
Focused audit `20261003T073045Z/report.json` passed 410 transitive Litt3
declarations with only the three standard logical axioms and zero
forbidden dependencies or source changes.

## Exact actual logarithmic kernel

`Definitions.CartierAndSpin.LogarithmicDifferentials` constructs the
literal additive homomorphism from `Additive K^*` to the true universal
differential module. `LogarithmicFibers` proves that two nonzero functions
have the same original logarithmic differential exactly when their
ratio is an actual pth power. `LogarithmicDifferentialKernel` proves its
kernel is precisely `p * Additive K^*`, including the full one-variable
wrapper with constructed p-basis and coordinate.

`LogarithmicDifferentialPullbacks` proves naturality for the actual unit
pullback and the original universal-differential pullback. Genuine
separable differential injectivity proves ENDPOINT kernel exactness
after embedding into the source. Thus an endpoint root is constructed
in the endpoint field itself; it is not inferred from an ambient scalar
surrogate.

## Canonical quotient p-torsion isomorphism

The general abelian-group chain
`LogarithmicBoundaryLifts`, `LogarithmicBoundaryMap`, and
`LogarithmicBoundaryEquivalence` constructs the torsion boundary in the
literal quotient `A/(image(B)-image(C))`. It proves all representative
and factor choices independent, then additivity, surjectivity and
injectivity. Inputs are exact p-kernels on `A`, `B`, `C`, injectivity of
the actual p-power operation on `A`, and zero logarithm on common
endpoint units. The isomorphism is a conclusion, not an input to any
generic package.

`ActualUnitTorsionLogarithms` derives all those inputs for the actual
two-leg configuration of one-variable function fields over perfect
constants, with both genuine separable field inclusions and the literal
constant-intersection hypothesis. Frobenius gives actual ambient-unit
power injectivity. The exact endpoint intersection condition gives
common units as actual endpoint constants, whose original differential
is zero.

`PulledCartierFixedLogarithms` derives endpoint Cartier fixedness from
source fixedness through the actual separable universal-differential
injection and the full constructed Cartier transport. The proved
logarithmic converse then constructs endpoint primitives.
`SharedCartierFixedLogarithms` identifies the intersection of actual
endpoint logarithmic images with the fixed part of the intersection of
the TWO ORIGINAL universal differential images. These images are not
extended as E-vector spaces.

`ActualUnitTorsionCartierLinear` gives the literal F_p-linear equivalence
`Q[p] ~= (image(Omega(F/k)) intersection image(Omega(G/k)))^{C=1}`
for the original multiplicative `UnitRelationQuotient`. Canonical
`ZMod p` module structures are constructed from actual p-annihilation;
the genuine additive isomorphism is automatically linear over this
prime subfield. No finite cardinal, shared-rank or common-cover
conclusion is assumed. Focused audit `20261003T073511Z/report.json`
passed 502 declarations with the standard three logical axioms,
zero forbidden dependencies and zero source changes.

## Literal original scheme wrapper

`SmoothEtaleSpanUnitTorsion` supplies this same F_p-linear isomorphism
for a genuine `FiniteEtaleSpan X Y`, retaining both original morphisms
from its SAME actual source. The endpoint structure maps are genuinely
smooth of relative dimension one over a perfect field, commute on the
actual source, and all three schemes are integral. The wrapper derives
source smoothness, all three actual function-field finite-generation
and transcendence-degree-one facts, both actual generic separabilities
and both actual constant-field scalar towers.

Its only intersection input is the original literal endpoint-field
constant-intersection hypothesis. The operator is an actual intrinsic
Cartier operator on the source's original universal differential module;
its existence has already been proved without a literature premise.
Properness, projectivity and genus restrictions are unnecessary for this
identity and are therefore absent. No supplied function-field
presentations, abstract derivative proxies, original-curve DVR premises
or simultaneous Galois closure occur.

Focused original-source wrapper audit `20261003T073749Z/report.json`
passed 643 transitive declarations, standard three axioms only, zero
forbidden dependencies and zero source changes. The parent independently
read the full terminal chain and actual original scheme wrapper; its
fifteen-module hash record is
`original_logarithmic_torsion_independent_scope_review.md`.

## Actual quotient p-power/decomposition criterion

The new `ActualLogarithmicPowerForward` proves the forward direction
for arbitrary field towers in characteristic `p`, even without
perfectness, separability, finite generation, primality or a shared-rank
input. A genuine quotient power witness gives an actual additive
endpoint differential decomposition.

`ActualLogarithmicCorrection` and `ActualLogarithmicPowerCriterion`
specialize the separately proved generic shared Cartier correction to
the original universal modules. They construct logarithmic endpoint
choices for arbitrary additive decompositions and thereby construct
the actual quotient p-power root. These reusable conditional modules
retain an explicit finite/shared-rank premise.

`ActualSharedDifferentialSpan` eliminates that premise in the original
constant-intersection configuration. Given any nonzero actual shared
form `omega0`, rank-one endpoint universal coordinates express each
shared form as `aF * omega0` and `aG * omega0`. The nonzero form cancels
in the source's actual E-module, so the two actual field embeddings
send `aF` and `aG` to the same element. Literal endpoint constant
intersection gives one `c` in `k`, proving `omega = c * omega0`.
Consequently the actual shared subspace is its singleton k-span.
This argument uses no separability, source finite generation, source
transcendence degree, characteristic or source rank-one premise.

`ActualSharedDifferentialRank` derives genuine module finiteness and
finrank at most one, including the zero space. Perfect-base finite
generation and transcendence degree one of the ENDPOINTS construct
their actual universal coordinates, so no supplied coordinate or rank
assumption remains.

`ActualConstantIntersectionPowerCriterion` therefore proves the exact
original quotient p-power/additive-decomposition equivalence with NO
shared-rank premise. It also constructs logarithmic choices in both
original endpoints. Its base is algebraically closed of prime
characteristic, both field inclusions are genuinely separable, and the
three original fields are finitely generated of transcendence degree
one. `SmoothEtaleSpanPowerCriterion` derives all those field hypotheses
from the actual smooth endpoint maps and BOTH genuine finite etale
maps from the SAME original source. Properness and genus restrictions
are unnecessary for these algebraic clauses. Focused audit
`20261003T074959Z/report.json` passed 678 declarations with only the
standard three logical axioms and zero forbidden dependencies or source
changes. Shared REGULARITY is still a separate geometric theorem.

## Actual decomposition torsors and fixed cardinalities

`EndpointSharedKernel` constructs the genuine additive equivalence
between the kernel of the two original endpoint difference map and
the literal intersection of their images. Both actual map injections
are inputs to this universal group lemma. `AdditiveFiberTorsor` supplies
literal addition/subtraction on a nonempty homomorphism fiber, and
`EndpointDecompositionTorsor` transports that actual action to the
shared-image group. Its computation theorem identifies the parameter
of a decomposition relative to an actual base point with its
simultaneous original endpoint shift.

`ActualEndpointDecompositionTorsor` derives map injectivity from the
actual separable universal-differential maps and endpoint rank-one
coordinates. Its one-variable wrapper constructs those coordinates.
There is no characteristic or shared-rank input to the torsor statement.
The actual shared-zero theorem proves uniqueness of any two existing
decompositions, without presuming their existence.

`SharedRationalCartier` proves preservation of the literal shared
rational k-space from genuine endpoint Cartier transport, then
constructs its actual restricted additive operator and inherited
inverse-pth semilinearity. `SharedCartierFixedCardinality` identifies
its fixed kernel with the original shared fixed subgroup and applies
the symbolic rank-one prime-subfield argument. Actual endpoint finite
generation, transcendence degree one and constant intersection derive
rank and finiteness; the conclusion is exactly cardinality one when
the restricted operator is zero and cardinality p otherwise. No source
finite generation or rank-one hypothesis is used for that cardinality
lemma beyond an actual intrinsic source operator.

`LogarithmicChoiceFibers` defines choices as pairs of actual endpoint
logarithmic ONE-FORMS in the literal ranges of their logarithmic
homomorphisms. Different primitive functions with identical logarithms
give the same point. `LogarithmicChoiceImages` proves their literal
shared image is the actual shared Cartier-fixed subgroup.
`ActualLogarithmicChoiceTorsor` constructs the genuine torsor and proves
every nonempty such choice fiber has exactly one or p points. It does
not claim that primitive functions themselves have only p choices.

`PrimeCardinalityDimension` derives true finiteness, finite prime-field
module structure, dimension at most one and cyclicity from cardinality
one or p. `ActualUnitTorsionSize` applies this to the ORIGINAL quotient
Q[p] through the proved literal linear equivalence, and to the original
shared fixed forms. Combined focused audit
`20261003T080018Z/report.json` checked the three terminal roots and 614
transitive Litt3 declarations, with only the three standard logical
axioms, zero forbidden dependencies and zero source changes.

## All prime-power kernels and the entire primary subgroup

`PowerKernelSteps` constructs actual multiplication by p from Q[p^(n+1)]
to Q[p^n], and injects its genuine kernel into the original Q[p].
`PowerKernelFiniteness` proves all higher kernels finite from true
finiteness of the first kernel, even for an infinite ambient group.
`PrimePowerKernelCardinality` counts the actual kernels and ranges and
proves cardinality at most p^n. `FinitePrimaryCyclicity` realizes an
actual maximal-order element via the genuine finite exponent, then
uses those kernel bounds to prove cyclicity; a cyclic decomposition
is not supplied. `HigherPrimeKernelCyclicity` applies this to every
actual higher kernel. `PrimePowerKernelVanishing` proves that a zero
first kernel kills the entire literal primary component without any
finiteness assumption on that component.

`ActualPrimaryUnitTorsion` and `ActualHigherUnitTorsion` apply these
general group results to the ORIGINAL unit quotient. The latter
constructs intrinsic Cartier from the actual field hypotheses instead
of taking an operator as input. The conclusion is that every Q[p^n]
is finite, cyclic, and has cardinality at most p^n. If the literal
shared rational form space is zero, the whole primary component is
zero. `SmoothEtaleSpanHigherTorsion` derives every field hypothesis
from the actual same-source finite etale span and actual smooth
endpoint structure morphisms. It retains both original generic maps
and their literal constant intersection. No source/endpoint coordinate,
Cartier operator, supplied shared rank, ambient quotient finiteness,
primary finiteness, or simultaneous Galois closure is assumed.

`FinitePrimaryKernelProfile` and `PrimaryAmbientKernelProfile` prove
that every finite literal primary subgroup with small first kernel
has one height h and that the TRUE ambient kernel cardinality at
every height n is exactly p^min(h,n). An actual additive equivalence
places every prime-power kernel inside the literal primary component;
there is no supplied primary decomposition. The proof uses a genuine
cyclic generator, the actual multiplication-kernel gcd formula, and a
symbolic same-base-power gcd identity, including exponent zero.
`ActualPrimaryUnitTorsionProfile` applies this to the original Q.
It also proves, WITHOUT finiteness of the entire primary subgroup,
that this subgroup vanishes exactly when the actual restricted shared
Cartier operator vanishes. Focused audit
`20261003T081710Z/report.json` checked 600 transitive declarations with
the standard three axioms only and zero forbidden dependencies or
source changes.

`PrimaryBoundedExponent` isolates the precise further finiteness step:
with finite first kernel, the actual entire primary component is finite
if and only if one uniform p-power annihilates all its actual elements.
Such a bound identifies the primary component with the literal ambient
kernel at that height, and gives finite cyclicity and cardinality at
most p^height. This theorem does not assume or derive the geometric
annihilation bound for the original curve quotient.

Focused audit `20261003T081042Z/report.json` built the terminal actual
scheme wrapper and checked 737 transitive Litt3 declarations, with
only the three standard logical axioms, zero forbidden dependencies,
and zero source changes. Finiteness of the ENTIRE primary component
remains a separate geometric theorem; its cyclicity is already proved
conditional on that precise genuine finiteness input.

## Naturality of the canonical torsion boundary

`TwoLegQuotientMaps` constructs actual quotient and p-kernel maps from
a genuine commuting diagram of BOTH endpoint maps. It also constructs
the literal shared-image map from the actual commuting logarithmic
target diagram. `LogarithmicBoundaryNaturality` transports a genuine
power-relation lift through the actual diagram and applies the already
proved boundary computation on both sides. Thus compatibility of the
canonical chosen-lift boundary is a conclusion, not a supplied
assumption. This general theorem holds for arbitrary additive groups
and any natural multiple, subject to the explicit exact-logarithmic
kernel and endpoint-common-log-zero hypotheses in both diagrams.
Focused audit `20261003T081526Z/report.json` checked all 32 transitive
Litt3 declarations, with only the three standard logical axioms, zero
forbidden dependencies, and zero source changes. Actual field/scheme
specializations of this commuting-diagram statement remain separate.

`ActualAlgebraDifferentialNaturality` now constructs the true universal
k-linear map of an arbitrary actual algebra homomorphism and proves
its derivative and logarithm identities. The unit diagram is derived
from the literal field diagram. `TwoEndpointFieldDiagrams` retains
BOTH endpoint inclusions and their SAME ambient field.
`ActualFieldBoundaryNaturality` specializes canonical boundary
naturality to this original field diagram. Ambient FG/trdeg one,
perfect characteristic-p constants and literal constant intersection
suffice for the well-defined boundary; endpoint finite generation and
separability are not needed for that map. With the additional hypotheses
used for bijectivity, it is literally the previously proved canonical
equivalence. These newest specializations and bounded-exponent lemma
are included in the stable whole-library checkpoint
`verification/20261003T082351Z/report.json`: 1,291 solution roots,
8,256 transitive Litt3 declarations and 1,781 local source hashes, with
only the three standard logical axioms, zero forbidden dependencies
and zero source changes. Their earlier generic audit remains separately
identified above.

No proof in this chain claims that a canonical root exists in the
unexcluded no-clump case or resolves the unmarked common-cover problem.
