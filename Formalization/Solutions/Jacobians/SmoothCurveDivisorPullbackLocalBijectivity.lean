import Solutions.Jacobians.SmoothCurveDivisorPullbackGenerators
import Solutions.Jacobians.SmoothCurveDivisorPullbackLocalFrames
import Solutions.Jacobians.ModuleBaseChangeRankOneGenerators
import Mathlib.Topology.Sheaves.LocallySurjective

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

set_option maxHeartbeats 1000000 in
/-- On EVERY nonempty source subopen of an actual inverse-image
principal-frame neighborhood, the FULL original divisor tensor map is
bijective. It is identified with actual scalar extension of the target
frame and the actual source frame by the proved generator formula. -/
theorem actual_smooth_curve_divisor_tensor_pullback_local_bijective
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
    Function.Bijective ((actualSchemeDivisorOpenImageTensorMap f hf D).app (op V)).hom := by
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
  let eY : (actualSchemeDivisorSheaf Y D).val.obj (op (hf.functor.obj V)) ≅
      ModuleCat.of Γ(Y, hf.functor.obj V) Γ(Y, hf.functor.obj V) := EY.toModuleIso
  let eX : (actualSchemeDivisorSheaf X
      (Litt3.SharedTensors.schemeDivisorPullback f D)).val.obj (op V) ≅
      ModuleCat.of Γ(X, V) Γ(X, V) := EX.toModuleIso
  let e := actualModuleBaseChangeRankOneIso
    ((actualSchemeOpenImageRingMap f hf).app (op V)).hom _ eY ≪≫ eX.symm
  have he : (actualSchemeDivisorOpenImageTensorMap f hf D).app (op V) = e.hom := by
    apply actualModuleBaseChangeRankOneHom_ext
      ((actualSchemeOpenImageRingMap f hf).app (op V)).hom _ eY
    change (actualSchemeDivisorOpenImageTensorMap f hf D).app (op V)
        ((1 : Γ(X, V)) ⊗ₜ[Γ(Y, hf.functor.obj V),_ ] EY.symm 1) =
      EX.symm (((actualModuleBaseChangeRankOneIso
        ((actualSchemeOpenImageRingMap f hf).app (op V)).hom _ eY).hom)
          ((1 : Γ(X, V)) ⊗ₜ[Γ(Y, hf.functor.obj V),_ ] EY.symm 1))
    change _ = EX.symm (((actualSchemeOpenImageRingMap f hf).app (op V)).hom
      (EY (EY.symm 1)) * 1)
    rw [EY.apply_symm_apply,
      ((actualSchemeOpenImageRingMap f hf).app (op V)).hom.map_one, mul_one]
    exact actual_smooth_curve_divisor_tensor_pullback_generator sX sY f hf D a U hY hX V i
  rw [he]
  exact e.toLinearEquiv.bijective

/-- The literal FULL original tensor divisor-pullback map is
genuinely site-locally bijective. Target equations, source equations,
all original frames and section bijections are derived from the actual
smooth integral curves and the actual morphism. -/
theorem actual_smooth_curve_divisor_tensor_pullback_locally_bijective
    (D : Divisor (Litt3.SharedTensors.ClosedPoint Y)) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : ClosedPointDVRStalks Y :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sY
    PresheafOfModules.IsLocallyInjective (Opens.grothendieckTopology X)
      (actualSchemeDivisorOpenImageTensorMap f hf D) ∧
    PresheafOfModules.IsLocallySurjective (Opens.grothendieckTopology X)
      (actualSchemeDivisorOpenImageTensorMap f hf D) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : ClosedPointDVRStalks Y :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sY
  let g := actualSchemeDivisorOpenImageTensorMap f hf D
  have h : ∀ (W : X.Opens) (x : X), x ∈ W →
      ∃ V : X.Opens, ∃ i : V ⟶ W, x ∈ V ∧ Function.Bijective (g.app (op V)).hom := by
    intro W x hx
    obtain ⟨a, U, hxU, hY, hX⟩ :=
      actual_smooth_curve_divisor_pullback_local_principal sX sY f D x
    let V := W ⊓ f ⁻¹ᵁ U
    letI : Nonempty V := ⟨⟨x, hx, hxU⟩⟩
    refine ⟨V, homOfLE inf_le_left, ⟨hx, hxU⟩, ?_⟩
    exact actual_smooth_curve_divisor_tensor_pullback_local_bijective sX sY f hf
      D a U hY hX V (homOfLE inf_le_right)
  constructor
  · constructor
    intro W a b hab x hx
    obtain ⟨V, i, hxV, hV⟩ := h W.unop x hx
    refine ⟨V, i, ?_, hxV⟩
    change (actualSchemeOpenImageTensorPresheaf f hf (actualSchemeDivisorSheaf Y D)).map i.op a =
      (actualSchemeOpenImageTensorPresheaf f hf (actualSchemeDivisorSheaf Y D)).map i.op b
    apply hV.injective
    rw [PresheafOfModules.naturality_apply, PresheafOfModules.naturality_apply]
    exact congrArg (fun z => (actualSchemeDivisorSheaf X
      (Litt3.SharedTensors.schemeDivisorPullback f D)).val.map i.op z) hab
  · constructor
    intro W c x hx
    obtain ⟨V, i, hxV, hV⟩ := h W x hx
    refine ⟨V, i, ?_, hxV⟩
    exact hV.surjective ((actualSchemeDivisorSheaf X
      (Litt3.SharedTensors.schemeDivisorPullback f D)).val.map i.op c)

end Litt3.Jacobians
