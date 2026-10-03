import Solutions.CartierAndSpin.DegreeTenQuotientCoefficients
import Solutions.CartierAndSpin.GeneralTwoStepRemainderCoefficients

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The canonical critical quadratic retains the actual high source
coefficients through the moment recurrence. Only the true leading source
coefficient is cancelled; critical coefficients may vanish. -/
theorem general_degree_ten_critical_quadratic (F D U V2 Q : K[X])
    (hFdegree : F.natDegree = 10) (hU : U.natDegree ≤ 5) (hD : D.natDegree ≤ 3)
    (hV : V2.degree < F.degree) (hidentity : U ^ 2 - F * Q = D * V2)
    (rho : K) (mu : ℕ → K) (hrho : F.leadingCoeff * rho = U.coeff 5)
    (hmu0 : F.leadingCoeff * mu 0 = V2.coeff 9)
    (hmu1 : F.leadingCoeff * mu 1 = V2.coeff 8 - mu 0 * F.coeff 9)
    (hmu2 : F.leadingCoeff * mu 2 = V2.coeff 7 -
      mu 0 * F.coeff 8 - mu 1 * F.coeff 9) :
    Q = criticalQuadraticFromMoments F.leadingCoeff D rho mu := by
  have hF : F ≠ 0 := by
    intro hzero
    simp [hzero] at hFdegree
  have hleading : F.leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr hF
  have hVbound : V2.natDegree ≤ 9 := by
    by_cases hzero : V2 = 0
    · simp [hzero]
    · have hlt := natDegree_lt_natDegree hzero hV
      omega
  have hQbound : Q.natDegree ≤ 2 := by
    have h := critical_interpolation_quotient_degree_bound F D U V2 Q
      hF (by omega) hV hidentity
    omega
  obtain ⟨h2, h1, h0⟩ := degree_ten_general_critical_quotient_coefficients F D U V2 Q
    hFdegree hU hD hVbound hQbound hidentity
  have hP8 : V2.coeff 8 = F.leadingCoeff * mu 1 + mu 0 * F.coeff 9 := by
    linear_combination -hmu1
  have hP7 : V2.coeff 7 = F.leadingCoeff * mu 2 +
      mu 0 * F.coeff 8 + mu 1 * F.coeff 9 := by
    linear_combination -hmu2
  have hQ2 : Q.coeff 2 = -D.coeff 3 * mu 0 := by
    apply mul_left_cancel₀ hleading
    rw [h2, ← hmu0]
    ring
  have hQ1 : Q.coeff 1 = -(D.coeff 3 * mu 1 + D.coeff 2 * mu 0) := by
    apply mul_left_cancel₀ hleading
    calc
      F.leadingCoeff * Q.coeff 1 =
          -D.coeff 3 * V2.coeff 8 - D.coeff 2 * V2.coeff 9 -
            F.coeff 9 * Q.coeff 2 := by linear_combination h1
      _ = _ := by rw [hP8, ← hmu0, hQ2]; ring
  have hQ0 : Q.coeff 0 = F.leadingCoeff * rho ^ 2 -
      D.coeff 3 * mu 2 - D.coeff 2 * mu 1 - D.coeff 1 * mu 0 := by
    apply mul_left_cancel₀ hleading
    calc
      F.leadingCoeff * Q.coeff 0 = U.coeff 5 ^ 2 -
          D.coeff 3 * V2.coeff 7 - D.coeff 2 * V2.coeff 8 - D.coeff 1 * V2.coeff 9 -
          F.coeff 9 * Q.coeff 1 - F.coeff 8 * Q.coeff 2 := by linear_combination h0
      _ = _ := by rw [hP7, hP8, ← hmu0, ← hrho, hQ1, hQ2]; ring
  ext j
  by_cases hj : j ≤ 2
  · interval_cases j
    · simpa only [criticalQuadraticFromMoments, coeff_sub, coeff_C_mul,
        coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
        ↓reduceIte, mul_zero, sub_zero] using hQ0
    · simpa only [criticalQuadraticFromMoments, coeff_sub, coeff_C_mul,
        coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
        ↓reduceIte, mul_zero, mul_one, sub_zero, zero_sub] using hQ1
    · simpa only [criticalQuadraticFromMoments, coeff_sub, coeff_C_mul,
        coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
        ↓reduceIte, mul_zero, mul_one, sub_zero, zero_sub, neg_mul] using hQ2
  · have hj0 : j ≠ 0 := by omega
    have hj1 : 1 ≠ j := by omega
    have hj2 : j ≠ 2 := by omega
    rw [coeff_eq_zero_of_natDegree_lt (hQbound.trans_lt (by omega))]
    simp only [criticalQuadraticFromMoments, coeff_sub, coeff_C_mul,
      coeff_X, coeff_X_pow, coeff_C, hj0, hj1, hj2, if_false, mul_zero, sub_zero]

end Litt3.CartierAndSpin
