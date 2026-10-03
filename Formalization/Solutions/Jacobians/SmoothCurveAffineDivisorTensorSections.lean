import Solutions.Jacobians.AffineDivisorSectionTensorProducts
import Solutions.Jacobians.SmoothCurveAffineDivisorSections

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped TensorProduct

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (U : X.Opens) (hU : IsAffineOpen U) [Nonempty U]

/-- EVERY true nonempty affine chart of ANY actual smooth integral
curve has the genuine original divisor-section tensor equivalence.
Every characteristic is allowed; no properness, quasi-compactness,
supplied DVR/Dedekind/valuation data or abstract section tensor input.
The original fraction-ideal multiplication and whole-field section
equivalences construct the map. -/
noncomputable def actualSmoothCurveAffineDivisorTensorSectionsEquiv
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    (actualSmoothCurveDivisorSheaf sX D).val.obj (op U) ⊗[Γ(X, U)]
      (actualSmoothCurveDivisorSheaf sX E).val.obj (op U) ≃ₗ[Γ(X, U)]
        (actualSmoothCurveDivisorSheaf sX (D + E)).val.obj (op U) := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : IsDedekindDomain Γ(X, U) :=
    Litt3.QuotientGeometry.actual_smooth_curve_affine_chart_dedekind sX U hU
  exact actualAffineDivisorSectionTensorEquiv hU
    (Litt3.SharedTensors.actual_smooth_curve_affine_chart_not_isField sX U hU) D E

end Litt3.Jacobians
