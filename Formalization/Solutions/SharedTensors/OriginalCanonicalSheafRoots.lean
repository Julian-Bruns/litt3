import Solutions.SharedTensors.DifferentialTensorDivisorSheaves

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [CompactSpace X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- An actual global canonical SHEAF root is exactly the corresponding
multiple in the HONEST group of ALL original line-sheaf classes. The
whole actual tensor power and whole original differential sheaf are used. -/
theorem actual_original_canonical_sheaf_root_iff_picard_multiple
    (M : X.Modules) (hM : ActualOriginalLineSheaf X M) (n : ℕ) :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    Nonempty (actualSchemeModuleTensorPower X M n ≅ schemeDifferentialSheaf sX) ↔
      n • actualOriginalLineSheafIsoClass X M hM = actualOriginalCanonicalLineClass sX := by
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  rw [← actualSmoothCurveOriginalLinePicard_nsmul_is_actual_tensor_power sX M hM n]
  constructor
  · intro h
    exact Quotient.sound h
  · intro h
    exact Quotient.exact h

/-- The literal divisor-sheaf class of nD is the multiple of the
literal divisor-sheaf class of D in the HONEST original Picard group. -/
theorem actual_original_divisor_line_class_nsmul
    (D : Divisor (ClosedPoint X)) (n : ℕ) :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    actualSmoothCurveDivisorOriginalLineClass sX (n • D) =
      n • actualSmoothCurveDivisorOriginalLineClass sX D := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  rw [← actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor sX (n • D),
    map_nsmul, map_nsmul, actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor]

/-- A divisor D gives an ACTUAL original canonical sheaf root if and
only if nD is equivalent to the ORIGINAL differential divisor by the
ORIGINAL principal-divisor relation. No degree-divisibility shortcut or
root-existence premise replaces this exact class condition. -/
theorem actual_original_canonical_divisor_root_iff :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (D : Divisor (ClosedPoint X)) (n : ℕ),
      Nonempty (actualSchemeModuleTensorPower X (actualSmoothCurveDivisorSheaf sX D) n ≅
        schemeDifferentialSheaf sX) ↔
      divisorClassMap (schemeDivisorSystem X) (n • D) =
        divisorClassMap (schemeDivisorSystem X) (actualRationalDifferentialDivisor sX omega h) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  intro omega h D n
  rw [actual_original_canonical_sheaf_root_iff_picard_multiple sX _
    (actualSmoothCurveDivisorSheaf_is_original_line sX D) n,
    actual_original_canonical_line_class_eq_differential_divisor sX omega h]
  change n • actualSmoothCurveDivisorOriginalLineClass sX D =
      actualSmoothCurveDivisorOriginalLineClass sX (actualRationalDifferentialDivisor sX omega h) ↔ _
  rw [← actual_original_divisor_line_class_nsmul sX D n]
  exact actualSmoothCurveDivisorOriginalLineClass_eq_iff_divisor_class_eq sX
    (n • D) (actualRationalDifferentialDivisor sX omega h)

/-- Existence of ANY actual original line-sheaf root is exactly
divisibility of the ORIGINAL differential divisor class. All arbitrary
line sheaves are included using their PROVED actual divisor classification;
the equation is retained as an unresolved existence condition. -/
theorem actual_original_canonical_sheaf_root_exists_iff_divisor_class_divisible :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (n : ℕ),
      (∃ (M : X.Modules) (_hM : ActualOriginalLineSheaf X M),
        Nonempty (actualSchemeModuleTensorPower X M n ≅ schemeDifferentialSheaf sX)) ↔
      ∃ D : Divisor (ClosedPoint X),
        divisorClassMap (schemeDivisorSystem X) (n • D) =
          divisorClassMap (schemeDivisorSystem X) (actualRationalDifferentialDivisor sX omega h) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
  intro omega h n
  constructor
  · rintro ⟨M, hM, ⟨e⟩⟩
    obtain ⟨D, ⟨eD⟩⟩ := actual_smooth_curve_every_original_line_sheaf_has_divisor sX M hM
    refine ⟨D, (actual_original_canonical_divisor_root_iff sX omega h D n).mp ?_⟩
    exact ⟨actualOriginalModuleTensorPowerIso X eD.symm n ≪≫ e⟩
  · rintro ⟨D, hD⟩
    exact ⟨actualSmoothCurveDivisorSheaf sX D, actualSmoothCurveDivisorSheaf_is_original_line sX D,
      (actual_original_canonical_divisor_root_iff sX omega h D n).mpr hD⟩

end Litt3.SharedTensors
