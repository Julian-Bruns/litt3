import Theorems.Deformations.InvariantCokernelObstruction
import Solutions.Deformations.RepresentationCocycles

namespace Litt3.Deformations.InvariantDescentSquare

universe u

variable {k G L U DL DU : Type u} [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]
    (square : InvariantDescentSquare k G L U DL DU)

@[simp] theorem difference_cocycle_apply (b : square.invariantPreimage) (g : G) :
    (square.differenceCocycle b g).1 = square.sourceAction g b.1 - b.1 := rfl

@[simp] theorem target_pullback_invariant_image_descent (b : square.invariantPreimage) :
    square.targetPullback (square.invariantImageDescent b) = square.upperMap b.1 := by
  simp [invariantImageDescent, LinearEquiv.ofInjective_symm_apply]

/-- The actual primitive changes exactly by an actual invariant and
an actual kernel point; this is a full coboundary equivalence. -/
theorem cohomology_connecting_zero_iff (b : square.invariantPreimage) :
    square.cohomologyConnectingMap b = 0 ↔
      ∃ v ∈ square.sourceAction.invariants, square.upperMap v = square.upperMap b.1 := by
  change groupCohomology.H1π _ (square.differenceCocycle b) = 0 ↔ _
  rw [groupCohomology.H1π_eq_zero_iff]
  constructor
  · rintro ⟨z, hz⟩
    refine ⟨b.1 - z.1, ?_, ?_⟩
    · apply (Representation.mem_invariants _ _).mpr
      intro g
      have h := congrArg Subtype.val (congrFun hz g)
      change square.sourceAction g z.1 - z.1 = square.sourceAction g b.1 - b.1 at h
      rw [map_sub]
      exact sub_eq_sub_iff_add_eq_add.mpr
        ((sub_eq_sub_iff_add_eq_add.mp h).symm.trans (add_comm _ _))
    · rw [map_sub, show square.upperMap z.1 = 0 from z.2, sub_zero]
  · rintro ⟨v, fixed, same_image⟩
    let z : LinearMap.ker square.upperMap := ⟨b.1 - v, by
      change square.upperMap (b.1 - v) = 0
      rw [map_sub, same_image, sub_self]⟩
    refine ⟨z, ?_⟩
    apply funext
    intro g
    apply Subtype.ext
    change square.sourceAction g (b.1 - v) - (b.1 - v) =
      square.sourceAction g b.1 - b.1
    rw [map_sub, (Representation.mem_invariants _ v).mp fixed g]
    abel

theorem cokernel_representative_zero_iff (b : square.invariantPreimage) :
    square.cokernelRepresentativeMap b = 0 ↔
      ∃ v ∈ square.sourceAction.invariants, square.upperMap v = square.upperMap b.1 := by
  change Submodule.Quotient.mk (square.invariantImageDescent b) =
    (0 : DU ⧸ LinearMap.range square.lowerMap) ↔ _
  rw [Submodule.Quotient.mk_eq_zero]
  constructor
  · rintro ⟨d, hd⟩
    refine ⟨square.sourcePullback d, ?_, ?_⟩
    · rw [← square.sourceInvariantImage]
      exact ⟨d, rfl⟩
    · calc
        square.upperMap (square.sourcePullback d) = square.targetPullback (square.lowerMap d) :=
          LinearMap.congr_fun square.commutes d
        _ = square.targetPullback (square.invariantImageDescent b) := congrArg square.targetPullback hd
        _ = square.upperMap b.1 := square.target_pullback_invariant_image_descent b
  · rintro ⟨v, fixed, same_image⟩
    rw [← square.sourceInvariantImage] at fixed
    obtain ⟨d, rfl⟩ := fixed
    refine ⟨d, square.targetInjective ?_⟩
    calc
      square.targetPullback (square.lowerMap d) = square.upperMap (square.sourcePullback d) :=
        (LinearMap.congr_fun square.commutes d).symm
      _ = square.upperMap b.1 := same_image
      _ = square.targetPullback (square.invariantImageDescent b) :=
        (square.target_pullback_invariant_image_descent b).symm

theorem cokernel_pullback_representative_zero (b : square.invariantPreimage) :
    square.cokernelPullback (square.cokernelRepresentativeMap b) = 0 := by
  change (LinearMap.range square.upperMap).mkQ
    (square.targetPullback (square.invariantImageDescent b)) = 0
  rw [square.target_pullback_invariant_image_descent]
  exact (Submodule.Quotient.mk_eq_zero _).mpr ⟨b.1, rfl⟩

/-- Actual invariant primitives give points of the actual pullback
cokernel kernel. -/
noncomputable def cokernelObstructionMap : square.invariantPreimage →ₗ[k]
    LinearMap.ker square.cokernelPullback :=
  square.cokernelRepresentativeMap.codRestrict _ (by
    intro b
    exact square.cokernel_pullback_representative_zero b)

