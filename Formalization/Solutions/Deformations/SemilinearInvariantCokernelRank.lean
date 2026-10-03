import Solutions.Deformations.SemilinearInvariantCokernel
import Solutions.Deformations.InvariantCokernelRank
import Solutions.Deformations.ScalarTwistDimensions

namespace Litt3.Deformations.SemilinearInvariantDescentData

open scoped MonoidAlgebra

universe u

variable {k G V D : Type u} [Field k] [Group G] [Finite G]
    [AddCommGroup V] [Module k V] [AddCommGroup D] [Module k D]
    {σ : k ≃+* k} (data : SemilinearInvariantDescentData (G := G) (V := V) (D := D) σ)
    [FiniteDimensional k V] [Module.Free k[G] data.action.asModule]

/-- For the canonical actual scalar-twisted square, the actual
cokernel pullback rank is determined by genuine H¹ and the actual
downstairs kernel. No identification of the scalar twist enters its maps. -/
theorem semilinear_invariant_cokernel_rank :
    Specifications.InvariantCokernelRank data.asLinearSquare := by
  letI : FiniteDimensional k D :=
    Module.Finite.of_injective data.pullback data.pullbackInjective
  exact data.asLinearSquare.invariant_cokernel_rank
    (scalar_twist_finrank (V := D) σ).symm
    (free_group_module_cocycle_primitives data.action)

end Litt3.Deformations.SemilinearInvariantDescentData
