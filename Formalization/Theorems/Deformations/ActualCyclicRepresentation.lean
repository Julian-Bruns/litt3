import Definitions.Deformations.ActualCyclicRepresentation

namespace Litt3.Deformations.Specifications

variable {k V : Type*} [Field k] [Invertible (2 : k)] [AddCommGroup V] [Module k V]

def ActualCyclicRepresentationRestored (p a : ℕ) [Fact p.Prime] [CharP k p]
    (ρ : Representation k (Multiplicative (ZMod (p ^ a))) V) : Prop :=
  letI := cyclicRepresentationTruncatedModule p a ρ
  ∀ g x, (cyclicSkewAlgebraEquiv (k := k) p a).symm
      (AddMonoidAlgebra.single g.toAdd 1) • x = ρ g x

end Litt3.Deformations.Specifications
