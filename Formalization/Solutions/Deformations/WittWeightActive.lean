import Solutions.Deformations.WittWeightedInitial

namespace Litt3.Deformations

theorem basis_weight_exact_exponent (w d b j : ℕ) (positive : 0 < w)
    (exactWeight : d = w * j + b) : basisWeightExponent w d b = j := by
  apply Nat.le_antisymm
  · exact (basis_weight_exponent_le w d b j positive).mpr exactWeight.le
  · by_contra smaller
    have strict : basisWeightExponent w d b < j := by omega
    have multiplied := Nat.mul_lt_mul_of_pos_left strict positive
    have reaches := basis_weight_exponent_reaches w d b positive
    omega

/-- The surviving coordinate condition means literally that the exact
weight is represented by an actual nonterminal prime power. -/
theorem witt_weight_active_iff (w d b N : ℕ) (positive : 0 < w) :
    wittWeightActive w d b N ↔ ∃ j : ℕ, j < N ∧ d = w * j + b := by
  constructor
  · intro active
    exact ⟨_, active.2, active.1.symm⟩
  · rintro ⟨j, bound, exactWeight⟩
    unfold wittWeightActive
    rw [basis_weight_exact_exponent w d b j positive exactWeight]
    exact ⟨exactWeight.symm, bound⟩

end Litt3.Deformations
