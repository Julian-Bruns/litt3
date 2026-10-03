import Solutions.Deformations.BalancedPreparedBinaryPolynomialLength
import Solutions.Deformations.OriginalBalancedQuadraticBoundary
import Solutions.Deformations.OriginalSeriesRectangularQuadraticCoefficients
import Solutions.Deformations.SeriesTruncatedHypersurfaceEquivalence

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.Deformations

variable (K : Type*) [Field K] [Invertible (2 : K)]
  (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The original diagonal quadratic polynomial clause includes the
actual Frobenius cutoff ONE, rather than excluding its boundary. -/
theorem original_balanced_diagonal_binary_polynomial_finrank (n : ℕ)
    (odd : Odd (p ^ n))
    (P : MvPolynomial (Fin 2) K) (quadratic : ∀ a ∈ P.support, 2 ≤ a.degree)
    (selected : P.coeff (Finsupp.single 0 2) ≠ 0)
    (mixed : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) = 0)
    (lower : P.coeff (Finsupp.single 1 2) ≠ 0) :
    Module.finrank K (MvPolynomial (Fin 2) K ⧸
      (truncatedMonomialIdeal K (Fin 2) (fun _ => p ^ n) ⊔ Ideal.span ({P} : Set _))) =
        2 * p ^ n - 1 := by
  by_cases one : p ^ n = 1
  · exact original_balanced_binary_polynomial_cutoff_eq_one K (p ^ n) one P quadratic
  · have large : 2 < p ^ n := by
      obtain ⟨m, exponent⟩ := odd.exists_bit1
      omega
    exact balanced_prepared_original_binary_polynomial_finrank K p n odd large
      P quadratic selected mixed lower

/-- The WHOLE original arbitrary binary formal hypersurface with a
nonzero diagonal quadratic plane has exact balanced length. The original
equation and both original power generators are preserved. All higher
coefficients are arbitrary; no formal normal-form change is assumed. -/
theorem original_balanced_diagonal_binary_series_finrank (n : ℕ)
    (odd : Odd (p ^ n))
    (f : MvPowerSeries (Fin 2) K)
    (quadratic : f ∈ IsLocalRing.maximalIdeal (MvPowerSeries (Fin 2) K) ^ 2)
    (selected : MvPowerSeries.coeff (Finsupp.single 0 2) f ≠ 0)
    (mixed : MvPowerSeries.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) f = 0)
    (lower : MvPowerSeries.coeff (Finsupp.single 1 2) f ≠ 0) :
    Module.finrank K (MvPowerSeries (Fin 2) K ⧸
      (seriesVariablePowerIdeal K 2 (fun _ => p ^ n) ⊔ Ideal.span ({f} : Set _))) =
        2 * p ^ n - 1 := by
  classical
  have positive : ∀ _i : Fin 2, 0 < p ^ n := fun _ => pow_pos (Fact.out : p.Prime).pos _
  let q := fun _ : Fin 2 => p ^ n
  let P := MvPowerSeries.trunc' K (originalTruncationRectangle (Fin 2) q) f
  have support := original_series_rectangular_quadratic_support K (Fin 2) q f quadratic
  let e := seriesTruncatedHypersurfaceEquiv K 2 q positive f
  rw [e.toLinearEquiv.finrank_eq]
  by_cases one : p ^ n = 1
  · exact original_balanced_binary_polynomial_cutoff_eq_one K (p ^ n) one P support
  · have large : 2 < p ^ n := by
      obtain ⟨m, exponent⟩ := odd.exists_bit1
      omega
    have selectedP : P.coeff (Finsupp.single 0 2) ≠ 0 := by
      rw [original_series_rectangular_coefficient K (Fin 2) q positive f]
      · exact selected
      · intro i
        fin_cases i <;> simp [q] <;> omega
    have mixedP : P.coeff (Finsupp.single 0 1 + Finsupp.single 1 1) = 0 :=
      original_series_rectangular_coefficient_zero K (Fin 2) q f _ mixed
    have lowerP : P.coeff (Finsupp.single 1 2) ≠ 0 := by
      rw [original_series_rectangular_coefficient K (Fin 2) q positive f]
      · exact lower
      · intro i
        fin_cases i <;> simp [q] <;> omega
    exact balanced_prepared_original_binary_polynomial_finrank K p n odd large
      P support selectedP mixedP lowerP

end Litt3.Deformations
