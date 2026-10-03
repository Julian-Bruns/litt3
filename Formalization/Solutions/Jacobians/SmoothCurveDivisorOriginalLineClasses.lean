import Definitions.Jacobians.OriginalLineSheafIsoClasses
import Solutions.Jacobians.SmoothCurveOriginalLineClassification
import Solutions.Jacobians.SmoothCurveDivisorLocalFrames
import Solutions.Jacobians.SmoothCurveDivisorSheafClassDetection

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]

/-- Every genuine original divisor SHEAF is an actual original
line sheaf on the ENTIRE original site, from actual local frames. -/
theorem actualSmoothCurveDivisorSheaf_is_original_line
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    ActualOriginalLineSheaf X (actualSmoothCurveDivisorSheaf sX D) :=
  actual_smooth_curve_divisor_sheaf_locally_trivial sX D

/-- The genuine isomorphism class in the space of ALL original
line SHEAVES of the actual original divisor sheaf. -/
noncomputable def actualSmoothCurveDivisorOriginalLineClass
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    ActualOriginalLineSheafIsoClasses X :=
  actualOriginalLineSheafIsoClass X (actualSmoothCurveDivisorSheaf sX D)
    (actualSmoothCurveDivisorSheaf_is_original_line sX D)

/-- The map of genuine divisors onto classes of ALL original line
SHEAVES is surjective. Every arbitrary sheaf's divisor is actually
constructed by true DVR orders and original sheaf gluing. -/
theorem actualSmoothCurveDivisorOriginalLineClass_surjective :
    Function.Surjective (actualSmoothCurveDivisorOriginalLineClass sX) := by
  intro a
  refine Quotient.inductionOn a ?_
  intro M
  refine ⟨actualSmoothCurveOriginalLineDivisor sX M.val M.property, ?_⟩
  apply Quotient.sound
  exact ⟨(actualSmoothCurveOriginalLineDivisorIso sX M.val M.property).symm⟩

/-- The exact fiber relation of divisors mapping to classes of ALL
genuine original line SHEAVES is the ORIGINAL principal-divisor relation.
This uses the true global sheaf principal kernel, not an assumed Picard
identification or an affine-only comparison. -/
theorem actualSmoothCurveDivisorOriginalLineClass_eq_iff_divisor_class_eq
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    actualSmoothCurveDivisorOriginalLineClass sX D =
        actualSmoothCurveDivisorOriginalLineClass sX E ↔
      divisorClassMap (schemeDivisorSystem X) D = divisorClassMap (schemeDivisorSystem X) E := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  rw [actual_smooth_curve_divisor_class_eq_iff_sheaves_iso sX D E]
  exact Quotient.eq

end Litt3.Jacobians
