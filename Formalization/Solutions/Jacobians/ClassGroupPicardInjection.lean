import Solutions.Jacobians.FractionalIdealPrincipalPicard

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable (R : Type*) [CommRing R] [IsDomain R]

/-- The genuine ideal-class quotient maps to Mathlib's genuine ring Picard group.
Its map on representatives is the actual fractional-ideal module. -/
noncomputable def actualClassGroupToPicard : ClassGroup R →* CommRing.Pic R :=
  QuotientGroup.lift (toPrincipalIdeal R (FractionRing R)).range
    (fractionalIdealPicardHom (R := R) (K := FractionRing R))
    (by rw [fractionalIdealPicardHom_ker])

theorem actualClassGroupToPicard_representative
    (I : (FractionalIdeal R⁰ (FractionRing R))ˣ) :
    actualClassGroupToPicard R (QuotientGroup.mk I) = fractionalIdealPicardClass I := rfl

/-- The exact principal kernel proves injectivity, over every integral domain. -/
theorem actualClassGroupToPicard_injective :
    Function.Injective (actualClassGroupToPicard R) := by
  intro a b
  refine Quotient.inductionOn₂' a b fun I J h => ?_
  apply Quotient.sound'
  rw [QuotientGroup.leftRel_apply, ← fractionalIdealPicardHom_ker]
  change (fractionalIdealPicardHom (R := R) (K := FractionRing R)) (I⁻¹ * J) = 1
  change fractionalIdealPicardClass I = fractionalIdealPicardClass J at h
  rw [map_mul, map_inv]
  change (fractionalIdealPicardClass I)⁻¹ * fractionalIdealPicardClass J = 1
  rw [← h, inv_mul_cancel]

end Litt3.Jacobians
