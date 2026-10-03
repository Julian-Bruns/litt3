import Solutions.QuotientGeometry.WeakLaurentNormalForm
import Mathlib.RingTheory.PowerSeries.Derivative

namespace Litt3.CartierAndSpin

open Litt3.QuotientGeometry

variable {k : Type*} [Field k]

theorem laurent_derivative_coefficient_at (f : LaurentSeries k) (r : ℤ) :
    (LaurentSeries.derivative k f).coeff r = (r + 1 : k) * f.coeff (r + 1) := by
  simpa only [add_sub_cancel_right, Int.cast_add, Int.cast_one] using
    laurent_derivative_coefficient f (r + 1)

theorem laurent_single_mul_coefficient (n : ℤ) (a : k) (f : LaurentSeries k) (r : ℤ) :
    (HahnSeries.single n a * f).coeff r = a * f.coeff (r - n) := by
  have h : r = (r - n) + n := by omega
  conv_lhs => rw [h]
  rw [HahnSeries.coeff_single_mul_add]

/-- The actual Leibniz rule for every Laurent monomial times every
Laurent series follows directly from the shifted coefficient formula. -/
theorem laurent_derivative_single_mul (n : ℤ) (a : k) (f : LaurentSeries k) :
    LaurentSeries.derivative k (HahnSeries.single n a * f) =
      HahnSeries.single n a * LaurentSeries.derivative k f +
        HahnSeries.single (n - 1) ((n : k) * a) * f := by
  ext r
  rw [laurent_derivative_coefficient_at, laurent_single_mul_coefficient,
    HahnSeries.coeff_add, laurent_single_mul_coefficient, laurent_derivative_coefficient_at,
    laurent_single_mul_coefficient]
  have hfirst : r + 1 - n = r - n + 1 := by ring
  have hsecond : r - (n - 1) = r - n + 1 := by ring
  rw [hfirst, hsecond]
  simp only [Int.cast_sub]
  ring

/-- Actual Laurent differentiation agrees with actual power-series
differentiation on the embedded power-series ring. -/
theorem laurent_derivative_powerSeries (f : PowerSeries k) :
    LaurentSeries.derivative k (f : LaurentSeries k) =
      (PowerSeries.derivative k f : LaurentSeries k) := by
  ext r
  rw [laurent_derivative_coefficient_at]
  by_cases hr : r < 0
  · have hright : (PowerSeries.derivative k f : LaurentSeries k).coeff r = 0 := by
      simp [PowerSeries.coeff_coe, hr]
    rw [hright]
    by_cases hm : r + 1 = 0
    · have hcast : (r : k) + 1 = 0 := by
        have hrzero : r = -1 := by omega
        simp [hrzero]
      rw [hcast, zero_mul]
    · have hnegative : r + 1 < 0 := by omega
      rw [PowerSeries.coeff_coe, if_pos hnegative, mul_zero]
  · have hrnonnegative : 0 ≤ r := le_of_not_gt hr
    obtain ⟨n, rfl⟩ := Int.eq_ofNat_of_zero_le hrnonnegative
    have hindex : (n : ℤ) + 1 = ((n + 1 : ℕ) : ℤ) := by omega
    simp only [PowerSeries.coeff_coe, hindex, Int.natCast_nonneg, not_lt_of_ge,
      if_false, Int.natAbs_natCast, PowerSeries.coeff_derivative, Int.cast_natCast]
    ring

/-- Laurent differentiation obeys the product rule on the embedded
power-series ring. -/
theorem laurent_derivative_powerSeries_mul (f g : PowerSeries k) :
    LaurentSeries.derivative k ((f : LaurentSeries k) * (g : LaurentSeries k)) =
      (f : LaurentSeries k) * LaurentSeries.derivative k (g : LaurentSeries k) +
        (g : LaurentSeries k) * LaurentSeries.derivative k (f : LaurentSeries k) := by
  rw [← PowerSeries.coe_mul, laurent_derivative_powerSeries,
    (PowerSeries.derivative k).leibniz]
  simp only [smul_eq_mul, PowerSeries.coe_add, PowerSeries.coe_mul,
    laurent_derivative_powerSeries]

