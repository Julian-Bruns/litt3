import Solutions.QuotientGeometry.OriginalCoordinateDifferentialRatio
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

theorem original_differential_frame_coefficient_injective
    {k R : Type*} [CommRing k] [CommRing R] [Algebra k R]
    (t : R) (e : R ≃ₗ[R] KaehlerDifferential k R)
    (he : ∀ r : R, e r = r • KaehlerDifferential.D k R t) :
    Function.Injective (fun r : R => r • KaehlerDifferential.D k R t) := by
  intro a b hab
  apply e.injective
  simpa only [he] using hab

/-- The genuine coordinate derivation is UNIQUE. Its construction from
an original uniformizer frame does not make F_z depend on that frame. -/
theorem original_coordinate_derivation_unique
    {k R : Type*} [CommRing k] [CommRing R] [Algebra k R]
    (t z : R) (e : R ≃ₗ[R] KaehlerDifferential k R)
    (he : ∀ r : R, e r = r • KaehlerDifferential.D k R t)
    (q : Rˣ) (hz : KaehlerDifferential.D k R z = q.val • KaehlerDifferential.D k R t)
    (D₁ D₂ : Derivation k R R) (hD₁ : D₁ z = 1) (hD₂ : D₂ z = 1) : D₁ = D₂ := by
  have hco (D : Derivation k R R) (hD : D z = 1) : D t = (q⁻¹ : Rˣ).val := by
    have hd := congrArg D.liftKaehlerDifferential hz
    simp only [Derivation.liftKaehlerDifferential_comp_D, map_smul,
      smul_eq_mul, hD] at hd
    apply q.eq_inv_of_mul_eq_one_left
    exact hd.symm
  have ht : D₁ t = D₂ t := (hco D₁ hD₁).trans (hco D₂ hD₂).symm
  ext a
  have hform : KaehlerDifferential.D k R a =
      e.symm (KaehlerDifferential.D k R a) • KaehlerDifferential.D k R t := by
    rw [← he]
    exact (e.apply_symm_apply _).symm
  have hd₁ := congrArg D₁.liftKaehlerDifferential hform
  have hd₂ := congrArg D₂.liftKaehlerDifferential hform
  simp only [Derivation.liftKaehlerDifferential_comp_D, map_smul, smul_eq_mul] at hd₁ hd₂
  rw [hd₁, hd₂, ht]

theorem coordinate_power_fiber_constraint_iff
    {k : Type*} [Field k] (p : ℕ) (g₁ g₂ s₁ s₂ y₁ y₂ v₁ v₂ : k)
    (hg₁ : g₁ ≠ 0) (hg₂ : g₂ ≠ 0)
    (hy₁ : y₁ ≠ 0) (hy₂ : y₂ ≠ 0) (hv₁ : v₁ ≠ 0) (hv₂ : v₂ ≠ 0)
    (hs₁ : s₁ = (y₁ * v₁)⁻¹) (hs₂ : s₂ = (y₂ * v₂)⁻¹) :
    g₁ ^ 2 * s₁ ^ p = g₂ ^ 2 * s₂ ^ p ↔
      (y₁ * v₁) ^ p / g₁ ^ 2 = (y₂ * v₂) ^ p / g₂ ^ 2 := by
  rw [hs₁, hs₂, inv_pow, inv_pow, ← div_eq_mul_inv, ← div_eq_mul_inv]
  rw [div_eq_div_iff (pow_ne_zero p (mul_ne_zero hy₁ hv₁))
      (pow_ne_zero p (mul_ne_zero hy₂ hv₂)),
    div_eq_div_iff (pow_ne_zero 2 hg₁) (pow_ne_zero 2 hg₂)]
  constructor <;> intro h <;> simpa only [mul_comm] using h.symm

/-- Pairwise equality on a nonempty fiber gives ONE actual nonzero
constant, for the entire fiber rather than a bounded enumerated list. -/
theorem nonzero_fiber_values_constant
    {ι k : Type*} [Nonempty ι] [Zero k] (value : ι → k)
    (hnonzero : ∀ i, value i ≠ 0) (hequal : ∀ i j, value i = value j) :
    ∃ C : k, C ≠ 0 ∧ ∀ i, value i = C := by
  let i₀ : ι := Classical.arbitrary ι
  exact ⟨value i₀, hnonzero i₀, fun i => hequal i i₀⟩

end Litt3.QuotientGeometry
