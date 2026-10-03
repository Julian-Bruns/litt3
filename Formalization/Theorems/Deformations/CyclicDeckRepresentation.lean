import Definitions.Deformations.CyclicDeckRepresentation

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k] [Invertible (2 : k)]

def CyclicDeckEquivalenceEquivariant (p a : ℕ) [Fact p.Prime] [CharP k p]
    (M M' : Type*) [AddCommGroup M] [Module k M]
    [Module (TruncatedCoefficientRing k (p ^ a)) M]
    [IsScalarTower k (TruncatedCoefficientRing k (p ^ a)) M]
    [AddCommGroup M'] [Module k M'] [Module (TruncatedCoefficientRing k (p ^ a)) M']
    [IsScalarTower k (TruncatedCoefficientRing k (p ^ a)) M']
    (E : M ≃ₗ[TruncatedCoefficientRing k (p ^ a)] M') : Prop :=
  ∀ g x, E (cyclicSkewDeckRepresentation (k := k) p a M g x) =
    cyclicSkewDeckRepresentation (k := k) p a M' g (E x)

end Litt3.Deformations.Specifications
