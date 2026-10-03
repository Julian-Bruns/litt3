import Theorems.Deformations.InvariantCokernelRank
import Theorems.Deformations.ActualCyclicBlockCounts

namespace Litt3.Deformations.Specifications

variable {k G L U DL DU ι : Type} [Field k] [Group G] [Fintype G] [Fintype ι]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]

/-- Exact block counts for the actual comparison square, including
the rank of the actual pullback on its actual cokernels. -/
def CyclicCokernelBlockCounts (square : InvariantDescentSquare k G L U DL DU)
    (p a : ℕ) (length : ι → ℕ) : Prop :=
  Module.finrank k (LinearMap.ker square.lowerMap) = Fintype.card ι ∧
    Module.finrank k (LinearMap.ker square.upperMap) = ∑ i, length i ∧
    Module.finrank k (groupCohomology (Rep.of square.kernelAction) 1) =
      (Finset.univ.filter fun i => length i < p ^ a).card ∧
    Module.finrank k (LinearMap.range square.cokernelPullback) =
      (Finset.univ.filter fun i => length i = p ^ a).card

end Litt3.Deformations.Specifications
