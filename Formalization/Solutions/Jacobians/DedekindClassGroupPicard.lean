import Solutions.Jacobians.ClassGroupPicardInjection
import Solutions.Jacobians.InvertibleModuleFractionalIdeals

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable (R : Type*) [CommRing R] [IsDomain R] [IsDedekindDomain R]

theorem actualClassGroupToPicard_surjective :
    Function.Surjective (actualClassGroupToPicard R) := by
  intro M
  let I := invertibleModuleFractionalIdealUnit R (FractionRing R) M
  refine ⟨QuotientGroup.mk I, ?_⟩
  change fractionalIdealPicardClass I = M
  rw [invertibleModuleFractionalIdealUnit_picard, CommRing.Pic.mk_eq_self]

/-- The actual affine ideal-class group is the actual ring Picard group.
This statement does not identify a curve's global Picard or Jacobian. -/
noncomputable def actualDedekindClassGroupPicardEquiv :
    ClassGroup R ≃* CommRing.Pic R :=
  MulEquiv.ofBijective (actualClassGroupToPicard R)
    ⟨actualClassGroupToPicard_injective R, actualClassGroupToPicard_surjective R⟩

theorem actualDedekindClassGroupPicardEquiv_representative
    (I : (FractionalIdeal R⁰ (FractionRing R))ˣ) :
    actualDedekindClassGroupPicardEquiv R (QuotientGroup.mk I) =
      fractionalIdealPicardClass I := rfl

end Litt3.Jacobians
