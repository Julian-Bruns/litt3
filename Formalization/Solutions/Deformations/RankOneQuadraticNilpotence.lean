import Definitions.Deformations.RankOneQuadraticRemainder
import Solutions.Deformations.TruncatedWeightedNilpotence
import Mathlib.Tactic

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (R : Type*) [CommRing R]

/-- Every literal rank-one remainder lies in the actual ideal of
original y,z weight at least three. -/
theorem rank_one_remainder_le_weight_three (Q T : ℕ) :
    rankOneQuadraticRemainderIdeal R Q T ≤
      truncatedWeightedIdeal R (Fin 2) ![Q, T] ![1, 2] 3 := by
  classical
  apply Ideal.span_le.mpr
  intro g member
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at member
  rcases member with rfl | rfl | rfl
  · apply Ideal.mem_map_of_mem
    change (MvPolynomial.X 0 : MvPolynomial (Fin 2) R) ^ 3 ∈ weightedMonomialIdeal (Fin 2) R ![1, 2] 3
    rw [MvPolynomial.X_pow_eq_monomial]
    apply Ideal.subset_span
    exact ⟨Finsupp.single 0 3, by simp [originalMonomialWeight, Fin.sum_univ_two], rfl⟩
  · apply Ideal.mem_map_of_mem
    change (MvPolynomial.X 0 : MvPolynomial (Fin 2) R) * MvPolynomial.X 1 ∈
      weightedMonomialIdeal (Fin 2) R ![1, 2] 3
    rw [MvPolynomial.X, MvPolynomial.X, MvPolynomial.monomial_mul, one_mul]
    apply Ideal.subset_span
    refine ⟨Finsupp.single 0 1 + Finsupp.single 1 1, ?_, rfl⟩
    simp [originalMonomialWeight, Fin.sum_univ_two]
  · apply Ideal.mem_map_of_mem
    change (MvPolynomial.X 1 : MvPolynomial (Fin 2) R) ^ 2 ∈ weightedMonomialIdeal (Fin 2) R ![1, 2] 3
    rw [MvPolynomial.X_pow_eq_monomial]
    apply Ideal.subset_span
    exact ⟨Finsupp.single 1 2, by simp [originalMonomialWeight, Fin.sum_univ_two], rfl⟩

/-- The rank-one higher remainder is nilpotent under the exact
weighted inequality, over every commutative coefficient ring. -/
theorem rank_one_remainder_pow_eq_zero (Q T m : ℕ)
    (bound : Q - 1 + 2 * (T - 1) < 3 * m)
    (g : TruncatedMonomialAlgebra R (Fin 2) ![Q, T])
    (member : g ∈ rankOneQuadraticRemainderIdeal R Q T) : g ^ m = 0 := by
  apply truncated_weighted_element_pow_eq_zero R (Fin 2) ![Q, T] ![1, 2] 3 m
  · simpa [Fin.sum_univ_two] using bound
  · exact rank_one_remainder_le_weight_three R Q T member

/-- The source's odd-exponent inequality is exactly sufficient for
the actual rank-one nilpotence, with no higher-jet computation. -/
theorem rank_one_remainder_odd_cutoff (Q T : ℕ) (positiveQ : 0 < Q) (positiveT : 0 < T)
    (odd : Odd Q) (bound : 4 * T < Q + 3)
    (g : TruncatedMonomialAlgebra R (Fin 2) ![Q, T])
    (member : g ∈ rankOneQuadraticRemainderIdeal R Q T) : g ^ ((Q - 1) / 2) = 0 := by
  apply rank_one_remainder_pow_eq_zero R Q T
  obtain ⟨m, exponent⟩ := odd.exists_bit1
  omega
  exact member

end Litt3.Deformations
