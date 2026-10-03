import Definitions.Deformations.TruncatedWeightedIdeal
import Solutions.Deformations.WeightedMonomialIdeal
import Solutions.Deformations.TruncatedMonomialBasis

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R] [Fintype I]

/-- The maximum possible weight of a surviving original monomial is
derived from each literal truncation bound. -/
theorem surviving_monomial_weight_le (q w : I → ℕ) (a : I →₀ ℕ)
    (surviving : ∀ i, a i < q i) :
    originalMonomialWeight I w a ≤ ∑ i, w i * (q i - 1) := by
  apply Finset.sum_le_sum
  intro i member
  exact Nat.mul_le_mul_left (w i) (by have := surviving i; omega)

/-- Above the derived maximum surviving weight the entire original
weighted ideal lies in the literal unequal variable-power ideal. -/
theorem weighted_ideal_le_truncation (q w : I → ℕ) (d : ℕ)
    (cutoff : (∑ i, w i * (q i - 1)) < d) :
    weightedMonomialIdeal I R w d ≤ truncatedMonomialIdeal R I q := by
  classical
  intro f member
  rw [weighted_monomial_ideal_membership] at member
  rw [truncated_monomial_ideal_membership]
  intro a support
  by_contra outside
  have surviving : ∀ i, a i < q i := by simpa only [not_exists, not_le] using outside
  have bound := surviving_monomial_weight_le I q w a surviving
  exact (not_le_of_gt cutoff) ((member a support).trans bound)

/-- The actual image ideal has the exact weight-controlled nilpotence
bound. No nilpotence or quotient-length conclusion is supplied as input. -/
theorem truncated_weighted_ideal_nilpotent (q w : I → ℕ) (d m : ℕ)
    (cutoff : (∑ i, w i * (q i - 1)) < d * m) :
    truncatedWeightedIdeal R I q w d ^ m = ⊥ := by
  rw [truncatedWeightedIdeal, ← Ideal.map_pow]
  apply Ideal.map_mk_eq_bot_of_le
  exact (weighted_monomial_ideal_pow_le I R w d m).trans
    (weighted_ideal_le_truncation R I q w (d * m) cutoff)

/-- Each actual element of the image weighted ideal satisfies the
derived nilpotence bound, including over a nonreduced coefficient ring. -/
theorem truncated_weighted_element_pow_eq_zero (q w : I → ℕ) (d m : ℕ)
    (cutoff : (∑ i, w i * (q i - 1)) < d * m)
    (g : TruncatedMonomialAlgebra R I q)
    (member : g ∈ truncatedWeightedIdeal R I q w d) : g ^ m = 0 := by
  have power := Ideal.pow_mem_pow member m
  rw [truncated_weighted_ideal_nilpotent R I q w d m cutoff, Ideal.mem_bot] at power
  exact power

end Litt3.Deformations
