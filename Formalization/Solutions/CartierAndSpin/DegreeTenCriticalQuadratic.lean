import Solutions.CartierAndSpin.DegreeTenQuotientCoefficients
import Solutions.CartierAndSpin.TwoStepRemainderCoefficients
import Solutions.CartierAndSpin.QuadraticInterpolationTrace

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The canonical degree-ten quadratic follows from the exact source
identity, retaining zero leading critical coefficients and degree drops. -/
theorem degree_ten_exact_critical_quadratic (F D U V2 Q : K[X])
    (hFdegree : F.natDegree = 10) (hF9 : F.coeff 9 = 0) (hF8 : F.coeff 8 = 0)
    (hU : U.natDegree ≤ 5) (hD : D.natDegree ≤ 3)
    (hV : V2.degree < F.degree) (hidentity : U ^ 2 - F * Q = D * V2) :
    Q = criticalQuadraticFromMoments F.leadingCoeff D
      (U.coeff 5 / F.leadingCoeff) (fun j => V2.coeff (9 - j) / F.leadingCoeff) := by
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
  obtain ⟨h2, h1, h0⟩ := degree_ten_critical_quotient_coefficients F D U V2 Q
    hFdegree hF9 hF8 hU hD hVbound hQbound hidentity
  ext j
  by_cases hj : j ≤ 2
  · interval_cases j
    · simp only [criticalQuadraticFromMoments, coeff_sub, coeff_C_mul,
        coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
        ↓reduceIte, mul_zero, sub_zero, Nat.reduceSub]
      apply mul_left_cancel₀ hleading
      rw [h0]
      field_simp [hleading]
    · simp only [criticalQuadraticFromMoments, coeff_sub, coeff_C_mul,
        coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
        ↓reduceIte, mul_zero, mul_one, zero_sub, sub_zero, Nat.reduceSub]
      apply mul_left_cancel₀ hleading
      rw [h1]
      field_simp [hleading]
      ring
    · simp only [criticalQuadraticFromMoments, coeff_sub, coeff_C_mul,
        coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
        ↓reduceIte, mul_zero, mul_one, zero_sub, sub_zero, Nat.reduceSub]
      apply mul_left_cancel₀ hleading
      rw [h2]
      field_simp [hleading]
  · have hj0 : j ≠ 0 := by omega
    have hj1 : j ≠ 1 := by omega
    have hj2 : j ≠ 2 := by omega
    rw [coeff_eq_zero_of_natDegree_lt (hQbound.trans_lt (by omega))]
    simp only [criticalQuadraticFromMoments, coeff_sub, coeff_C_mul,
      coeff_X, coeff_X_pow, coeff_C, hj0, Ne.symm hj1, hj2,
      if_false, mul_zero, sub_zero, zero_sub]

end Litt3.CartierAndSpin
