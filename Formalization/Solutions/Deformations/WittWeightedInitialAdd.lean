import Solutions.Deformations.WittWeightedInitialZero

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

include positive in
/-- Actual Teichmüller addition induces literal residue-field addition
in every original nonterminal weighted class. -/
theorem witt_weighted_coefficient_initial_add (w d b : ℕ)
    (weightPositive : 0 < w) (a a' : TruncatedWittVector p N k) (c c' : k)
    (initial : WittWeightedCoefficientInitial p N w d b a c)
    (initial' : WittWeightedCoefficientInitial p N w d b a' c') :
    WittWeightedCoefficientInitial p N w d b (a + a') (c + c') := by
  classical
  constructor
  · intro inactive
    rw [initial.1 inactive, initial'.1 inactive, add_zero]
  · by_cases active : wittWeightActive w d b N
    · obtain ⟨t, relation⟩ := truncated_witt_teichmuller_initial_replacement p N positive k
        (basisWeightExponent w d b)
        (WittVector.truncate N (WittVector.teichmuller p c) +
          WittVector.truncate N (WittVector.teichmuller p c'))
      simp only [map_add, truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero] at relation
      have defect : (p : TruncatedWittVector p N k) ^ basisWeightExponent w (d + 1) b ∣
          wittWeightedInitialCoefficient p N w d b c +
            wittWeightedInitialCoefficient p N w d b c' -
            wittWeightedInitialCoefficient p N w d b (c + c') := by
        rw [basis_weight_successor_exponent w d b weightPositive, if_pos active.1]
        refine ⟨t, ?_⟩
        simpa only [wittWeightedInitialCoefficient, if_pos active, mul_add] using relation
      have sum := dvd_add (dvd_add initial.2 initial'.2) defect
      convert sum using 1 <;> ring
    · have first := initial.2
      have second := initial'.2
      simp only [wittWeightedInitialCoefficient, if_neg active, sub_zero] at first second ⊢
      exact dvd_add first second

end Litt3.Deformations
