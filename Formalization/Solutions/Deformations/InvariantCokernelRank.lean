import Theorems.Deformations.InvariantCokernelRank
import Solutions.Deformations.InvariantCokernelObstruction
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations.InvariantDescentSquare

universe u

variable {k G L U DL DU : Type u} [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]
    (square : InvariantDescentSquare k G L U DL DU)

/-- Genuine rank-nullity computes the actual cokernel pullback rank
from the full actual H¹ obstruction. Only finite downstairs spaces of
equal dimension and ambient cocycle primitives are needed. -/
theorem invariant_cokernel_rank [FiniteDimensional k DL] [FiniteDimensional k DU]
    (dimensions : Module.finrank k DL = Module.finrank k DU)
    (primitives : RepresentationCocyclePrimitives square.sourceAction) :
    Specifications.InvariantCokernelRank square := by
  have lower := square.lowerMap.finrank_range_add_finrank_ker
  have quotient := (LinearMap.range square.lowerMap).finrank_quotient_add_finrank
  have cokernel : Module.finrank k (DU ⧸ LinearMap.range square.lowerMap) =
      Module.finrank k (LinearMap.ker square.lowerMap) := by omega
  have cohomology : Module.finrank k (groupCohomology (Rep.of square.kernelAction) 1) =
      Module.finrank k (LinearMap.ker square.cokernelPullback) :=
    (square.cohomologyCokernelObstructionEquiv primitives).finrank_eq
  have rank := square.cokernelPullback.finrank_range_add_finrank_ker
  rw [← cohomology, cokernel] at rank
  exact rank

end Litt3.Deformations.InvariantDescentSquare
