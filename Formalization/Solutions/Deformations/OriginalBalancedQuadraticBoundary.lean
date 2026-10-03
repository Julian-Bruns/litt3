import Solutions.Deformations.TruncatedMonomialDimensions
import Solutions.Deformations.TruncatedMonomialCoefficients

set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K : Type*) [Field K]

/-- Cutoff ONE is retained: every original positive-degree equation is
already in the original power ideal, and the actual quotient is the
unchanged coefficient field of dimension one. -/
theorem original_balanced_binary_polynomial_cutoff_one
    (P : MvPolynomial (Fin 2) K) (quadratic : ∀ a ∈ P.support, 2 ≤ a.degree) :
    Module.finrank K (MvPolynomial (Fin 2) K ⧸
      (truncatedMonomialIdeal K (Fin 2) (fun _ => 1) ⊔ Ideal.span ({P} : Set _))) = 1 := by
  have member : P ∈ truncatedMonomialIdeal K (Fin 2) (fun _ => 1) := by
    rw [truncated_monomial_ideal_membership]
    intro a ha
    have degree : a.degree = a 0 + a 1 := by simp [Finsupp.degree_eq_sum, Fin.sum_univ_two]
    have bound := quadratic a ha
    rw [degree] at bound
    by_cases first : 1 ≤ a 0
    · exact ⟨0, first⟩
    · exact ⟨1, by omega⟩
  have included : Ideal.span ({P} : Set _) ≤ truncatedMonomialIdeal K (Fin 2) (fun _ => 1) := by
    apply Ideal.span_le.mpr
    rintro x rfl
    exact member
  rw [sup_eq_left.mpr included]
  simpa using truncated_monomial_finrank K (Fin 2) (fun _ => 1)

/-- Transport the cutoff-one boundary through equality of the ORIGINAL
power ideals, preserving the actual quotient module instances. -/
theorem original_balanced_binary_polynomial_cutoff_eq_one (Q : ℕ) (one : Q = 1)
    (P : MvPolynomial (Fin 2) K) (quadratic : ∀ a ∈ P.support, 2 ≤ a.degree) :
    Module.finrank K (MvPolynomial (Fin 2) K ⧸
      (truncatedMonomialIdeal K (Fin 2) (fun _ => Q) ⊔ Ideal.span ({P} : Set _))) =
        2 * Q - 1 := by
  have powers : truncatedMonomialIdeal K (Fin 2) (fun _ => Q) =
      truncatedMonomialIdeal K (Fin 2) (fun _ => 1) := by
    congr 1
    funext i
    exact one
  let e := Ideal.quotientEquivAlgOfEq K
    (congrArg (fun I => I ⊔ Ideal.span ({P} : Set _)) powers)
  rw [e.toLinearEquiv.finrank_eq]
  simpa only [one] using original_balanced_binary_polynomial_cutoff_one K P quadratic

end Litt3.Deformations
