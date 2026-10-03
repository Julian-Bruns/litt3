import Definitions.CartierAndSpin.CriticalContraction
import Theorems.CartierAndSpin.CriticalContraction
import Solutions.CartierAndSpin.ValuationRingIntegrality
import Mathlib.Algebra.Polynomial.Reverse
import Mathlib.Algebra.GroupWithZero.Invertible
import Definitions.CartierAndSpin.CriticalQuadratic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [Nontrivial R] [Field K] [Algebra R K]

/-- Actual monic-power division shifts coefficients in every degree. -/
theorem critical_power_quotient_coeff (D : R[X]) (n k : ℕ) :
    (D /ₘ X ^ n).coeff k = D.coeff (k + n) := by
  by_cases hn : n = 0
  · simp [hn]
  have hpower : (X ^ n : R[X]) ≠ 1 := by
    intro h
    have := congrArg natDegree h
    simp only [natDegree_X_pow, natDegree_one] at this
    exact hn this
  have hdegree : (D %ₘ X ^ n).natDegree < n := by
    simpa only [natDegree_X_pow] using
      natDegree_modByMonic_lt D (monic_X.pow n) hpower
  have hzero : (D %ₘ X ^ n).coeff (k + n) = 0 :=
    coeff_eq_zero_of_natDegree_lt (hdegree.trans_le (Nat.le_add_left n k))
  have h := congrArg (fun P : R[X] => P.coeff (k + n))
    (modByMonic_add_div D (monic_X.pow n))
  simpa only [coeff_add, hzero, zero_add, coeff_X_pow_mul] using h

/-- The cubic trace contraction has its actual low-degree expression,
including every leading-coefficient or actual-degree drop. -/
theorem critical_trace_contraction_cubic (D : R[X]) (n : ℕ → R)
    (hdegree : D.natDegree ≤ 3) :
    criticalTraceContraction D n 3 =
      C (D.coeff 1 * n 0 + D.coeff 2 * n 1 + D.coeff 3 * n 2) +
      C (D.coeff 2 * n 0 + D.coeff 3 * n 1) * X + C (D.coeff 3 * n 0) * X ^ 2 := by
  classical
  ext k
  simp only [criticalTraceContraction, Finset.sum_range_succ, Finset.sum_range_zero,
    zero_add, coeff_add, coeff_C_mul, critical_power_quotient_coeff]
  have hfour : D.coeff 4 = 0 := coeff_eq_zero_of_natDegree_lt (hdegree.trans_lt (by omega))
  have hfive : D.coeff 5 = 0 := coeff_eq_zero_of_natDegree_lt (hdegree.trans_lt (by omega))
  by_cases hk : k < 3
  · interval_cases k <;> simp [coeff_X, hfour, hfive] <;> ring
  · have hk' : 3 ≤ k := Nat.le_of_not_gt hk
    have hzero : ∀ j, D.coeff (k + (j + 1)) = 0 := fun j =>
      coeff_eq_zero_of_natDegree_lt (hdegree.trans_lt (by omega))
    simp [hzero, coeff_C, coeff_X, show k ≠ 0 by omega,
      show 1 ≠ k by omega, show k ≠ 2 by omega]

/-- The source's explicit quadratic is exactly its constant term minus
the actual cubic trace contraction. -/
theorem critical_quadratic_eq_contraction (D : R[X]) (leading rho : R) (mu : ℕ → R)
    (hdegree : D.natDegree ≤ 3) :
    criticalQuadraticFromMoments leading D rho mu =
      C (leading * rho ^ 2) - criticalTraceContraction D mu 3 := by
  rw [critical_trace_contraction_cubic D mu hdegree]
  simp only [criticalQuadraticFromMoments, map_sub, map_add, map_mul]
  ring

/-- At a nonzero root of D, division by a monic power can be evaluated
using only the reciprocal root and coefficients in the original ring. -/
theorem critical_root_power_quotient_reciprocal (D : R[X]) (c : K) (hc : c ≠ 0)
    (hroot : D.eval₂ (algebraMap R K) c = 0) (j : ℕ) :
    (D /ₘ X ^ (j + 1)).eval₂ (algebraMap R K) c =
      -c⁻¹ * (reflect j (D %ₘ X ^ (j + 1))).eval₂ (algebraMap R K) c⁻¹ := by
  letI : Invertible c := invertibleOfNonzero hc
  have hpower : (X ^ (j + 1) : R[X]) ≠ 1 := by
    intro h
    have := congrArg natDegree h
    simp only [natDegree_X_pow, natDegree_one] at this
    omega
  have hdegree : (D %ₘ X ^ (j + 1)).natDegree ≤ j := by
    have h := natDegree_modByMonic_lt D (monic_X.pow (j + 1)) hpower
    simpa only [natDegree_X_pow, Nat.lt_succ_iff] using h
  have hreflect := eval₂_reflect_mul_pow (algebraMap R K) c j
    (D %ₘ X ^ (j + 1)) hdegree
  simp only [invOf_eq_inv] at hreflect
  have hdivision := congrArg (fun P : R[X] => P.eval₂ (algebraMap R K) c)
    (modByMonic_add_div D (monic_X.pow (j + 1)))
  simp only [eval₂_add, eval₂_mul, eval₂_pow, eval₂_X, hroot] at hdivision
  rw [← hreflect] at hdivision
  have hpow : c ^ (j + 1) ≠ 0 := pow_ne_zero _ hc
  apply (mul_left_cancel₀ hpow)
  calc
    c ^ (j + 1) * (D /ₘ X ^ (j + 1)).eval₂ (algebraMap R K) c =
        -(reflect j (D %ₘ X ^ (j + 1))).eval₂ (algebraMap R K) c⁻¹ * c ^ j := by
      linear_combination hdivision
    _ = c ^ (j + 1) *
        (-c⁻¹ * (reflect j (D %ₘ X ^ (j + 1))).eval₂ (algebraMap R K) c⁻¹) := by
      rw [pow_succ]
      field_simp
      ring

