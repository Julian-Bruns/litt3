import Solutions.Deformations.SelectedOriginalQuadraticCoefficients
import Solutions.Deformations.WeightedMonomialIdeal
import Definitions.Deformations.TruncatedWeightedIdeal

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (K : Type*) [Field K] (d : ℕ)

/-- Regrouping an arbitrary original polynomial retains its total-order
bound in every selected-variable coefficient. -/
theorem selected_polynomial_coefficient_support_bound
    (P : MvPolynomial (Fin (d + 1)) K)
    (quadratic : ∀ a ∈ P.support, 2 ≤ a.degree) (n : ℕ) :
    ∀ a ∈ ((MvPolynomial.finSuccEquiv K d P).coeff n).support, 2 ≤ n + a.degree := by
  intro a ha
  have coefficient : P.coeff (a.cons n) ≠ 0 := by
    rw [← MvPolynomial.finSuccEquiv_coeff_coeff]
    exact MvPolynomial.mem_support_iff.mp ha
  have bound := quadratic _ (MvPolynomial.mem_support_iff.mpr coefficient)
  rwa [original_finsupp_selected_degree] at bound

/-- The actual selected coefficient series of ANY original polynomial
has the preparation input directly from its original low coefficients. -/
theorem selected_polynomial_quadratic_coefficients (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (P : MvPolynomial (Fin (d + 1)) K)
    (quadratic : ∀ a ∈ P.support, 2 ≤ a.degree)
    (selected : P.coeff (Finsupp.single 0 2) ≠ 0) :
    let g : PowerSeries (TruncatedMonomialAlgebra K (Fin d) q) :=
      selectedTruncatedCoefficientPolynomial K d q P
    PowerSeries.constantCoeff g ∈ truncatedMonomialAugmentationIdeal K (Fin d) q ^ 2 ∧
      PowerSeries.coeff 1 g ∈ truncatedMonomialAugmentationIdeal K (Fin d) q ∧
      PowerSeries.coeff 2 g ∉ truncatedMonomialAugmentationIdeal K (Fin d) q := by
  classical
  intro g
  let G := MvPolynomial.finSuccEquiv K d P
  let A := TruncatedMonomialAlgebra K (Fin d) q
  have supportBound := selected_polynomial_coefficient_support_bound K d P quadratic
  have coefficient (n : ℕ) : PowerSeries.coeff n g =
      Ideal.Quotient.mk (truncatedMonomialIdeal K (Fin d) q) (G.coeff n) := by
    change PowerSeries.coeff n (selectedTruncatedCoefficientPolynomial K d q P : PowerSeries A) = _
    rw [Polynomial.coeff_coe]
    exact Polynomial.coeff_map _ _
  constructor
  · rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply, coefficient]
    apply truncated_monomial_polynomial_quadratic_augmentation
    intro a ha
    simpa only [zero_add] using supportBound 0 a ha
  · constructor
    · rw [coefficient]
      apply truncated_monomial_polynomial_augmentation
      by_contra nz
      have bound := supportBound 1 0 (MvPolynomial.mem_support_iff.mpr nz)
      simp only [map_zero, add_zero] at bound
      omega
    · rw [← truncated_monomial_residue_kernel K (Fin d) q positive, RingHom.mem_ker,
        coefficient]
      change truncatedMonomialResidue K (Fin d) q positive
        (Ideal.Quotient.mk _ (G.coeff 2)) ≠ 0
      rw [truncatedMonomialResidue, Ideal.Quotient.lift_mk, MvPolynomial.constantCoeff_eq,
        MvPolynomial.finSuccEquiv_coeff_coeff]
      change P.coeff ((0 : Fin d →₀ ℕ).cons 2) ≠ 0
      have index : (0 : Fin d →₀ ℕ).cons 2 = Finsupp.single 0 2 := by
        ext i
        induction i using Fin.cases with
        | zero => simp
        | succ j => simp
      rwa [index]

variable (Q T : ℕ)

/-- Vanishing of the original xy and y² quadratic coefficients gives
the exact weighted constant and linear ideals needed in the rank-one
case. All higher coefficients remain arbitrary. -/
theorem selected_polynomial_rank_one_weighted_coefficients
    (P : MvPolynomial (Fin 3) K) (quadratic : ∀ a ∈ P.support, 2 ≤ a.degree)
    (mixed : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) = 0)
    (second : P.coeff (Finsupp.single 1 2) = 0) :
    let g : PowerSeries (TruncatedMonomialAlgebra K (Fin 2) ![Q, T]) :=
      selectedTruncatedCoefficientPolynomial K 2 ![Q, T] P
    PowerSeries.constantCoeff g ∈ truncatedWeightedIdeal K (Fin 2) ![Q, T] ![1, 2] 3 ∧
      PowerSeries.coeff 1 g ∈ truncatedWeightedIdeal K (Fin 2) ![Q, T] ![1, 2] 2 := by
  classical
  intro g
  let G := MvPolynomial.finSuccEquiv K 2 P
  have supportBound := selected_polynomial_coefficient_support_bound K 2 P quadratic
  have coefficient (n : ℕ) : PowerSeries.coeff n g =
      Ideal.Quotient.mk (truncatedMonomialIdeal K (Fin 2) ![Q, T]) (G.coeff n) := by
    rw [Polynomial.coeff_coe]
    exact Polynomial.coeff_map _ _
  have degree (a : Fin 2 →₀ ℕ) : a.degree = a 0 + a 1 := by
    simp [Finsupp.degree_eq_sum, Fin.sum_univ_two]
  have weight (a : Fin 2 →₀ ℕ) : originalMonomialWeight (Fin 2) ![1, 2] a =
      a 0 + 2 * a 1 := by
    simp [originalMonomialWeight, Fin.sum_univ_two]
  constructor
  · rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply, coefficient]
    apply Ideal.mem_map_of_mem
    rw [weighted_monomial_ideal_membership]
    intro a ha
    have bound := supportBound 0 a ha
    rw [zero_add, degree] at bound
    have excluded : ¬ (a 0 = 2 ∧ a 1 = 0) := by
      intro values
      have index : a.cons 0 = Finsupp.single (1 : Fin 3) 2 := by
        ext i
        induction i using Fin.cases with
        | zero => simp
        | succ j =>
          induction j using Fin.cases with
          | zero => simpa using values.1
          | succ k =>
            fin_cases k
            simpa using values.2
      have nz := MvPolynomial.mem_support_iff.mp ha
      rw [MvPolynomial.finSuccEquiv_coeff_coeff, index, second] at nz
      exact nz rfl
    rw [weight]
    omega
  · rw [coefficient]
    apply Ideal.mem_map_of_mem
    rw [weighted_monomial_ideal_membership]
    intro a ha
    have bound := supportBound 1 a ha
    rw [degree] at bound
    have excluded : ¬ (a 0 = 1 ∧ a 1 = 0) := by
      intro values
      have index : a.cons 1 = Finsupp.single (0 : Fin 3) 1 + Finsupp.single 1 1 := by
        ext i
        induction i using Fin.cases with
        | zero => simp
        | succ j =>
          induction j using Fin.cases with
          | zero => simpa using values.1
          | succ k =>
            fin_cases k
            simpa using values.2
      have nz := MvPolynomial.mem_support_iff.mp ha
      rw [MvPolynomial.finSuccEquiv_coeff_coeff, index, mixed] at nz
      exact nz rfl
    rw [weight]
    omega

end Litt3.Deformations
