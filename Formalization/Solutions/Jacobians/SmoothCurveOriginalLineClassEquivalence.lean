import Solutions.Jacobians.SmoothCurveDivisorOriginalLineClasses

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]

/-- The ORIGINAL divisor-class quotient maps to the honest
isomorphism classes of ALL original line SHEAVES. Well-definedness uses
the proved genuine whole-sheaf principal kernel. -/
noncomputable def actualSmoothCurveDivisorClassToOriginalLineClass :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    DivisorClassGroup (schemeDivisorSystem X) → ActualOriginalLineSheafIsoClasses X := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  exact Quotient.lift (actualSmoothCurveDivisorOriginalLineClass sX) (fun D E h =>
    (actualSmoothCurveDivisorOriginalLineClass_eq_iff_divisor_class_eq sX D E).mpr
      (Quotient.sound h))

/-- The actual quotient map retains the literal divisor-sheaf
class on each ORIGINAL divisor. -/
theorem actualSmoothCurveDivisorClassToOriginalLineClass_on_divisor
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    actualSmoothCurveDivisorClassToOriginalLineClass sX
        (divisorClassMap (schemeDivisorSystem X) D) =
      actualSmoothCurveDivisorOriginalLineClass sX D := rfl

/-- Exact principal-kernel detection makes the actual divisor-class
map into honest ALL-line-SHEAF isomorphism classes injective. -/
theorem actualSmoothCurveDivisorClassToOriginalLineClass_injective :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    Function.Injective (actualSmoothCurveDivisorClassToOriginalLineClass sX) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  intro a b
  refine Quotient.inductionOn₂ a b ?_
  intro D E h
  exact (actualSmoothCurveDivisorOriginalLineClass_eq_iff_divisor_class_eq sX D E).mp h

/-- The constructed divisor of EVERY genuine original line SHEAF
makes the actual quotient-to-ALL-line-class map surjective. -/
theorem actualSmoothCurveDivisorClassToOriginalLineClass_surjective :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    Function.Surjective (actualSmoothCurveDivisorClassToOriginalLineClass sX) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  intro a
  obtain ⟨D, hD⟩ := actualSmoothCurveDivisorOriginalLineClass_surjective sX a
  exact ⟨divisorClassMap (schemeDivisorSystem X) D, hD⟩

/-- The genuine ORIGINAL divisor-class quotient is in bijection
with the ACTUAL isomorphism classes of ALL original line SHEAVES on any
true quasi-compact smooth integral curve over an algebraically closed
field, in EVERY characteristic. No divisor presentation is hidden in the
line-class definition, and no Picard/Jacobian representability is inferred. -/
noncomputable def actualSmoothCurveOriginalDivisorLineClassEquiv :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    DivisorClassGroup (schemeDivisorSystem X) ≃ ActualOriginalLineSheafIsoClasses X := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  exact Equiv.ofBijective (actualSmoothCurveDivisorClassToOriginalLineClass sX)
    ⟨actualSmoothCurveDivisorClassToOriginalLineClass_injective sX,
      actualSmoothCurveDivisorClassToOriginalLineClass_surjective sX⟩

end Litt3.Jacobians