theorem cokernel_obstruction_map_zero_iff (b : square.invariantPreimage) :
    square.cokernelObstructionMap b = 0 ↔ square.cokernelRepresentativeMap b = 0 := by
  constructor
  · intro h
    exact congrArg Subtype.val h
  · intro h
    exact Subtype.ext h

theorem connecting_maps_same_kernel :
    LinearMap.ker square.cohomologyConnectingMap = LinearMap.ker square.cokernelObstructionMap := by
  ext b
  rw [LinearMap.mem_ker, LinearMap.mem_ker,
    square.cokernel_obstruction_map_zero_iff,
    square.cohomology_connecting_zero_iff, square.cokernel_representative_zero_iff]

theorem cohomology_connecting_map_surjective
    (primitives : RepresentationCocyclePrimitives square.sourceAction) :
    Function.Surjective square.cohomologyConnectingMap := by
  intro x
  refine groupCohomology.H1_induction_on (A := Rep.of square.kernelAction)
    (C := fun x => ∃ b, square.cohomologyConnectingMap b = x) x ?_
  intro c
  obtain ⟨b, hb⟩ := primitives (fun g => (c g).1) (by
    intro g h
    have hc := (groupCohomology.mem_cocycles₁_iff (A := Rep.of square.kernelAction) c).mp c.2 g h
    exact congrArg Subtype.val hc)
  have image_fixed : square.upperMap b ∈ square.targetAction.invariants := by
    apply (Representation.mem_invariants _ _).mpr
    intro g
    have h := congrArg square.upperMap (hb g)
    rw [map_sub, square.upperEquivariant, show square.upperMap (c g).1 = 0 from (c g).2] at h
    exact sub_eq_zero.mp h
  let B : square.invariantPreimage := ⟨b, image_fixed⟩
  have differences : square.differenceCocycle B = c := by
    apply groupCohomology.cocycles₁_ext
    intro g
    exact Subtype.ext (hb g)
  refine ⟨B, ?_⟩
  change groupCohomology.H1π _ (square.differenceCocycle B) = groupCohomology.H1π _ c
  exact congrArg (groupCohomology.H1π _) differences

theorem cokernel_obstruction_map_surjective : Function.Surjective square.cokernelObstructionMap := by
  intro x
  obtain ⟨a, ha⟩ := (LinearMap.range square.lowerMap).mkQ_surjective x.1
  have zero : square.cokernelPullback ((LinearMap.range square.lowerMap).mkQ a) = 0 := by
    rw [ha]
    exact x.2
  change (LinearMap.range square.upperMap).mkQ (square.targetPullback a) = 0 at zero
  obtain ⟨b, hb⟩ := (Submodule.Quotient.mk_eq_zero _).mp zero
  have image_fixed : square.upperMap b ∈ square.targetAction.invariants := by
    rw [hb, ← square.targetInvariantImage]
    exact ⟨a, rfl⟩
  let B : square.invariantPreimage := ⟨b, image_fixed⟩
  have descended : square.invariantImageDescent B = a := square.targetInjective (by
    rw [square.target_pullback_invariant_image_descent]
    exact hb)
  refine ⟨B, ?_⟩
  apply Subtype.ext
  change (LinearMap.range square.lowerMap).mkQ (square.invariantImageDescent B) = x.1
  rw [descended]
  exact ha

/-- The full genuine H¹ of the actual kernel is the actual cokernel
pullback kernel. Both quotient maps are constructed and proved onto,
and their complete coboundary kernels are identified. -/
noncomputable def cohomologyCokernelObstructionEquiv
    (primitives : RepresentationCocyclePrimitives square.sourceAction) :
    groupCohomology (Rep.of square.kernelAction) 1 ≃ₗ[k]
      LinearMap.ker square.cokernelPullback :=
  (square.cohomologyConnectingMap.quotKerEquivOfSurjective
    (square.cohomology_connecting_map_surjective primitives)).symm.trans
    ((Submodule.quotEquivOfEq _ _ square.connecting_maps_same_kernel).trans
      (square.cokernelObstructionMap.quotKerEquivOfSurjective square.cokernel_obstruction_map_surjective))

/-- The isomorphism is the actual connecting-map comparison on every
invariant-image primitive, rather than an arbitrary vector-space isomorphism. -/
theorem cohomology_cokernel_obstruction_equiv_apply
    (primitives : RepresentationCocyclePrimitives square.sourceAction)
    (b : square.invariantPreimage) :
    square.cohomologyCokernelObstructionEquiv primitives
      (square.cohomologyConnectingMap b) = square.cokernelObstructionMap b := by
  simp [cohomologyCokernelObstructionEquiv,
    LinearMap.quotKerEquivOfSurjective_symm_apply]

theorem invariant_cokernel_comparison
    (primitives : RepresentationCocyclePrimitives square.sourceAction) :
    Specifications.InvariantCokernelComparison square := by
  refine ⟨square.cohomologyCokernelObstructionEquiv primitives, ?_⟩
  intro b
  exact congrArg Subtype.val (square.cohomology_cokernel_obstruction_equiv_apply primitives b)

end Litt3.Deformations.InvariantDescentSquare
