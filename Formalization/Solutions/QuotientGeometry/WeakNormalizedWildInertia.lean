import Solutions.QuotientGeometry.WeakNormalizedRamification
import Solutions.QuotientGeometry.WeakNormalizedSemidirect

namespace Litt3.QuotientGeometry

noncomputable def weakNormalizedWildHom
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    WeakTranslationGroup p α γ →*
      weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ 1 :=
  ((weakNormalizedSemidirectHom p h hh hdiv α γ hα hγ).comp SemidirectProduct.inl).codRestrict
    (weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ 1) (by
      intro b
      change (weakNormalizedAffineAutomorphism p h hh hdiv α γ hα 1 b.toAdd)⁻¹ ∈ _
      rw [Subgroup.inv_mem_iff]
      exact (weak_normalized_lower_ramification_one_iff p h hh hdiv α γ hα hγ 1 b.toAdd).mpr rfl)

theorem weak_normalized_wild_hom_bijective
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    Function.Bijective (weakNormalizedWildHom p h hh hdiv α γ hα hγ) := by
  constructor
  · intro b c heq
    have heq' := congrArg Subtype.val heq
    exact SemidirectProduct.inl_injective
      ((weak_normalized_semidirect_hom_bijective p h hh hdiv α γ hα hγ).1 heq')
  · intro σ
    have hinv : σ.val⁻¹ ∈ weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ 1 :=
      Subgroup.inv_mem _ σ.property
    obtain ⟨z, hz⟩ := (weak_normalized_affine_automorphism_bijective
      p h hh hdiv α γ hα hγ).2 σ.val⁻¹
    dsimp only at hz
    have hmem : weakNormalizedAffineAutomorphism p h hh hdiv α γ hα z.1 z.2 ∈
        weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ 1 := by
      rw [hz]
      exact hinv
    have hζ : z.1 = 1 := (weak_normalized_lower_ramification_one_iff
      p h hh hdiv α γ hα hγ z.1 z.2).mp hmem
    refine ⟨Multiplicative.ofAdd z.2, Subtype.ext ?_⟩
    change (weakNormalizedAffineAutomorphism p h hh hdiv α γ hα 1 z.2)⁻¹ = σ.val
    rw [← hζ, hz, inv_inv]

noncomputable def weakNormalizedWildEquiv
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    WeakTranslationGroup p α γ ≃*
      weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ 1 :=
  MulEquiv.ofBijective (weakNormalizedWildHom p h hh hdiv α γ hα hγ)
    (weak_normalized_wild_hom_bijective p h hh hdiv α γ hα hγ)

/-- The actual first lower ramification group is cyclic of order p. -/
theorem weak_normalized_wild_inertia_cyclic_and_card
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    IsCyclic (weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ 1) ∧
      Nat.card (weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ 1) = p := by
  let e := weakNormalizedWildEquiv p h hh hdiv α γ hα hγ
  obtain ⟨hcyc, hcard⟩ := weak_translation_group_cyclic_and_card p α γ hα hγ
  letI := hcyc
  exact ⟨isCyclic_of_surjective e e.surjective, (Nat.card_congr e.toEquiv).symm.trans hcard⟩

end Litt3.QuotientGeometry
