import Definitions.Deformations.SelectedTruncatedCoefficientPolynomial
import Solutions.Deformations.OriginalQuadraticSeriesOrders
import Solutions.Deformations.TruncatedMonomialQuadraticAugmentation
import Solutions.Deformations.TruncatedMonomialResidue
import Definitions.Deformations.TruncatedMonomialSeries
import Mathlib.RingTheory.PowerSeries.Basic

namespace Litt3.Deformations

variable (K : Type*) [Field K] (d : ℕ)

theorem original_finsupp_selected_degree (a : Fin d →₀ ℕ) (n : ℕ) :
    (a.cons n).degree = n + a.degree := by
  rw [Finsupp.degree_eq_sum, Fin.sum_univ_succ, Finsupp.degree_eq_sum]
  simp only [Finsupp.cons_zero, Finsupp.cons_succ]

/-- Every original coefficient of the regrouped rectangular polynomial
retains the original total-order bound. Truncation cannot create a new
low-degree coefficient, including when lower powers equal one. -/
theorem selected_original_coefficient_support_bound (Q : ℕ) (q : Fin d → ℕ)
    (f : MvPowerSeries (Fin (d + 1)) K) (order : 2 ≤ f.order) (n : ℕ) :
    let P := MvPowerSeries.trunc' K (originalTruncationRectangle (Fin (d + 1)) (Fin.cons Q q)) f
    ∀ a ∈ ((MvPolynomial.finSuccEquiv K d P).coeff n).support, 2 ≤ n + a.degree := by
  classical
  intro P a ha
  have coefficient : P.coeff (a.cons n) ≠ 0 := by
    rw [← MvPolynomial.finSuccEquiv_coeff_coeff]
    exact MvPolynomial.mem_support_iff.mp ha
  change MvPolynomial.coeff (a.cons n)
    (MvPowerSeries.trunc' K (originalTruncationRectangle (Fin (d + 1)) (Fin.cons Q q)) f) ≠ 0 at coefficient
  rw [MvPowerSeries.coeff_trunc'] at coefficient
  split_ifs at coefficient with survives
  · have bound : (2 : ℕ∞) ≤ (a.cons n).degree := order.trans (MvPowerSeries.order_le coefficient)
    have natural : 2 ≤ (a.cons n).degree := ENat.coe_le_coe.mp bound
    rwa [original_finsupp_selected_degree] at natural
  · exact (coefficient rfl).elim

/-- The ORIGINAL multivariate maximal-square hypothesis and nonzero
selected quadratic coefficient derive the entire three-coefficient input
to actual preparation on the original lower-variable quotient. -/
theorem selected_original_quadratic_coefficients (Q : ℕ) (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (quadraticSurvives : 2 < Q)
    (f : MvPowerSeries (Fin (d + 1)) K)
    (quadratic : f ∈ IsLocalRing.maximalIdeal (MvPowerSeries (Fin (d + 1)) K) ^ 2)
    (selected : MvPowerSeries.coeff (Finsupp.single 0 2) f ≠ 0) :
    let P := MvPowerSeries.trunc' K (originalTruncationRectangle (Fin (d + 1)) (Fin.cons Q q)) f
    let g : PowerSeries (TruncatedMonomialAlgebra K (Fin d) q) :=
      selectedTruncatedCoefficientPolynomial K d q P
    PowerSeries.constantCoeff g ∈ truncatedMonomialAugmentationIdeal K (Fin d) q ^ 2 ∧
      PowerSeries.coeff 1 g ∈ truncatedMonomialAugmentationIdeal K (Fin d) q ∧
      PowerSeries.coeff 2 g ∉ truncatedMonomialAugmentationIdeal K (Fin d) q := by
  classical
  intro P g
  let G := MvPolynomial.finSuccEquiv K d P
  let A := TruncatedMonomialAlgebra K (Fin d) q
  have order := original_series_maximal_square_order K (Fin (d + 1)) f quadratic
  have supportBound := selected_original_coefficient_support_bound K d Q q f order
  have coefficient (n : ℕ) : PowerSeries.coeff n g =
      Ideal.Quotient.mk (truncatedMonomialIdeal K (Fin d) q) (G.coeff n) := by
    change PowerSeries.coeff n (selectedTruncatedCoefficientPolynomial K d q P : PowerSeries A) = _
    rw [Polynomial.coeff_coe]
    exact Polynomial.coeff_map _ _
  constructor
  · rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply]
    rw [coefficient]
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
    · rw [← truncated_monomial_residue_kernel K (Fin d) q positive, RingHom.mem_ker, coefficient]
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
      rw [index]
      change MvPolynomial.coeff (Finsupp.single 0 2)
        (MvPowerSeries.trunc' K (originalTruncationRectangle (Fin (d + 1)) (Fin.cons Q q)) f) ≠ 0
      rw [MvPowerSeries.coeff_trunc', if_pos]
      · exact selected
      · have allPositive : ∀ i : Fin (d + 1), 0 < (Fin.cons Q q : Fin (d + 1) → ℕ) i := by
          intro i
          induction i using Fin.cases with
          | zero => exact lt_trans (by decide : 0 < 2) quadraticSurvives
          | succ j => exact positive j
        apply (original_truncation_rectangle_bound (Fin (d + 1)) (Fin.cons Q q) allPositive _).mpr
        intro i
        induction i using Fin.cases with
        | zero => simpa using quadraticSurvives
        | succ j => simpa using positive j

end Litt3.Deformations
