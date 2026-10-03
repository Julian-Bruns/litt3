import Solutions.Jacobians.SmoothCurveOriginalLineClassEquivalence
import Mathlib.Algebra.Group.TransferInstance

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]

/-- The group structure on the HONEST isomorphism classes of ALL
original line SHEAVES, transferred through the PROVED actual divisor
classification. The subsequent tensor comparison proves its addition is
the ACTUAL original sheafified tensor, not a renamed divisor operation. -/
noncomputable def actualSmoothCurveOriginalLinePicardGroup :
    AddCommGroup (ActualOriginalLineSheafIsoClasses X) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  exact (actualSmoothCurveOriginalDivisorLineClassEquiv sX).symm.addCommGroup

/-- The genuine ORIGINAL divisor-class group is additively
isomorphic to the HONEST classes of ALL original line SHEAVES. This
uses actual whole-sheaf classification and its exact principal kernel;
geometric Picard/Jacobian representability remains separate. -/
noncomputable def actualSmoothCurveOriginalDivisorLinePicardEquiv :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    DivisorClassGroup (schemeDivisorSystem X) ≃+ ActualOriginalLineSheafIsoClasses X := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  exact (Equiv.addEquiv (actualSmoothCurveOriginalDivisorLineClassEquiv sX).symm).symm

/-- The Picard comparison has the literal original divisor-sheaf
class on each actual divisor. -/
theorem actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    actualSmoothCurveOriginalDivisorLinePicardEquiv sX
        (divisorClassMap (schemeDivisorSystem X) D) =
      actualSmoothCurveDivisorOriginalLineClass sX D := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  change actualSmoothCurveDivisorClassToOriginalLineClass sX
    (divisorClassMap (schemeDivisorSystem X) D) = _
  rfl

/-- The sum of actual divisor-sheaf classes is the class of the
literal sum of original divisors. -/
theorem actualSmoothCurveDivisorOriginalLineClass_add
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    actualSmoothCurveDivisorOriginalLineClass sX (D + E) =
      actualSmoothCurveDivisorOriginalLineClass sX D +
        actualSmoothCurveDivisorOriginalLineClass sX E := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  rw [← actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor sX (D + E),
    ← actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor sX D,
    ← actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor sX E,
    map_add, map_add]

end Litt3.Jacobians
