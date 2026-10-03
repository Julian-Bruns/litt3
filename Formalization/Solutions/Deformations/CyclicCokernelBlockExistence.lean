import Theorems.Deformations.CyclicCokernelBlockExistence
import Solutions.Deformations.CyclicCokernelBlockCounts
import Solutions.Deformations.ActualCyclicBlockExistence

namespace Litt3.Deformations.InvariantDescentSquare

variable {k G L U DL DU : Type} [Field k] [Group G] [Fintype G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]
    (square : InvariantDescentSquare k G L U DL DU)

/-- Every actual finite-dimensional cyclic invariant square has
its full positive kernel-block decomposition and exact genuine H¹
and cokernel counts. The decomposition is proved, not supplied. -/
theorem cyclic_cokernel_block_existence (p a : ℕ) [Fact p.Prime] [CharP k p]
    [FiniteDimensional k L] [FiniteDimensional k DL] [FiniteDimensional k DU]
    (dimensions : Module.finrank k DL = Module.finrank k DU)
    (sourceInjective : Function.Injective square.sourcePullback)
    (primitives : RepresentationCocyclePrimitives square.sourceAction)
    (groupEquiv : G ≃* Multiplicative (ZMod (p ^ a))) :
    Specifications.CyclicCokernelBlockExistence square p a groupEquiv := by
  obtain ⟨d, length, bound, positive, e, equivariant, counts⟩ :=
    actual_cyclic_block_existence p a groupEquiv square.kernelAction
  have lower_dimension : Module.finrank k (LinearMap.ker square.lowerMap) = d := by
    have invariant := counts.2.1
    rw [Fintype.card_fin] at invariant
    exact (square.kernel_invariant_finrank_eq sourceInjective).symm.trans invariant
  have actual := square.cyclic_cokernel_block_counts p a dimensions sourceInjective
    primitives groupEquiv length bound positive e equivariant
  subst d
  exact ⟨length, bound, positive, e, equivariant, actual⟩

end Litt3.Deformations.InvariantDescentSquare
