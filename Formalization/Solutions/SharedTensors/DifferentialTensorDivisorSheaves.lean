import Solutions.SharedTensors.OriginalCanonicalLineSheaf
import Solutions.Jacobians.ActualGlobalModuleTensorIsomorphisms
import Solutions.Jacobians.SmoothCurveDivisorTensorSheaves

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u

/-- Genuine WHOLE module-sheaf isomorphisms transport every actual
sheafified tensor power on ANY original scheme, including the unit power. -/
noncomputable def actualOriginalModuleTensorPowerIso (X : Scheme.{u})
    {M N : X.Modules} (e : M ≅ N) :
    ∀ n : ℕ, actualSchemeModuleTensorPower X M n ≅ actualSchemeModuleTensorPower X N n
  | 0 => Iso.refl _
  | n + 1 => actualSchemeModuleTensorIso X e (actualOriginalModuleTensorPowerIso X e n)

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- Every actual original GLOBAL tensor power of O(D) is the whole
original O(nD). This uses literal rational multiplication of the genuine
sheafified tensor and has no properness or quasi-compactness hypothesis. -/
noncomputable def actualOriginalDivisorTensorPowerIso
    (D : Divisor (ClosedPoint X)) :
    ∀ n : ℕ, actualSchemeModuleTensorPower X (actualSmoothCurveDivisorSheaf sX D) n ≅
      actualSmoothCurveDivisorSheaf sX (n • D)
  | 0 => by
      simpa only [zero_nsmul] using (actualSmoothCurveZeroDivisorOriginalStructureIso sX).symm
  | n + 1 => by
      change actualSchemeModuleTensorSheaf X (actualSmoothCurveDivisorSheaf sX D)
        (actualSchemeModuleTensorPower X (actualSmoothCurveDivisorSheaf sX D) n) ≅ _
      simpa only [succ_nsmul'] using
        actualSchemeModuleTensorIso X (Iso.refl _) (actualOriginalDivisorTensorPowerIso D n) ≪≫
          actualSmoothCurveDivisorTensorSheafIso sX D (n • D)

variable [CompactSpace X]

/-- Every genuine canonical tensor POWER is the whole original
divisor sheaf O(n div omega), for each nonzero ORIGINAL rational frame.
This is an actual SHEAF isomorphism, not an assumed section-space model,
and includes every original restriction and the tensor unit at n=0. -/
noncomputable def actualDifferentialTensorDivisorSheafIso :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (n : ℕ),
      actualSchemeModuleTensorPower X (schemeDifferentialSheaf sX) n ≅
        actualSmoothCurveDivisorSheaf sX (n • actualRationalDifferentialDivisor sX omega h) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h n
  exact actualOriginalModuleTensorPowerIso X (actualDifferentialDivisorSheafIso sX omega h) n ≪≫
    actualOriginalDivisorTensorPowerIso sX (actualRationalDifferentialDivisor sX omega h) n

/-- The class of the ORIGINAL whole canonical tensor power is the
literal multiple of its ORIGINAL differential divisor class. -/
theorem actual_canonical_tensor_power_class_eq_divisor :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (n : ℕ),
      actualOriginalLineSheafIsoClass X
          (actualSchemeModuleTensorPower X (schemeDifferentialSheaf sX) n)
          (actualSmoothCurveOriginalLineTensorPower_is_line sX _
            (actual_smooth_curve_differential_sheaf_is_original_line sX) n) =
        actualSmoothCurveDivisorOriginalLineClass sX (n • actualRationalDifferentialDivisor sX omega h) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h n
  exact Quotient.sound ⟨actualDifferentialTensorDivisorSheafIso sX omega h n⟩

end Litt3.SharedTensors
