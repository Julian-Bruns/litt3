import Theorems.Deformations.InvariantCokernelCriteria
import Solutions.Deformations.InvariantCokernelObstruction
import Solutions.Deformations.InvariantKernelPullback
import Solutions.Deformations.PGroupCohomologyFreeness

namespace Litt3.Deformations.InvariantDescentSquare

open scoped MonoidAlgebra

universe u

variable {k G L U DL DU : Type u} [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]
    (square : InvariantDescentSquare k G L U DL DU)

/-- The actual H¹ obstruction vanishes exactly when the actual
pullback on cokernels is injective. No p-group or finite-dimension
hypothesis is used in this exact-sequence comparison. -/
theorem cohomology_zero_iff_cokernel_pullback_injective
    (primitives : RepresentationCocyclePrimitives square.sourceAction) :
    (∀ x : groupCohomology (Rep.of square.kernelAction) 1, x = 0) ↔
      Function.Injective square.cokernelPullback := by
  let e := square.cohomologyCokernelObstructionEquiv primitives
  constructor
  · intro zero
    apply LinearMap.ker_eq_bot.mp
    apply LinearMap.ker_eq_bot'.mpr
    intro a ha
    let A : LinearMap.ker square.cokernelPullback := ⟨a, ha⟩
    have h : A = 0 := by
      calc
        A = e (e.symm A) := (e.apply_symm_apply A).symm
        _ = e 0 := congrArg e (zero (e.symm A))
        _ = 0 := e.map_zero
    exact congrArg Subtype.val h
  · intro injective x
    apply e.injective
    exact Subtype.ext (by
      calc
        (e x).1 = 0 := injective (by exact (e x).2.trans (map_zero _).symm)
        _ = (e 0).1 := congrArg Subtype.val e.map_zero.symm)

variable {p : ℕ} [Fact p.Prime] [CharP k p] [Finite G]

/-- Over a characteristic-p field, for an actual finite p-group,
the actual obstruction map is injective exactly when its actual
kernel representation is a free group-algebra module. -/
theorem kernel_free_iff_cokernel_pullback_injective
    (group : IsPGroup p G) [Module.Free k[G] square.sourceAction.asModule] :
    Module.Free k[G] square.kernelAction.asModule ↔ Function.Injective square.cokernelPullback :=
  (p_group_cohomology_freeness group square.kernelAction).trans
    (square.cohomology_zero_iff_cokernel_pullback_injective
      (free_group_module_cocycle_primitives square.sourceAction))

/-- Every full finite-dimensional clause follows for the actual
comparison square, including equality with the actual lower kernel
dimension. The only ambient input is actual group-algebra freeness. -/
theorem invariant_cokernel_criteria
    (group : IsPGroup p G) [FiniteDimensional k L]
    [Module.Free k[G] square.sourceAction.asModule]
    (sourceInjective : Function.Injective square.sourcePullback) :
    Specifications.InvariantCokernelCriteria square := by
  have dimensions := square.kernel_invariant_finrank_eq sourceInjective
  have growth := p_group_representation_growth group square.kernelAction
  change Module.finrank k square.kernelAction.invariants ≤
      Module.finrank k (LinearMap.ker square.upperMap) ∧
    Module.finrank k (LinearMap.ker square.upperMap) ≤
      Nat.card G * Module.finrank k square.kernelAction.invariants at growth
  rw [dimensions] at growth
  have maximal := p_group_maximal_growth_freeness group square.kernelAction
  change Module.finrank k (LinearMap.ker square.upperMap) =
      Nat.card G * Module.finrank k square.kernelAction.invariants ↔ _ at maximal
  rw [dimensions] at maximal
  exact ⟨growth.1, growth.2, maximal,
    p_group_cohomology_freeness group square.kernelAction,
    square.cohomology_zero_iff_cokernel_pullback_injective
      (free_group_module_cocycle_primitives square.sourceAction)⟩

end Litt3.Deformations.InvariantDescentSquare
