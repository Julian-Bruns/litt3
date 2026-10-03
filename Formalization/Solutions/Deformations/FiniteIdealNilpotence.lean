import Mathlib.RingTheory.Ideal.Operations
import Mathlib.Tactic

namespace Litt3.Deformations

variable {A : Type*} [CommSemiring A]

/-- The sharp two-ideal nilpotence bound retains the one shared unit
of degree, rather than losing it at every ideal sum. -/
theorem ideal_sup_pow_sub_one_le (I J : Ideal A) (n m : ℕ) :
    (I ⊔ J) ^ (n + m - 1) ≤ I ^ n ⊔ J ^ m := by
  rw [← Ideal.add_eq_sup, ← Ideal.add_eq_sup, add_pow, Ideal.sum_eq_sup]
  apply Finset.sup_le
  intro i member
  by_cases first : n ≤ i
  · exact Ideal.mul_le_right.trans (Ideal.mul_le_right.trans
      ((Ideal.pow_le_pow_right first).trans le_sup_left))
  · exact Ideal.mul_le_right.trans (Ideal.mul_le_left.trans
      ((Ideal.pow_le_pow_right (by omega)).trans le_sup_right))

/-- The finite sum of actual nilpotent ideals has the sharp exponent
one plus the sum of each individual exponent minus one. -/
theorem finite_ideal_sup_nilpotent {I : Type*} (s : Finset I)
    (J : I → Ideal A) (q : I → ℕ)
    (positive : ∀ i ∈ s, 0 < q i) (nilpotent : ∀ i ∈ s, J i ^ q i = ⊥) :
    s.sup J ^ ((∑ i ∈ s, (q i - 1)) + 1) = ⊥ := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert i s fresh ih =>
    have qi := positive i (Finset.mem_insert_self _ _)
    have old := ih (fun j member => positive j (Finset.mem_insert_of_mem member))
      (fun j member => nilpotent j (Finset.mem_insert_of_mem member))
    rw [Finset.sup_insert, Finset.sum_insert fresh]
    have bound := ideal_sup_pow_sub_one_le (J i) (s.sup J) (q i)
      ((∑ j ∈ s, (q j - 1)) + 1)
    rw [nilpotent i (Finset.mem_insert_self _ _), old, sup_bot_eq] at bound
    have exponent : q i + ((∑ j ∈ s, (q j - 1)) + 1) - 1 =
        (q i - 1) + (∑ j ∈ s, (q j - 1)) + 1 := by omega
    rw [exponent] at bound
    exact le_bot_iff.mp bound

end Litt3.Deformations
