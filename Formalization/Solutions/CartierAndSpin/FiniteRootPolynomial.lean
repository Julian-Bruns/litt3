import Definitions.CartierAndSpin.FiniteRootPolynomial
import Solutions.CartierAndSpin.CohortPowerSums
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Finset Polynomial

variable {K ι : Type*} [CommRing K] [Fintype ι]

@[simp]
theorem finiteElementarySymmetric_zero (u : ι → K) :
    finiteElementarySymmetric u 0 = 1 := by
  simp [finiteElementarySymmetric]

theorem finiteElementarySymmetric_eq_multiset (u : ι → K) (k : ℕ) :
    finiteElementarySymmetric u k = (univ.val.map u).esymm k := by
  classical
  simp [finiteElementarySymmetric, MvPolynomial.esymm, Finset.esymm_map_val]

theorem finiteRootPolynomial_coeff_of_le (u : ι → K) (k : ℕ)
    (hk : k ≤ Fintype.card ι) :
    (finiteRootPolynomial u).coeff k =
      (-1) ^ (Fintype.card ι - k) * finiteElementarySymmetric u (Fintype.card ι - k) := by
  classical
  have hcard : (univ.val.map u).card = Fintype.card ι := by simp
  have h := Multiset.prod_X_sub_C_coeff (univ.val.map u) (k := k) (by simpa using hk)
  simpa only [finiteRootPolynomial, prod_eq_multiset_prod, Multiset.map_map,
    Function.comp_def, hcard, finiteElementarySymmetric_eq_multiset] using h

theorem finiteRootPolynomial_eval_at_member (u : ι → K) (i : ι) :
    (finiteRootPolynomial u).eval (u i) = 0 := by
  classical
  simp only [finiteRootPolynomial, eval_prod, eval_sub, eval_X, eval_C]
  apply prod_eq_zero (mem_univ i)
  exact sub_self _

theorem finiteRootPolynomial_monic (u : ι → K) : (finiteRootPolynomial u).Monic := by
  classical
  exact monic_prod_of_monic _ _ (fun i _ => monic_X_sub_C (u i))

theorem finiteRootPolynomial_natDegree [Nontrivial K] (u : ι → K) :
    (finiteRootPolynomial u).natDegree = Fintype.card ι := by
  classical
  unfold finiteRootPolynomial
  rw [natDegree_prod_of_monic univ _ (fun i _ => monic_X_sub_C (u i))]
  simp

/-- Vanishing intermediate elementary functions gives the actual two-term
root polynomial; no splitting conclusion is assumed. -/
theorem finiteRootPolynomial_eq_pow_add_constant [Nontrivial K] (u : ι → K)
    (n : ℕ) (hn : 0 < n) (hcard : Fintype.card ι = n)
    (hesymm : ∀ k, 0 < k → k < n → finiteElementarySymmetric u k = 0) :
    finiteRootPolynomial u = X ^ n + C ((finiteRootPolynomial u).coeff 0) := by
  classical
  ext k
  by_cases hk0 : k = 0
  · subst k
    simp [coeff_X_pow, coeff_C, Ne.symm hn.ne']
  by_cases hkn : k = n
  · subst k
    rw [finiteRootPolynomial_coeff_of_le u n (by omega), hcard]
    simp [coeff_C, hn.ne']
  by_cases hklt : k < n
  · rw [finiteRootPolynomial_coeff_of_le u k (by omega), hcard,
      hesymm (n - k) (by omega) (by omega)]
    simp [coeff_X_pow, coeff_C, hk0, hkn]
  · rw [coeff_eq_zero_of_natDegree_lt (by rw [finiteRootPolynomial_natDegree, hcard]; omega)]
    simp [coeff_X_pow, coeff_C, hk0, hkn]

end Litt3.CartierAndSpin
