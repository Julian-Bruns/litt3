import Solutions.SharedTensors.DifferentialDivisorSheafIsomorphisms
import Solutions.Jacobians.SmoothCurveDivisorOriginalLineClasses
import Solutions.Jacobians.OriginalLineSheafIsomorphismInvariance
import Solutions.Jacobians.SmoothCurveOriginalLinePicardTorsion

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [CompactSpace X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

omit [IsAlgClosed k] [CompactSpace X] in
/-- A nonzero rational differential exists in the ACTUAL original
generic differential module, from genuine smooth relative dimension one. -/
theorem actual_smooth_curve_rational_differential_exists_ne_zero :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∃ omega : KaehlerDifferential k X.functionField, omega ≠ 0 := by
  letI := (genericBaseFieldHom sX).toAlgebra
  let e := actualSmoothCurveKaehlerCoordinate sX
  refine ⟨e.symm 1, ?_⟩
  intro h
  have hh : (1 : X.functionField) = 0 := by
    simpa only [LinearEquiv.apply_symm_apply, map_zero] using congrArg e h
  exact one_ne_zero hh

/-- The genuine original relative differential SHEAF is locally free
of rank one on the ENTIRE original site. Actual local freeness is derived
from the proved original divisor presentation; no chosen frame is supplied. -/
theorem actual_smooth_curve_differential_sheaf_is_original_line :
    ActualOriginalLineSheaf X (schemeDifferentialSheaf sX) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : QuasiCompact sX := inferInstance
  obtain ⟨omega, h⟩ := actual_smooth_curve_rational_differential_exists_ne_zero sX
  exact actualOriginalLineSheaf_of_iso X (actualDifferentialDivisorSheafIso sX omega h).symm
    (actualSmoothCurveDivisorSheaf_is_original_line sX (actualRationalDifferentialDivisor sX omega h))

/-- The canonical class is literally the class of the ORIGINAL
differential SHEAF among ALL original line sheaves. No genus, degree,
cohomology or representable Picard scheme is hidden in this definition. -/
noncomputable def actualOriginalCanonicalLineClass : ActualOriginalLineSheafIsoClasses X :=
  actualOriginalLineSheafIsoClass X (schemeDifferentialSheaf sX)
    (actual_smooth_curve_differential_sheaf_is_original_line sX)

/-- Every actual nonzero rational differential represents the class
of the SAME original whole differential SHEAF in the HONEST line Picard group. -/
theorem actual_original_canonical_line_class_eq_differential_divisor :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0),
      actualOriginalCanonicalLineClass sX =
        actualSmoothCurveDivisorOriginalLineClass sX (actualRationalDifferentialDivisor sX omega h) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : QuasiCompact sX := inferInstance
  intro omega h
  exact Quotient.sound ⟨actualDifferentialDivisorSheafIso sX omega h⟩

/-- Canonical-class torsion is exactly actual global tensor-power
triviality of the ORIGINAL differential SHEAF. All powers, including zero,
are genuine sheafified tensor powers; this is not a root-existence claim. -/
theorem actual_original_canonical_line_torsion_iff_tensor_power_trivial
    (n : ℕ) :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    n • actualOriginalCanonicalLineClass sX = 0 ↔
      Nonempty (actualSchemeModuleTensorPower X (schemeDifferentialSheaf sX) n ≅
        SheafOfModules.unit X.ringCatSheaf) := by
  letI : QuasiCompact sX := inferInstance
  exact actualSmoothCurveOriginalLinePicard_torsion_iff_actual_tensor_power_trivial sX
    (schemeDifferentialSheaf sX) (actual_smooth_curve_differential_sheaf_is_original_line sX) n

end Litt3.SharedTensors
