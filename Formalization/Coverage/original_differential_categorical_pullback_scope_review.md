# Canonical original differential categorical pullback

Scope review, 3 October 2026. Owner: CartierAndSpin. This extends the
[original whole-open and sheaf map](original_differential_sheaf_pullback_scope_review.md)
to the actual adjoint f*Ω_Y → Ω_X. It uses the accepted original
Ω≃O(div omega) coefficient isomorphism and the actual categorical
divisor-sheaf pullback isomorphism.

## The actual map and its proof

`actualSmoothEtaleDifferentialCategoricalPullbackMap` in
`Solutions.CartierAndSpin.SmoothEtaleDifferentialCategoricalPullbacks`
is the image under the genuine module-sheaf pullback/pushforward
adjunction of `actualSmoothEtaleDifferentialSheafPullbackMap`.
Consequently it is the actual original universal differential adjoint,
whose direct-image map agrees with the entire original universal
presheaf through both sheafification units. Constructing this map does
not need compactness.

`actual_normalized_differential_coefficient_pullback` in
`Solutions.CartierAndSpin.DifferentialCoefficientDivisorTransports`
proves rational coefficient naturality for arbitrary field towers,
arbitrary genuine rank-one coordinates, a nonzero original reference
omega, and its nonzero original pullback. The proof applies the actual
Kaehler map to the reconstruction eta=c*omega and normalizes by the
actual pulled reference. It has no compatible-coordinate premise.
The equal-divisor helpers retain this literal original coefficient
map, its scalar action and all restrictions. Their divisor equality is
bookkeeping; the finite-etale application supplies the already PROVED
original divisor transport, rather than assuming the desired identity.

`actual_smooth_etale_differential_coefficient_sheaf_square` proves the
commutative square of the ENTIRE original normalized coefficient maps
and the actual differential and divisor direct-image maps. On each
nonempty open it uses injective original rational realization, actual
section pullback naturality and the proved normalized coefficient law.
On empty opens it uses the original module sheaf's unique section,
including the restricted-scalar pushforward object. The square is not
supplied as an input.

`actual_smooth_etale_differential_categorical_pullback_map_isIso`
proves that the exact canonical adjoint itself is IsIso. A nonzero
original reference is constructed from the true smooth generic rank-one
coordinate. Original Ω≃O(div omega) and its transported source version
are isomorphisms with the exact coefficient-map homs. Applying actual
adjunction naturality to the proved square identifies the canonical
differential adjoint after these coefficient maps with the actual
categorical O(D) pullback adjoint, already proved IsIso by Jacobians.
Cancellation by the genuine coefficient isomorphisms proves IsIso of
the original differential map. No arbitrary comparison map or chosen
target isomorphism replaces the canonical map.

`actualSmoothEtaleDifferentialCategoricalPullbackIso` is `asIso` of
that actual map; `_hom` states that its hom is literally the same
canonical adjoint. The exact IsIso scope is integral smooth
relative-dimension-one schemes over an algebraically closed field,
compact source and target, and an actual finite etale surjective map
over the field, in every characteristic. Compactness is used to form
finite original differential divisors in this proof. No properness,
projective embedding, genus, Riemann–Roch, canonical degree or accepted
literature hypothesis is input.

`same_source_actual_differential_categorical_pullback_isomorphisms`
in `Solutions.CartierAndSpin.SmoothEtaleSpanDifferentialSheaves`
retains BOTH literal adjoints of the two actual finite etale maps from
the SAME `FiniteEtaleSpan` source, derives its smoothness from the left
leg, and uses the original common-base equality for the right leg.
Compactness and integrality of both endpoints and the source remain
explicit. It does not assert existence of a common cover.

## Source freeze

| Module | SHA256 |
| --- | --- |
| DifferentialCoefficientDivisorTransports | 4e2bf238372b33e9f528afd8c634af638cbe811eb22651675d365a4b0d72768d |
| SmoothEtaleDifferentialCategoricalPullbacks | 2454ad5c03f267510b0b2ece7391b4d5fcb3ae6dfa54b07c81147f76f12243db |
| SmoothEtaleSpanDifferentialSheaves | f5454d930289d68ef00485a4fc89cccb05d819112b90c9b75b2b93c5364cccc0 |

The canonical categorical module and the SAME-source span terminal build
successfully. Focused terminal audit:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T122904Z/report.json`.
It checks 1,273 transitive Litt3 theorem declarations, only
Classical.choice, Quot.sound and propext; zero forbidden dependencies
and zero source changes with all three sources frozen. This new audit
covers the additional categorical declarations and both actual span
legs. The independent mathematical readback is recorded separately.

## Remaining gap

The categorical differential pullback foundation is exact in the scope
above. Its current proof does not remove compactness or extend to
arbitrary etale morphisms of higher-dimensional schemes. It does not
prove canonical degree, cohomological/genus formulas, existence of a
canonical power on a common cover, or the unmarked common-cover
problem. No archived source record is promoted to complete by this
foundation alone.
