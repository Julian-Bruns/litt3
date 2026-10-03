import Definitions.Deformations.AffineFrobenius

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k] [IsAlgClosed k]

/-- Affine Frobenius coordinates have exactly the predicted count at
every translation, not just on a bounded parameter search. -/
def AffineFrobeniusCount (q d : ℕ) : Prop :=
  ∀ translation : Fin d → k,
    Nonempty (CoordinateFrobeniusSolutions q d translation) ∧
      Nat.card (CoordinateFrobeniusSolutions q d translation) = q ^ d

end Litt3.Deformations.Specifications
