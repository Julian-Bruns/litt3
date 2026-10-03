import Solutions.SharedTensors.RationalDifferentialDivisorClasses
import Solutions.SharedTensors.RationalLineCoordinates

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.CartierAndSpin Litt3.QuotientGeometry
open scoped WithZero

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [CompactSpace X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- The ORIGINAL rational differential coefficient satisfies the actual
divisor bound iff its multiple of the original form is in the ENTIRE
original point-stalk differential image. The sign and zero case are proved. -/
theorem actual_differential_divisor_bound_iff_local_regular :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (a : X.functionField) (x : ClosedPoint X),
      closedPointValuation X x a ≤ WithZero.exp (actualRationalDifferentialDivisor sX omega h x) ↔
        a • omega ∈ schemeLocalRegularDifferentials sX x.val := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  intro omega h a x
  by_cases ha : a = 0
  · subst a
    simp only [map_zero, zero_smul, Submodule.zero_mem, iff_true]
    exact bot_le
  · let u : X.functionFieldˣ := Units.mk0 a ha
    have hv := valuation_value_eq_exp_neg_order (closedPointValuation X x) (Additive.ofMul u)
    change closedPointValuation X x a = WithZero.exp (-valuationOrder
      (closedPointValuation X x) (Additive.ofMul u)) at hv
    rw [hv, WithZero.exp_le_exp]
    change -valuationOrder (closedPointValuation X x) (Additive.ofMul u) ≤
        actualRationalDifferentialDivisor sX omega h x ↔
      ((u : X.functionField) • omega) ∈ schemeLocalRegularDifferentials sX x.val
    rw [← actual_smooth_nonnegative_differential_order_iff_regular sX
      ((u : X.functionField) • omega) (rational_line_smul_ne_zero u omega h) x]
    rw [actual_smooth_differential_order_smul sX u omega h x]
    change -valuationOrder (closedPointValuation X x) (Additive.ofMul u) ≤
        smoothCurveRationalDifferentialOrder sX omega h x ↔
      0 ≤ valuationOrder (closedPointValuation X x) (Additive.ofMul u) +
        smoothCurveRationalDifferentialOrder sX omega h x
    omega

end Litt3.SharedTensors
