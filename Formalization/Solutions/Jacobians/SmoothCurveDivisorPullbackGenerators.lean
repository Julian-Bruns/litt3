import Solutions.Jacobians.SmoothCurvePrincipalOpenFrameValues
import Solutions.Jacobians.SchemeDivisorOpenImageTensorMaps

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped TensorProduct ChangeOfRings

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
  [IsSmoothOfRelativeDimension 1 sX] [IsSmoothOfRelativeDimension 1 sY]
  [QuasiCompact sX] [QuasiCompact sY]
  (f : X ⟶ Y) [IsFinite f] [Surjective f]
  [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f]
  (hf : IsOpenMap f.base)

/-- The ACTUAL global divisor tensor map sends the genuine original
target principal-frame generator to the genuine ORIGINAL source-frame
generator on EVERY nonempty inverse-image subopen. Their equality is
proved on entire original sections through injective true rational values,
with the actual field pullback and both original frame formulas. -/
theorem actual_smooth_curve_divisor_tensor_pullback_generator
    (D : Divisor (Litt3.SharedTensors.ClosedPoint Y)) (a : Y.functionFieldˣ)
    (U : Y.Opens)
    (hY : ∀ y : Litt3.SharedTensors.ClosedPoint Y, y.val ∈ U →
      (D - actualSmoothCurvePrincipalDivisor sY a) y = 0)
    (hX : ∀ z : Litt3.SharedTensors.ClosedPoint X, z.val ∈ f ⁻¹ᵁ U →
      (Litt3.SharedTensors.schemeDivisorPullback f D - actualSmoothCurvePrincipalDivisor sX
        (Units.map (Litt3.SharedTensors.schemeFunctionFieldPullback f).toMonoidHom a)) z = 0)
    (V : X.Opens) [Nonempty V] (i : V ⟶ f ⁻¹ᵁ U) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : ClosedPointDVRStalks Y :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sY
    let j : hf.functor.obj V ⟶ U := (hf.adjunction.homEquiv V U).symm i
    let b := Units.map (Litt3.SharedTensors.schemeFunctionFieldPullback f).toMonoidHom a
    let EY := actualOriginalLineFrameSectionEquiv Y (actualSmoothCurveDivisorSheaf sY D) U
      (actualSmoothCurvePrincipalOpenFrameIso sY D a U hY) (hf.functor.obj V) j
    let EX := actualOriginalLineFrameSectionEquiv X
      (actualSmoothCurveDivisorSheaf sX (Litt3.SharedTensors.schemeDivisorPullback f D)) (f ⁻¹ᵁ U)
      (actualSmoothCurvePrincipalOpenFrameIso sX (Litt3.SharedTensors.schemeDivisorPullback f D)
        b (f ⁻¹ᵁ U) hX) V i
    (actualSchemeDivisorOpenImageTensorMap f hf D).app (op V)
      ((1 : Γ(X, V))
        ⊗ₜ[Γ(Y, hf.functor.obj V),((actualSchemeOpenImageRingMap f hf).app (op V)).hom]
          EY.symm (1 : Γ(Y, hf.functor.obj V))) = EX.symm (1 : Γ(X, V)) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : ClosedPointDVRStalks Y :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sY
  letI := actualSchemeOpenImage_nonempty f hf V
  dsimp only
  apply Subtype.ext
  apply (actualRationalFunctionOpenLinearEquiv X V).injective
  rw [actualSchemeDivisorOpenImageTensorMap_unit_field_value,
    actualSmoothCurvePrincipalOpenFrameIso_generator_field_value,
    actualSmoothCurvePrincipalOpenFrameIso_generator_field_value]
  rfl

end Litt3.Jacobians
