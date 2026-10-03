import Theorems.QuotientGeometry.InvariantIntersections
import Solutions.QuotientGeometry.RefinementAlgebra

namespace Litt3.QuotientGeometry

theorem finite_invariant_intermediate_field_eq_bot
    {K L : Type*} [Field K] [Field L] [Algebra K L] [IsAlgClosed K]
    (H : Subgroup (L ≃ₐ[K] L)) [Finite H] (E : IntermediateField K L)
    (hstable : ∀ (σ : H) (x : L), x ∈ E → σ.val x ∈ E)
    (hfixed : E ⊓ IntermediateField.fixedField H = ⊥) : E = ⊥ := by
  letI : MulSemiringAction H E :=
    { smul := fun σ x => ⟨σ.val x.val, hstable σ x.val x.property⟩
      one_smul := fun x => Subtype.ext rfl
      mul_smul := fun σ τ x => Subtype.ext rfl
      smul_zero := fun σ => Subtype.ext (map_zero σ.val)
      smul_add := fun σ x y => Subtype.ext (map_add σ.val x.val y.val)
      smul_one := fun σ => Subtype.ext (map_one σ.val)
      smul_mul := fun σ x y => Subtype.ext (map_mul σ.val x.val y.val) }
  have hconstants : ∀ (σ : H) (k : K), σ • algebraMap K E k = algebraMap K E k := by
    intro σ k
    apply Subtype.ext
    exact σ.val.commutes k
  have hfixedE : ∀ x : E, (∀ σ : H, σ • x = x) → ∃ k, algebraMap K E k = x := by
    intro x hx
    have hxfix : x.val ∈ IntermediateField.fixedField H := by
      rw [IntermediateField.mem_fixedField_iff]
      intro σ hσ
      exact congrArg Subtype.val (hx ⟨σ, hσ⟩)
    have hxbot : x.val ∈ (⊥ : IntermediateField K L) := by
      rw [← hfixed]
      exact ⟨x.property, hxfix⟩
    obtain ⟨k, hk⟩ := hxbot
    exact ⟨k, Subtype.ext hk⟩
  have hsurjective := finite_invariant_field_triviality hconstants hfixedE
  apply bot_unique
  intro x hx
  obtain ⟨k, hk⟩ := hsurjective ⟨x, hx⟩
  exact ⟨k, congrArg Subtype.val hk⟩

theorem finite_invariant_intermediate_field_triviality_target :
    Targets.FiniteInvariantIntermediateFieldTriviality := by
  intro K L instK instL instAlgebra instClosed H instFinite E hstable hfixed
  exact finite_invariant_intermediate_field_eq_bot H E hstable hfixed

/-- Apply the preceding result to the actual intersection of two
embedded fields. No simultaneous Galois closure of a coreless span is
assumed: H acts only on the explicitly supplied ambient field. -/
theorem finite_invariant_field_intersection_eq_bot
    {K L : Type*} [Field K] [Field L] [Algebra K L] [IsAlgClosed K]
    (H : Subgroup (L ≃ₐ[K] L)) [Finite H] (A B : IntermediateField K L)
    (hstableA : ∀ (σ : H) (x : L), x ∈ A → σ.val x ∈ A)
    (hstableB : ∀ (σ : H) (x : L), x ∈ B → σ.val x ∈ B)
    (hfixed : A ⊓ B ⊓ IntermediateField.fixedField H = ⊥) : A ⊓ B = ⊥ := by
  apply finite_invariant_intermediate_field_eq_bot H (A ⊓ B) _ hfixed
  intro σ x hx
  exact ⟨hstableA σ x hx.1, hstableB σ x hx.2⟩

end Litt3.QuotientGeometry
