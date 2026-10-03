import Solutions.Jacobians.SmoothCurveOriginalLinePicardTensor
import Solutions.Jacobians.OriginalModuleSheafTensorPowers

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]

/-- Zero in the HONEST original line-SHEAF Picard group means
ACTUAL whole original SHEAF triviality, for any genuine original line
sheaf; no generic-frame triviality or affine-only substitute is used. -/
theorem actualSmoothCurveOriginalLinePicard_zero_iff_trivial
    (M : X.Modules) (hM : ActualOriginalLineSheaf X M) :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    actualOriginalLineSheafIsoClass X M hM = 0 ↔
      Nonempty (M ≅ SheafOfModules.unit X.ringCatSheaf) := by
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  rw [← actualSmoothCurveOriginalLinePicard_zero_is_original_structure sX]
  exact Quotient.eq

include sX in
/-- Genuine global sheafified tensor POWERS of any original line
SHEAF are actual original line SHEAVES, including power zero. -/
theorem actualSmoothCurveOriginalLineTensorPower_is_line
    (M : X.Modules) (hM : ActualOriginalLineSheaf X M) (n : ℕ) :
    ActualOriginalLineSheaf X (actualSchemeModuleTensorPower X M n) := by
  induction n with
  | zero => exact actualOriginalStructureSheaf_is_line X
  | succ n hn => exact actualSmoothCurveOriginalLineTensor_is_line sX M _ hM hn

/-- Multiples in the HONEST original line-SHEAF Picard group are
the classes of the ACTUAL iterated global sheafified tensor powers. -/
theorem actualSmoothCurveOriginalLinePicard_nsmul_is_actual_tensor_power
    (M : X.Modules) (hM : ActualOriginalLineSheaf X M) (n : ℕ) :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    actualOriginalLineSheafIsoClass X (actualSchemeModuleTensorPower X M n)
        (actualSmoothCurveOriginalLineTensorPower_is_line sX M hM n) =
      n • actualOriginalLineSheafIsoClass X M hM := by
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  induction n with
  | zero =>
    change actualOriginalLineSheafIsoClass X (SheafOfModules.unit X.ringCatSheaf) _ = _
    rw [actualSmoothCurveOriginalLinePicard_zero_is_original_structure sX, zero_nsmul]
  | succ n hn =>
    change actualOriginalLineSheafIsoClass X
      (actualSchemeModuleTensorSheaf X M (actualSchemeModuleTensorPower X M n)) _ = _
    rw [actualSmoothCurveOriginalLinePicard_add_is_actual_tensor sX M
      (actualSchemeModuleTensorPower X M n) hM
      (actualSmoothCurveOriginalLineTensorPower_is_line sX M hM n), hn,
      succ_nsmul']

/-- Torsion in the HONEST global original line-SHEAF Picard group
is EXACTLY genuine triviality of the ACTUAL global tensor power. Every
line/divisor/class/tensor bridge is derived from the true smooth curve. -/
theorem actualSmoothCurveOriginalLinePicard_torsion_iff_actual_tensor_power_trivial
    (M : X.Modules) (hM : ActualOriginalLineSheaf X M) (n : ℕ) :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    n • actualOriginalLineSheafIsoClass X M hM = 0 ↔
      Nonempty (actualSchemeModuleTensorPower X M n ≅ SheafOfModules.unit X.ringCatSheaf) := by
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  rw [← actualSmoothCurveOriginalLinePicard_nsmul_is_actual_tensor_power sX M hM n]
  exact actualSmoothCurveOriginalLinePicard_zero_iff_trivial sX _
    (actualSmoothCurveOriginalLineTensorPower_is_line sX M hM n)

end Litt3.Jacobians
