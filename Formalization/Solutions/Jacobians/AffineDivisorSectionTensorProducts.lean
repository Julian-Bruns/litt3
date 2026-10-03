import Solutions.Jacobians.AffineDivisorSectionsFractionalIdeals
import Solutions.Jacobians.DedekindSectionTensorProducts

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped nonZeroDivisors TensorProduct
open IsDedekindDomain

namespace Litt3.Jacobians

universe u
variable {X : Scheme.{u}} [IsIntegral X] [JacobsonSpace X] [ClosedPointDVRStalks X]
  {U : X.Opens} (hU : IsAffineOpen U)
  [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))

theorem actualAffineChartDivisorRestriction_add_tensor
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    actualAffineChartDivisorRestriction hU hfield (D + E) =
      actualAffineChartDivisorRestriction hU hfield D +
        actualAffineChartDivisorRestriction hU hfield E := by
  ext v
  obtain ⟨x, rfl⟩ := (actualAffineChartClosedPointEquiv hU hfield).surjective v
  change actualAffineChartDivisorRestriction hU hfield (D + E)
    (chartHeightOne hU hfield x) =
      actualAffineChartDivisorRestriction hU hfield D (chartHeightOne hU hfield x) +
        actualAffineChartDivisorRestriction hU hfield E (chartHeightOne hU hfield x)
  simp only [Finsupp.add_apply, actualAffineChartDivisorRestriction_coefficient]

/-- On an ORIGINAL nonempty affine chart, the entire true sections
of O(D) tensor the true sections of O(E) to the true sections of O(D+E).
This derives the tensor equivalence from actual original fraction-ideal
multiplication, with the same original rational field and scalar ring. -/
noncomputable def actualAffineDivisorSectionTensorEquiv
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    (actualSchemeDivisorSheaf X D).val.obj (op U) ⊗[Γ(X, U)]
      (actualSchemeDivisorSheaf X E).val.obj (op U) ≃ₗ[Γ(X, U)]
        (actualSchemeDivisorSheaf X (D + E)).val.obj (op U) := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  let D' := actualAffineChartDivisorRestriction hU hfield D
  let E' := actualAffineChartDivisorRestriction hU hfield E
  have hprod :
      ((actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField D').val :
        Submodule Γ(X, U) X.functionField) ⊗[Γ(X, U)]
      ((actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField E').val :
        Submodule Γ(X, U) X.functionField) ≃ₗ[Γ(X, U)]
      ((actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
        (actualAffineChartDivisorRestriction hU hfield (D + E))).val :
          Submodule Γ(X, U) X.functionField) := by
    rw [actualAffineChartDivisorRestriction_add_tensor hU hfield]
    exact actualDedekindSectionTensorEquiv Γ(X, U) X.functionField D' E'
  exact ((TensorProduct.congr
    (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield D)
    (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield E)).trans hprod).trans
      (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield (D + E)).symm

end Litt3.Jacobians
