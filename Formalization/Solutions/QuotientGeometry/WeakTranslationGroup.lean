import Definitions.QuotientGeometry.WeakTranslationGroup
import Solutions.QuotientGeometry.WeakTameRootCounts
import Mathlib.GroupTheory.SpecificGroups.Cyclic

namespace Litt3.QuotientGeometry

theorem mem_linearized_translation_group
    {k : Type*} [Field k] (p : ℕ) [Fact p.Prime] [CharP k p] (α γ b : k) :
    b ∈ linearizedTranslationGroup p α γ ↔ α * b ^ p + γ * b = 0 := Iff.rfl

/-- The actual additive kernel has exactly p elements, without selecting
or enumerating any coefficient field. -/
theorem linearized_translation_group_card
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    Nat.card (linearizedTranslationGroup p α γ) = p := by
  classical
  let s := (linearizedConstantPolynomial p α γ).roots.toFinset
  let e : linearizedTranslationGroup p α γ ≃ s :=
    { toFun := fun b => ⟨b.val, (mem_linearized_constant_roots p
        (Fact.out : p.Prime).one_lt α γ hα b.val).mpr b.property⟩
      invFun := fun b => ⟨b.val, (mem_linearized_constant_roots p
        (Fact.out : p.Prime).one_lt α γ hα b.val).mp b.property⟩
      left_inv := fun _ => rfl
      right_inv := fun _ => rfl }
  rw [Nat.card_congr e, Nat.card_eq_fintype_card, Fintype.card_coe]
  exact linearized_constant_roots_card p (Fact.out : p.Prime).one_lt α γ hα hγ

theorem weak_translation_group_cyclic_and_card
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    IsCyclic (WeakTranslationGroup p α γ) ∧ Nat.card (WeakTranslationGroup p α γ) = p := by
  have hcard : Nat.card (WeakTranslationGroup p α γ) = p := by
    rw [Nat.card_congr Multiplicative.toAdd]
    exact linearized_translation_group_card p α γ hα hγ
  exact ⟨isCyclic_of_prime_card hcard, hcard⟩

end Litt3.QuotientGeometry
