import Solutions.SharedTensors.SmoothCurvePrincipalKernel
import Solutions.SharedTensors.ConstantPrincipalDivisors

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [IsProper sX]

/-- The kernel of the genuine original principal divisor map is EXACTLY
the pulled-back constant units, with every geometric input derived. -/
theorem actual_proper_smooth_curve_principal_zero_iff_constant :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_proper_smooth_curve_finite_principal_support sX
    ∀ u : Additive X.functionFieldˣ,
      principalDivisorMap (schemeDivisorSystem X) u = 0 ↔
      ∃ a : Additive kˣ, rationalUnitPullback (genericBaseFieldHom sX) a = u := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_proper_smooth_curve_finite_principal_support sX
  intro u
  constructor
  · exact actual_proper_smooth_curve_principal_kernel_constants sX u
  · rintro ⟨a, rfl⟩
    exact scheme_constant_principal_divisor_zero sX a

/-- Literal equality of the original principal kernel and constant
unit image. This is a subgroup equality in the original function field,
not an independently specified abstract divisor system. -/
theorem actual_proper_smooth_curve_principal_kernel_eq_constant_range :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_proper_smooth_curve_finite_principal_support sX
    (principalDivisorMap (schemeDivisorSystem X)).ker =
      (rationalUnitPullback (genericBaseFieldHom sX)).range := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_proper_smooth_curve_finite_principal_support sX
  ext u
  exact actual_proper_smooth_curve_principal_zero_iff_constant sX u

end Litt3.SharedTensors