/-- The product rule survives arbitrary integer shifts of two embedded
power series, including negative Laurent orders. -/
theorem laurent_derivative_shifted_powerSeries_mul (m n : ℤ) (f g : PowerSeries k) :
    LaurentSeries.derivative k
        ((HahnSeries.single m 1 * (f : LaurentSeries k)) *
          (HahnSeries.single n 1 * (g : LaurentSeries k))) =
      (HahnSeries.single m 1 * (f : LaurentSeries k)) *
        LaurentSeries.derivative k (HahnSeries.single n 1 * (g : LaurentSeries k)) +
      (HahnSeries.single n 1 * (g : LaurentSeries k)) *
        LaurentSeries.derivative k (HahnSeries.single m 1 * (f : LaurentSeries k)) := by
  have hmain : (HahnSeries.single m (1 : k) : LaurentSeries k) *
      HahnSeries.single n 1 = HahnSeries.single (m + n) 1 := by
    simp only [HahnSeries.single_mul_single, one_mul]
  have hproduct :
      (HahnSeries.single m 1 * (f : LaurentSeries k)) *
          (HahnSeries.single n 1 * (g : LaurentSeries k)) =
        HahnSeries.single (m + n) 1 * ((f : LaurentSeries k) * (g : LaurentSeries k)) := by
    rw [← hmain]
    ring
  have hfirst : (HahnSeries.single m (1 : k) : LaurentSeries k) *
      HahnSeries.single (n - 1) (n : k) = HahnSeries.single (m + n - 1) (n : k) := by
    simp only [HahnSeries.single_mul_single, one_mul,
      show m + (n - 1) = m + n - 1 by omega]
  have hsecond : (HahnSeries.single n (1 : k) : LaurentSeries k) *
      HahnSeries.single (m - 1) (m : k) = HahnSeries.single (m + n - 1) (m : k) := by
    simp only [HahnSeries.single_mul_single, one_mul,
      show n + (m - 1) = m + n - 1 by omega]
  have hsum : (HahnSeries.single (m + n - 1) ((m + n : ℤ) : k) : LaurentSeries k) =
      HahnSeries.single (m + n - 1) (n : k) +
        HahnSeries.single (m + n - 1) (m : k) := by
    simp only [← HahnSeries.single_add, Int.cast_add, add_comm]
  rw [hproduct, laurent_derivative_single_mul, laurent_derivative_powerSeries_mul,
    laurent_derivative_single_mul, laurent_derivative_single_mul]
  simp only [mul_one]
  rw [hsum]
  calc
    _ = HahnSeries.single (m + n) 1 *
          ((f : LaurentSeries k) * LaurentSeries.derivative k (g : LaurentSeries k) +
            (g : LaurentSeries k) * LaurentSeries.derivative k (f : LaurentSeries k)) +
        (HahnSeries.single m 1 * HahnSeries.single (n - 1) (n : k) +
          HahnSeries.single n 1 * HahnSeries.single (m - 1) (m : k)) *
          ((f : LaurentSeries k) * (g : LaurentSeries k)) := by rw [hfirst, hsecond]
    _ = _ := by
      rw [← hmain]
      ring

/-- Formal Laurent differentiation satisfies the actual Leibniz rule
on the whole Laurent-series field, without a finite-support assumption. -/
theorem laurent_derivative_leibniz (f g : LaurentSeries k) :
    LaurentSeries.derivative k (f * g) =
      f * LaurentSeries.derivative k g + g * LaurentSeries.derivative k f := by
  have h := laurent_derivative_shifted_powerSeries_mul f.order g.order
    f.powerSeriesPart g.powerSeriesPart
  simpa only [LaurentSeries.single_order_mul_powerSeriesPart] using h

def fieldDerivationOfFunction (R A : Type*) [CommRing R] [Field A] [Algebra R A]
    (f : A → A) (hadd : ∀ x y, f (x + y) = f x + f y)
    (hscalar : ∀ a x, f (algebraMap R A a * x) = algebraMap R A a * f x)
    (hone : f 1 = 0) (hleibniz : ∀ x y, f (x * y) = x * f y + y * f x) :
    Derivation R A A where
  toFun := f
  map_add' := hadd
  map_smul' a x := by simpa only [Algebra.smul_def, RingHom.id_apply] using hscalar a x
  map_one_eq_zero' := hone
  leibniz' x y := by simpa only [smul_eq_mul] using hleibniz x y

/-- The formal Laurent derivative, with its actual product rule,
is a derivation over the coefficient field. -/
def laurentDerivation (k : Type*) [Field k] :=
  fieldDerivationOfFunction k (LaurentSeries k) (fun f => LaurentSeries.derivative k f)
    (fun f g => (LaurentSeries.derivative k (V := k)).map_add f g)
    (by
      intro a f
      dsimp only
      rw [LaurentSeries.algebraMap_apply, HahnSeries.C_apply,
        laurent_derivative_single_mul]
      simp)
    (by
      have h := laurent_derivative_powerSeries (1 : PowerSeries k)
      simpa only [PowerSeries.coe_one, (PowerSeries.derivative k).map_one_eq_zero,
        PowerSeries.coe_zero] using h)
    laurent_derivative_leibniz

theorem laurentDerivation_apply (f : LaurentSeries k) :
    laurentDerivation k f = LaurentSeries.derivative k f := rfl

end Litt3.CartierAndSpin
