import Solutions.SharedTensors.SmoothCurveRationalDifferentialOrders
import Solutions.SharedTensors.DVRDifferentialOrderIndependence

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.CartierAndSpin Litt3.QuotientGeometry

variable {k R F : Type*} [CommRing k] [CommRing R] [IsDomain R]
  [IsDiscreteValuationRing R] [Field F] [Algebra k R] [Algebra k F]
  [Algebra R F] [IsFractionRing R F] [IsScalarTower k R F]

/-- The scalar is in the SAME original fraction field. -/
theorem actual_dvr_differential_order_smul
    (e : KaehlerDifferential k R ≃ₗ[R] R) (a : Fˣ)
    (omega : KaehlerDifferential k F) (h : omega ≠ 0) :
    actualDVRDifferentialOrder e ((a : F) • omega)
        (rational_line_smul_ne_zero a omega h) =
      valuationOrder ((discreteValuationPlace R).valuation F) (Additive.ofMul a) +
        actualDVRDifferentialOrder e omega h := by
  letI : Algebra.FormallyEtale R F :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)
  exact rational_line_order_smul _ _ a omega h

universe u

variable {K : Type u} [Field K] [IsAlgClosed K]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of K)) [IsSmoothOfRelativeDimension 1 sX]

/-- The point order agrees with EVERY original integral stalk frame,
not just the frame chosen in its construction. -/
theorem actual_smooth_differential_order_every_integral_frame :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential K X.functionField) (h : omega ≠ 0)
      (x : ClosedPoint X),
      letI := (stalkBaseFieldHom sX x.val).toAlgebra
      letI : IsScalarTower K (X.presheaf.stalk x.val) X.functionField :=
        IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      ∀ e : KaehlerDifferential K (X.presheaf.stalk x.val) ≃ₗ[X.presheaf.stalk x.val]
          X.presheaf.stalk x.val,
        actualDVRDifferentialOrder e omega h =
          smoothCurveRationalDifferentialOrder sX omega h x := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h x
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI : IsScalarTower K (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  intro e
  exact actual_dvr_differential_order_independent
    (actualSmoothCurveStalkDifferentialCoordinate sX x.val) e omega h

/-- Actual differential orders transform by the original scalar valuation
at every original closed point, in any characteristic. -/
theorem actual_smooth_differential_order_smul :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (a : X.functionFieldˣ) (omega : KaehlerDifferential K X.functionField)
      (h : omega ≠ 0) (x : ClosedPoint X),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      smoothCurveRationalDifferentialOrder sX ((a : X.functionField) • omega)
          (rational_line_smul_ne_zero a omega h) x =
        valuationOrder (closedPointValuation X x) (Additive.ofMul a) +
          smoothCurveRationalDifferentialOrder sX omega h x := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro a omega h x
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI : IsScalarTower K (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  exact actual_dvr_differential_order_smul
    (actualSmoothCurveStalkDifferentialCoordinate sX x.val) a omega h

end Litt3.SharedTensors
