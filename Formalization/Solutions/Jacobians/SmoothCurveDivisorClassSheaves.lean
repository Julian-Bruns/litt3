import Solutions.Jacobians.SmoothCurveDivisorSheafPrincipalKernel
import Solutions.Jacobians.ValuationDivisorClasses

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]

/-- The kernel of the genuine ORIGINAL divisor-class quotient is
exactly genuine triviality of the ACTUAL global divisor SHEAF. This is
not an asserted identification with an abstract geometric Picard scheme. -/
theorem actual_smooth_curve_divisor_class_zero_iff_sheaf_trivial
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    divisorClassMap (schemeDivisorSystem X) D = 0 ↔
      Nonempty (actualSmoothCurveDivisorSheaf sX D ≅ SheafOfModules.unit X.ringCatSheaf) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  rw [divisor_class_zero_iff_principal]
  constructor
  · rintro ⟨f, hf⟩
    exact (actual_smooth_curve_divisor_sheaf_trivial_iff_principal sX D).mpr ⟨f.toMul, hf⟩
  · intro he
    obtain ⟨f, hf⟩ :=
      (actual_smooth_curve_divisor_sheaf_trivial_iff_principal sX D).mp he
    exact ⟨Additive.ofMul f, hf⟩

/-- Actual integer torsion of the original divisor class is exactly
triviality of the ACTUAL sheaf of the multiplied divisor. No tensor
sheafification or Jacobian realization is silently assumed. -/
theorem actual_smooth_curve_divisor_class_torsion_iff_sheaf_trivial
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (N : ℕ) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    N • divisorClassMap (schemeDivisorSystem X) D = 0 ↔
      Nonempty (actualSmoothCurveDivisorSheaf sX (N • D) ≅
        SheafOfModules.unit X.ringCatSheaf) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  rw [← map_nsmul]
  exact actual_smooth_curve_divisor_class_zero_iff_sheaf_trivial sX (N • D)

end Litt3.Jacobians
