import Theorems.Deformations.InvariantCokernelTorsors
import Solutions.Deformations.InvariantCokernelObstruction
import Solutions.Deformations.RepresentationAffineTorsors

namespace Litt3.Deformations.InvariantDescentSquare

universe u

variable {k G L U DL DU A : Type u} [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]
    (square : InvariantDescentSquare k G L U DL DU)
    [AddTorsor (LinearMap.ker square.upperMap) A] [MulAction G A]
    (compatible : IsRepresentationAffineAction (A := A) square.kernelAction)
    (primitives : RepresentationCocyclePrimitives square.sourceAction)

/-- The actual class of a full affine kernel torsor, through the
constructed cohomology/cokernel connecting isomorphism. -/
noncomputable def cokernelTorsorClass (a : A) : LinearMap.ker square.cokernelPullback :=
  square.cohomologyCokernelObstructionEquiv primitives
    (affineTorsorClass square.kernelAction compatible a)

theorem cokernel_torsor_class_independent (a b : A) :
    square.cokernelTorsorClass compatible primitives a =
      square.cokernelTorsorClass compatible primitives b :=
  congrArg (square.cohomologyCokernelObstructionEquiv primitives)
    (affine_torsor_class_independent square.kernelAction compatible a b)

theorem cokernel_torsor_class_zero_iff_fixed (a : A) :
    square.cokernelTorsorClass compatible primitives a = 0 ↔
      ∃ b : A, ∀ g : G, g • b = b := by
  rw [cokernelTorsorClass, map_eq_zero_iff _
    (square.cohomologyCokernelObstructionEquiv primitives).injective]
  exact affine_torsor_class_zero_iff_fixed square.kernelAction compatible a

/-- Every genuine ambient primitive of the actual deck cocycle
represents the same actual obstruction class. -/
theorem cokernel_torsor_class_primitive (a : A) (b : square.invariantPreimage)
    (primitive : ∀ g : G, square.differenceCocycle b g = g • a -ᵥ a) :
    (square.cokernelTorsorClass compatible primitives a).1 =
      square.cokernelRepresentativeMap b := by
  have cocycle : affineTorsorCocycle square.kernelAction compatible a =
      square.differenceCocycle b := by
    apply groupCohomology.cocycles₁_ext
    intro g
    exact (primitive g).symm
  unfold cokernelTorsorClass affineTorsorClass
  rw [cocycle]
  exact congrArg Subtype.val
    (square.cohomology_cokernel_obstruction_equiv_apply primitives b)

include compatible primitives in
/-- Every actual deck cocycle admits an actual ambient primitive
whose upper image is invariant. The representative is constructed
from the full actual cocycle. -/
theorem affine_kernel_torsor_primitive_exists (a : A) :
    ∃ b : square.invariantPreimage,
      ∀ g : G, square.differenceCocycle b g = g • a -ᵥ a := by
  let c := affineTorsorCocycle square.kernelAction compatible a
  obtain ⟨b, hb⟩ := primitives (fun g => (c g).1) (by
    intro g h
    exact congrArg Subtype.val
      ((groupCohomology.mem_cocycles₁_iff (A := Rep.of square.kernelAction) c).mp c.2 g h))
  have fixed : square.upperMap b ∈ square.targetAction.invariants := by
    apply (Representation.mem_invariants _ _).mpr
    intro g
    have h := congrArg square.upperMap (hb g)
    rw [map_sub, square.upperEquivariant,
      show square.upperMap (c g).1 = 0 from (c g).2] at h
    exact sub_eq_zero.mp h
  exact ⟨⟨b, fixed⟩, fun g => Subtype.ext (hb g)⟩

include compatible primitives in
theorem invariant_cokernel_torsor_criterion :
    Specifications.InvariantCokernelTorsorCriterion (A := A) square := by
  exact ⟨square.cokernelTorsorClass compatible primitives,
    square.cokernel_torsor_class_independent compatible primitives,
    square.cokernel_torsor_class_zero_iff_fixed compatible primitives,
    square.cokernel_torsor_class_primitive compatible primitives⟩

end Litt3.Deformations.InvariantDescentSquare
