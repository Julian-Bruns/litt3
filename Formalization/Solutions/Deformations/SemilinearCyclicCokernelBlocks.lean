import Solutions.Deformations.SemilinearInvariantCokernelRank
import Solutions.Deformations.CyclicCokernelBlockExistence

namespace Litt3.Deformations.SemilinearInvariantDescentData

open scoped MonoidAlgebra

variable {k G V D : Type} [Field k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V] [AddCommGroup D] [Module k D]
    {σ : k ≃+* k} (data : SemilinearInvariantDescentData (G := G) (V := V) (D := D) σ)
    [FiniteDimensional k V] [Module.Free k[G] data.action.asModule]

/-- The actual semilinear obstruction square of every cyclic p-power
group has its full proved kernel decomposition. Its genuine H¹ counts
and literal cokernel-pullback rank retain both distinct scalar twists
and every actual pullback and operator. -/
theorem semilinear_cyclic_cokernel_blocks (p a : ℕ) [Fact p.Prime] [CharP k p]
    (groupEquiv : G ≃* Multiplicative (ZMod (p ^ a))) :
    Specifications.CyclicCokernelBlockExistence data.asLinearSquare p a groupEquiv := by
  letI : FiniteDimensional k D :=
    Module.Finite.of_injective data.pullback data.pullbackInjective
  exact data.asLinearSquare.cyclic_cokernel_block_existence p a
    (scalar_twist_finrank (V := D) σ).symm data.pullbackInjective
    (free_group_module_cocycle_primitives data.action) groupEquiv

end Litt3.Deformations.SemilinearInvariantDescentData
