import Solutions.CartierAndSpin.CriticalInterpolationWeights

namespace Litt3.CartierAndSpin

open Polynomial

variable {k : Type*} [Field k]

/-- Formal differentiation in the interpolation variable lowers its
weight by that variable's weight. Characteristic cancellations can only
improve the coefficient bounds. -/
theorem laurent_weighted_polynomial_derivative_bound
    (F : (LaurentSeries k)[X]) (a weight : ℤ)
    (hF : ∀ j : ℕ, ((a - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (F.coeff j).orderTop)
    (j : ℕ) :
    ((a - weight - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (F.derivative.coeff j).orderTop := by
  rw [coeff_derivative]
  have h := laurent_natCast_mul_order_bound (j + 1) (F.coeff (j + 1))
    (a - weight * ((j + 1 : ℕ) : ℤ)) (hF (j + 1))
  have hindex : a - weight * ((j + 1 : ℕ) : ℤ) = a - weight - weight * (j : ℤ) := by
    push_cast
    ring
  rw [hindex] at h
  simpa only [Nat.cast_add, Nat.cast_one, mul_comm] using h

/-- The literal characteristic-power factor has exact weighted content
at its actual constant coefficient, with no source-content premise. -/
theorem laurent_power_plus_constant_exact_weight
    (q : LaurentSeries k) (p : ℕ) (c weight : ℤ) (hp : 0 < p)
    (hq : q.orderTop = (c : WithTop ℤ)) (hc : c ≤ (p : ℤ) * weight) :
    (∀ j : ℕ, ((c - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (((X : (LaurentSeries k)[X]) ^ p + C q).coeff j).orderTop) ∧
    (∃ j : ℕ, (((X : (LaurentSeries k)[X]) ^ p + C q).coeff j).orderTop =
      ((c - weight * (j : ℤ) : ℤ) : WithTop ℤ)) := by
  have hp0 : p ≠ 0 := by omega
  constructor
  · intro j
    by_cases hj : j = 0
    · subst j
      simpa [coeff_add, coeff_X_pow, coeff_C, hp0, Ne.symm hp0, hq]
    · by_cases hjp : j = p
      · subst j
        simp only [coeff_add, coeff_X_pow_self, coeff_C, hp0, ↓reduceIte,
          add_zero, HahnSeries.orderTop_one]
        exact WithTop.coe_le_coe.mpr (by nlinarith)
      · simp [coeff_add, coeff_X_pow, coeff_C, hj, hjp]
  · refine ⟨0, ?_⟩
    simp [coeff_add, coeff_X_pow, coeff_C, hp0, Ne.symm hp0, hq]

/-- The exact source derivative factorization supplies the critical
polynomial's weight. No order assumption on the critical coefficients
is needed. -/
theorem critical_derivative_factor_weight
    (F D : (LaurentSeries k)[X]) (q : LaurentSeries k) (p : ℕ)
    (a c weight : ℤ) (hp : 0 < p)
    (hq : q.orderTop = (c : WithTop ℤ)) (hc : c ≤ (p : ℤ) * weight)
    (hF : ∀ j : ℕ, ((a - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (F.coeff j).orderTop)
    (hidentity : F.derivative = ((X : (LaurentSeries k)[X]) ^ p + C q) * D)
    (j : ℕ) :
    ((a - weight - c - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      (D.coeff j).orderTop := by
  obtain ⟨hphi, hexact⟩ := laurent_power_plus_constant_exact_weight q p c weight hp hq hc
  apply laurent_weighted_polynomial_quotient_bound
    ((X : (LaurentSeries k)[X]) ^ p + C q) D c (a - weight - c) weight hphi hexact
  intro i
  rw [← hidentity]
  have h := laurent_weighted_polynomial_derivative_bound F a weight hF i
  have hcancel : c + (a - weight - c) = a - weight := by ring
  simpa only [hcancel] using h

end Litt3.CartierAndSpin
