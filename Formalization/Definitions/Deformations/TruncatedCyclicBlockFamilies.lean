import Definitions.Deformations.TruncatedCyclicRepresentations
import Definitions.Deformations.RepresentationProducts

namespace Litt3.Deformations

variable {k ι : Type} [CommRing k]

/-- The actual finite direct-sum model, presented as its actual
product representation, of the specified full cyclic quotient blocks. -/
noncomputable def truncatedCyclicBlockFamilyRepresentation (p a : ℕ)
    [Fact p.Prime] [CharP k p] (length : ι → ℕ) (bound : ∀ i, length i ≤ p ^ a) :
    Representation k (Multiplicative (ZMod (p ^ a)))
      (∀ i, TruncatedCoefficientRing k (length i)) :=
  representationPi (fun i => truncatedCyclicBlockRepresentation p a (length i) (bound i))

end Litt3.Deformations
