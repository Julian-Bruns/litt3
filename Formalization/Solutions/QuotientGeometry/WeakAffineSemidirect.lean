import Solutions.QuotientGeometry.WeakTranslationGroup
import Mathlib.RingTheory.RootsOfUnity.Basic
import Mathlib.GroupTheory.SemidirectProduct

namespace Litt3.QuotientGeometry

theorem weak_translation_scalar_mem
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hdiv : h ∣ p - 1) (α γ : k) (ζ : rootsOfUnity h k)
    (b : linearizedTranslationGroup p α γ) :
    (ζ.val : k) * b.val ∈ linearizedTranslationGroup p α γ := by
  have hζ : (ζ.val : k) ^ h = 1 := (mem_rootsOfUnity' h ζ.val).mp ζ.property
  have hfix := tame_scalar_frobenius_fixed p h (Fact.out : p.Prime).one_lt hdiv
    (ζ.val : k) hζ
  change α * ((ζ.val : k) * b.val) ^ p + γ * ((ζ.val : k) * b.val) = 0
  rw [mul_pow, hfix]
  have hb : α * b.val ^ p + γ * b.val = 0 := b.property
  linear_combination (ζ.val : k) * hb

noncomputable def weakTranslationScalarAut
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hdiv : h ∣ p - 1) (α γ : k) (ζ : rootsOfUnity h k) :
    MulAut (WeakTranslationGroup p α γ) where
  toFun b := Multiplicative.ofAdd ⟨(ζ.val : k) * b.toAdd.val,
    weak_translation_scalar_mem p h hdiv α γ ζ b.toAdd⟩
  invFun b := Multiplicative.ofAdd ⟨((ζ⁻¹).val : k) * b.toAdd.val,
    weak_translation_scalar_mem p h hdiv α γ ζ⁻¹ b.toAdd⟩
  left_inv b := by
    apply Multiplicative.ext
    apply Subtype.ext
    change ((ζ⁻¹).val : k) * ((ζ.val : k) * b.toAdd.val) = b.toAdd.val
    simp [← mul_assoc]
  right_inv b := by
    apply Multiplicative.ext
    apply Subtype.ext
    change (ζ.val : k) * (((ζ⁻¹).val : k) * b.toAdd.val) = b.toAdd.val
    simp [← mul_assoc]
  map_mul' a b := by
    apply Multiplicative.ext
    apply Subtype.ext
    change (ζ.val : k) * (a.toAdd.val + b.toAdd.val) =
      (ζ.val : k) * a.toAdd.val + (ζ.val : k) * b.toAdd.val
    exact mul_add _ _ _

noncomputable def weakTranslationScalarAction
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hdiv : h ∣ p - 1) (α γ : k) :
    rootsOfUnity h k →* MulAut (WeakTranslationGroup p α γ) where
  toFun := weakTranslationScalarAut p h hdiv α γ
  map_one' := by
    apply MulEquiv.ext
    intro b
    apply Multiplicative.ext
    apply Subtype.ext
    change (1 : k) * b.toAdd.val = b.toAdd.val
    exact one_mul _
  map_mul' ζ η := by
    apply MulEquiv.ext
    intro b
    apply Multiplicative.ext
    apply Subtype.ext
    change ((ζ * η).val : k) * b.toAdd.val =
      (ζ.val : k) * ((η.val : k) * b.toAdd.val)
    exact mul_assoc _ _ _

abbrev WeakAffineSemidirect
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hdiv : h ∣ p - 1) (α γ : k) :=
  WeakTranslationGroup p α γ ⋊[weakTranslationScalarAction p h hdiv α γ] rootsOfUnity h k

theorem tame_scalar_group_card
    {k : Type*} [Field k] [IsAlgClosed k] (h : ℕ) (hh : 0 < h)
    (hchar : (h : k) ≠ 0) : Nat.card (rootsOfUnity h k) = h := by
  classical
  letI : NeZero h := ⟨hh.ne'⟩
  let s := (Polynomial.X ^ h - Polynomial.C (1 : k)).roots.toFinset
  let e : rootsOfUnity h k ≃ s :=
    { toFun := fun ζ => ⟨(ζ.val : k), (mem_tame_scalar_roots h hh _).mpr
        ((mem_rootsOfUnity' h ζ.val).mp ζ.property)⟩
      invFun := fun ζ => rootsOfUnity.mkOfPowEq ζ.val
        ((mem_tame_scalar_roots h hh _).mp ζ.property)
      left_inv := fun ζ => rootsOfUnity.coe_injective rfl
      right_inv := fun ζ => Subtype.ext rfl }
  rw [Nat.card_congr e, Nat.card_eq_fintype_card, Fintype.card_coe]
  exact tame_scalar_roots_card h hh hchar

/-- Both factors are actual cyclic root groups and the action is actual
scalar multiplication on the p-element additive kernel. -/
theorem weak_affine_semidirect_cyclic_factors_and_card
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (hchar : (h : k) ≠ 0)
    (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    IsCyclic (WeakTranslationGroup p α γ) ∧ Nat.card (WeakTranslationGroup p α γ) = p ∧
      IsCyclic (rootsOfUnity h k) ∧ Nat.card (rootsOfUnity h k) = h ∧
      Nat.card (WeakAffineSemidirect p h hdiv α γ) = p * h := by
  letI : NeZero h := ⟨hh.ne'⟩
  obtain ⟨hcyc, hcard⟩ := weak_translation_group_cyclic_and_card p α γ hα hγ
  have htame := tame_scalar_group_card h hh hchar
  refine ⟨hcyc, hcard, inferInstance, htame, ?_⟩
  rw [Nat.card_congr SemidirectProduct.equivProd, Nat.card_prod, hcard, htame]

end Litt3.QuotientGeometry
