import Solutions.Jacobians.SmoothCurveOriginalLineFrameCoefficients
import Solutions.Jacobians.SchemeSectionValuationBounds

open CategoryTheory Opposite AlgebraicGeometry
open scoped WithZero

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]
  (M : X.Modules) (hM : ActualOriginalLineSheaf X M)

/-- The normalized actual generator valuation equals the literal
bound of the constructed original divisor on its entire frame open. -/
theorem actualSmoothCurveOriginalLineFrame_generator_valuation
    (U : X.Opens) [Nonempty U]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (x : Litt3.SharedTensors.ClosedPoint X) (hx : x.val ∈ U) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    closedPointValuation X x (actualOriginalLineFrameRationalGenerator X M hM U e) =
      WithZero.exp (actualSmoothCurveOriginalLineDivisor sX M hM x) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  rw [actualSmoothCurveOriginalLineDivisor_coefficient_in_frame sX M hM U e x hx]
  exact Litt3.SharedTensors.valuation_value_eq_exp_neg_order (closedPointValuation X x)
    (Additive.ofMul (Units.mk0 (actualOriginalLineFrameRationalGenerator X M hM U e)
      (actualOriginalLineFrameRationalGenerator_ne_zero X M hM U e)))

/-- EVERY genuine original line-sheaf section on EVERY nonempty
original open satisfies the literal closed-point valuation bounds of its
constructed divisor. The local original frame, coefficient and order
comparison are all derived, with no rational regularity input. -/
theorem actualSmoothCurveOriginalLine_section_valuation_bound
    (U : X.Opens) [Nonempty U] (a : M.val.obj (op U))
    (x : Litt3.SharedTensors.ClosedPoint X) (hx : x.val ∈ U) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    closedPointValuation X x (actualOriginalLineSheafGenericValue X M hM U a) ≤
      WithZero.exp (actualSmoothCurveOriginalLineDivisor sX M hM x) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  let W := actualOriginalLinePointOpen X M hM x.val
  let e := actualOriginalLinePointFrame X M hM x.val
  have hxW : x.val ∈ W := actualOriginalLinePointOpen_contains X M hM x.val
  letI : Nonempty W := actualOriginalLinePointOpen_nonempty X M hM x.val
  let V := U ⊓ W
  letI : Nonempty V := ⟨⟨x.val, hx, hxW⟩⟩
  let i : V ⟶ U := homOfLE inf_le_left
  let j : V ⟶ W := homOfLE inf_le_right
  let b := M.val.map i.op a
  let c := actualOriginalLineFrameSectionEquiv X M W e V j b
  have hres := actualOriginalLineSheafGenericValue_restriction X M hM i a
  have hvalue := actualOriginalLineFrameRationalGenerator_apply_subopen X M hM W e V j b
  have hgen := actualSmoothCurveOriginalLineFrame_generator_valuation sX M hM W e x hxW
  have hcoeff := actual_section_function_field_valuation_le_one X V c x ⟨hx, hxW⟩
  rw [← hres, hvalue, map_mul, hgen]
  exact (mul_le_mul_right' hcoeff _).trans_eq (one_mul _)

end Litt3.Jacobians
