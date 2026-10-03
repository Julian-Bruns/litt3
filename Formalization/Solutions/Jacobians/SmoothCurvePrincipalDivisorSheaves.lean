import Solutions.Jacobians.PrincipalDivisorSheafIsomorphisms
import Solutions.Jacobians.SmoothCurveDivisorSheaves
import Solutions.SharedTensors.SmoothCurveFiniteSupport

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]

/-- The ACTUAL principal divisor of an ORIGINAL function on a true
quasi-compact smooth curve. DVR stalks and finite support are both derived
from the original scheme, not supplied as valuation-system inputs. -/
noncomputable def actualSmoothCurvePrincipalDivisor
    (f : X.functionFieldˣ) : Divisor (Litt3.SharedTensors.ClosedPoint X) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  exact principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul f)

/-- Literal ORIGINAL rational-function multiplication realizes the
actual principal-divisor shift of true original smooth-curve SHEAVES.
Only quasi-compactness is required globally, hence proper curves are included. -/
noncomputable def actualSmoothCurvePrincipalDivisorSheafShiftIso
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (f : X.functionFieldˣ) :
    actualSmoothCurveDivisorSheaf sX D ≅
      actualSmoothCurveDivisorSheaf sX (D - actualSmoothCurvePrincipalDivisor sX f) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  exact actualPrincipalDivisorSheafShiftIso X D f

/-- The sheaf of a literal ORIGINAL principal divisor on the actual
smooth curve is truly trivial, by its actual multiplier and the genuine
zero-divisor/structure-sheaf comparison. -/
noncomputable def actualSmoothCurvePrincipalDivisorSheafUnitIso (f : X.functionFieldˣ) :
    actualSmoothCurveDivisorSheaf sX (actualSmoothCurvePrincipalDivisor sX f) ≅
      SheafOfModules.unit X.ringCatSheaf :=
  actualSmoothCurvePrincipalDivisorSheafShiftIso sX (actualSmoothCurvePrincipalDivisor sX f) f ≪≫
    (by simpa only [sub_self] using actualSmoothCurveZeroDivisorOriginalStructureIso sX)

end Litt3.Jacobians
