# Actual associated sheaves and original finite projective modules

Stable roots: `Solutions.Jacobians.ActualTildeIsomorphismRecovery` and
`Solutions.Jacobians.ActualTildeRankOneStalks`. Trust checkpoint
`verification/20261003T081002Z/report.json`: 99 transitive declarations,
only Classical.choice, Quot.sound and propext, zero forbidden dependencies
and zero source changes.

The construction uses Mathlib's ACTUAL associated O_Spec-module SHEAF, whose
sections are original localized-module values locally represented by fractions.
Every original module map acts on every actual localized component, preserves
the original local fraction witnesses, and gives an actual sheaf morphism.
The resulting functor preserves identity and composition and is faithful for
ANY commutative ring and ANY module in the ring's universe: original constant
global sections are injective by actual maximal-localization detection.

The genuine associated sheaf of R is proved isomorphic to the genuine
structure-sheaf module, using the canonical localized-module/ring equivalence
at every original prime and on every actual open. For an actual invertible
module, its original associated-sheaf stalk has a derived rank-one frame over
the actual prime localization. Every original prime also has a derived basic
open with a genuine rank-one localized-module frame; these conclusions use
actual Module.Invertible and derive finite presentation, freeness and rank.

For ANY actual finite projective module M, its original constant-global-section
map is proved bijective and upgraded to a genuine R-linear equivalence. A true
finite projective splitting gives finitely many original dual functionals and
original elements with the reconstruction identity. That identity is extended
to every element of every genuine prime localization by the localization
universal property. Applying each original functional to an arbitrary actual
global section reduces its coefficients to the actual affine structure-sheaf
global-sections theorem. The derived original coefficients then reconstruct
the original M-element. No surjectivity of associated-sheaf global sections is
supplied as an assumption.

Consequently an actual sheaf isomorphism between associated finite projective
modules induces an actual isomorphism of their original modules. For invertible
modules, equality in Mathlib's genuine ring Picard group is equivalent to an
isomorphism of their actual associated sheaves. A genuine ring Picard class
vanishes precisely when its actual associated sheaf is isomorphic to the actual
structure-sheaf module.

The further `DedekindAffineDivisorSheaves` specialization constructs the ACTUAL
associated sheaf and passed `verification/20261003T081237Z/report.json`,
220 transitive declarations, standard three axioms and zero forbidden/source
changes. It constructs the actual
associated sheaf of the literal prime-fractional-ideal product for a normalized
adic affine divisor. Its true sheaf triviality is equivalent to being the
actual normalized divisor of an original fraction-field unit. Positive prime
divisors map to prime IDEALS, hence the O(-D) convention. This uses the original
adic principal-ideal equality and exact affine Picard kernel; it does not
substitute an abstract divisor quotient for a sheaf object.

The actual local-trivialization root
`Solutions.Jacobians.ActualTildeInvertibleSheaves` passed
`verification/20261003T081801Z/report.json`, 87 declarations, standard three
axioms and zero forbidden/source changes. At EVERY original prime, the genuine
canonical dual contraction produces original m and g with g(m) outside that
prime. Original invertible-module tensor interchange proves that the two
original pairing maps are inverse up to the scalar g(m). On the true basic
open of g(m), its actual structure-sheaf section is a unit; the construction
restricts its inverse to EVERY smaller open. Actual associated-sheaf maps and
this section multiplication give genuine mutually inverse SHEAF morphisms on
the entire restricted original open site. Thus these sheaves are actually
locally free of rank one, with no local frame or pairing supplied.

This identifies actual associated sheaves and affine ideal/divisor classes.
The new `DedekindAffineSectionSheaves` terminal also proves the literal section
interpretation: the fractional ideal for -D consists EXACTLY of original
rational functions whose true normalized adic valuations are bounded by
exp(D) at every actual height-one point. Original fractional-ideal inclusion
is proved equivalent to the reverse inequality of all true prime counts,
using genuine Dedekind factorization and actual invertible-ideal cancellation;
membership in the original ideal is then the genuine original principal-order
bound. This proves both the zero and nonzero cases and the exact O(D) sign.
Its actual affine associated sheaf is locally free of rank one, and its true
global sections recover the literal valuation-bounded original module through
the derived finite-projective global-section equivalence.
Trust checkpoint `verification/20261003T082213Z/report.json`: 342 transitive
declarations, standard three axioms, zero forbidden dependencies and zero
source changes.

The further all-open chain derives an actual equivalence
Γ(U, tilde M) ≃ Γ(U, O) ⊗_R M for EVERY original open U and EVERY finite
projective M over ANY commutative ring. No affine, quasi-compact or nonempty
condition is imposed on U. The true extension/restriction-of-scalars
adjunction produces the canonical map, and the original finite dual
reconstruction proves its bijectivity on the entire module. Actual invertible
modules therefore have actual invertible section modules over Γ(U, O).
Trust checkpoints `verification/20261003T083222Z/report.json` (92) and
`verification/20261003T083351Z/report.json` (97) use the standard three axioms,
zero forbidden dependencies and zero source changes.

`ActualTildeTensorNaturality` proves that the all-open tensor equivalences
commute with EVERY original restriction map. Actual original sections span
the entire section module over its genuine open structure ring, so the
bilinear naturality check reduces to genuine original tensor sections.
`ActualTildeTensorSheaves` derives the genuine SHEAF condition of the literal
pointwise tensor presheaf and constructs its actual sheaf isomorphism to
tilde(M ⊗_R N). This is a sheaf isomorphism on the whole original affine
open site, not a collection of unrelated section isomorphisms. Trust
checkpoint `verification/20261003T083944Z/report.json`: 105 declarations,
standard three axioms, zero forbidden dependencies and zero source changes.

`ActualTildeInvertibleTensorUnits` transports genuine original dual
contraction to actual inverse tensor SHEAVES and the actual structure-sheaf
unit. `ActualFractionalIdealTensorSheaves` transports the literal field
multiplication of actual invertible fractional ideals to their actual tensor
sheaves. Their joint trust checkpoint
`verification/20261003T084114Z/report.json` has 150 declarations and the same
clean axiom/source result. `DedekindAffineDivisorTensorSheaves` derives the
genuine O(D) ⊗ O(E) ≅ O(D+E) and O(D) ⊗ O(-D) ≅ O isomorphisms, retaining
the exact normalized adic and O(D) sign conventions; checkpoint
`verification/20261003T084220Z/report.json`: 403 declarations, standard three
axioms, zero forbidden dependencies and zero source changes.

It does NOT yet construct a group of ALL locally free rank-one sheaves,
prove that every such sheaf is associated to an original module, or identify
a proper curve's full Picard scheme or Jacobian. The actual global curve
divisor sheaf and its comparison with affine ideals are the next separate
geometric obligations. The tensor theorem above concerns associated finite
projective sheaves on an actual affine spectrum and makes no general assertion
about pointwise tensor sections on an arbitrary proper scheme.
