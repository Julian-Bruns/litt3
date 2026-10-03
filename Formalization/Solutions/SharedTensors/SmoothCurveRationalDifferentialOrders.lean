import Solutions.SharedTensors.DVRRationalDifferentialOrders
import Solutions.CartierAndSpin.SmoothStalkDifferentialCoordinates
import Definitions.CartierAndSpin.SchemeDifferentialZeros
import Definitions.CartierAndSpin.SchemeDifferentialPoles
import Solutions.SharedTensors.SchemeRegularDifferentials

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.CartierAndSpin Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- Actual normalized order at EVERY original closed point. The genuine
local differential frame and DVR are derived from smoothness, in ANY
characteristic. No order, lattice, completion or finite support is an input. -/
noncomputable def smoothCurveRationalDifferentialOrder :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField, omega ≠ 0 → ClosedPoint X → ℤ := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h x
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  exact actualDVRDifferentialOrder (actualSmoothCurveStalkDifferentialCoordinate sX x.val)
    omega h

theorem actual_smooth_positive_differential_order_iff_zero :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (x : ClosedPoint X),
      0 < smoothCurveRationalDifferentialOrder sX omega h x ↔
        x ∈ schemeDifferentialZeroSet sX omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h x
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  exact actual_dvr_positive_differential_order_iff_zero
    (actualSmoothCurveStalkDifferentialCoordinate sX x.val) omega h

theorem actual_smooth_nonnegative_differential_order_iff_regular :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (x : ClosedPoint X),
      0 ≤ smoothCurveRationalDifferentialOrder sX omega h x ↔
        omega ∈ schemeLocalRegularDifferentials sX x.val := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h x
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  exact (actual_dvr_nonnegative_differential_order_iff_regular
    (actualSmoothCurveStalkDifferentialCoordinate sX x.val) omega h).trans
      (mem_schemeLocalRegularDifferentials_iff sX x.val omega).symm

theorem actual_smooth_negative_differential_order_iff_pole :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (x : ClosedPoint X),
      smoothCurveRationalDifferentialOrder sX omega h x < 0 ↔
        x ∈ schemeDifferentialPoleSet sX omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h x
  change smoothCurveRationalDifferentialOrder sX omega h x < 0 ↔
    omega ∉ schemeLocalRegularDifferentials sX x.val
  rw [← actual_smooth_nonnegative_differential_order_iff_regular sX omega h x]
  omega

end Litt3.SharedTensors
