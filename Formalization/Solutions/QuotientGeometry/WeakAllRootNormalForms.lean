import Solutions.QuotientGeometry.WeakDifferentProfilePairs
import Solutions.CartierAndSpin.LaurentDerivation

namespace Litt3.QuotientGeometry

/-- Every root of the SAME element has the same pole and derivative
orders when the tame root degree divides p-1. These orders are not
required anew for a different root choice. -/
theorem weak_tame_all_root_orders
    {k : Type*} [Field k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hh : 0 < h) (hdiv : h ∣ p - 1)
    (ψ χ : LaurentSeries k) (hroot : ψ ^ h = χ ^ h)
    (ho : ψ.order = -(p : ℤ)) (hd : (LaurentSeries.derivative k ψ).order = -2) :
    χ.order = -(p : ℤ) ∧ (LaurentSeries.derivative k χ).order = -2 := by
  have hψ : ψ ≠ 0 := by
    intro hz
    simp only [hz, HahnSeries.order_zero] at ho
    have hp : 0 < p := (Fact.out : p.Prime).pos
    omega
  have hDψ : LaurentSeries.derivative k ψ ≠ 0 := by
    intro hz
    simp only [hz, HahnSeries.order_zero] at hd
    omega
  obtain ⟨ζ, hζ, _, _, hχ⟩ :=
    laurent_tame_roots_differ_by_constant p h hh hdiv ψ χ hψ hroot
  have hC : (HahnSeries.C ζ : LaurentSeries k) ≠ 0 := by
    simpa only [HahnSeries.C_apply] using
      (HahnSeries.single_ne_zero hζ : (HahnSeries.single (0 : ℤ) ζ) ≠ 0)
  have hCo : (HahnSeries.C ζ : LaurentSeries k).order = 0 := by
    simpa only [HahnSeries.C_apply] using
      (HahnSeries.order_single hζ : (HahnSeries.single (0 : ℤ) ζ).order = 0)
  have hDχ : LaurentSeries.derivative k χ = HahnSeries.C ζ * LaurentSeries.derivative k ψ := by
    rw [hχ, HahnSeries.C_apply, Litt3.CartierAndSpin.laurent_derivative_single_mul]
    simp
  constructor
  · rw [hχ, HahnSeries.order_mul hC hψ, hCo, zero_add]
    exact ho
  · rw [hDχ, HahnSeries.order_mul hC hDψ, hCo, zero_add]
    exact hd

theorem weak_pole_scalar_ne_zero_of_orders
    {k : Type*} [Field k] (p : ℕ) (hp : 0 < p) (ψ : LaurentSeries k)
    (ho : ψ.order = -(p : ℤ)) (hd : (LaurentSeries.derivative k ψ).order = -2) :
    weakPoleScalar p ψ ≠ 0 := by
  have hψ : ψ ≠ 0 := by
    intro hz
    simp only [hz, HahnSeries.order_zero] at ho
    omega
  have hDψ : LaurentSeries.derivative k ψ ≠ 0 := by
    intro hz
    simp only [hz, HahnSeries.order_zero] at hd
    omega
  have hα : ψ.coeff (-(p : ℤ)) ≠ 0 := by
    simpa only [ho] using HahnSeries.coeff_order_ne_zero hψ
  have hγ : ψ.coeff (-1) ≠ 0 := by
    have hc := HahnSeries.coeff_order_ne_zero hDψ
    rw [hd] at hc
    have he : (LaurentSeries.derivative k ψ).coeff (-2) = -ψ.coeff (-1) := by
      simpa using laurent_derivative_coefficient ψ (-1)
    rw [he] at hc
    exact neg_ne_zero.mp hc
  exact div_ne_zero (neg_ne_zero.mpr hα) (pow_ne_zero p hγ)

/-- The ORIGINAL separating trace-different profile proves the genuine
two-pole full Laurent expansion, nonzero scalar and both orders for
EVERY h-th root of the actual downstairs pole parameter. -/
theorem weak_original_different_all_roots_normal_form
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p] [Fact p.Prime]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1) (hchar : (h : k) ≠ 0)
    (b c : PowerSeries k) (hb : b = PowerSeries.X ^ (p * h) * c)
    (hc : PowerSeries.constantCoeff c ≠ 0) (hb0 : PowerSeries.constantCoeff b = 0)
    (hprofile : weakCompletedDifferentProfile p h hp hh b c hb hc hb0)
    (χ : LaurentSeries k) (hχ : χ ^ h = (b : LaurentSeries k)⁻¹) :
    χ.order = -(p : ℤ) ∧ (LaurentSeries.derivative k χ).order = -2 ∧
      weakPoleScalar p χ ≠ 0 ∧
      ∃ (α γ : k) (r : PowerSeries k), α ≠ 0 ∧ γ ≠ 0 ∧
        χ = HahnSeries.single (-(p : ℤ)) α + HahnSeries.single (-1) γ +
          (r : LaurentSeries k) := by
  obtain ⟨ψ, hr, ho, hd, _, _⟩ :=
    weak_different_profile_classification p h hp hh hdiv hchar b c hb hc hb0 hprofile
  obtain ⟨hχo, hχd⟩ := weak_tame_all_root_orders p h hh hdiv ψ χ (hr.trans hχ.symm) ho hd
  exact ⟨hχo, hχd, weak_pole_scalar_ne_zero_of_orders p (by omega) χ hχo hχd,
    weak_laurent_normal_form p hp χ hχo hχd⟩

end Litt3.QuotientGeometry
