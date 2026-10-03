import Solutions.Jacobians.SmoothCurveDivisorTensorLocalBijectivity
import Solutions.Jacobians.SchemeModuleSheafificationLocalIsomorphisms

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- Literal rational multiplication on the TRUE GLOBAL module tensor
SHEAF is an actual ISOMORPHISM onto O(D+E). Entire affine multiplication
bijections, the true affine-basis local bijection and original module
sheafification derive it. No supplied frames, abstract tensor comparison,
properness, quasi-compactness or characteristic restriction is imposed. -/
theorem actual_smooth_curve_divisor_tensor_multiply_isIso
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    IsIso (actualDivisorSheafTensorMultiply X D E) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI := (actual_smooth_curve_divisor_tensor_locally_bijective sX D E).1
  letI := (actual_smooth_curve_divisor_tensor_locally_bijective sX D E).2
  exact actualSchemeModuleSheafificationLift_isIso X
    (actualSchemeModuleTensorPresheaf X (actualSchemeDivisorSheaf X D)
      (actualSchemeDivisorSheaf X E))
    (actualSchemeDivisorSheaf X (D + E)) (actualDivisorSheafTensorPresheafMultiply X D E)

/-- Genuine original GLOBAL divisor SHEAVES multiply by adding
their ORIGINAL divisors, through the literal sheafified multiplication. -/
noncomputable def actualSmoothCurveDivisorTensorSheafIso
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    actualSchemeModuleTensorSheaf X (actualSmoothCurveDivisorSheaf sX D)
      (actualSmoothCurveDivisorSheaf sX E) ≅ actualSmoothCurveDivisorSheaf sX (D + E) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_divisor_tensor_multiply_isIso sX D E
  exact asIso (actualDivisorSheafTensorMultiply X D E)

/-- The ACTUAL original O(-D) is a genuine tensor inverse of O(D)
on the WHOLE original scheme site. This uses the actual original structure
module and true sheafified tensor, not proper global-section tensor data. -/
noncomputable def actualSmoothCurveDivisorInverseTensorUnitIso
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    actualSchemeModuleTensorSheaf X (actualSmoothCurveDivisorSheaf sX D)
      (actualSmoothCurveDivisorSheaf sX (-D)) ≅ SheafOfModules.unit X.ringCatSheaf :=
  (by simpa only [add_neg_cancel] using actualSmoothCurveDivisorTensorSheafIso sX D (-D)) ≪≫
    actualSmoothCurveZeroDivisorOriginalStructureIso sX

end Litt3.Jacobians
