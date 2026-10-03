import Solutions.CartierAndSpin.ReducedShiftCoefficients

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- Two leading coefficient gaps make the first three shifted top
coefficients literal coefficients of the original reduced numerator.
This holds for every source degree at least three, without separability. -/
theorem source_two_gap_remainder_top_coefficients (F P : K[X])
    (hF : F ≠ 0) (hdegree : 3 ≤ F.natDegree) (hP : P.degree < F.degree)
    (hgap1 : F.coeff (F.natDegree - 1) = 0)
    (hgap2 : F.coeff (F.natDegree - 2) = 0) :
    ∀ j : ℕ, j ≤ 2 →
      ((X ^ j * P) % F).coeff (F.natDegree - 1) =
        P.coeff (F.natDegree - 1 - j) := by
  have hpositive : 0 < F.natDegree := by omega
  have hshift (j : ℕ) (hj : 1 ≤ j) :
      ((X * P) % F).coeff j = P.coeff (j - 1) -
        (P.coeff (F.natDegree - 1) / F.leadingCoeff) * F.coeff j := by
    rw [reduced_parameter_shift_coefficient F P hF hpositive hP j, if_pos hj]
  intro j hj
  interval_cases j
  · simp only [pow_zero, one_mul, Nat.sub_zero,
      (mod_eq_self_iff hF).mpr hP]
  · simpa only [pow_one, hgap1, mul_zero, sub_zero] using
      hshift (F.natDegree - 1) (by omega)
  · have hreduction : (X ^ 2 * P) % F = (X * ((X * P) % F)) % F := by
      calc
        (X ^ 2 * P) % F = (X * (X * P)) % F := by rw [pow_two, mul_assoc]
        _ = (X % F) * ((X * P) % F) % F := mul_mod _ _ _
        _ = (X * ((X * P) % F)) % F := by
          rw [mul_mod X ((X * P) % F) F,
            (mod_eq_self_iff hF).mpr (degree_mod_lt (X * P) hF)]
    rw [hreduction, reduced_parameter_shift_coefficient F ((X * P) % F)
      hF hpositive (degree_mod_lt _ hF) (F.natDegree - 1),
      if_pos (show 1 ≤ F.natDegree - 1 by omega), hgap1, mul_zero, sub_zero]
    have hindex : F.natDegree - 1 - 1 = F.natDegree - 2 := by omega
    rw [hindex, hshift (F.natDegree - 2) (by omega), hgap2, mul_zero, sub_zero]
    congr 1

end Litt3.CartierAndSpin
