import Solutions.Jacobians.SmoothCurveOriginalLinePicardPullbacks

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
  [IsSmoothOfRelativeDimension 1 sX] [IsSmoothOfRelativeDimension 1 sY]
  [QuasiCompact sX] [QuasiCompact sY]
  (s : Litt3.SharedTensors.FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sW : s.source ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sW] [QuasiCompact sW]

/-- On a genuine finite etale span, BOTH actual categorical divisor
SHEAF pullbacks are isomorphic to their literal pulled divisor sheaves
on the SAME original source. Neither actual morphism is discarded or
replaced by a simultaneous Galois closure. -/
theorem actualSmoothCurveSameSourceDivisorPullbackIsos
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (E : Divisor (Litt3.SharedTensors.ClosedPoint Y)) :
    Nonempty ((actualSchemeModulePullback s.left).obj (actualSmoothCurveDivisorSheaf sX D) ≅
      actualSmoothCurveDivisorSheaf sW (Litt3.SharedTensors.schemeDivisorPullback s.left D)) ∧
    Nonempty ((actualSchemeModulePullback s.right).obj (actualSmoothCurveDivisorSheaf sY E) ≅
      actualSmoothCurveDivisorSheaf sW (Litt3.SharedTensors.schemeDivisorPullback s.right E)) :=
  ⟨⟨actualSmoothCurveFiniteEtaleDivisorPullbackIso sW sX s.left D⟩,
    ⟨actualSmoothCurveFiniteEtaleDivisorPullbackIso sW sY s.right E⟩⟩

/-- Actual global isomorphism of BOTH categorical pulled divisor
SHEAVES is equivalent to equality of their genuine divisor classes on
the SAME original source. This is an exact two-leg bridge, with the
source and both finite etale morphisms retained throughout. -/
theorem actualSmoothCurveSameSourcePullbackIso_iff_divisor_classes
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (E : Divisor (Litt3.SharedTensors.ClosedPoint Y)) :
    letI : ClosedPointDVRStalks s.source :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sW
    letI : FinitePrincipalSupport s.source :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sW
    Nonempty ((actualSchemeModulePullback s.left).obj (actualSmoothCurveDivisorSheaf sX D) ≅
      (actualSchemeModulePullback s.right).obj (actualSmoothCurveDivisorSheaf sY E)) ↔
      divisorClassMap (schemeDivisorSystem s.source)
          (Litt3.SharedTensors.schemeDivisorPullback s.left D) =
        divisorClassMap (schemeDivisorSystem s.source)
          (Litt3.SharedTensors.schemeDivisorPullback s.right E) := by
  letI : ClosedPointDVRStalks s.source :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sW
  letI : FinitePrincipalSupport s.source :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sW
  let eL := actualSmoothCurveFiniteEtaleDivisorPullbackIso sW sX s.left D
  let eR := actualSmoothCurveFiniteEtaleDivisorPullbackIso sW sY s.right E
  rw [actual_smooth_curve_divisor_class_eq_iff_sheaves_iso sW]
  constructor
  · rintro ⟨e⟩
    exact ⟨eL.symm ≪≫ e ≪≫ eR⟩
  · rintro ⟨e⟩
    exact ⟨eL ≪≫ e ≪≫ eR.symm⟩

end Litt3.Jacobians
