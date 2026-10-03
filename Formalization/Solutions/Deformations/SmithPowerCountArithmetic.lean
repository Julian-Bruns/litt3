import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic

namespace Litt3.Deformations

/-- Three exact full filtration counts force the complete finite
power-factor multiset, uniformly in all dimensions and exponents.
This is symbolic counting and imposes no bound on any parameter. -/
theorem smith_power_count_arithmetic (q h f a : ℕ) (aPositive : 0 < a)
    (e : Fin (q * f) → ℕ) (eBound : ∀ i, e i ≤ a + 1)
    (first : (∑ i : Fin (q * f), min (e i) 1) = f * h)
    (lower : (∑ i : Fin (q * f), min (e i) a) = f * h * a)
    (full : (∑ i : Fin (q * f), min (e i) (a + 1)) = f * h * a + f) :
    (∀ i, e i = 0 ∨ e i = a ∨ e i = a + 1) ∧
      (Finset.univ.filter (fun i : Fin (q * f) => e i = 0)).card = f * (q - h) ∧
      (Finset.univ.filter (fun i : Fin (q * f) => e i = a)).card = f * (h - 1) ∧
      (Finset.univ.filter (fun i : Fin (q * f) => e i = a + 1)).card = f := by
  classical
  have domination : ∀ i : Fin (q * f), min (e i) a ≤ a * min (e i) 1 := by
    intro i
    by_cases zero : e i = 0
    · simp [zero]
    · have one : min (e i) 1 = 1 := Nat.min_eq_right (by omega)
      rw [one, mul_one]
      exact Nat.min_le_right _ _
  have aggregate : (∑ i : Fin (q * f), min (e i) a) =
      ∑ i : Fin (q * f), a * min (e i) 1 := by
    rw [← Finset.mul_sum, first, lower]
    ring
  have noSmall : ∀ i, 0 < e i → a ≤ e i := by
    intro i positive
    by_contra notLarge
    have strict : (∑ j : Fin (q * f), min (e j) a) <
        ∑ j : Fin (q * f), a * min (e j) 1 := by
      apply Finset.sum_lt_sum
      · intro j member
        exact domination j
      · refine ⟨i, Finset.mem_univ _, ?_⟩
        rw [Nat.min_eq_left (by omega : e i ≤ a), Nat.min_eq_right (by omega : 1 ≤ e i), mul_one]
        omega
    rw [aggregate] at strict
    exact (lt_irrefl _ strict)
  have support : ∀ i, e i = 0 ∨ e i = a ∨ e i = a + 1 := by
    intro i
    have upper := eBound i
    by_cases zero : e i = 0
    · exact Or.inl zero
    · have lower := noSmall i (by omega)
      omega
  have positiveCount : (Finset.univ.filter (fun i : Fin (q * f) => 0 < e i)).card = f * h := by
    have identity : (∑ i : Fin (q * f), min (e i) 1) =
        (Finset.univ.filter (fun i : Fin (q * f) => 0 < e i)).card := by
      calc
        _ = ∑ i : Fin (q * f), if 0 < e i then 1 else 0 := by
          apply Finset.sum_congr rfl
          intro i member
          by_cases positive : 0 < e i <;> simp [positive] <;> omega
        _ = _ := Finset.sum_boole _ _
    exact identity.symm.trans first
  have highCount : (Finset.univ.filter (fun i : Fin (q * f) => e i = a + 1)).card = f := by
    have identity : (∑ i : Fin (q * f), min (e i) (a + 1)) =
        (∑ i : Fin (q * f), min (e i) a) +
          (Finset.univ.filter (fun i : Fin (q * f) => e i = a + 1)).card := by
      calc
        _ = ∑ i : Fin (q * f), (min (e i) a + if e i = a + 1 then 1 else 0) := by
          apply Finset.sum_congr rfl
          intro i member
          have upper := eBound i
          by_cases high : e i = a + 1 <;> simp [high] <;> omega
        _ = _ := by rw [Finset.sum_add_distrib, Finset.sum_boole]; simp
    rw [full, lower] at identity
    omega
  have zeroPartition :
      (Finset.univ.filter (fun i : Fin (q * f) => e i = 0)).card +
        (Finset.univ.filter (fun i : Fin (q * f) => 0 < e i)).card = q * f := by
    have identity := Finset.card_filter_add_card_filter_not (s := Finset.univ)
      (p := fun i : Fin (q * f) => e i = 0)
    simpa only [Nat.pos_iff_ne_zero, Finset.card_univ, Fintype.card_fin] using identity
  have positivePartition :
      (Finset.univ.filter (fun i : Fin (q * f) => e i = a)).card +
        (Finset.univ.filter (fun i : Fin (q * f) => e i = a + 1)).card =
          (Finset.univ.filter (fun i : Fin (q * f) => 0 < e i)).card := by
    have identity : (Finset.univ.filter (fun i : Fin (q * f) => 0 < e i)) =
        (Finset.univ.filter (fun i : Fin (q * f) => e i = a)) ∪
          (Finset.univ.filter (fun i : Fin (q * f) => e i = a + 1)) := by
      ext i
      simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_union]
      have cases := support i
      omega
    have disjoint : Disjoint (Finset.univ.filter (fun i : Fin (q * f) => e i = a))
        (Finset.univ.filter (fun i : Fin (q * f) => e i = a + 1)) := by
      apply Finset.disjoint_left.mpr
      intro i first second
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at first second
      omega
    rw [identity, Finset.card_union_of_disjoint disjoint]
  refine ⟨support, ?_, ?_, highCount⟩
  · rw [positiveCount] at zeroPartition
    have difference : q * f - f * h = f * (q - h) := by
      rw [mul_comm q f, ← Nat.mul_sub_left_distrib]
    omega
  · rw [positiveCount, highCount] at positivePartition
    have difference : f * h - f = f * (h - 1) := by
      rw [Nat.mul_sub_left_distrib, mul_one]
    omega

end Litt3.Deformations
