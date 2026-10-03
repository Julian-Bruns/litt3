import Definitions.CartierAndSpin.OrderedCommutatorStacks
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open scoped BigOperators

/-- The exact symbolic triangular count; only arithmetic, with no
matrix enumeration or entry computations. -/
theorem ordered_commutator_pairs_card_twice (d : ℕ) :
    Fintype.card (OrderedCommutatorPairs d) * 2 = (d + 1) * (d + 2) := by
  rw [Fintype.card_sigma]
  simp only [Fintype.card_fin]
  rw [Fin.sum_univ_eq_sum_range]
  have hreflect := Finset.sum_range_reflect (fun i : ℕ => d + 1 - i) (d + 1)
  have heq : (∑ i ∈ Finset.range (d + 1), (d + 1 - i)) =
      ∑ i ∈ Finset.range (d + 1), (i + 1) := by
    rw [← hreflect]
    apply Finset.sum_congr rfl
    intro i hi
    have hi' := Finset.mem_range.mp hi
    omega
  rw [heq, Finset.sum_add_distrib]
  simp only [Finset.sum_const, Finset.card_range, smul_eq_mul, mul_one]
  have hgauss := Finset.sum_range_id_mul_two (d + 1)
  simp only [Nat.add_sub_cancel] at hgauss
  nlinarith

theorem ordered_middle_stack_block_count : Fintype.card (OrderedCommutatorPairs 14) = 120 := by
  have h := ordered_commutator_pairs_card_twice 14
  omega

theorem ordered_middle_stack_row_count :
    Fintype.card (OrderedCommutatorPairs 14 × Fin 15) = 1800 := by
  rw [Fintype.card_prod, ordered_middle_stack_block_count, Fintype.card_fin]

theorem power_middle_stack_block_count : Fintype.card (Fin 14 × Fin 14) = 196 := by
  simp

theorem power_middle_stack_row_count : Fintype.card ((Fin 14 × Fin 14) × Fin 15) = 2940 := by
  simp

end Litt3.CartierAndSpin
