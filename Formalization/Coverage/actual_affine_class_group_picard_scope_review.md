# Actual affine ideal classes and the ring Picard group

Terminal root: `Solutions.Jacobians.ActualClassGroupPicard`.
Trust checkpoint: `verification/20261003T074917Z/report.json`, 73 transitive
declarations; only Classical.choice, Quot.sound and propext, zero forbidden
dependencies and zero source changes.

For EVERY commutative integral domain R, the proof constructs a genuine group
isomorphism `ClassGroup R ≃* CommRing.Pic R`. Both sides are Mathlib's actual
objects. The left side is invertible fractional ideals in the actual fraction
field modulo actual principal fractional ideals; the right side is isomorphism
classes of actual invertible R-modules with tensor multiplication.

The representative map sends an actual invertible fractional ideal to its
literal R-submodule in the fraction field. Literal field multiplication gives
the tensor map; finite pure-tensor induction proves its image is the actual
fractional-ideal product. When I J=1, its ring-valued form is bijective, as
derived from a genuine tensor mapping to one and the multiplication interchange
identity. This constructs actual Module.Invertible and proves multiplicativity
of the representative map. An actual module equivalence I≃R gives the genuine
generator e⁻¹(1), proving that its exact kernel is the principal-ideal range.
Consequently the induced actual ideal-class quotient map is injective.

For surjectivity, an arbitrary actual invertible module M injects into the
actual fraction field through its genuine rank-one generic fiber. Finite
generation derives common denominators for its literal image I. No fractional
ideal or ideal presentation is supplied. Every original R-valued dual
functional extends to the genuine generic fiber and becomes multiplication by
a derived field scalar; its product with every actual image element lies in R.
Thus this scalar belongs to the genuine fractional inverse I⁻¹. The actual
canonical dual contraction is surjective by Module.Invertible, and tensor
induction proves that its image of one belongs to I I⁻¹. The reverse inclusion
is the definition of the genuine inverse, so I I⁻¹=1. No Dedekind, normality,
Noetherian, localization rank assumption, computation or literature axiom is
used. The image module is actually equivalent to M, proving surjectivity.

The preserved Dedekind special case has its own earlier checkpoint,
`verification/20261003T074811Z/report.json`, 55 declarations and the same clean
trust result. The wider terminal theorem derives invertibility directly and
does not use Dedekind cancellation as a premise.

This is an AFFINE RING comparison. It does not yet identify invertible sheaves
on Spec R, a proper curve's global divisor/Picard group, its degree-zero Picard
scheme, or its Jacobian geometric points. Those geometric identifications
remain separate obligations. No original source theorem about a proper curve
or Jacobian is complete solely because this affine comparison is proved.

The further terminal root `Solutions.Jacobians.DedekindAffineDivisorPicard`
passed `verification/20261003T075401Z/report.json`, 130 transitive declarations,
with the same standard three axioms and zero forbidden/source changes. It
constructs an actual additive equivalence between the genuine normalized adic
AFFINE divisor-class quotient and `Additive (CommRing.Pic R)` for any Dedekind
domain with its true chosen fraction field. Every integer prime divisor maps
to the literal product of the actual prime fractional ideals. The inverse is
the true finitely supported prime-count divisor, and both inverse laws use
Mathlib's genuine Dedekind factorization. For every nonzero original field
unit, its normalized-valuation principal divisor is proved equal to the true
principal fractional ideal's count divisor, by actual numerator/denominator
decomposition and the original ring-element valuation formula. The exact
principal kernel and quotient equivalence follow, together with the literal
Picard torsion iff actual principal-multiple criterion.

Positive prime divisors map to their actual prime-ideal modules. Accordingly,
under a future separately proved sheaf realization, this map uses the
O(-D) convention. No proper/global Picard or Jacobian conclusion is inferred.
