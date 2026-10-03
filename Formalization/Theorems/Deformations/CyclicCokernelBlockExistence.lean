import Theorems.Deformations.CyclicCokernelBlockCounts
import Definitions.Deformations.TruncatedCyclicBlockFamilies

namespace Litt3.Deformations.Specifications

variable {k G L U DL DU : Type} [Field k] [Group G] [Fintype G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]

/-- The full actual cyclic kernel decomposition, indexed by the
literal downstairs kernel dimension, and all exact obstruction counts. -/
def CyclicCokernelBlockExistence (square : InvariantDescentSquare k G L U DL DU)
    (p a : ℕ) [Fact p.Prime] [CharP k p]
    (groupEquiv : G ≃* Multiplicative (ZMod (p ^ a))) : Prop :=
  ∃ (length : Fin (Module.finrank k (LinearMap.ker square.lowerMap)) → ℕ)
    (bound : ∀ i, length i ≤ p ^ a),
    (∀ i, 0 < length i) ∧
    ∃ e : LinearMap.ker square.upperMap ≃ₗ[k]
      (∀ i, TruncatedCoefficientRing k (length i)),
      (∀ g v, e (square.kernelAction g v) =
        truncatedCyclicBlockFamilyRepresentation p a length bound (groupEquiv g) (e v)) ∧
      CyclicCokernelBlockCounts square p a length

end Litt3.Deformations.Specifications
