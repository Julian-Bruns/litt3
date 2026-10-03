import Definitions.Jacobians.SchemeDivisors
import Mathlib.AlgebraicGeometry.FunctionField

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]

/-- Every ORIGINAL section on an ORIGINAL open is integral at each
original closed point of that open, in its true normalized DVR valuation. -/
theorem actual_section_function_field_valuation_le_one
    (U : X.Opens) [Nonempty U] (a : Γ(X, U))
    (x : Litt3.SharedTensors.ClosedPoint X) (hx : x.val ∈ U) :
    closedPointValuation X x (algebraMap Γ(X, U) X.functionField a) ≤ 1 := by
  let xU : U := ⟨x.val, hx⟩
  letI := X.presheaf.algebra_section_stalk xU
  letI := functionField_isScalarTower X U xU
  rw [IsScalarTower.algebraMap_apply Γ(X, U) (X.presheaf.stalk x.val) X.functionField]
  exact (discreteValuationPlace (X.presheaf.stalk x.val)).valuation_le_one _

end Litt3.Jacobians
