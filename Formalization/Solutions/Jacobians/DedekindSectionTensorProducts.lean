import Solutions.Jacobians.DedekindSectionFractionalIdeals
import Solutions.Jacobians.FractionalIdealProductModules

open scoped nonZeroDivisors TensorProduct
open IsDedekindDomain

namespace Litt3.Jacobians

variable (R K : Type*) [CommRing R] [IsDedekindDomain R]
  [Field K] [Algebra R K] [IsFractionRing R K]

/-- The actual O(D) fractional ideals multiply with the correct
NEGATIVE exponent convention in the ORIGINAL fraction field. -/
theorem actualDedekindSectionFractionalIdeal_add
    (D E : Divisor (HeightOneSpectrum R)) :
    actualDedekindSectionFractionalIdeal R K (D + E) =
      actualDedekindSectionFractionalIdeal R K D *
        actualDedekindSectionFractionalIdeal R K E := by
  unfold actualDedekindSectionFractionalIdeal
  rw [neg_add, map_add]
  rfl

/-- Literal original rational multiplication is a TRUE tensor
equivalence of the entire valuation-bounded O(D), O(E), O(D+E)
modules over ANY actual Dedekind ring and ANY actual fraction field. -/
noncomputable def actualDedekindSectionTensorEquiv
    (D E : Divisor (HeightOneSpectrum R)) :
    ((actualDedekindSectionFractionalIdeal R K D).val : Submodule R K) ⊗[R]
      ((actualDedekindSectionFractionalIdeal R K E).val : Submodule R K) ≃ₗ[R]
      ((actualDedekindSectionFractionalIdeal R K (D + E)).val : Submodule R K) :=
  (fractionalIdealTensorMultiplyEquiv
    (actualDedekindSectionFractionalIdeal R K D)
    (actualDedekindSectionFractionalIdeal R K E)).trans
      (LinearEquiv.ofEq _ _ (congrArg (fun I : (FractionalIdeal R⁰ K)ˣ =>
        (I.val : Submodule R K))
          (actualDedekindSectionFractionalIdeal_add R K D E).symm))

@[simp] theorem actualDedekindSectionTensorEquiv_tmul
    (D E : Divisor (HeightOneSpectrum R))
    (a : ((actualDedekindSectionFractionalIdeal R K D).val : Submodule R K))
    (b : ((actualDedekindSectionFractionalIdeal R K E).val : Submodule R K)) :
    (actualDedekindSectionTensorEquiv R K D E (a ⊗ₜ[R] b) : K) =
      (a : K) * (b : K) := by
  simp only [actualDedekindSectionTensorEquiv, LinearEquiv.trans_apply,
    LinearEquiv.coe_ofEq_apply]
  exact fractionalIdealTensorMultiplyEquiv_tmul _ _ a b

end Litt3.Jacobians
