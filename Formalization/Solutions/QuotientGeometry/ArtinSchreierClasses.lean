import Definitions.QuotientGeometry.ArtinSchreierClasses
import Solutions.QuotientGeometry.ArtinSchreierPoles
import Solutions.QuotientGeometry.WeakLaurentLinearization

namespace Litt3.QuotientGeometry

theorem artin_schreier_class_eq_zero_iff
    {R : Type*} [CommRing R] (p : ℕ) [Fact p.Prime] [CharP R p] (f : R) :
    artinSchreierClass p f = 0 ↔ ∃ v : R, v ^ p - v = f := by
  change QuotientAddGroup.mk f = 0 ↔ _
  rw [QuotientAddGroup.eq_zero_iff]
  rfl

theorem artin_schreier_class_eq_iff
    {R : Type*} [CommRing R] (p : ℕ) [Fact p.Prime] [CharP R p] (f g : R) :
    artinSchreierClass p f = artinSchreierClass p g ↔
      ∃ v : R, v ^ p - v = f - g := by
  rw [← sub_eq_zero]
  simp only [artinSchreierClass, ← QuotientAddGroup.mk_sub]
  change artinSchreierClass p (f - g) = 0 ↔ _
  exact artin_schreier_class_eq_zero_iff p (f - g)

theorem laurent_nonzero_scalar_pole_order
    {k : Type*} [Field k] (c : k) (hc : c ≠ 0)
    (ψ : LaurentSeries k) (hψ : ψ ≠ 0) :
    (HahnSeries.C c * ψ).order = ψ.order := by
  rw [HahnSeries.order_mul (HahnSeries.C_ne_zero hc) hψ, HahnSeries.order_C, zero_add]

theorem laurent_pole_one_scalar_coboundary_iff
    {k : Type*} [Field k] (p : ℕ) (hp : 1 < p)
    (ψ : LaurentSeries k) (hψ : ψ.order = -1) (c : k) :
    (∃ v : LaurentSeries k, v ^ p - v = HahnSeries.C c * ψ) ↔ c = 0 := by
  constructor
  · rintro ⟨v, hv⟩
    by_contra hc
    have hψzero : ψ ≠ 0 := by intro hzero; simp [hzero] at hψ
    have hpole : (HahnSeries.C c * ψ).order = -1 := by
      rw [laurent_nonzero_scalar_pole_order c hc ψ hψzero, hψ]
    exact laurent_pole_one_not_power_sub_self p hp _ hpole v hv
  · intro hc
    subst c
    exact ⟨0, by simp [show p ≠ 0 by omega]⟩

/-- The same-line condition for actual Laurent coboundary classes is
exactly equality of the scalar (p−1)-st powers. No abstract extension
classification is assumed. -/
theorem laurent_artin_schreier_lines_iff
    {k : Type*} [Field k] (p : ℕ) (hp : 1 < p)
    (ψ : LaurentSeries k) (hψ : ψ.order = -1)
    (a b : k) (ha : a ≠ 0) (hb : b ≠ 0) :
    LaurentArtinSchreierLineEquivalent p a b ψ ↔ a ^ (p - 1) = b ^ (p - 1) := by
  constructor
  · rintro ⟨c, hc, hcp, v, hv⟩
    have hdifference : a - c * b = 0 := by
      apply (laurent_pole_one_scalar_coboundary_iff p hp ψ hψ (a - c * b)).mp
      refine ⟨v, ?_⟩
      rw [map_sub, sub_mul]
      exact hv.symm
    have hconstant : c ^ (p - 1) = 1 := by
      apply mul_right_cancel₀ hc
      rw [one_mul, ← pow_succ, Nat.sub_add_cancel (by omega : 1 ≤ p)]
      exact hcp
    rw [sub_eq_zero] at hdifference
    rw [hdifference, mul_pow, hconstant, one_mul]
  · intro hpower
    let c := a / b
    have hc : c ≠ 0 := div_ne_zero ha hb
    have hconstant : c ^ (p - 1) = 1 := by
      dsimp only [c]
      rw [div_pow, hpower, div_self (pow_ne_zero _ hb)]
    have hcp : c ^ p = c := by
      calc
        c ^ p = c ^ ((p - 1) + 1) := by rw [Nat.sub_add_cancel (by omega : 1 ≤ p)]
        _ = c ^ (p - 1) * c := pow_succ _ _
        _ = c := by rw [hconstant, one_mul]
    refine ⟨c, hc, hcp, 0, ?_⟩
    have hcb : c * b = a := div_mul_cancel₀ a hb
    simp [hcb, show p ≠ 0 by omega]

end Litt3.QuotientGeometry
