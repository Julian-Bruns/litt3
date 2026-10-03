import Solutions.QuotientGeometry.PowerSeriesLifting
import Solutions.QuotientGeometry.WeakLaurentNormalForm
import Mathlib.Algebra.CharP.Algebra

namespace Litt3.QuotientGeometry

theorem power_series_charP
    {k : Type*} [CommSemiring k] (p : ℕ) [CharP k p] :
    CharP (PowerSeries k) p :=
  charP_of_injective_ringHom PowerSeries.C_injective p

theorem laurent_series_charP
    {k : Type*} [CommSemiring k] (p : ℕ) [CharP k p] :
    CharP (LaurentSeries k) p :=
  charP_of_injective_ringHom HahnSeries.C_injective p

theorem laurent_pole_one_coordinate
    {k : Type*} [Field k] (w : PowerSeries k) :
    (HahnSeries.single (-1) 1 + (w : LaurentSeries k)).order = -1 := by
  let u : LaurentSeries k := HahnSeries.single (-1) 1 + (w : LaurentSeries k)
  have hcoeff : u.coeff (-1) = 1 := by simp [u, PowerSeries.coeff_coe]
  have hne : u ≠ 0 := HahnSeries.ne_zero_of_coeff_ne_zero (by rw [hcoeff]; exact one_ne_zero)
  apply le_antisymm
  · exact HahnSeries.order_le_of_coeff_ne_zero (by rw [hcoeff]; exact one_ne_zero)
  · by_contra h
    have hlow : u.order < -1 := lt_of_not_ge h
    have hzero : u.coeff u.order = 0 := by
      simp [u, PowerSeries.coeff_coe, ne_of_lt hlow, show u.order < 0 by omega]
    exact HahnSeries.coeff_order_ne_zero hne hzero

/-- Hensel lifting removes the entire actual regular tail. The
resulting pole-one coordinate lives in the original Laurent field. -/
theorem weak_laurent_linearized_normal_form
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [CharP k p] (hp : 1 < p)
    (f : LaurentSeries k) (horder : f.order = -(p : ℤ))
    (hderiv : (LaurentSeries.derivative k f).order = -2) :
    ∃ (α γ : k) (w : PowerSeries k), α ≠ 0 ∧ γ ≠ 0 ∧
      let u : LaurentSeries k := HahnSeries.single (-1) 1 + (w : LaurentSeries k)
      u.order = -1 ∧ f = HahnSeries.C α * u ^ p + HahnSeries.C γ * u := by
  haveI := laurent_series_charP (k := k) p
  haveI : Fact p.Prime := ⟨CharP.char_is_prime_of_two_le k p (by omega)⟩
  obtain ⟨α, γ, r, hα, hγ, hnormal⟩ := weak_laurent_normal_form p hp f horder hderiv
  obtain ⟨w, hw⟩ := power_series_two_coefficient_linearized_equation p hp α γ hα hγ r
  refine ⟨α, γ, w, hα, hγ, ?_⟩
  dsimp only
  constructor
  · exact laurent_pole_one_coordinate w
  · have htail := congrArg (fun a : PowerSeries k => (a : LaurentSeries k)) hw
    simp only [PowerSeries.coe_add, PowerSeries.coe_mul, PowerSeries.coe_pow,
      PowerSeries.coe_C] at htail
    rw [hnormal, add_pow_char, mul_add, mul_add]
    have hsingle : (HahnSeries.single (-1) (1 : k) : LaurentSeries k) ^ p =
        HahnSeries.single (-(p : ℤ)) 1 := by
      simp [HahnSeries.single_pow]
    rw [hsingle]
    have hαsingle : (HahnSeries.C α : LaurentSeries k) * HahnSeries.single (-(p : ℤ)) 1 =
        HahnSeries.single (-(p : ℤ)) α := by
      simp [HahnSeries.C_apply, HahnSeries.single_mul_single]
    have hγsingle : (HahnSeries.C γ : LaurentSeries k) * HahnSeries.single (-1) 1 =
        HahnSeries.single (-1) γ := by
      simp [HahnSeries.C_apply, HahnSeries.single_mul_single]
    rw [hαsingle, hγsingle, ← htail]
    ring

end Litt3.QuotientGeometry
