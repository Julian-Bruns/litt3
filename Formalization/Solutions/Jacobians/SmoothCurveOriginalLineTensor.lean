import Solutions.Jacobians.SmoothCurveDivisorOriginalLineClasses
import Solutions.Jacobians.OriginalLineSheafIsomorphismInvariance
import Solutions.Jacobians.ActualGlobalModuleTensorIsomorphisms
import Solutions.Jacobians.SmoothCurveDivisorTensorSheaves

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]
  (M N : X.Modules) (hM : ActualOriginalLineSheaf X M) (hN : ActualOriginalLineSheaf X N)

/-- The ACTUAL global sheafified tensor of ANY TWO original line
SHEAVES is isomorphic to O(D_M+D_N), using their CONSTRUCTED original
divisors and literal genuine divisor-sheaf tensor multiplication. -/
noncomputable def actualSmoothCurveOriginalLineTensorDivisorIso :
    actualSchemeModuleTensorSheaf X M N ≅
      actualSmoothCurveDivisorSheaf sX
        (actualSmoothCurveOriginalLineDivisor sX M hM +
          actualSmoothCurveOriginalLineDivisor sX N hN) :=
  actualSchemeModuleTensorIso X (actualSmoothCurveOriginalLineDivisorIso sX M hM)
      (actualSmoothCurveOriginalLineDivisorIso sX N hN) ≪≫
    actualSmoothCurveDivisorTensorSheafIso sX _ _

include sX hM hN in
/-- ALL genuine original line SHEAVES are closed under the ACTUAL
global sheafified tensor. This follows from whole-sheaf classification and
actual local divisor frames, rather than an abstract Picard operation. -/
theorem actualSmoothCurveOriginalLineTensor_is_line :
    ActualOriginalLineSheaf X (actualSchemeModuleTensorSheaf X M N) :=
  actualOriginalLineSheaf_of_iso X
    (actualSmoothCurveOriginalLineTensorDivisorIso sX M N hM hN).symm
    (actualSmoothCurveDivisorSheaf_is_original_line sX _)

/-- The ACTUAL tensor class of arbitrary original line SHEAVES is
the honest isomorphism class of the sum of their constructed divisors. -/
theorem actualSmoothCurveOriginalLineTensor_class :
    actualOriginalLineSheafIsoClass X (actualSchemeModuleTensorSheaf X M N)
        (actualSmoothCurveOriginalLineTensor_is_line sX M N hM hN) =
      actualSmoothCurveDivisorOriginalLineClass sX
        (actualSmoothCurveOriginalLineDivisor sX M hM +
          actualSmoothCurveOriginalLineDivisor sX N hN) := by
  apply Quotient.sound
  exact ⟨actualSmoothCurveOriginalLineTensorDivisorIso sX M N hM hN⟩

end Litt3.Jacobians
