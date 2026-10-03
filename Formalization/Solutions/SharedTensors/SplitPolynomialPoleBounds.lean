import Solutions.SharedTensors.SymmetricPoleBounds
import Mathlib.RingTheory.Polynomial.Vieta
import Mathlib.FieldTheory.Minpoly.Field
import Mathlib.FieldTheory.SplittingField.IsSplittingField

namespace Litt3.SharedTensors

open Polynomial

variable {K Γ : Type*} [Field K] [LinearOrderedCommGroupWithZero Γ]

theorem multiset_esymm_zero (s : Multiset K) : s.esymm 0 = 1 := by
  simp [Multiset.esymm, Multiset.powersetCard_zero_left]

theorem multiset_esymm_cons_succ (a : K) (s : Multiset K) (j : ℕ) :
    (a ::ₘ s).esymm (j + 1) = a * s.esymm j + s.esymm (j + 1) := by
  simp only [Multiset.esymm, Multiset.powersetCard_cons, Multiset.map_add,
    Multiset.sum_add, Multiset.map_map, Function.comp_def, Multiset.prod_cons]
  rw [Multiset.sum_map_mul_left]
  exact add_comm _ _

/-- The genuine root multiset, with all multiplicities and zero roots,
bounds every elementary symmetric function by its total pole product. -/
theorem multiset_esymm_valuation_le_total_poles (v : Valuation K Γ)
    (s : Multiset K) (j : ℕ) :
    v (s.esymm j) ≤ (s.map fun a => max 1 (v a)).prod := by
  induction s using Multiset.induction_on generalizing j with
  | empty =>
      cases j <;> simp [Multiset.esymm, Multiset.powersetCard_zero_left]
  | @cons a s ih =>
      cases j with
      | zero =>
          simp only [multiset_esymm_zero, map_one, Multiset.map_cons, Multiset.prod_cons]
          exact one_le_mul (le_max_left _ _) (by
            simpa only [multiset_esymm_zero, map_one] using ih 0)
      | succ j =>
          rw [multiset_esymm_cons_succ, Multiset.map_cons, Multiset.prod_cons]
          apply v.map_add_le
          · rw [map_mul]
            exact mul_le_mul' (le_max_right _ _) (ih j)
          · exact (ih (j + 1)).trans (le_mul_of_one_le_left' (le_max_left _ _))

/-- An actual monic split polynomial has this bound on EVERY coefficient,
including its leading and out-of-range coefficients. -/
theorem monic_split_polynomial_coeff_valuation_le_total_root_poles
    (v : Valuation K Γ) (P : K[X]) (hP : P.Monic) (hsplit : P.Splits) (j : ℕ) :
    v (P.coeff j) ≤ (P.roots.map fun a => max 1 (v a)).prod := by
  by_cases hj : j ≤ P.natDegree
  · rw [P.coeff_eq_esymm_roots_of_splits hsplit hj, hP.leadingCoeff,
      one_mul, map_mul, map_pow, v.map_neg, map_one, one_pow, one_mul]
    exact multiset_esymm_valuation_le_total_poles v P.roots (P.natDegree - j)
  · rw [P.coeff_eq_zero_of_natDegree_lt (Nat.lt_of_not_ge hj), map_zero]
    exact zero_le'

/-- Apply the bound to the actual minimal polynomial in an actual splitting
field. Only this single polynomial is split; no simultaneous closure of
the two endpoint maps is posited. -/
theorem minimal_polynomial_coeff_valuation_le_total_root_poles
    {L Ω : Type*} [Field L] [Field Ω] [Algebra K L] [Algebra K Ω]
    (chi : L) (hchi : IsIntegral K chi)
    [IsSplittingField K Ω (minpoly K chi)]
    (v : Valuation K Γ) (w : Valuation Ω Γ)
    (hw : ∀ a : K, w (algebraMap K Ω a) = v a) (j : ℕ) :
    v ((minpoly K chi).coeff j) ≤
      (((minpoly K chi).map (algebraMap K Ω)).roots.map fun a => max 1 (w a)).prod := by
  have h := monic_split_polynomial_coeff_valuation_le_total_root_poles w
    ((minpoly K chi).map (algebraMap K Ω))
    ((minpoly.monic hchi).map _) (IsSplittingField.splits Ω (minpoly K chi)) j
  simpa only [coeff_map, hw] using h

end Litt3.SharedTensors
