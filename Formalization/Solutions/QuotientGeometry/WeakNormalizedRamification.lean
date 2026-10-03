import Solutions.QuotientGeometry.WeakNormalizedIntegralAction
import Solutions.QuotientGeometry.AffineUniformizerDisplacement

namespace Litt3.QuotientGeometry

theorem weak_normalized_affine_uniformizer_displacement_order
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0)
    (ζ : rootsOfUnity h k) (b : linearizedTranslationGroup p α γ) :
    PowerSeries.order
      ((weakNormalizedIntegralAction p h hh hdiv α γ hα hγ
        (weakNormalizedAffineAutomorphism p h hh hdiv α γ hα ζ b)) PowerSeries.X - PowerSeries.X) =
      affineUniformizerDisplacementOrder (ζ.val : k) b.val := by
  rw [compatible_affine_pole_uniformizer _ _
    (weak_normalized_integral_action_compatible p h hh hdiv α γ hα hγ _)
    (ζ.val : k) b.val ζ.val.ne_zero
    (weak_normalized_affine_automorphism_pole p h hh hdiv α γ hα ζ b)]
  exact affine_uniformizer_displacement_order _ _ ζ.val.ne_zero

theorem weak_normalized_affine_lower_ramification_iff
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0)
    (ζ : rootsOfUnity h k) (b : linearizedTranslationGroup p α γ) (n : ℕ) :
    weakNormalizedAffineAutomorphism p h hh hdiv α γ hα ζ b ∈
      weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ n ↔
      n = 0 ∨ ((ζ.val : k) = 1 ∧ (n = 1 ∨ b.val = 0)) := by
  classical
  rw [weak_normalized_lower_ramification_uniformizer_iff,
    weak_normalized_affine_uniformizer_displacement_order]
  unfold affineUniformizerDisplacementOrder
  by_cases hz : (ζ.val : k) = 1
  · by_cases hb : b.val = 0
    · simp [hz, hb]
    · simp [hz, hb]
      norm_cast
      omega
  · simp [hz]
    norm_cast
    omega

/-- All actual automorphisms are inertia: the genuine G_0 condition
holds for every integral series, not merely for a labeled generator. -/
theorem weak_normalized_lower_ramification_zero
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ 0 = ⊤ := by
  apply le_antisymm le_top
  intro σ _
  obtain ⟨z, rfl⟩ := (weak_normalized_affine_automorphism_bijective
    p h hh hdiv α γ hα hγ).2 σ
  exact (weak_normalized_affine_lower_ramification_iff p h hh hdiv α γ hα hγ z.1 z.2 0).mpr
    (Or.inl rfl)

theorem weak_normalized_lower_ramification_one_iff
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0)
    (ζ : rootsOfUnity h k) (b : linearizedTranslationGroup p α γ) :
    weakNormalizedAffineAutomorphism p h hh hdiv α γ hα ζ b ∈
      weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ 1 ↔ ζ = 1 := by
  rw [weak_normalized_affine_lower_ramification_iff]
  simp only [one_ne_zero, false_or, true_or, and_true]
  constructor
  · intro hz
    apply rootsOfUnity.coe_injective
    simpa using hz
  · intro hz
    simp [hz]

/-- The entire actual lower filtration is trivial from G_2 onward. -/
theorem weak_normalized_lower_ramification_ge_two
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0)
    (n : ℕ) (hn : 2 ≤ n) :
    weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ n = ⊥ := by
  apply le_antisymm _ bot_le
  intro σ hσ
  obtain ⟨z, rfl⟩ := (weak_normalized_affine_automorphism_bijective
    p h hh hdiv α γ hα hγ).2 σ
  have hz := (weak_normalized_affine_lower_ramification_iff p h hh hdiv α γ hα hγ
    z.1 z.2 n).mp hσ
  have hz0 : (z.1.val : k) = 1 ∧ z.2.val = 0 := by
    rcases hz with hzero | ⟨hζ, hone | hb⟩
    · omega
    · omega
    · exact ⟨hζ, hb⟩
  rw [Subgroup.mem_bot]
  apply weak_normalized_automorphism_pole_injective p h hh hdiv α γ hα hγ
  dsimp only
  rw [weak_normalized_affine_automorphism_pole, hz0.1, hz0.2]
  simp

end Litt3.QuotientGeometry
