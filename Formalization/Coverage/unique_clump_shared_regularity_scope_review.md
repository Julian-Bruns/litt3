# Arbitrary rational zeros, at-most-one-clump regularity and uniqueness

This extension retains the literal SAME-source finite étale span and
BOTH original maps. Endpoint curves are actually integral smooth proper
curves over an algebraically closed field. All geometric statements are
in arbitrary characteristic. The only dimension input is the actual
original differential-sheaf H0 rank at least two on ONE endpoint.

`RationalDifferentialZeroRatios` widens the primitive ratio argument:
over a true DVR, a nonzero RATIONAL form outside the original maximal-
ideal differential image divides every original regular form with an
ORIGINAL stalk coefficient. The denominator may have a pole. The true
valuation criterion gives denominator valuation at least one and
numerator valuation at most one; their actual quotient has valuation at
most one, hence is an actual DVR integer. No coordinate compatibility
is supplied and no order-zero assumption is smuggled into the result.

`ProperRationalDifferentialZeros` uses these true local coefficients
and the actual proper global-constant theorem. If ANY nonzero rational
form has no original differential zero, every globally regular form is
an original constant multiple of it. If that rational form is regular,
the genuine H0 module has rank at most one. If it is not regular, any
nonzero constant multiple would force it regular, so every global
regular form is zero. Thus genuine H0 rank at least two forces EVERY
nonzero rational form to have an original differential zero, even when
it has poles. This argument uses no canonical-degree or genus formula.

`SchemeDifferentialZeroPoleSeparation` proves that a true original
maximal-ideal differential zero is original regular and hence zero
and pole sets are disjoint. This elementary inclusion holds even on an
arbitrary integral scheme, without smoothness, rank or valuation input.

`UniqueClumpSharedDifferentialRegularity` assumes the literal condition
`∀ c d : s.fiberClump, c.left = d.left`. It asserts at most one clump,
and does not presume that a clump exists. A hypothetical pole of a shared
rational form produces an actual nonempty finite pole clump. The stronger
arbitrary-rational zero theorem supplies a genuine zero on the first
endpoint; actual closed-point surjectivity and actual étale zero
pullbacks produce a nonempty finite zero clump for BOTH maps. The two
clumps have disjoint original endpoint supports, contradicting the
literal uniqueness input. Consequently every shared rational form is
original globally regular. No original regularity, finite zero/pole
support, pullback support equation, common Galois closure, or line-bundle
model is a hypothesis.

`NoClumpEndpointDecompositionUniqueness` concludes uniqueness of BOTH
actual original endpoint representatives whenever their difference
pulls back to the same source form, under literal no-clump and ONE true
H0 rank at least two. It asserts no decomposition existence.

`NoClumpQuotientRootUniqueness` concludes that `p^n q = p^n r` in the
ACTUAL original unit quotient implies `q=r`, for every `n`, in prime
characteristic under the same no-clump and H0 rank hypothesis. It uses
the proved vanishing of the ENTIRE actual primary component. No root
existence is asserted and no finite-primary premise is used.

Focused verification captured the last three solution roots and all
their imports: `../litt3-computation-data/formalization-20261003/verification/20261003T090302Z/report.json`.
All roots build; 1,369 transitive Litt3 declarations use only
`Classical.choice`, `Quot.sound` and `propext`; zero forbidden dependencies
and zero source changes. Exact transitive hashes are preserved there.
No accepted literature input or numerical certificate is used.

The exact clump-count theorem from the canonical field-intersection
scope and the genus-to-genuine-H0 comparison remain separate gaps.
They must be proved or precisely supplied as accepted literature in a
first-pass source wrapper; neither is claimed here. The new genuine
H0 pullback/intersection comparison is outside this 09:03 capture and
will have its own evidence. No canonical whole-source completion is
promoted by this conditional extension.
