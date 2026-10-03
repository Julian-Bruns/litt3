import Solutions.SharedTensors.SmoothCurveDVRStalks

namespace Litt3.CartierAndSpin

open CategoryTheory AlgebraicGeometry
open scoped WithZero

universe u

/-- The literal closed-point valuation on an actual smooth integral
curve, constructing its DVR stalk from the structure morphism. -/
noncomputable def smoothCurveClosedPointValuation
    {k : Type u} [Field k] [IsAlgClosed k] {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (P : Litt3.SharedTensors.ClosedPoint X) : Valuation X.functionField ℤᵐ⁰ := by
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  exact Litt3.Jacobians.closedPointValuation X P

end Litt3.CartierAndSpin