/-- Every monic-power quotient is integral at every critical root, over
an actual integer ring. Neither the leading coefficient nor the roots
are assumed to be units or pairwise distinct. -/
theorem critical_root_power_quotient_integral {Γ : Type*}
    [LinearOrderedCommGroupWithZero Γ] (v : Valuation K Γ) (hv : v.Integers R)
    (D : R[X]) (c : K) (hroot : D.eval₂ (algebraMap R K) c = 0) (j : ℕ) :
    ∃ b : R, algebraMap R K b = (D /ₘ X ^ (j + 1)).eval₂ (algebraMap R K) c := by
  by_cases hc : c = 0
  · exact ⟨(D /ₘ X ^ (j + 1)).coeff 0, by simp [hc]⟩
  rcases v.val_le_one_or_val_inv_le_one c with hregular | hinverse
  · obtain ⟨b, hb⟩ := hv.exists_of_le_one hregular
    exact ⟨(D /ₘ X ^ (j + 1)).eval b, by rw [← hb, eval₂_at_apply]⟩
  · obtain ⟨b, hb⟩ := hv.exists_of_le_one hinverse
    refine ⟨-b * (reflect j (D %ₘ X ^ (j + 1))).eval b, ?_⟩
    rw [critical_root_power_quotient_reciprocal D c hc hroot j, ← hb,
      eval₂_at_apply, map_mul, map_neg]

/-- The entire critical trace contraction is integral at every root.
The degree and characteristic are arbitrary and zero roots are included. -/
theorem critical_trace_contraction_root_integral {Γ : Type*}
    [LinearOrderedCommGroupWithZero Γ] (v : Valuation K Γ) (hv : v.Integers R)
    (D : R[X]) (n : ℕ → R) (d : ℕ) (c : K)
    (hroot : D.eval₂ (algebraMap R K) c = 0) :
    ∃ b : R, algebraMap R K b =
      (criticalTraceContraction D n d).eval₂ (algebraMap R K) c := by
  classical
  choose b hb using fun j => critical_root_power_quotient_integral v hv D c hroot j
  refine ⟨∑ j ∈ Finset.range d, n j * b j, ?_⟩
  simp only [criticalTraceContraction, map_sum, map_mul, eval₂_finset_sum, eval₂_mul, eval₂_C]
  exact Finset.sum_congr rfl fun j _ => congrArg ((algebraMap R K (n j)) * ·) (hb j)

/-- A regular constant minus the actual trace contraction is regular at
every critical root, with no leading-coefficient unit assumption. -/
theorem critical_quadratic_contraction_root_integral {Γ : Type*}
    [LinearOrderedCommGroupWithZero Γ] (v : Valuation K Γ) (hv : v.Integers R)
    (D : R[X]) (n : ℕ → R) (d : ℕ) (constant : R) (c : K)
    (hroot : D.eval₂ (algebraMap R K) c = 0) :
    ∃ b : R, algebraMap R K b =
      (C constant - criticalTraceContraction D n d).eval₂ (algebraMap R K) c := by
  obtain ⟨b, hb⟩ := critical_trace_contraction_root_integral v hv D n d c hroot
  exact ⟨constant - b, by simp only [map_sub, eval₂_sub, eval₂_C, hb]⟩

/-- The same conclusion for a valuation ring and its actual fraction
field, using its canonical valuation rather than a supplied abstraction. -/
theorem valuationRing_critical_contraction_root_integral
    [IsDomain R] [ValuationRing R] [IsFractionRing R K]
    (D : R[X]) (n : ℕ → R) (d : ℕ) (constant : R) (c : K)
    (hroot : D.eval₂ (algebraMap R K) c = 0) :
    ∃ b : R, algebraMap R K b =
      (C constant - criticalTraceContraction D n d).eval₂ (algebraMap R K) c :=
  critical_quadratic_contraction_root_integral (ValuationRing.valuation R K)
    valuationRing_valuation_integers D n d constant c hroot

/-- The explicit source quadratic is regular at every actual critical
root whenever its actual moments and critical coefficients lie in R. -/
theorem critical_quadratic_root_integral {Γ : Type*}
    [LinearOrderedCommGroupWithZero Γ] (v : Valuation K Γ) (hv : v.Integers R)
    (D : R[X]) (leading rho : R) (mu : ℕ → R) (hdegree : D.natDegree ≤ 3)
    (c : K) (hroot : D.eval₂ (algebraMap R K) c = 0) :
    ∃ b : R, algebraMap R K b =
      (criticalQuadraticFromMoments leading D rho mu).eval₂ (algebraMap R K) c := by
  rw [critical_quadratic_eq_contraction D leading rho mu hdegree]
  exact critical_quadratic_contraction_root_integral v hv D mu 3 (leading * rho ^ 2) c hroot

/-- The named precise source component holds over every integer ring. -/
theorem critical_contraction_root_integral_specification {Γ : Type*}
    [LinearOrderedCommGroupWithZero Γ] (v : Valuation K Γ) (hv : v.Integers R)
    (D : R[X]) (n : ℕ → R) (d : ℕ) (constant : R) :
    Specifications.CriticalContractionRootIntegral (K := K) D n d constant :=
  fun c hc => critical_quadratic_contraction_root_integral v hv D n d constant c hc

end Litt3.CartierAndSpin
