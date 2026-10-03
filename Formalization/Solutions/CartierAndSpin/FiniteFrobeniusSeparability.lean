import Mathlib.FieldTheory.SeparablyGenerated
import Mathlib.FieldTheory.PurelyInseparable.PerfectClosure
import Mathlib.LinearAlgebra.Dimension.OrzechProperty
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Module Submodule IntermediateField

variable {F E : Type*} [Field F] [Field E] [Algebra F E]
variable {p : ℕ} [Fact p.Prime] [CharP F p] [CharP E p]

/-- If actual p-th powers linearly span a finite extension, p-th powers
of every actual basis still span it. -/
theorem basis_powers_span_of_frobenius_span_top
    (hspan : Submodule.span F (Set.range (fun x : E => x ^ p)) = ⊤)
    {ι : Type*} (b : Basis ι F E) :
    Submodule.span F (Set.range (fun i => b i ^ p)) = ⊤ := by
  apply le_antisymm le_top
  rw [← hspan]
  apply Submodule.span_le.mpr
  rintro _ ⟨x, rfl⟩
  have hx : x ∈ Submodule.span F (Set.range b) := by rw [b.span_eq]; trivial
  have h := Submodule.image_span_subset_span (LinearMap.frobenius F E p)
    (Set.range b) ⟨x, hx, rfl⟩
  simpa only [LinearMap.frobenius_def, ← Set.range_comp] using h

/-- The finite-dimensional converse to the standard Frobenius spanning
lemma: actual p-th-power spanning implies actual separability. -/
theorem finite_separable_of_frobenius_span_top [FiniteDimensional F E]
    (hspan : Submodule.span F (Set.range (fun x : E => x ^ p)) = ⊤) :
    Algebra.IsSeparable F E := by
  have Hind : ∀ s : Finset E,
      LinearIndepOn F _root_.id (s : Set E) →
        LinearIndepOn F (fun x : E => x ^ p) (s : Set E) := by
    intro s hs
    let ι := hs.extend (Set.subset_univ (s : Set E))
    let b : Basis ι F E := Basis.extend hs
    letI : Fintype ι := FiniteDimensional.fintypeBasisIndex b
    have H := linearIndependent_of_top_le_span_of_card_eq_finrank
      (basis_powers_span_of_frobenius_span_top hspan b).ge
      (Module.finrank_eq_card_basis b).symm
    let f : ↥(s : Set E) → ↥ι := fun x => ⟨x.val, hs.subset_extend _ x.property⟩
    have hfinj : Function.Injective f := by
      intro x y h
      apply Subtype.ext
      exact congrArg (fun z : ↥ι => z.val) h
    change LinearIndependent F (fun x : ↥(s : Set E) => x.val ^ p)
    convert H.comp f hfinj using 1
    funext x
    exact congrArg (fun z : E => z ^ p) (Basis.extend_apply_self hs (f x)).symm
  obtain ⟨s, hbasis, hseparable⟩ :=
    exists_isTranscendenceBasis_and_isSeparable_of_linearIndepOn_pow_of_fg
      p (Fact.out : p.Prime) Hind (IntermediateField.fg_of_noetherian ⊤)
  haveI : IsEmpty (s : Set E) := hbasis.isEmpty_iff_isAlgebraic.mpr inferInstance
  have hs : s = ∅ := by
    apply Finset.eq_empty_iff_forall_notMem.mpr
    intro x hx
    exact isEmptyElim (⟨x, hx⟩ : (s : Set E))
  have hfield : IntermediateField.adjoin F (s : Set E) = ⊥ := by
    rw [hs, Finset.coe_empty, IntermediateField.adjoin_empty]
  rw [hfield] at hseparable
  letI : Algebra.IsSeparable (⊥ : IntermediateField F E) E := hseparable
  exact Algebra.isSeparable_tower_top_of_isSeparable (⊥ : IntermediateField F E) F E

end Litt3.CartierAndSpin
