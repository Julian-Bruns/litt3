import Mathlib.RingTheory.PowerSeries.Order
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

variable {k ι : Type*} [CommRing k]

/-- The first possibly nonzero coefficient of a product only sees the
constant term of its second factor. -/
theorem power_series_leading_product_coefficient (f g : PowerSeries k) (n : ℕ)
    (hf : ∀ j < n, PowerSeries.coeff j f = 0) :
    PowerSeries.coeff n (f * g) = PowerSeries.coeff n f * PowerSeries.constantCoeff g := by
  classical
  rw [PowerSeries.coeff_mul, ← PowerSeries.coeff_zero_eq_constantCoeff_apply]
  refine Finset.sum_eq_single (n, 0) ?_ ?_
  · intro x hx hxn
    have hxsum : x.1 + x.2 = n := Finset.mem_antidiagonal.mp hx
    have hlt : x.1 < n := by
      by_contra h
      have hx1 : x.1 = n := by omega
      have hx2 : x.2 = 0 := by omega
      exact hxn (Prod.ext hx1 hx2)
    rw [hf x.1 hlt, zero_mul]
  · simp

theorem power_series_square_second_coefficient (f : PowerSeries k)
    (hzero : PowerSeries.coeff 0 f = 0) :
    PowerSeries.coeff 2 (f ^ 2) = PowerSeries.coeff 1 f ^ 2 := by
  simp [pow_two, PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ,
    Finset.Nat.antidiagonal_zero, hzero]

theorem power_series_square_third_coefficient (f : PowerSeries k)
    (hzero : PowerSeries.coeff 0 f = 0) :
    PowerSeries.coeff 3 (f ^ 2) = 2 * PowerSeries.coeff 1 f * PowerSeries.coeff 2 f := by
  simp [pow_two, PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ,
    Finset.Nat.antidiagonal_zero, hzero]
  ring

theorem power_series_sum_square_second_coefficient (s : Finset ι)
    (node : ι → PowerSeries k) (hzero : ∀ i ∈ s, PowerSeries.coeff 0 (node i) = 0) :
    PowerSeries.coeff 2 (∑ i ∈ s, node i ^ 2) = ∑ i ∈ s, PowerSeries.coeff 1 (node i) ^ 2 := by
  classical
  rw [map_sum]
  exact Finset.sum_congr rfl fun i hi => power_series_square_second_coefficient (node i) (hzero i hi)

theorem power_series_sum_square_third_coefficient (s : Finset ι)
    (node : ι → PowerSeries k) (hzero : ∀ i ∈ s, PowerSeries.coeff 0 (node i) = 0) :
    PowerSeries.coeff 3 (∑ i ∈ s, node i ^ 2) =
      2 * ∑ i ∈ s, PowerSeries.coeff 1 (node i) * PowerSeries.coeff 2 (node i) := by
  classical
  rw [map_sum, Finset.mul_sum]
  exact Finset.sum_congr rfl fun i hi => by
    simpa only [mul_assoc] using power_series_square_third_coefficient (node i) (hzero i hi)

end Litt3.CartierAndSpin
