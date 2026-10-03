import Solutions.Jacobians.SmoothCurveOriginalLineDivisors

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]
  (M : X.Modules) (hM : ActualOriginalLineSheaf X M)

/-- The derived whole divisor has the exact negative original
generator order on EVERY original frame neighborhood, not merely on the
neighborhood chosen in the coefficient definition. -/
theorem actualSmoothCurveOriginalLineDivisor_coefficient_in_frame
    (U : X.Opens) [Nonempty U]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (x : Litt3.SharedTensors.ClosedPoint X) (hx : x.val ∈ U) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    actualSmoothCurveOriginalLineDivisor sX M hM x =
      -valuationOrder (closedPointValuation X x)
        (Additive.ofMul (Units.mk0 (actualOriginalLineFrameRationalGenerator X M hM U e)
          (actualOriginalLineFrameRationalGenerator_ne_zero X M hM U e))) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  change -valuationOrder (closedPointValuation X x)
    (Additive.ofMul (actualOriginalLinePointRationalUnit X M hM x.val)) = _
  exact congrArg Neg.neg (actualOriginalLinePointRationalUnit_order_eq_frame X M hM x U e hx)

end Litt3.Jacobians
