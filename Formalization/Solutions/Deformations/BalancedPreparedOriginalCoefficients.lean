import Solutions.Deformations.SelectedPolynomialQuadraticCoefficients
import Solutions.Deformations.BalancedPreparedMonomialSocle

set_option maxHeartbeats 800000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.Deformations

variable (K : Type*) [Field K] (Q : ℕ)

/-- With the ORIGINAL mixed quadratic coefficient zero, the entire
selected linear coefficient lies in the square of the SAME lower
augmentation ideal. No higher-term or prepared-coefficient input is used. -/
theorem balanced_prepared_original_linear_quadratic
    (P : MvPolynomial (Fin 2) K) (quadratic : ∀ a ∈ P.support, 2 ≤ a.degree)
    (mixed : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) = 0) :
    PowerSeries.coeff 1
        (selectedTruncatedCoefficientPolynomial K 1 (fun _ => Q) P :
          PowerSeries (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))) ∈
      truncatedMonomialAugmentationIdeal K (Fin 1) (fun _ => Q) ^ 2 := by
  classical
  rw [Polynomial.coeff_coe]
  unfold selectedTruncatedCoefficientPolynomial
  rw [Polynomial.coeff_map]
  apply truncated_monomial_polynomial_quadratic_augmentation
  intro a ha
  have bound := selected_polynomial_coefficient_support_bound K 1 P quadratic 1 a ha
  have degree : a.degree = a 0 := by simp [Finsupp.degree_eq_sum]
  have excluded : a 0 ≠ 1 := by
    intro same
    have index : a.cons 1 = Finsupp.single (0 : Fin 2) 1 + Finsupp.single 1 1 := by
      ext i
      induction i using Fin.cases with
      | zero => simp
      | succ j =>
        rw [Subsingleton.elim j 0]
        simpa using same
    have nz := MvPolynomial.mem_support_iff.mp ha
    rw [MvPolynomial.finSuccEquiv_coeff_coeff, index, mixed] at nz
    exact nz rfl
  rw [degree] at bound ⊢
  omega

/-- The lower quadratic coefficient in the selected equation is the
UNCHANGED original y² coefficient, before and after actual regrouping. -/
theorem balanced_prepared_original_lower_quadratic_coefficient
    (P : MvPolynomial (Fin 2) K) :
    ((MvPolynomial.finSuccEquiv K 1 P).coeff 0).coeff (Finsupp.single 0 2) =
      P.coeff (Finsupp.single 1 2) := by
  rw [MvPolynomial.finSuccEquiv_coeff_coeff]
  congr 1
  ext i
  induction i using Fin.cases with
  | zero => simp
  | succ j =>
    simp only [Finsupp.cons_succ]
    rw [Subsingleton.elim j 0]
    simp

end Litt3.Deformations
