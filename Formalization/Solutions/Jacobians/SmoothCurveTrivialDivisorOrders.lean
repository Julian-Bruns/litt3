import Solutions.Jacobians.AffineDivisorTrivialOrders
import Solutions.Jacobians.SmoothCurveAffineDivisorSections

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- A genuine global trivialization of the actual divisor SHEAF on
ANY actual smooth curve yields ONE original rational unit whose actual
closed-stalk orders are exactly -D. No properness, quasi-compactness,
local generator, valuation system or principal-divisor premise is needed. -/
theorem actual_smooth_curve_trivial_divisor_orders
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (e : actualSmoothCurveDivisorSheaf sX D ≅ SheafOfModules.unit X.ringCatSheaf) :
    ∃ f : X.functionFieldˣ, ∀ x : Litt3.SharedTensors.ClosedPoint X,
      letI : ClosedPointDVRStalks X :=
        Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
      valuationOrder (closedPointValuation X x) (Additive.ofMul f) = -D x := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  let f : X.functionFieldˣ := Units.mk0 (actualDivisorSheafGlobalGenerator X D e)
    (actualDivisorSheafGlobalGenerator_ne_zero X D e)
  refine ⟨f, ?_⟩
  intro x
  obtain ⟨U, hU, hx, _⟩ := Litt3.SharedTensors.actual_smooth_point_chart sX 1 x.val
  letI : Nonempty U := ⟨⟨x.val, hx⟩⟩
  letI : IsDedekindDomain Γ(X, U) :=
    Litt3.QuotientGeometry.actual_smooth_curve_affine_chart_dedekind sX U hU
  exact actualAffineDivisorTrivialGenerator_order hU
    (Litt3.SharedTensors.actual_smooth_curve_affine_chart_not_isField sX U hU)
    D e ⟨x, hx⟩

end Litt3.Jacobians
