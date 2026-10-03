import Solutions.Deformations.WittWeightedInitial

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

@[simp] theorem witt_weighted_initial_coefficient_zero (w d b : ℕ) :
    wittWeightedInitialCoefficient p N w d b (0 : k) = 0 := by
  classical
  unfold wittWeightedInitialCoefficient
  split_ifs <;> simp only [WittVector.teichmuller_zero, map_zero, mul_zero]

include positive in
/-- A genuine weighted residue initial coefficient vanishes exactly
when its actual Witt coefficient lies one weight higher. -/
theorem witt_weighted_coefficient_initial_zero_iff (w d b : ℕ)
    (weightPositive : 0 < w) (a : TruncatedWittVector p N k) (c : k)
    (initial : WittWeightedCoefficientInitial p N w d b a c) :
    c = 0 ↔ (p : TruncatedWittVector p N k) ^ basisWeightExponent w (d + 1) b ∣ a := by
  classical
  constructor
  · intro zero
    have remainder := initial.2
    rw [zero, witt_weighted_initial_coefficient_zero, sub_zero] at remainder
    exact remainder
  · intro higher
    by_cases active : wittWeightActive w d b N
    · have representative := dvd_sub higher initial.2
      rw [sub_sub_cancel] at representative
      rw [wittWeightedInitialCoefficient, if_pos active,
        basis_weight_successor_exponent w d b weightPositive, if_pos active.1] at representative
      have zero := (truncated_witt_initial_layer_zero p N positive k _ active.2 _).mp representative
      simpa only [truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero] using zero
    · exact initial.1 active

end Litt3.Deformations
