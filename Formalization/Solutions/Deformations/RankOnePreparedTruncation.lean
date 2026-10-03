import Solutions.Deformations.PreparedQuadraticCoefficientIdeals
import Solutions.Deformations.PreparedQuadraticTruncation
import Solutions.Deformations.SelectedPolynomialQuadraticCoefficients
import Solutions.Deformations.SelectedTruncatedHypersurfaceQuotients
import Solutions.Deformations.TruncatedWeightedNilpotence

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R] [Fintype I]

/-- The actual weighted ideal decreases as its minimum weight increases. -/
theorem weighted_monomial_ideal_threshold_le (w : I → ℕ) (d e : ℕ) (bound : d ≤ e) :
    weightedMonomialIdeal I R w e ≤ weightedMonomialIdeal I R w d := by
  intro f member
  rw [weighted_monomial_ideal_membership] at member ⊢
  intro a ha
  exact bound.trans (member a ha)

theorem truncated_weighted_ideal_threshold_le (q w : I → ℕ) (d e : ℕ) (bound : d ≤ e) :
    truncatedWeightedIdeal R I q w e ≤ truncatedWeightedIdeal R I q w d :=
  Ideal.map_mono (weighted_monomial_ideal_threshold_le R I w d e bound)

/-- Squaring the weight-two first-coefficient ideal puts it in the
weight-three remainder ideal, before and after literal truncation. -/
theorem truncated_weight_two_square_le_three (q w : I → ℕ) :
    truncatedWeightedIdeal R I q w 2 ^ 2 ≤ truncatedWeightedIdeal R I q w 3 := by
  rw [truncatedWeightedIdeal, ← Ideal.map_pow]
  apply Ideal.map_mono
  exact (weighted_monomial_ideal_pow_le I R w 2 2).trans
    (weighted_monomial_ideal_threshold_le R I w 3 4 (by omega))

variable (K : Type*) [Field K] [Invertible (2 : K)]
  (p : ℕ) [Fact p.Prime] [CharP K p]

/-- Original selected coefficient ideals, genuine preparation and the
weighted inequality give the full rank-one length. The series and both
original lower powers are retained; no split equation is assumed. -/
theorem rank_one_prepared_series_truncation_finrank (n T : ℕ) (positiveT : 0 < T)
    (odd : Odd (p ^ n)) (bound : 4 * T < p ^ n + 3)
    (g : PowerSeries (TruncatedMonomialAlgebra K (Fin 2) ![p ^ n, T]))
    (constant : PowerSeries.constantCoeff g ∈
      truncatedWeightedIdeal K (Fin 2) ![p ^ n, T] ![1, 2] 3)
    (linear : PowerSeries.coeff 1 g ∈
      truncatedWeightedIdeal K (Fin 2) ![p ^ n, T] ![1, 2] 2)
    (constantAug : PowerSeries.constantCoeff g ∈
      truncatedMonomialAugmentationIdeal K (Fin 2) ![p ^ n, T] ^ 2)
    (linearAug : PowerSeries.coeff 1 g ∈
      truncatedMonomialAugmentationIdeal K (Fin 2) ![p ^ n, T])
    (quadratic : PowerSeries.coeff 2 g ∉
      truncatedMonomialAugmentationIdeal K (Fin 2) ![p ^ n, T]) :
    Module.finrank K ((PowerSeries (TruncatedMonomialAlgebra K (Fin 2) ![p ^ n, T])) ⧸
      Ideal.span ({g, PowerSeries.X ^ (p ^ n)} : Set _)) = 2 * p ^ n * T := by
  have prime : p.Prime := Fact.out
  have positive : ∀ i : Fin 2, 0 < (![p ^ n, T] : Fin 2 → ℕ) i := by
    intro i
    fin_cases i
    · exact pow_pos prime.pos n
    · exact positiveT
  let A := TruncatedMonomialAlgebra K (Fin 2) ![p ^ n, T]
  letI := truncatedMonomialLocalRing K 2 ![p ^ n, T] positive
  letI : Invertible (2 : A) :=
    (Invertible.map (algebraMap K A) (2 : K)).copy _ (map_ofNat _ _).symm
  letI : CharP A p :=
    charP_of_injective_algebraMap
      (truncated_monomial_coefficient_injective K (Fin 2) ![p ^ n, T] positive) p
  letI := truncated_monomial_maximal_is_adic_complete K (Fin 2) ![p ^ n, T] positive
  have constantMaximal : PowerSeries.constantCoeff g ∈ IsLocalRing.maximalIdeal A := by
    rw [← truncated_monomial_augmentation_eq_maximal K (Fin 2) ![p ^ n, T] positive]
    exact Ideal.pow_le_self (by omega) constantAug
  have linearMaximal : PowerSeries.coeff 1 g ∈ IsLocalRing.maximalIdeal A := by
    rwa [← truncated_monomial_augmentation_eq_maximal K (Fin 2) ![p ^ n, T] positive]
  have quadraticMaximal : PowerSeries.coeff 2 g ∉ IsLocalRing.maximalIdeal A := by
    rwa [← truncated_monomial_augmentation_eq_maximal K (Fin 2) ![p ^ n, T] positive]
  have order := original_quadratic_series_residue_order g constantMaximal linearMaximal quadraticMaximal
  have nonzero : g.map (IsLocalRing.residue A) ≠ 0 := by
    intro zero
    rw [zero, PowerSeries.order_zero] at order
    exact ENat.top_ne_coe 2 order
  obtain ⟨m, exponent⟩ := odd.exists_bit1
  have cutoff : ∀ c ∈ truncatedWeightedIdeal K (Fin 2) ![p ^ n, T] ![1, 2] 3,
      c ^ m = 0 := by
    intro c member
    apply truncated_weighted_element_pow_eq_zero K (Fin 2) ![p ^ n, T] ![1, 2] 3 m
    · simp only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, one_mul]
      omega
    · exact member
  have relations := prepared_series_coefficient_ideals_frobenius_redundant p
    (truncatedWeightedIdeal K (Fin 2) ![p ^ n, T] ![1, 2] 3)
    (truncatedWeightedIdeal K (Fin 2) ![p ^ n, T] ![1, 2] 2)
    (truncated_weighted_ideal_threshold_le K (Fin 2) _ _ 2 3 (by omega))
    (truncated_weight_two_square_le_three K (Fin 2) _ _) n m exponent cutoff
    g nonzero order constant linear
  let equivalence := Ideal.quotientEquivAlgOfEq K relations
  rw [equivalence.toLinearEquiv.finrank_eq,
    truncated_coefficient_series_hypersurface_finrank K (Fin 2) ![p ^ n, T] positive g nonzero,
    order, ENat.toNat_ofNat, Fin.prod_univ_two]
  simp [mul_assoc]

