import Theorems.Deformations.RankOneQuadraticTruncation
import Solutions.Deformations.RankOneQuadraticNilpotence
import Solutions.Deformations.SplitQuadraticWeightedTruncation

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K : Type*) [Field K]

/-- The exact rank-one source length follows from its literal
higher-remainder ideal and weighted inequality, independently of all
uncomputed higher terms. Algebraic closure and characteristic are unnecessary
for this actual normal-form quotient. -/
theorem rank_one_quadratic_truncation_length (Q T : ℕ) (positiveQ : 0 < Q) (positiveT : 0 < T)
    (odd : Odd Q) (bound : 4 * T < Q + 3) :
    Specifications.RankOneQuadraticTruncationLength K Q T := by
  intro g member
  obtain ⟨m, exponent⟩ := odd.exists_bit1
  have positive : ∀ i : Fin 2, 0 < (![Q, T] : Fin 2 → ℕ) i := by
    intro i
    fin_cases i <;> simp [positiveQ, positiveT]
  have cutoff : (∑ i : Fin 2, (![1, 2] : Fin 2 → ℕ) i *
      ((![Q, T] : Fin 2 → ℕ) i - 1)) < 3 * m := by
    simp only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, one_mul]
    omega
  have actual := split_quadratic_weighted_truncation_length K (Fin 2) ![Q, T] positive ![1, 2]
    3 m cutoff g (rank_one_remainder_le_weight_three K Q T member)
  have powers : (Polynomial.X : Polynomial (TruncatedMonomialAlgebra K (Fin 2) ![Q, T])) ^
      (2 * m + 1) = Polynomial.X ^ Q := congrArg (fun n => Polynomial.X ^ n) exponent.symm
  have ideals := congrArg (fun t : Polynomial (TruncatedMonomialAlgebra K (Fin 2) ![Q, T]) =>
    Ideal.span ({splitQuadraticPolynomial g, t} :
      Set (Polynomial (TruncatedMonomialAlgebra K (Fin 2) ![Q, T])))) powers
  have equivalence := Ideal.quotientEquivAlgOfEq K ideals
  rw [← equivalence.toLinearEquiv.finrank_eq]
  simpa only [Fin.prod_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, mul_assoc] using actual

end Litt3.Deformations
