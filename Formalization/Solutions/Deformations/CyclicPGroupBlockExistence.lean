import Solutions.Deformations.ActualCyclicBlockExistence

namespace Litt3.Deformations

variable {k G V : Type} [Field k] [Group G] [Fintype G] [IsCyclic G]
    [AddCommGroup V] [Module k V] [FiniteDimensional k V]

/-- An actual cyclic group of the stated p-power cardinality admits
the full actual block decomposition, without a supplied group model
or block model. The actual group isomorphism is constructed. -/
theorem cyclic_p_group_block_existence (p a : ℕ) [Fact p.Prime] [CharP k p]
    (card : Nat.card G = p ^ a) (ρ : Representation k G V) :
    ∃ groupEquiv : G ≃* Multiplicative (ZMod (p ^ a)),
      Specifications.ActualCyclicBlockExistence p a groupEquiv ρ := by
  have canonical_card : Nat.card (Multiplicative (ZMod (p ^ a))) = p ^ a := by
    change Nat.card (ZMod (p ^ a)) = p ^ a
    rw [Nat.card_eq_fintype_card, ZMod.card]
  let groupEquiv : G ≃* Multiplicative (ZMod (p ^ a)) :=
    mulEquivOfCyclicCardEq (card.trans canonical_card.symm)
  exact ⟨groupEquiv, actual_cyclic_block_existence p a groupEquiv ρ⟩

end Litt3.Deformations
