import Solutions.Jacobians.SmoothCurveTrivialDivisorOrders
import Solutions.Jacobians.SmoothCurvePrincipalDivisorSheaves

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]

/-- A genuine global trivialization of the actual divisor SHEAF gives
an actual ORIGINAL rational function with precisely the original divisor.
All DVR stalks and principal support are derived from the actual smooth
quasi-compact curve. No class-group/Picard identification is assumed. -/
theorem actual_smooth_curve_trivial_divisor_sheaf_is_principal
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (e : actualSmoothCurveDivisorSheaf sX D ≅ SheafOfModules.unit X.ringCatSheaf) :
    ∃ f : X.functionFieldˣ, actualSmoothCurvePrincipalDivisor sX f = D := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  obtain ⟨f, hf⟩ := actual_smooth_curve_trivial_divisor_orders sX D e
  refine ⟨f⁻¹, ?_⟩
  ext x
  change valuationOrder (closedPointValuation X x) (Additive.ofMul f⁻¹) = D x
  change valuationOrder (closedPointValuation X x) (-(Additive.ofMul f)) = D x
  rw [map_neg, hf x, neg_neg]

/-- The actual global divisor SHEAF is genuinely trivial EXACTLY when
the original divisor is the principal divisor of an ORIGINAL function.
This is the exact geometric principal kernel, valid in every characteristic;
it does not identify all line sheaves with divisors or a Jacobian. -/
theorem actual_smooth_curve_divisor_sheaf_trivial_iff_principal
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    Nonempty (actualSmoothCurveDivisorSheaf sX D ≅ SheafOfModules.unit X.ringCatSheaf) ↔
      ∃ f : X.functionFieldˣ, actualSmoothCurvePrincipalDivisor sX f = D := by
  constructor
  · rintro ⟨e⟩
    exact actual_smooth_curve_trivial_divisor_sheaf_is_principal sX D e
  · rintro ⟨f, rfl⟩
    exact ⟨actualSmoothCurvePrincipalDivisorSheafUnitIso sX f⟩

end Litt3.Jacobians
