import Solutions.Deformations.PreparedQuadraticFrobenius
import Solutions.Deformations.TruncatedCoefficientWeierstrass
import Solutions.Deformations.TruncatedMonomialFrobenius
import Mathlib.Algebra.Ring.Parity

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

/-- The quadratic residue order is derived from the actual original
coefficients. The constant and linear coefficients lie in the true
maximal ideal and the quadratic coefficient has nonzero residue. -/
theorem original_quadratic_series_residue_order {A : Type*} [CommRing A] [IsLocalRing A]
    (g : PowerSeries A) (constant : PowerSeries.constantCoeff g ∈ IsLocalRing.maximalIdeal A)
    (linear : PowerSeries.coeff 1 g ∈ IsLocalRing.maximalIdeal A)
    (quadratic : PowerSeries.coeff 2 g ∉ IsLocalRing.maximalIdeal A) :
    (g.map (IsLocalRing.residue A)).order = 2 := by
  apply (PowerSeries.order_eq_nat (n := 2)).mpr
  constructor
  · rw [PowerSeries.coeff_map]
    exact (IsLocalRing.residue_eq_zero_iff _).not.mpr quadratic
  · intro i hi
    have cases : i = 0 ∨ i = 1 := by omega
    rcases cases with rfl | rfl
    · rw [PowerSeries.coeff_map]
      apply (IsLocalRing.residue_eq_zero_iff _).mpr
      simpa only [PowerSeries.coeff_zero_eq_constantCoeff] using constant
    · rw [PowerSeries.coeff_map]
      exact (IsLocalRing.residue_eq_zero_iff _).mpr linear

variable (K I : Type*) [Field K] [Fintype I]
  (p : ℕ) [Fact p.Prime] [CharP K p]

/-- An arbitrary ORIGINAL one-variable series over the actual truncated
coefficient algebra has the source's exact quadratic length, after adding
the original Frobenius power. Actual Weierstrass preparation derives both
rank and redundancy; no split equation or coordinate change is an input. -/
theorem prepared_quadratic_truncation_finrank (q : I → ℕ) (positive : ∀ i, 0 < q i)
    [IsLocalRing (TruncatedMonomialAlgebra K I q)]
    [Invertible (2 : TruncatedMonomialAlgebra K I q)]
    (n : ℕ) (odd : Odd (p ^ n))
    (degreeBound : (∑ i, (q i - 1)) < p ^ n - 1)
    (g : PowerSeries (TruncatedMonomialAlgebra K I q))
    (nonzero : g.map (IsLocalRing.residue (TruncatedMonomialAlgebra K I q)) ≠ 0)
    (order : (g.map (IsLocalRing.residue (TruncatedMonomialAlgebra K I q))).order = 2)
    (constant : PowerSeries.constantCoeff g ∈ truncatedMonomialAugmentationIdeal K I q ^ 2) :
    Module.finrank K ((PowerSeries (TruncatedMonomialAlgebra K I q)) ⧸
      Ideal.span ({g, PowerSeries.X ^ (p ^ n)} :
        Set (PowerSeries (TruncatedMonomialAlgebra K I q)))) = 2 * ∏ i, q i := by
  let A := TruncatedMonomialAlgebra K I q
  letI : CharP A p :=
    charP_of_injective_algebraMap (truncated_monomial_coefficient_injective K I q positive) p
  letI := truncated_monomial_maximal_is_adic_complete K I q positive
  obtain ⟨m, exponent⟩ := odd.exists_bit1
  have cutoff : IsLocalRing.maximalIdeal A ^ (2 * m) = ⊥ := by
    rw [← truncated_monomial_augmentation_eq_maximal K I q positive]
    apply le_bot_iff.mp
    have base := truncated_monomial_augmentation_cutoff K I q positive
    have bound : (∑ i, (q i - 1)) + 1 ≤ 2 * m := by omega
    exact base ▸ Ideal.pow_le_pow_right bound
  have quadraticConstant : PowerSeries.constantCoeff g ∈ IsLocalRing.maximalIdeal A ^ 2 := by
    rwa [← truncated_monomial_augmentation_eq_maximal K I q positive]
  have relations := prepared_series_quadratic_frobenius_redundant p n m exponent cutoff
    g nonzero order quadraticConstant
  let equivalence := Ideal.quotientEquivAlgOfEq K relations
  rw [equivalence.toLinearEquiv.finrank_eq,
    truncated_coefficient_series_hypersurface_finrank K I q positive g nonzero,
    order, ENat.toNat_ofNat]

