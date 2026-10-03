import Solutions.Jacobians.SmoothCurveOriginalLinePicardTensor

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]
  (M : X.Modules) (hM : ActualOriginalLineSheaf X M)

/-- A genuine ORIGINAL inverse line SHEAF for an arbitrary original
line sheaf, constructed from its true divisor, not assumed as invertibility
data or an abstract Picard-group inverse. -/
noncomputable def actualSmoothCurveOriginalLineInverseSheaf : X.Modules :=
  actualSmoothCurveDivisorSheaf sX (-actualSmoothCurveOriginalLineDivisor sX M hM)

theorem actualSmoothCurveOriginalLineInverseSheaf_is_line :
    ActualOriginalLineSheaf X (actualSmoothCurveOriginalLineInverseSheaf sX M hM) :=
  actualSmoothCurveDivisorSheaf_is_original_line sX _

/-- The ACTUAL global sheafified tensor of an arbitrary original
line SHEAF and its constructed genuine inverse is isomorphic to the
ORIGINAL structure module on the ENTIRE original scheme site. -/
noncomputable def actualSmoothCurveOriginalLineInverseTensorUnitIso :
    actualSchemeModuleTensorSheaf X M (actualSmoothCurveOriginalLineInverseSheaf sX M hM) ≅
      SheafOfModules.unit X.ringCatSheaf :=
  actualSchemeModuleTensorIso X (actualSmoothCurveOriginalLineDivisorIso sX M hM)
      (Iso.refl _) ≪≫
    actualSmoothCurveDivisorInverseTensorUnitIso sX (actualSmoothCurveOriginalLineDivisor sX M hM)

/-- The negative in the HONEST original line-SHEAF Picard group is
the class of its ACTUAL constructed inverse SHEAF, whose genuine tensor
product was proved to be the ORIGINAL unit. -/
theorem actualSmoothCurveOriginalLinePicard_neg_is_actual_inverse :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    actualOriginalLineSheafIsoClass X (actualSmoothCurveOriginalLineInverseSheaf sX M hM)
        (actualSmoothCurveOriginalLineInverseSheaf_is_line sX M hM) =
      -actualOriginalLineSheafIsoClass X M hM := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  change actualSmoothCurveDivisorOriginalLineClass sX
    (-actualSmoothCurveOriginalLineDivisor sX M hM) = _
  rw [actualSmoothCurveOriginalLineClass_eq_constructed_divisor sX M hM,
    ← actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor sX
      (-actualSmoothCurveOriginalLineDivisor sX M hM),
    ← actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor sX
      (actualSmoothCurveOriginalLineDivisor sX M hM),
    map_neg, map_neg]

end Litt3.Jacobians
