import Definitions.CartierAndSpin.CommutatorWordIdeals
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

variable {A : Type*} [Ring A]

theorem ordered_commutator_ideal_mono (U V : A) {d e : ℕ} (hde : d ≤ e) :
    orderedCommutatorIdeal U V d ≤ orderedCommutatorIdeal U V e := by
  apply Ideal.span_mono
  rintro m ⟨a, b, hab, hm⟩
  exact ⟨a, b, hab.trans hde, hm⟩

theorem ordered_commutator_generator_mem (U V : A) (a b d : ℕ) (hab : a + b ≤ d) :
    (U * V - V * U) * U ^ a * V ^ b ∈ orderedCommutatorIdeal U V d :=
  Ideal.subset_span ⟨a, b, hab, rfl⟩

theorem commutator_mem_ordered_ideal (U V : A) (d : ℕ) :
    U * V - V * U ∈ orderedCommutatorIdeal U V d := by
  simpa only [pow_zero, mul_one] using ordered_commutator_generator_mem U V 0 0 d (by omega)

theorem ordered_commutator_right_V (U V : A) (d : ℕ) {m : A}
    (hm : m ∈ orderedCommutatorIdeal U V d) :
    m * V ∈ orderedCommutatorIdeal U V (d + 1) := by
  induction hm using Submodule.span_induction with
  | mem m hm =>
      obtain ⟨a, b, hab, rfl⟩ := hm
      simpa only [pow_succ, mul_assoc] using
        ordered_commutator_generator_mem U V a (b + 1) (d + 1) (by omega)
  | zero => simpa using (orderedCommutatorIdeal U V (d + 1)).zero_mem
  | add x y hx hy hxe hye =>
      rw [add_mul]
      exact (orderedCommutatorIdeal U V (d + 1)).add_mem hxe hye
  | smul a x hx hxe =>
      change (a * x) * V ∈ _
      rw [mul_assoc]
      exact (orderedCommutatorIdeal U V (d + 1)).mul_mem_left a hxe

/-- Moving a final U past the V-power adds only shorter commutator
rows. This symbolic induction needs no division or commutativity. -/
theorem ordered_commutator_right_U_generator (U V : A) (a b : ℕ) :
    ((U * V - V * U) * U ^ a * V ^ b) * U ∈ orderedCommutatorIdeal U V (a + b + 1) := by
  induction b with
  | zero =>
      simpa only [pow_zero, mul_one, Nat.add_zero, pow_succ, mul_assoc] using
        ordered_commutator_generator_mem U V (a + 1) 0 (a + 1) (by omega)
  | succ b ih =>
      have hfirst := ordered_commutator_right_V U V (a + b + 1) ih
      have hsecond : ((U * V - V * U) * U ^ a * V ^ b) * (U * V - V * U) ∈
          orderedCommutatorIdeal U V (a + (b + 1) + 1) :=
        (orderedCommutatorIdeal U V (a + (b + 1) + 1)).mul_mem_left _
          (commutator_mem_ordered_ideal U V _)
      have heq : ((U * V - V * U) * U ^ a * V ^ (b + 1)) * U =
          (((U * V - V * U) * U ^ a * V ^ b) * U) * V -
            ((U * V - V * U) * U ^ a * V ^ b) * (U * V - V * U) := by
        rw [pow_succ]
        noncomm_ring
      rw [heq]
      exact (orderedCommutatorIdeal U V _).sub_mem (by simpa [Nat.add_assoc] using hfirst) hsecond

theorem ordered_commutator_right_U (U V : A) (d : ℕ) {m : A}
    (hm : m ∈ orderedCommutatorIdeal U V d) :
    m * U ∈ orderedCommutatorIdeal U V (d + 1) := by
  induction hm using Submodule.span_induction with
  | mem m hm =>
      obtain ⟨a, b, hab, rfl⟩ := hm
      exact ordered_commutator_ideal_mono U V (by omega)
        (ordered_commutator_right_U_generator U V a b)
  | zero => simpa using (orderedCommutatorIdeal U V (d + 1)).zero_mem
  | add x y hx hy hxe hye =>
      rw [add_mul]
      exact (orderedCommutatorIdeal U V (d + 1)).add_mem hxe hye
  | smul a x hx hxe =>
      change (a * x) * U ∈ _
      rw [mul_assoc]
      exact (orderedCommutatorIdeal U V (d + 1)).mul_mem_left a hxe

end Litt3.CartierAndSpin
