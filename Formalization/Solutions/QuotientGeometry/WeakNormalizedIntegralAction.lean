import Solutions.QuotientGeometry.WeakNormalizedIntegralAutomorphisms
import Solutions.QuotientGeometry.CompletedLowerRamification

namespace Litt3.QuotientGeometry

noncomputable def weakNormalizedIntegralAction
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    WeakNormalizedAutomorphisms p h hh α γ hα →* (PowerSeries k ≃ₐ[k] PowerSeries k) where
  toFun σ := (weak_normalized_automorphism_power_series p h hh hdiv α γ hα hγ σ).choose
  map_one' := by
    apply AlgEquiv.ext
    intro f
    apply (HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k))
    exact (weak_normalized_automorphism_power_series p h hh hdiv α γ hα hγ 1).choose_spec f |>.symm
  map_mul' σ τ := by
    apply AlgEquiv.ext
    intro f
    apply (HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k))
    rw [AlgEquiv.mul_apply]
    rw [← (weak_normalized_automorphism_power_series p h hh hdiv α γ hα hγ (σ * τ)).choose_spec,
      ← (weak_normalized_automorphism_power_series p h hh hdiv α γ hα hγ σ).choose_spec,
      ← (weak_normalized_automorphism_power_series p h hh hdiv α γ hα hγ τ).choose_spec]
    rfl

theorem weak_normalized_integral_action_compatible
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0)
    (σ : WeakNormalizedAutomorphisms p h hh α γ hα) (f : PowerSeries k) :
    σ.val (f : LaurentSeries k) =
      ((weakNormalizedIntegralAction p h hh hdiv α γ hα hγ σ) f : PowerSeries k) :=
  (weak_normalized_automorphism_power_series p h hh hdiv α γ hα hγ σ).choose_spec f

/-- Actual valuations of all Laurent elements are preserved by every
member of the entire normalized base-field automorphism group. -/
theorem weak_normalized_automorphism_laurent_order
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0)
    (σ : WeakNormalizedAutomorphisms p h hh α γ hα) (f : LaurentSeries k) :
    (σ.val f).order = f.order :=
  compatible_laurent_equiv_order
    (weakNormalizedIntegralAction p h hh hdiv α γ hα hγ σ).toRingEquiv σ.val
    (weak_normalized_integral_action_compatible p h hh hdiv α γ hα hγ σ) f

noncomputable def weakNormalizedLowerRamificationGroup
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0)
    (n : ℕ) : Subgroup (WeakNormalizedAutomorphisms p h hh α γ hα) :=
  (completedLowerRamificationGroup k n).comap
    (weakNormalizedIntegralAction p h hh hdiv α γ hα hγ)

theorem weak_normalized_lower_ramification_uniformizer_iff
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0)
    (σ : WeakNormalizedAutomorphisms p h hh α γ hα) (n : ℕ) :
    σ ∈ weakNormalizedLowerRamificationGroup p h hh hdiv α γ hα hγ n ↔
      ((n + 1 : ℕ) : ℕ∞) ≤ PowerSeries.order
        ((weakNormalizedIntegralAction p h hh hdiv α γ hα hγ σ) PowerSeries.X - PowerSeries.X) :=
  completed_lower_ramification_uniformizer_iff _ n

end Litt3.QuotientGeometry
