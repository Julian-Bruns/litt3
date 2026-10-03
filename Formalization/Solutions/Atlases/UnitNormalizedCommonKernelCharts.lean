import Mathlib.Algebra.Module.LinearMap.Basic

namespace Litt3.Atlases

variable {R V W : Type*} [CommRing R]
  [AddCommGroup V] [Module R V] [AddCommGroup W] [Module R W]

/-- Original normalized reconstruction over an arbitrary coefficient
ring, with genuine units as the precise localized-chart hypotheses. -/
noncomputable def unitNormalizedCommonKernelChartVector
    (κ h : Rˣ) (u : V) : V := ((κ * h⁻¹ : Rˣ) : R) • u

/-- Exact normalized chart equations over ANY commutative ring and
ANY original modules. This supports genuine localized coefficient-ring
inverse morphisms, rather than only field-valued geometric points.
Both original kernel equations and the ACTUAL residual C(v)=β survive. -/
theorem unit_normalized_common_kernel_chart_equations_iff
    (A₀ A₁ : V →ₗ[R] V) (C : V →ₗ[R] W)
    (β : W) (κ h : Rˣ) (ℓ : V →ₗ[R] R) (u : V)
    (hu : ℓ u = (h : R)) :
    (A₀ (unitNormalizedCommonKernelChartVector κ h u) = 0 ∧
      A₁ (unitNormalizedCommonKernelChartVector κ h u) = 0 ∧
      C (unitNormalizedCommonKernelChartVector κ h u) = β ∧
      ℓ (unitNormalizedCommonKernelChartVector κ h u) = (κ : R)) ↔
    (A₀ u = 0 ∧ A₁ u = 0 ∧ (κ : R) • C u = (h : R) • β) := by
  let α : Rˣ := κ * h⁻¹
  have hmul : (h : R) * (α : R) = (κ : R) := by
    change (h : R) * ((κ : R) * (↑h⁻¹ : R)) = (κ : R)
    rw [mul_left_comm, Units.mul_inv, mul_one]
  have hinv : (↑h⁻¹ : R) * (κ : R) = (α : R) := by
    change (↑h⁻¹ : R) * (κ : R) = (κ : R) * (↑h⁻¹ : R)
    exact mul_comm _ _
  constructor
  · rintro ⟨h₀, h₁, hC, _⟩
    change A₀ ((α : R) • u) = 0 at h₀
    change A₁ ((α : R) • u) = 0 at h₁
    rw [map_smul] at h₀ h₁
    have hcancel (x : V) (hx : (α : R) • x = 0) : x = 0 := by
      have hz := congrArg (fun v : V => (↑α⁻¹ : R) • v) hx
      simpa only [smul_smul, Units.inv_mul, one_smul, smul_zero] using hz
    refine ⟨hcancel _ h₀, hcancel _ h₁, ?_⟩
    have hz := congrArg (fun w : W => (h : R) • w) hC
    change (h : R) • C ((α : R) • u) = (h : R) • β at hz
    rwa [map_smul, smul_smul, hmul] at hz
  · rintro ⟨h₀, h₁, hC⟩
    refine ⟨?_, ?_, ?_, ?_⟩
    · change A₀ ((α : R) • u) = 0
      rw [map_smul, h₀, smul_zero]
    · change A₁ ((α : R) • u) = 0
      rw [map_smul, h₁, smul_zero]
    · change C ((α : R) • u) = β
      rw [map_smul]
      have hz := congrArg (fun w : W => (↑h⁻¹ : R) • w) hC
      simpa only [smul_smul, hinv, Units.inv_mul, one_smul] using hz
    · change ℓ ((α : R) • u) = (κ : R)
      rw [map_smul, smul_eq_mul, hu, mul_comm, hmul]

end Litt3.Atlases
