import Solutions.Deformations.WittWeightedInitial
import Solutions.Deformations.WittWeightedCoordinateMap

namespace Litt3.Deformations

attribute [local instance] Classical.propDecidable

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

theorem witt_weighted_initial_coefficient_residue (w d b : ℕ) (c : k) :
    truncatedWittResidue p N positive k (wittWeightedInitialCoefficient p N w d b c) =
      if wittWeightActive w d b N ∧ basisWeightExponent w d b = 0 then c else 0 := by
  classical
  by_cases active : wittWeightActive w d b N
  · rw [wittWeightedInitialCoefficient, if_pos active, map_mul, map_pow,
      truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero]
    by_cases exponent : basisWeightExponent w d b = 0
    · simp only [exponent, pow_zero, one_mul, active, true_and, if_true]
    · rw [map_natCast, CharP.cast_eq_zero k p, zero_pow exponent, zero_mul,
        if_neg (by simp only [active, true_and, exponent, not_false_eq_true])]
  · rw [wittWeightedInitialCoefficient, if_neg active, map_zero, if_neg (by simp [active])]

theorem witt_weighted_initial_zero_exponent (w d : ℕ) (weightPositive : 0 < w)
    (a : TruncatedWittVector p N k) (c : k)
    (initial : WittWeightedCoefficientInitial p N w d d a c) :
    c = truncatedWittResidue p N positive k a := by
  have exponent : basisWeightExponent w d d = 0 := by
    apply Nat.eq_zero_of_le_zero
    apply (basis_weight_exponent_le w d d 0 weightPositive).mpr
    omega
  have active : wittWeightActive w d d N := by
    exact ⟨by rw [exponent]; omega, by rw [exponent]; exact positive⟩
  have next : basisWeightExponent w (d + 1) d = 1 := by
    rw [basis_weight_successor_exponent w d d weightPositive, exponent, if_pos (by omega)]
  obtain ⟨z, relation⟩ := initial.2
  rw [next, pow_one, wittWeightedInitialCoefficient, if_pos active, exponent, pow_zero, one_mul] at relation
  have residue := congrArg (truncatedWittResidue p N positive k) relation
  rw [map_mul, map_natCast, CharP.cast_eq_zero k p, zero_mul, map_sub,
    truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero] at residue
  exact (sub_eq_zero.mp residue).symm

end Litt3.Deformations
