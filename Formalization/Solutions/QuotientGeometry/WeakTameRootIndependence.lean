import Definitions.QuotientGeometry.WeakPoleScalar
import Solutions.QuotientGeometry.PoleOneArtinSchreierClasses
import Solutions.QuotientGeometry.WeakTameRootCounts

namespace Litt3.QuotientGeometry

theorem laurent_constant_mul_coefficient
    {k : Type*} [Field k] (ζ : k) (ψ : LaurentSeries k) (n : ℤ) :
    (HahnSeries.C ζ * ψ).coeff n = ζ * ψ.coeff n := by
  rw [HahnSeries.C_apply, ← add_zero n, HahnSeries.coeff_single_mul_add]
  simp

theorem weak_pole_scalar_frobenius_scaling
    {k : Type*} [Field k] (p : ℕ) (ζ : k) (hζ : ζ ≠ 0) (hζp : ζ ^ p = ζ)
    (ψ : LaurentSeries k) : weakPoleScalar p (HahnSeries.C ζ * ψ) = weakPoleScalar p ψ := by
  simp only [weakPoleScalar, laurent_constant_mul_coefficient, mul_pow, hζp]
  rw [← mul_neg]
  exact mul_div_mul_left _ _ hζ

/-- Two actual h-th roots of the SAME actual Laurent element differ
by a genuine constant in the prime subfield when h divides p−1. -/
theorem laurent_tame_roots_differ_by_constant
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (ψ χ : LaurentSeries k) (hψ : ψ ≠ 0)
    (hpowers : ψ ^ h = χ ^ h) :
    ∃ ζ : k, ζ ≠ 0 ∧ ζ ^ h = 1 ∧ ζ ^ p = ζ ∧ χ = HahnSeries.C ζ * ψ := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  let z := χ / ψ
  have hz : z ^ h = 1 := by
    rw [show z = χ / ψ from rfl, div_pow, ← hpowers, div_self (pow_ne_zero h hψ)]
  have hzp : z ^ p = z := tame_scalar_frobenius_fixed p h hp hdiv z hz
  obtain ⟨ζ, hζ, hζp⟩ := laurent_frobenius_fixed_constant p z hzp
  have hζh : ζ ^ h = 1 := by
    apply (HahnSeries.C : k →+* LaurentSeries k).injective
    rw [map_pow, ← hζ, hz, map_one]
  have hζzero : ζ ≠ 0 := by
    intro hzero
    rw [hzero, zero_pow hh.ne'] at hζh
    exact zero_ne_one hζh
  refine ⟨ζ, hζzero, hζh, hζp, ?_⟩
  rw [← hζ]
  exact (div_mul_cancel₀ χ hψ).symm

theorem weak_tame_root_scalar_independent
    {k : Type*} [Field k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1) (ψ χ : LaurentSeries k) (hψ : ψ ≠ 0)
    (hpowers : ψ ^ h = χ ^ h) : weakPoleScalar p ψ = weakPoleScalar p χ := by
  obtain ⟨ζ, hζ, _, hζp, hχ⟩ := laurent_tame_roots_differ_by_constant p h hh hdiv ψ χ hψ hpowers
  rw [hχ, weak_pole_scalar_frobenius_scaling p ζ hζ hζp ψ]

end Litt3.QuotientGeometry
