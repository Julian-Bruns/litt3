import Mathlib.Algebra.Module.LinearMap.Basic
import Mathlib.Tactic.FieldSimp

namespace Litt3.Atlases

variable {k V W : Type*} [Field k]
  [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

/-- The actual normalized vector attached to a genuine nonvanishing
linear chart. It preserves the original residual map, not just the
common-kernel condition. -/
noncomputable def normalizedCommonKernelChartVector
    (κ : k) (ℓ : V →ₗ[k] k) (u : V) : V := (κ / ℓ u) • u

/-- Exact elimination of the normalized vector on ANY linear chart.
All maps and vectors are original, and the actual residual C(v)=β is
retained. No alternating, parity, dimension, characteristic or sampled
rank assumptions are required for this algebraic reconstruction. -/
theorem normalized_common_kernel_chart_equations_iff
    (A₀ A₁ : V →ₗ[k] V) (C : V →ₗ[k] W)
    (β : W) (κ : k) (ℓ : V →ₗ[k] k) (u : V)
    (hκ : κ ≠ 0) (hu : ℓ u ≠ 0) :
    (A₀ (normalizedCommonKernelChartVector κ ℓ u) = 0 ∧
      A₁ (normalizedCommonKernelChartVector κ ℓ u) = 0 ∧
      C (normalizedCommonKernelChartVector κ ℓ u) = β ∧
      ℓ (normalizedCommonKernelChartVector κ ℓ u) = κ) ↔
    (A₀ u = 0 ∧ A₁ u = 0 ∧ κ • C u = ℓ u • β) := by
  have hcoef : κ / ℓ u ≠ 0 := div_ne_zero hκ hu
  have hmul : ℓ u * (κ / ℓ u) = κ := by field_simp
  constructor
  · rintro ⟨h₀, h₁, hC, _⟩
    change A₀ ((κ / ℓ u) • u) = 0 at h₀
    change A₁ ((κ / ℓ u) • u) = 0 at h₁
    rw [map_smul] at h₀ h₁
    have hcancel (x : V) (hx : (κ / ℓ u) • x = 0) : x = 0 := by
      have h := congrArg (fun v : V => (κ / ℓ u)⁻¹ • v) hx
      simpa only [smul_smul, inv_mul_cancel₀ hcoef, one_smul, smul_zero] using h
    refine ⟨hcancel _ h₀, hcancel _ h₁, ?_⟩
    have h := congrArg (fun w : W => ℓ u • w) hC
    change ℓ u • C ((κ / ℓ u) • u) = ℓ u • β at h
    rwa [map_smul, smul_smul, hmul] at h
  · rintro ⟨h₀, h₁, hC⟩
    refine ⟨?_, ?_, ?_, ?_⟩
    · change A₀ ((κ / ℓ u) • u) = 0
      rw [map_smul, h₀, smul_zero]
    · change A₁ ((κ / ℓ u) • u) = 0
      rw [map_smul, h₁, smul_zero]
    · change C ((κ / ℓ u) • u) = β
      rw [map_smul]
      have h := congrArg (fun w : W => (ℓ u)⁻¹ • w) hC
      simpa only [smul_smul, inv_mul_cancel₀ hu, one_smul,
        div_eq_mul_inv, mul_comm] using h
    · change ℓ ((κ / ℓ u) • u) = κ
      rw [map_smul, smul_eq_mul, div_mul_cancel₀ _ hu]

end Litt3.Atlases
