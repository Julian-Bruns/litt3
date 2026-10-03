import Solutions.SharedTensors.PowerSeriesFrobeniusCoefficients
import Mathlib.FieldTheory.Perfect
import Mathlib.Tactic

namespace Litt3.SharedTensors

open scoped BigOperators

variable {k : Type*} [Field k] [PerfectField k]
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- The entire power series formed by taking the unique p-th roots of
the coefficients in one residue class. -/
noncomputable def powerSeriesPBasisDigit (f : PowerSeries k) (i : Fin p) :
    PowerSeries k :=
  PowerSeries.mk fun n =>
    (frobeniusEquiv k p).symm (PowerSeries.coeff (p * n + i.val) f)

theorem powerSeriesPBasisDigit_term_coeff (f : PowerSeries k) (i : Fin p) (n : ℕ) :
    PowerSeries.coeff n ((powerSeriesPBasisDigit f i) ^ p * PowerSeries.X ^ i.val) =
      if n % p = i.val then PowerSeries.coeff n f else 0 := by
  rw [PowerSeries.coeff_mul_X_pow']
  by_cases hin : i.val ≤ n
  · rw [if_pos hin, power_series_frobenius_coeff]
    by_cases hd : p ∣ n - i.val
    · rw [if_pos hd, powerSeriesPBasisDigit, PowerSeries.coeff_mk,
        frobeniusEquiv_symm_pow_p]
      have heq : p * ((n - i.val) / p) + i.val = n := by
        rw [Nat.mul_comm p, Nat.div_mul_cancel hd, Nat.sub_add_cancel hin]
      have hm : n % p = i.val := by
        rw [← heq]
        simp [Nat.add_mod, Nat.mod_eq_of_lt i.isLt]
      rw [if_pos hm, heq]
    · rw [if_neg hd]
      have hm : n % p ≠ i.val := by
        intro hm
        apply hd
        rw [← hm]
        exact Nat.dvd_sub_mod n
      rw [if_neg hm]
  · rw [if_neg hin]
    have hm : n % p ≠ i.val := by
      intro hm
      exact hin (hm ▸ Nat.mod_le n p)
    rw [if_neg hm]

/-- A full p-residue expansion of every actual infinite power series. -/
theorem power_series_full_p_basis_expansion (f : PowerSeries k) :
    f = ∑ i : Fin p, (powerSeriesPBasisDigit f i) ^ p * PowerSeries.X ^ i.val := by
  classical
  ext n
  rw [map_sum]
  simp_rw [powerSeriesPBasisDigit_term_coeff]
  have hp : 0 < p := (Fact.out : p.Prime).pos
  let j : Fin p := ⟨n % p, Nat.mod_lt n hp⟩
  rw [Finset.sum_eq_single j]
  · simp [j]
  · intro i _ hij
    rw [if_neg]
    intro h
    apply hij
    apply Fin.ext
    exact h.symm
  · simp

end Litt3.SharedTensors
