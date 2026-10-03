import Solutions.SharedTensors.SmoothCurveFiniteSupport
import Solutions.SharedTensors.SmoothCurvePointStrata
import Solutions.SharedTensors.ProperSchemeGlobalConstants
import Solutions.CartierAndSpin.NormalizedDVRBoundary
import Definitions.Jacobians.PrincipalPullbacks

open CategoryTheory AlgebraicGeometry
open scoped WithZero

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [IsProper sX]

/-- The kernel of the ORIGINAL principal divisor map on the actual
proper smooth integral curve consists of actual constant units.
All local DVR, finite support, local regularity and global sheaf gluing
inputs are derived. No principal-kernel-constants premise is used. -/
theorem actual_proper_smooth_curve_principal_kernel_constants :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_proper_smooth_curve_finite_principal_support sX
    ∀ u : Additive X.functionFieldˣ,
      principalDivisorMap (schemeDivisorSystem X) u = 0 →
      ∃ a : Additive kˣ, rationalUnitPullback (genericBaseFieldHom sX) a = u := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_proper_smooth_curve_finite_principal_support sX
  intro u hdiv
  have hregular : ∀ x : ClosedPoint X, ∃ r : X.presheaf.stalk x.val,
      algebraMap (X.presheaf.stalk x.val) X.functionField r = u.toMul.val := by
    intro x
    let v := closedPointValuation X x
    have horder : valuationOrder v u = 0 := by
      exact congrArg (fun D : Divisor (ClosedPoint X) => D x) hdiv
    have hlog : WithZero.log (v u.toMul.val) = 0 := by
      have h := Litt3.CartierAndSpin.integerFieldOrder_eq_valuationOrder v u.toMul
      change Litt3.CartierAndSpin.integerFieldOrder v u.toMul.val = valuationOrder v u at h
      rw [horder] at h
      change -WithZero.log (v u.toMul.val) = 0 at h
      exact neg_eq_zero.mp h
    have hvalue : v u.toMul.val = 1 := by
      rw [← WithZero.exp_log ((Valuation.ne_zero_iff v).mpr u.toMul.ne_zero),
        hlog, WithZero.exp_zero]
    have hv : v.Integers (X.presheaf.stalk x.val) :=
      Litt3.CartierAndSpin.dvr_height_one_valuation_integers
    exact hv.exists_of_le_one (by rw [hvalue])
  have hregularAll := (actual_smooth_curve_closed_regular_iff_everywhere
    sX u.toMul.val).mp hregular
  obtain ⟨c, hc⟩ := actual_universally_closed_regular_rational_function_constant
    sX u.toMul.val hregularAll
  have hczero : c ≠ 0 := by
    intro hz
    apply u.toMul.ne_zero
    rw [← hc, hz, map_zero]
  refine ⟨Additive.ofMul (Units.mk0 c hczero), ?_⟩
  apply Additive.toMul.injective
  apply Units.ext
  exact hc

end Litt3.SharedTensors
