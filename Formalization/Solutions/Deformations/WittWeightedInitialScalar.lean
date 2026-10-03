import Solutions.Deformations.WittWeightedInitialAdd

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

include positive in
/-- Genuine coefficient multiplication induces multiplication by its
actual residue on every weighted initial class. -/
theorem witt_weighted_coefficient_initial_scalar (w d b : ℕ)
    (weightPositive : 0 < w) (a t : TruncatedWittVector p N k) (c : k)
    (initial : WittWeightedCoefficientInitial p N w d b a c) :
    WittWeightedCoefficientInitial p N w d b (t * a)
      (truncatedWittResidue p N positive k t * c) := by
  classical
  constructor
  · intro inactive
    rw [initial.1 inactive, mul_zero]
  · by_cases active : wittWeightActive w d b N
    · obtain ⟨u, relation⟩ := truncated_witt_teichmuller_initial_replacement p N positive k
        (basisWeightExponent w d b) (t * WittVector.truncate N (WittVector.teichmuller p c))
      simp only [map_mul, truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero] at relation
      have defect : (p : TruncatedWittVector p N k) ^ basisWeightExponent w (d + 1) b ∣
          t * wittWeightedInitialCoefficient p N w d b c -
            wittWeightedInitialCoefficient p N w d b (truncatedWittResidue p N positive k t * c) := by
        rw [basis_weight_successor_exponent w d b weightPositive, if_pos active.1]
        refine ⟨u, ?_⟩
        simp only [wittWeightedInitialCoefficient, if_pos active, map_mul]
        convert relation using 1 <;> ring
      have multiplied := dvd_mul_of_dvd_right initial.2 t
      have result := dvd_add multiplied defect
      convert result using 1 <;> ring
    · have remainder := initial.2
      simp only [wittWeightedInitialCoefficient, if_neg active, sub_zero] at remainder ⊢
      exact dvd_mul_of_dvd_right remainder t

end Litt3.Deformations
