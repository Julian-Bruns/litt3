import Solutions.CartierAndSpin.PrimitiveCriticalIntegrality
import Solutions.SharedTensors.SmoothCurveDVRStalks

namespace Litt3.CartierAndSpin

open CategoryTheory AlgebraicGeometry Polynomial

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {Z : Scheme.{u}} [IsIntegral Z]

/-- The exact critical quotient has genuine coefficients in the original
closed-point stalk on an actual smooth integral curve, from primitive
content and the actual integral numerator/interpolator identity. The DVR
and GCD properties are derived from the actual smooth structure morphism. -/
theorem smooth_curve_critical_quotient_is_integral
    (sZ : Z ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sZ]
    (P : Litt3.SharedTensors.ClosedPoint Z)
    (F D U V2 : (Z.presheaf.stalk P.val)[X]) (j : ℕ)
    (hunit : IsUnit (F.coeff j)) (Q : Z.functionField[X])
    (hidentity : (U.map (algebraMap (Z.presheaf.stalk P.val) Z.functionField)) ^ 2 -
      F.map (algebraMap (Z.presheaf.stalk P.val) Z.functionField) * Q =
      D.map (algebraMap (Z.presheaf.stalk P.val) Z.functionField) *
        V2.map (algebraMap (Z.presheaf.stalk P.val) Z.functionField)) :
    ∃ Q0 : (Z.presheaf.stalk P.val)[X],
      Q0.map (algebraMap (Z.presheaf.stalk P.val) Z.functionField) = Q ∧
      U ^ 2 - F * Q0 = D * V2 := by
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sZ P
  exact dvr_critical_quotient_is_integral F D U V2 j hunit Q hidentity

end Litt3.CartierAndSpin
