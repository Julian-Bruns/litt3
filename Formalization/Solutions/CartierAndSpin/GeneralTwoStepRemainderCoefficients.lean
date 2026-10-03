import Solutions.CartierAndSpin.ReducedShiftCoefficients

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The genuine two-step top remainder recurrence retains both high
source coefficients. No artificial coefficient gap or separability is
assumed. -/
theorem source_two_step_remainder_top_recurrence (F P : K[X])
    (hF : F ≠ 0) (hdegree : 3 ≤ F.natDegree) (hP : P.degree < F.degree) :
    ((X * P) % F).coeff (F.natDegree - 1) =
      P.coeff (F.natDegree - 2) -
        (P.coeff (F.natDegree - 1) / F.leadingCoeff) * F.coeff (F.natDegree - 1) ∧
    ((X ^ 2 * P) % F).coeff (F.natDegree - 1) =
      P.coeff (F.natDegree - 3) -
        (P.coeff (F.natDegree - 1) / F.leadingCoeff) * F.coeff (F.natDegree - 2) -
        (((X * P) % F).coeff (F.natDegree - 1) / F.leadingCoeff) *
          F.coeff (F.natDegree - 1) := by
  have hpositive : 0 < F.natDegree := by omega
  have hshift (j : ℕ) (hj : 1 ≤ j) :
      ((X * P) % F).coeff j = P.coeff (j - 1) -
        (P.coeff (F.natDegree - 1) / F.leadingCoeff) * F.coeff j := by
    rw [reduced_parameter_shift_coefficient F P hF hpositive hP j, if_pos hj]
  constructor
  · have h := hshift (F.natDegree - 1) (by omega)
    have hindex : F.natDegree - 1 - 1 = F.natDegree - 2 := by omega
    rwa [hindex] at h
  · have hreduction : (X ^ 2 * P) % F = (X * ((X * P) % F)) % F := by
      calc
        (X ^ 2 * P) % F = (X * (X * P)) % F := by rw [pow_two, mul_assoc]
        _ = (X % F) * ((X * P) % F) % F := mul_mod _ _ _
        _ = (X * ((X * P) % F)) % F := by
          rw [mul_mod X ((X * P) % F) F,
            (mod_eq_self_iff hF).mpr (degree_mod_lt (X * P) hF)]
    rw [hreduction, reduced_parameter_shift_coefficient F ((X * P) % F)
      hF hpositive (degree_mod_lt _ hF) (F.natDegree - 1),
      if_pos (show 1 ≤ F.natDegree - 1 by omega)]
    have hindex : F.natDegree - 1 - 1 = F.natDegree - 2 := by omega
    rw [hindex, hshift (F.natDegree - 2) (by omega)]
    congr 2

end Litt3.CartierAndSpin
