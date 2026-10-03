import Solutions.SharedTensors.RationalDifferentialDivisors
import Solutions.SharedTensors.SmoothCurveDifferentialOrderCalculus
import Solutions.SharedTensors.RationalLineCoordinates

open CategoryTheory AlgebraicGeometry
open scoped WithZero

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- A coefficient in the SAME original function field satisfies the
original pole bound precisely when its product with the original form
is in the ENTIRE original local differential image. Zero is included. -/
theorem actual_differential_coefficient_bound_iff_regular :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (a : X.functionField) (x : ClosedPoint X),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      closedPointValuation X x a ≤
          WithZero.exp (smoothCurveRationalDifferentialOrder sX omega h x) ↔
        a • omega ∈ schemeLocalRegularDifferentials sX x.val := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h a x
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  by_cases ha : a = 0
  · subst a
    simp only [map_zero, zero_smul, Submodule.zero_mem, iff_true]
    exact bot_le
  · let au : X.functionFieldˣ := Units.mk0 a ha
    have hs := rational_line_smul_ne_zero au omega h
    change closedPointValuation X x (au : X.functionField) ≤
        WithZero.exp (smoothCurveRationalDifferentialOrder sX omega h x) ↔
      (au : X.functionField) • omega ∈ schemeLocalRegularDifferentials sX x.val
    rw [← actual_smooth_nonnegative_differential_order_iff_regular sX
      ((au : X.functionField) • omega) hs x,
      actual_smooth_differential_order_smul sX au omega h x]
    have hv := valuation_value_eq_exp_neg_order (closedPointValuation X x)
      (Additive.ofMul au)
    change closedPointValuation X x (au : X.functionField) =
      WithZero.exp (-valuationOrder (closedPointValuation X x) (Additive.ofMul au)) at hv
    rw [hv, WithZero.exp_le_exp]
    omega

/-- On every original open, the actual divisor of the original form
gives exactly the coefficients of original regular rational differentials. -/
theorem actual_differential_divisor_open_bounds_iff_regular [CompactSpace X] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (U : X.Opens) (a : X.functionField),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      (∀ (x : ClosedPoint X), x.val ∈ U →
        closedPointValuation X x a ≤ WithZero.exp (actualRationalDifferentialDivisor sX omega h x)) ↔
      ∀ (x : ClosedPoint X), x.val ∈ U →
        a • omega ∈ schemeLocalRegularDifferentials sX x.val := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h U a
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  exact forall_congr' fun x => forall_congr' fun _ =>
    actual_differential_coefficient_bound_iff_regular sX omega h a x

end Litt3.SharedTensors
