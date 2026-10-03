import Solutions.Jacobians.ClassGroupPicardInjection
import Solutions.Jacobians.InvertibleModuleFractionalInverse

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable (R : Type*) [CommRing R] [IsDomain R]

theorem actualClassGroupToPicard_surjective_of_domain :
    Function.Surjective (actualClassGroupToPicard R) := by
  intro M
  let I := actualInvertibleModuleFractionalIdealUnit R (FractionRing R) M
  refine ⟨QuotientGroup.mk I, ?_⟩
  change fractionalIdealPicardClass I = M
  rw [actualInvertibleModuleFractionalIdealUnit_picard, CommRing.Pic.mk_eq_self]

/-- The genuine ideal-class quotient is canonically isomorphic to the genuine
ring Picard group over EVERY commutative integral domain. -/
noncomputable def actualClassGroupPicardEquiv : ClassGroup R ≃* CommRing.Pic R :=
  MulEquiv.ofBijective (actualClassGroupToPicard R)
    ⟨actualClassGroupToPicard_injective R, actualClassGroupToPicard_surjective_of_domain R⟩

theorem actualClassGroupPicardEquiv_representative
    (I : (FractionalIdeal R⁰ (FractionRing R))ˣ) :
    actualClassGroupPicardEquiv R (QuotientGroup.mk I) = fractionalIdealPicardClass I := rfl

end Litt3.Jacobians
