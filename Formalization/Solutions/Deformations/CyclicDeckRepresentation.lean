import Theorems.Deformations.CyclicDeckRepresentation

namespace Litt3.Deformations

variable {k : Type*} [Field k] [Invertible (2 : k)]

theorem cyclic_skew_deck_action (p a : ℕ) [Fact p.Prime] [CharP k p]
    (M : Type*) [AddCommGroup M] [Module k M]
    [Module (TruncatedCoefficientRing k (p ^ a)) M]
    [IsScalarTower k (TruncatedCoefficientRing k (p ^ a)) M]
    (g : Multiplicative (ZMod (p ^ a))) (x : M) :
    cyclicSkewDeckRepresentation (k := k) p a M g x =
      (cyclicSkewAlgebraEquiv (k := k) p a).symm
        (AddMonoidAlgebra.single g.toAdd 1) • x := rfl

/-- Every proved full Q_N-module kernel identification is
equivariant for the actual cyclic action supplied by the
actual group algebra, including the generator action. -/
theorem cyclic_deck_equivalence_equivariant (p a : ℕ) [Fact p.Prime] [CharP k p]
    (M M' : Type*) [AddCommGroup M] [Module k M]
    [Module (TruncatedCoefficientRing k (p ^ a)) M]
    [IsScalarTower k (TruncatedCoefficientRing k (p ^ a)) M]
    [AddCommGroup M'] [Module k M'] [Module (TruncatedCoefficientRing k (p ^ a)) M']
    [IsScalarTower k (TruncatedCoefficientRing k (p ^ a)) M']
    (E : M ≃ₗ[TruncatedCoefficientRing k (p ^ a)] M') :
    Specifications.CyclicDeckEquivalenceEquivariant p a M M' E := by
  intro g x
  rw [cyclic_skew_deck_action, cyclic_skew_deck_action]
  exact E.map_smul _ x

end Litt3.Deformations
