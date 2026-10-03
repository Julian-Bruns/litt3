import Solutions.Jacobians.SmoothCurveDivisorLocalFrames
import Solutions.Jacobians.SchemeValuationPullbacks

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
  [IsSmoothOfRelativeDimension 1 sX] [IsSmoothOfRelativeDimension 1 sY]
  [QuasiCompact sX] [QuasiCompact sY]
  (f : X ⟶ Y) [IsFinite f] [Surjective f]
  [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f]

include sX sY

/-- The ACTUAL target local principal equation for an original
divisor pulls back to the ACTUAL source local principal equation, on the
full original inverse-image neighborhood. Both original DVR systems,
finite principal support and rational-function compatibility are derived.
No source local equation or pullback frame is supplied. -/
theorem actual_smooth_curve_divisor_pullback_local_principal
    (D : Divisor (Litt3.SharedTensors.ClosedPoint Y)) (x : X) :
    ∃ (a : Y.functionFieldˣ) (U : Y.Opens), f x ∈ U ∧
      (∀ y : Litt3.SharedTensors.ClosedPoint Y, y.val ∈ U →
        (D - actualSmoothCurvePrincipalDivisor sY a) y = 0) ∧
      (∀ z : Litt3.SharedTensors.ClosedPoint X, z.val ∈ f ⁻¹ᵁ U →
        (Litt3.SharedTensors.schemeDivisorPullback f D -
          actualSmoothCurvePrincipalDivisor sX
            (Units.map (Litt3.SharedTensors.schemeFunctionFieldPullback f).toMonoidHom a)) z = 0) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : ClosedPointDVRStalks Y :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sY
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI : FinitePrincipalSupport Y :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sY
  obtain ⟨a, U, hx, hU⟩ := actual_smooth_curve_divisor_local_principal sY D (f x)
  refine ⟨a, U, hx, hU, ?_⟩
  have hp := scheme_principal_divisor_pullback f (Additive.ofMul a)
  change actualSmoothCurvePrincipalDivisor sX
      (Units.map (Litt3.SharedTensors.schemeFunctionFieldPullback f).toMonoidHom a) =
    Litt3.SharedTensors.schemeDivisorPullback f (actualSmoothCurvePrincipalDivisor sY a) at hp
  intro z hz
  rw [hp]
  change D (Litt3.SharedTensors.mapClosedPoint f z) -
    actualSmoothCurvePrincipalDivisor sY a (Litt3.SharedTensors.mapClosedPoint f z) = 0
  exact hU (Litt3.SharedTensors.mapClosedPoint f z) hz

end Litt3.Jacobians
