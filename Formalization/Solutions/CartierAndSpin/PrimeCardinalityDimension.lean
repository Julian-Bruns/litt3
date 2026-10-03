import Mathlib.FieldTheory.Finiteness
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Field.ZMod
import Mathlib.RingTheory.Finiteness.Cardinality
import Mathlib.GroupTheory.SpecificGroups.Cyclic

namespace Litt3.CartierAndSpin

variable {p : ℕ} [Fact p.Prime]
variable {V : Type*} [AddCommGroup V] [Module (ZMod p) V]

/-- Actual cardinality one or p forces a genuine finite prime-field
module of dimension at most one and a cyclic additive group. -/
theorem actual_prime_module_small_cardinality
    (hcard : Nat.card V = 1 ∨ Nat.card V = p) :
    Finite V ∧ Module.Finite (ZMod p) V ∧ Module.finrank (ZMod p) V ≤ 1 ∧ IsAddCyclic V := by
  have hp := (Fact.out : p.Prime)
  have hnonzero : Nat.card V ≠ 0 := by
    rcases hcard with h | h
    · rw [h]; exact one_ne_zero
    · rw [h]; exact hp.ne_zero
  letI : Finite V := Nat.finite_of_card_ne_zero hnonzero
  letI : Module.Finite (ZMod p) V := Module.Finite.of_finite
  have hpow : Nat.card V = p ^ Module.finrank (ZMod p) V := by
    simpa only [Nat.card_zmod] using (Module.natCard_eq_pow_finrank (K := ZMod p) (V := V))
  have hbound : p ^ Module.finrank (ZMod p) V ≤ p := by
    rw [← hpow]
    rcases hcard with h | h
    · rw [h]; exact hp.one_lt.le
    · rw [h]
  have hdim : Module.finrank (ZMod p) V ≤ 1 := by
    by_contra hn
    have hgt : p ^ 1 < p ^ Module.finrank (ZMod p) V :=
      Nat.pow_lt_pow_right hp.one_lt (by omega)
    have hgt' : p < p ^ Module.finrank (ZMod p) V := by simpa only [pow_one] using hgt
    exact not_lt_of_ge hbound hgt'
  refine ⟨inferInstance, inferInstance, hdim, isAddCyclic_of_card_dvd_prime (p := p) ?_⟩
  rcases hcard with h | h
  · rw [h]; exact one_dvd p
  · rw [h]

end Litt3.CartierAndSpin
