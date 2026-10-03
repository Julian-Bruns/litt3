import Definitions.CartierAndSpin.LogarithmicQuotientBoundary

namespace Litt3.CartierAndSpin

variable {A B C : Type*} [AddCommGroup A] [AddCommGroup B] [AddCommGroup C]

/-- Concrete representative and endpoint factors of an actual torsion
class. Existence is proved from the literal quotient, rather than
provided as a hypothesis to the boundary map. -/
structure PowerRelationLift (φ : B →+ A) (ψ : C →+ A) (p : ℕ)
    (q : powerTorsionSubgroup (TwoLegRelationQuotient φ ψ) p) where
  representative : A
  left : B
  right : C
  quotient_eq : QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range representative = q.val
  relation : p • representative = φ left - ψ right

end Litt3.CartierAndSpin
