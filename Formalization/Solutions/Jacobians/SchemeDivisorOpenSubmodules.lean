import Solutions.Jacobians.ActualRationalFunctionEvaluation
import Solutions.Jacobians.SchemeSectionValuationBounds

open CategoryTheory Opposite AlgebraicGeometry
open scoped WithZero

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]

/-- The ACTUAL original rational functions on every actual open, bounded
by D at precisely the original closed points of that open. This is a true
submodule over the original structure-sheaf ring on that open. -/
noncomputable def actualSchemeDivisorOpenSubmodule
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (U : X.Opensᵒᵖ) :
    Submodule (X.ringCatSheaf.val.obj U)
      ((actualSchemeRationalFunctionModuleSheaf X).val.obj U) where
  carrier := {a | ∀ (x : Litt3.SharedTensors.ClosedPoint X) (hx : x.val ∈ U.unop),
    closedPointValuation X x (actualRationalFunctionEvaluation X U.unop x.val hx a) ≤
      WithZero.exp (D x)}
  zero_mem' := by
    intro x hx
    rw [map_zero, map_zero]
    exact bot_le
  add_mem' := by
    intro a b ha hb x hx
    rw [map_add]
    exact (closedPointValuation X x).map_add_le (ha x hx) (hb x hx)
  smul_mem' := by
    intro r a ha x hx
    letI : Nonempty U.unop := ⟨⟨x.val, hx⟩⟩
    rw [actualRationalFunctionEvaluation_smul, map_mul]
    calc
      closedPointValuation X x (algebraMap Γ(X, U.unop) X.functionField r) *
          closedPointValuation X x (actualRationalFunctionEvaluation X U.unop x.val hx a) ≤
        1 * closedPointValuation X x
          (actualRationalFunctionEvaluation X U.unop x.val hx a) :=
        mul_le_mul_right' (actual_section_function_field_valuation_le_one X U.unop r x hx) _
      _ ≤ WithZero.exp (D x) := by simpa only [one_mul] using ha x hx

/-- Genuine original restrictions preserve precisely the original
closed-point valuation bounds on their smaller opens. -/
theorem actualSchemeDivisorOpenSubmodule_restriction
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    {U V : X.Opensᵒᵖ} (i : U ⟶ V)
    (a : (actualSchemeRationalFunctionModuleSheaf X).val.obj U)
    (ha : a ∈ actualSchemeDivisorOpenSubmodule X D U) :
    (actualSchemeRationalFunctionModuleSheaf X).val.map i a ∈
      actualSchemeDivisorOpenSubmodule X D V := by
  intro x hx
  change closedPointValuation X x
    (actualRationalFunctionEvaluation X V.unop x.val hx
      ((actualSchemeRationalFunctionRingSheaf X).val.map i a)) ≤ _
  have h := RingHom.congr_fun
    (actualRationalFunctionEvaluation_restriction X i.unop x.val hx) a
  change actualRationalFunctionEvaluation X V.unop x.val hx
    ((actualSchemeRationalFunctionRingSheaf X).val.map i a) =
      actualRationalFunctionEvaluation X U.unop x.val (i.unop.le hx) a at h
  rw [h]
  exact ha x (i.unop.le hx)

end Litt3.Jacobians