/-- The whole ORIGINAL polynomial rank-one clause after only an
invertible linear plane diagonalization. Arbitrary higher terms are
allowed, and all three original power relations remain literal. -/
theorem original_selected_rank_one_polynomial_truncation_finrank
    (n T : ℕ) (positiveT : 0 < T) (odd : Odd (p ^ n)) (bound : 4 * T < p ^ n + 3)
    (P : MvPolynomial (Fin 3) K) (quadratic : ∀ a ∈ P.support, 2 ≤ a.degree)
    (selected : P.coeff (Finsupp.single 0 2) ≠ 0)
    (mixed : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) = 0)
    (second : P.coeff (Finsupp.single 1 2) = 0) :
    Module.finrank K (MvPolynomial (Fin 3) K ⧸
      (truncatedMonomialIdeal K (Fin 3) (Fin.cons (p ^ n) ![p ^ n, T]) ⊔
        Ideal.span ({P} : Set _))) = 2 * p ^ n * T := by
  have prime : p.Prime := Fact.out
  have positive : ∀ i : Fin 2, 0 < (![p ^ n, T] : Fin 2 → ℕ) i := by
    intro i
    fin_cases i
    · exact pow_pos prime.pos n
    · exact positiveT
  have coefficients := selected_polynomial_quadratic_coefficients K 2 ![p ^ n, T]
    positive P quadratic selected
  have weighted := selected_polynomial_rank_one_weighted_coefficients K (p ^ n) T
    P quadratic mixed second
  have length := rank_one_prepared_series_truncation_finrank K p n T positiveT odd bound
    (selectedTruncatedCoefficientPolynomial K 2 ![p ^ n, T] P)
    weighted.1 weighted.2 coefficients.1 coefficients.2.1 coefficients.2.2
  let equivalence := selectedTruncatedPolynomialHypersurfaceEquiv K 2 (p ^ n) ![p ^ n, T] P
  rw [equivalence.toLinearEquiv.finrank_eq, Ideal.span_pair_comm]
  exact length

end Litt3.Deformations
