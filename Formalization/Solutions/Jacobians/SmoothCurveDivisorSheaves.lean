import Solutions.Jacobians.ZeroDivisorSheafIsomorphisms

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- The genuine valuation-bounded divisor SHEAF of an ORIGINAL smooth
curve. All original closed DVR stalks are derived from actual smoothness;
no DVR, valuation chart or closed-regularity input is supplied. -/
noncomputable def actualSmoothCurveDivisorSheaf
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) : X.Modules := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  exact actualSchemeDivisorSheaf X D

/-- The genuine zero-divisor sheaf of the ORIGINAL smooth curve is its
ORIGINAL structure-sheaf module. Only actual smooth relative dimension one,
integrality and an algebraically closed coefficient field are assumed. -/
noncomputable def actualSmoothCurveZeroDivisorOriginalStructureIso :
    actualSmoothCurveDivisorSheaf sX 0 ≅ SheafOfModules.unit X.ringCatSheaf := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  exact actualSmoothCurveZeroDivisorSheafIso sX

end Litt3.Jacobians
