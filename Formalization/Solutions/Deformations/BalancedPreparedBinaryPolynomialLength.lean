import Solutions.Deformations.BalancedPreparedOriginalCoefficients
import Solutions.Deformations.BalancedPreparedSquareCompletion
import Solutions.Deformations.BalancedPreparedSeriesRelations
import Solutions.Deformations.SelectedTruncatedHypersurfaceQuotients
import Solutions.Deformations.PreparedQuadraticTruncation

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.Deformations

variable (K : Type*) [Field K] [Invertible (2 : K)]
  (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The whole ORIGINAL arbitrary diagonal-quadratic polynomial has the
balanced length, retaining both literal equal Frobenius-power relations.
Every higher coefficient is unrestricted and all preparation inputs are
derived from the ORIGINAL three quadratic coefficients. -/
theorem balanced_prepared_original_binary_polynomial_finrank (n : ℕ)
    (odd : Odd (p ^ n)) (large : 2 < p ^ n)
    (P : MvPolynomial (Fin 2) K) (quadratic : ∀ a ∈ P.support, 2 ≤ a.degree)
    (selected : P.coeff (Finsupp.single 0 2) ≠ 0)
    (mixed : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) = 0)
    (lower : P.coeff (Finsupp.single 1 2) ≠ 0) :
    Module.finrank K (MvPolynomial (Fin 2) K ⧸
      (truncatedMonomialIdeal K (Fin 2) (fun _ => p ^ n) ⊔ Ideal.span ({P} : Set _))) =
        2 * p ^ n - 1 := by
  classical
  let Q := p ^ n
  let q := fun _ : Fin 1 => Q
  have positive : ∀ i, 0 < q i := fun _ => Nat.lt_trans (by decide : 0 < 2) large
  let A := TruncatedMonomialAlgebra K (Fin 1) q
  letI := truncatedMonomialLocalRing K 1 q positive
  letI : Nontrivial A := truncated_monomial_nontrivial K (Fin 1) q positive
  letI : Module.Finite K A := Module.Finite.of_basis (truncatedMonomialTupleBasis K (Fin 1) q)
  letI : CharP A p := charP_of_injective_algebraMap
    (truncated_monomial_coefficient_injective K (Fin 1) q positive) p
  letI : Invertible (2 : A) :=
    (Invertible.map (algebraMap K A) (2 : K)).copy _ (map_ofNat _ _).symm
  letI := truncated_monomial_maximal_is_adic_complete K (Fin 1) q positive
  let y := truncatedMonomialParameter K (Fin 1) q 0
  let J := truncatedMonomialAugmentationIdeal K (Fin 1) q
  let g : PowerSeries A := selectedTruncatedCoefficientPolynomial K 1 q P
  let G := MvPolynomial.finSuccEquiv K 1 P
  have coefficient0 : PowerSeries.constantCoeff g =
      Ideal.Quotient.mk (truncatedMonomialIdeal K (Fin 1) q) (G.coeff 0) := by
    rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply]
    change PowerSeries.coeff 0 (selectedTruncatedCoefficientPolynomial K 1 q P : PowerSeries A) = _
    rw [Polynomial.coeff_coe]
    exact Polynomial.coeff_map _ _
  have coefficients := selected_polynomial_quadratic_coefficients K 1 q positive P quadratic selected
  have linear : PowerSeries.coeff 1 g ∈ J ^ 2 :=
    balanced_prepared_original_linear_quadratic K Q P quadratic mixed
  have constant : PowerSeries.constantCoeff g ∈ J ^ 2 := coefficients.1
  have quadraticCoefficient : PowerSeries.coeff 2 g ∉ IsLocalRing.maximalIdeal A := by
    rw [← truncated_monomial_augmentation_eq_maximal K (Fin 1) q positive]
    exact coefficients.2.2
  have residueOrder := original_quadratic_series_residue_order g
    (by rw [← truncated_monomial_augmentation_eq_maximal K (Fin 1) q positive]
        exact Ideal.pow_le_self (by omega) constant)
    (by rw [← truncated_monomial_augmentation_eq_maximal K (Fin 1) q positive]
        exact Ideal.pow_le_self (by omega) linear) quadraticCoefficient
  have nonzero : g.map (IsLocalRing.residue A) ≠ 0 := by
    intro hz
    rw [hz, PowerSeries.order_zero] at residueOrder
    exact ENat.top_ne_coe 2 residueOrder
  have originalConstant : (G.coeff 0).coeff (Finsupp.single 0 2) ≠ 0 := by
    rw [balanced_prepared_original_lower_quadratic_coefficient K P]
    exact lower
  obtain ⟨u, hu⟩ := balanced_prepared_quadratic_unit_factor K Q large (G.coeff 0)
    (coefficient0 ▸ constant) originalConstant
  have gFactor : PowerSeries.constantCoeff g = y ^ 2 * (u : A) := coefficient0.trans hu
  obtain ⟨f, h, factorization⟩ := g.exists_isWeierstrassFactorization nonzero
  have degree : f.natDegree = 2 := by
    simpa only [residueOrder, ENat.toNat_ofNat] using factorization.natDegree_eq_toNat_order_map
  have preparedLinear : f.coeff 1 ∈ J ^ 2 := prepared_polynomial_linear_mem
    (J ^ 2) (J ^ 2) le_rfl g f h factorization.isUnit factorization.eq_mul constant linear
  obtain ⟨v, hv⟩ := balanced_prepared_constant_unit_factor K Q g f h
    factorization.isUnit factorization.eq_mul u gFactor
  let t := ⅟(2 : A) * f.coeff 1
  have half : f.coeff 1 = 2 * t := by
    dsimp only [t]
    rw [← mul_assoc, mul_invOf_self, one_mul]
  have tMember : t ∈ J ^ 2 := (J ^ 2).mul_mem_left _ preparedLinear
  have nilpotent : t ^ (p ^ n) = 0 := truncated_monomial_augmentation_frobenius
    K (Fin 1) p q positive n (fun _ => le_rfl) t (Ideal.pow_le_self (by omega) tMember)
  obtain ⟨w, hw⟩ := balanced_prepared_square_completed_unit_factor K Q (positive 0) t tMember v
  have remainder : f.coeff 0 - t ^ 2 = y ^ 2 * (w : A) := by rwa [← hv] at hw
  obtain ⟨m, exponent⟩ := odd.exists_bit1
  have socle := balanced_prepared_monomial_top_socle K Q m exponent w
  have length := balanced_prepared_split_polynomial_finrank (K := K)
    (y ^ 2 * (w : A)) m socle.1 socle.2.1 socle.2.2
  have eTranslation := balancedPreparedQuadraticTranslationEquiv (K := K) p n f
    factorization.isDistinguishedAt.monic degree t half nilpotent
  have ePreparation := balancedPreparedWeierstrassRelationEquiv (K := K)
    (IsLocalRing.maximalIdeal A) g f h factorization (p ^ n)
  have eOriginal := selectedTruncatedPolynomialHypersurfaceEquiv K 1 Q q P
  have cutoff : Fin.cons Q q = (fun _ : Fin 2 => p ^ n) := by
    ext i
    induction i using Fin.cases with
    | zero => rfl
    | succ j => rfl
  rw [← cutoff, eOriginal.toLinearEquiv.finrank_eq, Ideal.span_pair_comm,
    ← ePreparation.toLinearEquiv.finrank_eq, eTranslation.toLinearEquiv.finrank_eq,
    remainder, exponent]
  rw [truncated_monomial_finrank K (Fin 1) q] at length
  simpa only [Fin.prod_univ_one, q, Q, exponent] using length

end Litt3.Deformations