/-- A coefficient-only version of the exact arbitrary-series length:
the residue order and its nonzero series are derived, rather than inputs.
All three conditions refer to unchanged coefficients in the original
truncated algebra and its literal augmentation ideal. -/
theorem prepared_quadratic_truncation_finrank_of_original_coefficients
    (q : I → ℕ) (positive : ∀ i, 0 < q i)
    [IsLocalRing (TruncatedMonomialAlgebra K I q)]
    [Invertible (2 : TruncatedMonomialAlgebra K I q)]
    (n : ℕ) (odd : Odd (p ^ n))
    (degreeBound : (∑ i, (q i - 1)) < p ^ n - 1)
    (g : PowerSeries (TruncatedMonomialAlgebra K I q))
    (constant : PowerSeries.constantCoeff g ∈ truncatedMonomialAugmentationIdeal K I q ^ 2)
    (linear : PowerSeries.coeff 1 g ∈ truncatedMonomialAugmentationIdeal K I q)
    (quadratic : PowerSeries.coeff 2 g ∉ truncatedMonomialAugmentationIdeal K I q) :
    Module.finrank K ((PowerSeries (TruncatedMonomialAlgebra K I q)) ⧸
      Ideal.span ({g, PowerSeries.X ^ (p ^ n)} :
        Set (PowerSeries (TruncatedMonomialAlgebra K I q)))) = 2 * ∏ i, q i := by
  let A := TruncatedMonomialAlgebra K I q
  have constantMaximal : PowerSeries.constantCoeff g ∈ IsLocalRing.maximalIdeal A := by
    rw [← truncated_monomial_augmentation_eq_maximal K I q positive]
    exact Ideal.pow_le_self (by omega) constant
  have linearMaximal : PowerSeries.coeff 1 g ∈ IsLocalRing.maximalIdeal A := by
    rwa [← truncated_monomial_augmentation_eq_maximal K I q positive]
  have quadraticMaximal : PowerSeries.coeff 2 g ∉ IsLocalRing.maximalIdeal A := by
    rwa [← truncated_monomial_augmentation_eq_maximal K I q positive]
  have order := original_quadratic_series_residue_order g constantMaximal linearMaximal quadraticMaximal
  have nonzero : g.map (IsLocalRing.residue A) ≠ 0 := by
    intro zero
    rw [zero, PowerSeries.order_zero] at order
    exact ENat.top_ne_coe 2 order
  exact prepared_quadratic_truncation_finrank K I p q positive n odd degreeBound
    g nonzero order constant

/-- For the literal original finite-coordinate coefficient algebra,
locality, completeness and invertibility of two are constructed from the
field and original positive powers. Only original series coefficients and
the source's degree inequality remain as hypotheses. -/
theorem finite_coordinate_prepared_quadratic_truncation_finrank
    [Invertible (2 : K)] (d : ℕ) (q : Fin d → ℕ) (positive : ∀ i, 0 < q i)
    (n : ℕ) (odd : Odd (p ^ n))
    (degreeBound : (∑ i, (q i - 1)) < p ^ n - 1) :
    letI := truncatedMonomialLocalRing K d q positive
    ∀ (g : PowerSeries (TruncatedMonomialAlgebra K (Fin d) q)),
      g.map (IsLocalRing.residue (TruncatedMonomialAlgebra K (Fin d) q)) ≠ 0 →
      (g.map (IsLocalRing.residue (TruncatedMonomialAlgebra K (Fin d) q))).order = 2 →
      PowerSeries.constantCoeff g ∈ truncatedMonomialAugmentationIdeal K (Fin d) q ^ 2 →
      Module.finrank K ((PowerSeries (TruncatedMonomialAlgebra K (Fin d) q)) ⧸
        Ideal.span ({g, PowerSeries.X ^ (p ^ n)} :
          Set (PowerSeries (TruncatedMonomialAlgebra K (Fin d) q)))) = 2 * ∏ i, q i := by
  letI := truncatedMonomialLocalRing K d q positive
  let A := TruncatedMonomialAlgebra K (Fin d) q
  letI : Invertible (2 : A) :=
    (Invertible.map (algebraMap K A) (2 : K)).copy _ (map_ofNat _ _).symm
  intro g nonzero order constant
  exact prepared_quadratic_truncation_finrank K (Fin d) p q positive n odd degreeBound
    g nonzero order constant

/-- The literal finite-coordinate original coefficient conditions alone
give the exact original truncated length; all required local structures
and the residue-order conclusion are constructed. -/
theorem finite_coordinate_prepared_quadratic_truncation_finrank_of_original_coefficients
    [Invertible (2 : K)] (d : ℕ) (q : Fin d → ℕ) (positive : ∀ i, 0 < q i)
    (n : ℕ) (odd : Odd (p ^ n))
    (degreeBound : (∑ i, (q i - 1)) < p ^ n - 1)
    (g : PowerSeries (TruncatedMonomialAlgebra K (Fin d) q))
    (constant : PowerSeries.constantCoeff g ∈ truncatedMonomialAugmentationIdeal K (Fin d) q ^ 2)
    (linear : PowerSeries.coeff 1 g ∈ truncatedMonomialAugmentationIdeal K (Fin d) q)
    (quadratic : PowerSeries.coeff 2 g ∉ truncatedMonomialAugmentationIdeal K (Fin d) q) :
    Module.finrank K ((PowerSeries (TruncatedMonomialAlgebra K (Fin d) q)) ⧸
      Ideal.span ({g, PowerSeries.X ^ (p ^ n)} :
        Set (PowerSeries (TruncatedMonomialAlgebra K (Fin d) q)))) = 2 * ∏ i, q i := by
  letI := truncatedMonomialLocalRing K d q positive
  let A := TruncatedMonomialAlgebra K (Fin d) q
  letI : Invertible (2 : A) :=
    (Invertible.map (algebraMap K A) (2 : K)).copy _ (map_ofNat _ _).symm
  exact prepared_quadratic_truncation_finrank_of_original_coefficients K (Fin d) p q positive
    n odd degreeBound g constant linear quadratic

end Litt3.Deformations
