import Definitions.Deformations.WittWeightedInitial
import Solutions.Deformations.BasisWeightSuccessor
import Solutions.Deformations.TruncatedWittInitialLayer

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

theorem truncated_witt_power_zero_above (j : ℕ) (bound : N ≤ j) :
    (p : TruncatedWittVector p N k) ^ j = 0 := by
  obtain ⟨t, rfl⟩ := Nat.exists_eq_add_of_le bound
  rw [pow_add, truncated_witt_top_power_zero, zero_mul]

include positive in
/-- Every actual weighted coefficient has a unique surviving residue
initial coordinate; all terminal and inexact weights are forced zero. -/
theorem witt_weighted_coefficient_initial_exists_unique (w d b : ℕ)
    (weightPositive : 0 < w) (a : TruncatedWittVector p N k)
    (member : (p : TruncatedWittVector p N k) ^ basisWeightExponent w d b ∣ a) :
    ∃! c : k, WittWeightedCoefficientInitial p N w d b a c := by
  classical
  obtain ⟨z, rfl⟩ := member
  by_cases active : wittWeightActive w d b N
  · let c := truncatedWittResidue p N positive k z
    have successor : basisWeightExponent w (d + 1) b = basisWeightExponent w d b + 1 := by
      rw [basis_weight_successor_exponent w d b weightPositive, if_pos active.1]
    have represents : WittWeightedCoefficientInitial p N w d b
        ((p : TruncatedWittVector p N k) ^ basisWeightExponent w d b * z) c := by
      constructor
      · intro inactive
        exact (inactive active).elim
      · rw [wittWeightedInitialCoefficient, if_pos active, successor]
        exact truncated_witt_teichmuller_initial_replacement p N positive k _ z
    refine ⟨c, represents, ?_⟩
    intro other otherRepresents
    have difference := dvd_sub represents.2 otherRepresents.2
    have equalInitial : (p : TruncatedWittVector p N k) ^ (basisWeightExponent w d b + 1) ∣
        (p : TruncatedWittVector p N k) ^ basisWeightExponent w d b *
          WittVector.truncate N (WittVector.teichmuller p other) -
        (p : TruncatedWittVector p N k) ^ basisWeightExponent w d b *
          WittVector.truncate N (WittVector.teichmuller p c) := by
      rw [successor, wittWeightedInitialCoefficient, if_pos active,
        wittWeightedInitialCoefficient, if_pos active] at difference
      convert difference using 1 <;> ring
    exact (truncated_witt_teichmuller_initial_equal p N positive k _ active.2 other c).mp equalInitial
  · have represents : WittWeightedCoefficientInitial p N w d b
        ((p : TruncatedWittVector p N k) ^ basisWeightExponent w d b * z) 0 := by
      constructor
      · intro _
        rfl
      · rw [wittWeightedInitialCoefficient, if_neg active, sub_zero]
        by_cases exactWeight : w * basisWeightExponent w d b + b = d
        · have terminal : N ≤ basisWeightExponent w d b := by
            by_contra nonterminal
            exact active ⟨exactWeight, by omega⟩
          rw [truncated_witt_power_zero_above p N k _ terminal, zero_mul]
          exact dvd_zero _
        · rw [basis_weight_successor_exponent w d b weightPositive, if_neg exactWeight]
          exact dvd_mul_right _ _
    refine ⟨0, represents, ?_⟩
    intro other otherRepresents
    exact otherRepresents.1 active

end Litt3.Deformations
