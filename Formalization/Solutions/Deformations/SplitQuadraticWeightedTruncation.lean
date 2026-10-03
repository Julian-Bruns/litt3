import Solutions.Deformations.SplitQuadraticAlgebra
import Solutions.Deformations.TruncatedWeightedNilpotence
import Solutions.Deformations.TruncatedMonomialDimensions
import Solutions.Deformations.TruncatedMonomialNontrivial

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K I : Type*) [Field K] [Fintype I]

/-- The actual unequal-power quotient of a relative quadratic has
twice the exact base dimension once its derived weighted cutoff makes
the original odd power redundant. -/
theorem split_quadratic_weighted_truncation_length (q : I → ℕ) (positive : ∀ i, 0 < q i)
    (w : I → ℕ) (d m : ℕ) (cutoff : (∑ i, w i * (q i - 1)) < d * m)
    (g : TruncatedMonomialAlgebra K I q) (member : g ∈ truncatedWeightedIdeal K I q w d) :
    Module.finrank K ((Polynomial (TruncatedMonomialAlgebra K I q)) ⧸
      Ideal.span ({splitQuadraticPolynomial g, Polynomial.X ^ (2 * m + 1)} :
        Set (Polynomial (TruncatedMonomialAlgebra K I q)))) = 2 * ∏ i, q i := by
  let A := TruncatedMonomialAlgebra K I q
  letI : Nontrivial A := truncated_monomial_nontrivial K I q positive
  have nilpotent := truncated_weighted_element_pow_eq_zero K I q w d m cutoff g member
  have relations := split_quadratic_odd_relation_ideal g m nilpotent
  have equivalence := Ideal.quotientEquivAlgOfEq K relations
  rw [equivalence.toLinearEquiv.finrank_eq]
  change Module.finrank K (SplitQuadraticAlgebra g) = 2 * ∏ i, q i
  rw [split_quadratic_finrank K, truncated_monomial_finrank K I q]

end Litt3.Deformations
