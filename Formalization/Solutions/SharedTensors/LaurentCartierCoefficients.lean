import Solutions.SharedTensors.LaurentFrobeniusCoefficients
import Solutions.SharedTensors.RationalCartierFormula

namespace Litt3.SharedTensors

open scoped LaurentSeries BigOperators
open Litt3.CartierAndSpin

variable {k : Type*} [Field k] [PerfectField k]
  {p : ℕ} [Fact p.Prime] [CharP k p]

theorem fin_residue_difference_not_divisible (i j : Fin p) (hij : j ≠ i) :
    ¬ (p : ℤ) ∣ (i.val : ℤ) - (j.val : ℤ) := by
  intro hd
  have hi : (i.val : ℤ) < (p : ℤ) := by exact_mod_cast i.isLt
  have hj : (j.val : ℤ) < (p : ℤ) := by exact_mod_cast j.isLt
  by_cases hle : j.val ≤ i.val
  · have he := Int.eq_zero_of_dvd_of_nonneg_of_lt
      (m := (i.val : ℤ) - (j.val : ℤ)) (n := (p : ℤ))
      (by omega) (by omega) hd
    apply hij
    apply Fin.ext
    omega
  · have he := Int.eq_zero_of_dvd_of_nonneg_of_lt
      (m := (j.val : ℤ) - (i.val : ℤ)) (n := (p : ℤ))
      (by omega) (by omega) (by simpa only [neg_sub] using Int.dvd_neg.mpr hd)
    apply hij
    apply Fin.ext
    omega

/-- Literal full Laurent p-basis digits agree with the actual Laurent
coefficients in their residue classes, including all negative exponents. -/
theorem laurent_p_basis_digit_coeff
    (b : PowerPBasis (LaurentSeries k) p) (hb : b.parameter = laurentParameter k)
    (f : LaurentSeries k) (i : Fin p) (n : ℤ) :
    ((pRootCoefficient (LaurentSeries k) p b f i).coeff n) ^ p =
      f.coeff ((p : ℤ) * n + i.val) := by
  have hterm (j : Fin p) :
      (pRootCoefficient (LaurentSeries k) p b f j ^ p * b.parameter ^ j.val).coeff
        ((p : ℤ) * n + i.val) =
        if j = i then ((pRootCoefficient (LaurentSeries k) p b f i).coeff n) ^ p else 0 := by
    rw [hb, laurentParameter, HahnSeries.single_pow]
    simp only [one_pow, nsmul_eq_mul, Int.mul_one]
    rw [mul_comm, laurent_single_mul_coefficient, one_mul]
    by_cases hji : j = i
    · subst j
      rw [if_pos rfl]
      have he : (p : ℤ) * n + (i.val : ℤ) - i.val = (p : ℤ) * n := by ring
      rw [he, laurent_frobenius_coeff_multiple]
    · rw [if_neg hji]
      apply laurent_frobenius_coeff_nonmultiple
      intro hd
      apply fin_residue_difference_not_divisible i j hji
      have hm : (p : ℤ) ∣ (p : ℤ) * n := dvd_mul_right _ _
      have hsub := dvd_sub hd hm
      convert hsub using 1 <;> ring
  calc
    _ = (∑ j : Fin p,
      pRootCoefficient (LaurentSeries k) p b f j ^ p * b.parameter ^ j.val).coeff
        ((p : ℤ) * n + i.val) := by
      rw [HahnSeries.coeff_sum]
      simp_rw [hterm]
      simp
    _ = _ := congrArg (fun x : LaurentSeries k => x.coeff ((p : ℤ) * n + i.val))
      (p_basis_actual_expansion b f)

/-- Intrinsic Cartier's Laurent coordinate is the unique p-th root of
the coefficient at pn+p−1, on the entire Laurent field. -/
theorem laurent_rational_cartier_coefficient
    (b : PowerPBasis (LaurentSeries k) p) (hb : b.parameter = laurentParameter k)
    (f : LaurentSeries k) (n : ℤ) :
    (rationalCartierCoefficient (LaurentSeries k) p b f).coeff n =
      (frobeniusEquiv k p).symm (f.coeff ((p : ℤ) * n + (p - 1 : ℕ))) := by
  apply (frobeniusEquiv k p).injective
  rw [RingEquiv.apply_symm_apply, frobeniusEquiv_def]
  exact laurent_p_basis_digit_coeff b hb f
    ⟨p - 1, Nat.sub_lt (Fact.out : p.Prime).pos (by decide)⟩ n

end Litt3.SharedTensors
