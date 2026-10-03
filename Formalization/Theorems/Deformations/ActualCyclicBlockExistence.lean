import Theorems.Deformations.ActualCyclicBlockCounts
import Definitions.Deformations.TruncatedCyclicBlockFamilies

namespace Litt3.Deformations.Specifications

variable {k G V : Type} [Field k] [Group G]
    [AddCommGroup V] [Module k V]

/-- Full actual cyclic quotient-block existence, retaining every deck
element and the literal quotient-block action. The full counts refer
to genuine group cohomology, actual full invariants and actual norms. -/
def ActualCyclicBlockExistence (p a : ℕ) [Fact p.Prime] [CharP k p]
    (groupEquiv : G ≃* Multiplicative (ZMod (p ^ a)))
    (ρ : Representation k G V) [Fintype G] : Prop :=
  ∃ (d : ℕ) (length : Fin d → ℕ) (bound : ∀ i, length i ≤ p ^ a),
    (∀ i, 0 < length i) ∧
    ∃ e : V ≃ₗ[k] (∀ i, TruncatedCoefficientRing k (length i)),
      (∀ g v, e (ρ g v) =
        truncatedCyclicBlockFamilyRepresentation p a length bound (groupEquiv g) (e v)) ∧
      ActualCyclicBlockCounts p a ρ length

end Litt3.Deformations.Specifications
