import Theorems.Deformations.SplitQuadraticTruncation
import Solutions.Deformations.SplitQuadraticAlgebra
import Solutions.Deformations.TruncatedMonomialDimensions
import Solutions.Deformations.TruncatedMonomialNontrivial
import Solutions.Deformations.TruncatedMonomialNilpotence
import Mathlib.Algebra.Ring.Parity

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K I : Type*) [Field K] [Fintype I]

/-- The full actual split quadratic length formula follows uniformly
from the original unequal-power relations and their derived sharp
nilpotence. Neither Frobenius-power exponents nor algebraic closure are
needed once the literal relative quadratic equation is given. -/
theorem split_quadratic_truncation_length (q : I → ℕ) (positive : ∀ i, 0 < q i)
    (Q : ℕ) (odd : Odd Q) (degreeBound : (∑ i, (q i - 1)) < Q - 1) :
    Specifications.SplitQuadraticTruncationLength K I q Q := by
  let A := TruncatedMonomialAlgebra K I q
  letI : Nontrivial A := truncated_monomial_nontrivial K I q positive
  intro g quadratic
  obtain ⟨m, exponent⟩ := odd.exists_bit1
  have cutoff : truncatedMonomialAugmentationIdeal K I q ^ (2 * m) = ⊥ := by
    apply le_bot_iff.mp
    have base := truncated_monomial_augmentation_cutoff K I q positive
    have bound : (∑ i, (q i - 1)) + 1 ≤ 2 * m := by omega
    exact base ▸ Ideal.pow_le_pow_right bound
  have relations := split_quadratic_odd_relation_of_ideal_cutoff g
    (truncatedMonomialAugmentationIdeal K I q) m quadratic cutoff
  have fullRelations : Ideal.span ({splitQuadraticPolynomial g, Polynomial.X ^ Q} : Set (Polynomial A)) =
      Ideal.span ({splitQuadraticPolynomial g} : Set (Polynomial A)) := by
    simpa only [exponent] using relations
  have equivalence := Ideal.quotientEquivAlgOfEq K fullRelations
  rw [equivalence.toLinearEquiv.finrank_eq]
  change Module.finrank K (SplitQuadraticAlgebra g) = 2 * ∏ i, q i
  rw [split_quadratic_finrank K, truncated_monomial_finrank K I q]

end Litt3.Deformations
