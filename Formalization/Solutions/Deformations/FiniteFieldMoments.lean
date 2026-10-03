import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic

namespace Litt3.Deformations

open scoped BigOperators

variable (F : Type*) [Field F] [Fintype F]

/-- The top nonzero finite-field monomial moment, proved uniformly
from the actual multiplicative-group order. -/
theorem finite_field_top_power_sum :
    ∑ x : F, x ^ (Fintype.card F - 1) = -1 := by
  classical
  have exponent : 0 < Fintype.card F - 1 := by
    have := Fintype.one_lt_card (α := F)
    omega
  have formula (x : F) : x ^ (Fintype.card F - 1) = 1 - if x = 0 then 1 else 0 := by
    by_cases zero : x = 0
    · simp [zero, exponent.ne']
    · rw [FiniteField.pow_card_sub_one_eq_one x zero]
      simp [zero]
  simp_rw [formula]
  simp [Finset.sum_sub_distrib, FiniteField.cast_card_eq_zero F]

/-- All moments up to the field cardinality. The only surviving
exponent is card(F)-1, provided card(F)>2. -/
theorem finite_field_bounded_power_sum (large : 2 < Fintype.card F)
    (j : ℕ) (bound : j ≤ Fintype.card F) :
    ∑ x : F, x ^ j = if j = Fintype.card F - 1 then -1 else 0 := by
  classical
  by_cases low : j < Fintype.card F - 1
  · rw [if_neg (Nat.ne_of_lt low)]
    exact FiniteField.sum_pow_lt_card_sub_one F j low
  · by_cases top : j = Fintype.card F - 1
    · rw [top, if_pos rfl]
      exact finite_field_top_power_sum F
    · have last : j = Fintype.card F := by omega
      rw [if_neg top, last]
      simp_rw [FiniteField.pow_card]
      simpa only [pow_one] using
        FiniteField.sum_pow_lt_card_sub_one F 1 (by omega)

/-- The actual full multivariate moment factors coordinatewise.
It is supported at the original top multi-exponent only. -/
theorem finite_field_monomial_sum {I : Type*} [Fintype I] [DecidableEq I]
    (large : 2 < Fintype.card F) (alpha : I → ℕ)
    (bound : ∀ i, alpha i ≤ Fintype.card F) :
    ∑ a : I → F, ∏ i, a i ^ alpha i =
      if ∀ i, alpha i = Fintype.card F - 1 then (-1 : F) ^ Fintype.card I else 0 := by
  classical
  rw [← Fintype.prod_sum (fun i (x : F) => x ^ alpha i)]
  simp_rw [finite_field_bounded_power_sum F large _ (bound _)]
  by_cases top : ∀ i, alpha i = Fintype.card F - 1
  · rw [if_pos top]
    simp [top]
  · rw [if_neg top]
    obtain ⟨i, nonzero⟩ := not_forall.mp top
    exact Finset.prod_eq_zero (Finset.mem_univ i) (by simp [nonzero])

/-- The same exact moments inside any commutative coefficient ring
through the actual finite-field coefficient map. -/
theorem finite_field_monomial_sum_map {I K : Type*} [Fintype I] [DecidableEq I] [CommRing K]
    (φ : F →+* K) (large : 2 < Fintype.card F) (alpha : I → ℕ)
    (bound : ∀ i, alpha i ≤ Fintype.card F) :
    ∑ a : I → F, ∏ i, φ (a i) ^ alpha i =
      if ∀ i, alpha i = Fintype.card F - 1 then (-1 : K) ^ Fintype.card I else 0 := by
  classical
  have mapped := congrArg φ (finite_field_monomial_sum F large alpha bound)
  split_ifs at mapped ⊢ <;>
    simpa only [map_sum, map_prod, map_pow, map_neg, map_one, map_zero] using mapped

end Litt3.Deformations
