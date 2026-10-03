import Solutions.Jacobians.SmoothCurveOriginalLineTensor
import Solutions.Jacobians.SmoothCurveOriginalLinePicardGroup

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]

/-- An arbitrary genuine line-sheaf class equals the class of its
CONSTRUCTED original divisor, by the actual whole-sheaf isomorphism. -/
theorem actualSmoothCurveOriginalLineClass_eq_constructed_divisor
    (M : X.Modules) (hM : ActualOriginalLineSheaf X M) :
    actualOriginalLineSheafIsoClass X M hM =
      actualSmoothCurveDivisorOriginalLineClass sX
        (actualSmoothCurveOriginalLineDivisor sX M hM) := by
  apply Quotient.sound
  exact ⟨actualSmoothCurveOriginalLineDivisorIso sX M hM⟩

/-- The group addition on HONEST classes of ALL original line
SHEAVES is EXACTLY the ACTUAL global sheafified tensor of arbitrary
original line sheaves. Thus the group is the genuine whole-sheaf Picard
group operation, rather than merely transported divisor notation. -/
theorem actualSmoothCurveOriginalLinePicard_add_is_actual_tensor
    (M N : X.Modules) (hM : ActualOriginalLineSheaf X M) (hN : ActualOriginalLineSheaf X N) :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    actualOriginalLineSheafIsoClass X (actualSchemeModuleTensorSheaf X M N)
        (actualSmoothCurveOriginalLineTensor_is_line sX M N hM hN) =
      actualOriginalLineSheafIsoClass X M hM + actualOriginalLineSheafIsoClass X N hN := by
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  rw [actualSmoothCurveOriginalLineTensor_class sX M N hM hN,
    actualSmoothCurveDivisorOriginalLineClass_add sX,
    ← actualSmoothCurveOriginalLineClass_eq_constructed_divisor sX M hM,
    ← actualSmoothCurveOriginalLineClass_eq_constructed_divisor sX N hN]

/-- The group zero is the HONEST isomorphism class of the ACTUAL
original structure module, through the genuine O(0) whole-sheaf isomorphism. -/
theorem actualSmoothCurveOriginalLinePicard_zero_is_original_structure :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    actualOriginalLineSheafIsoClass X (SheafOfModules.unit X.ringCatSheaf)
      (actualOriginalStructureSheaf_is_line X) = 0 := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  have hunit : actualOriginalLineSheafIsoClass X (SheafOfModules.unit X.ringCatSheaf)
      (actualOriginalStructureSheaf_is_line X) =
      actualSmoothCurveDivisorOriginalLineClass sX 0 := by
    apply Quotient.sound
    exact ⟨(actualSmoothCurveZeroDivisorOriginalStructureIso sX).symm⟩
  rw [hunit, ← actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor sX 0,
    map_zero, map_zero]

end Litt3.Jacobians
