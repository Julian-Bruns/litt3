import Mathlib.Algebra.CharP.Frobenius
import Mathlib.Algebra.Group.Subgroup.Ker
import Mathlib.Algebra.Group.TypeTags.Basic

namespace Litt3.QuotientGeometry

noncomputable def linearizedTranslationHom
    {k : Type*} [Field k] (p : ℕ) [Fact p.Prime] [CharP k p] (α γ : k) : k →+ k where
  toFun := fun b => α * b ^ p + γ * b
  map_zero' := by simp [(Fact.out : p.Prime).ne_zero]
  map_add' := by
    intro a b
    rw [add_pow_char]
    ring

/-- The actual additive kernel of the constant linearized polynomial. -/
noncomputable def linearizedTranslationGroup
    {k : Type*} [Field k] (p : ℕ) [Fact p.Prime] [CharP k p] (α γ : k) : AddSubgroup k :=
  (linearizedTranslationHom p α γ).ker

abbrev WeakTranslationGroup
    {k : Type*} [Field k] (p : ℕ) [Fact p.Prime] [CharP k p] (α γ : k) :=
  Multiplicative (linearizedTranslationGroup p α γ)

end Litt3.QuotientGeometry
