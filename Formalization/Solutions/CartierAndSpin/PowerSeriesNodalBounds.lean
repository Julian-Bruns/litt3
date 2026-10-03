import Solutions.CartierAndSpin.PowerSeriesRootResidues
import Solutions.SharedTensors.UniformRootValuationBounds

namespace Litt3.CartierAndSpin

open Polynomial

variable {k ι : Type*} [Field k]

theorem power_series_laurent_order_lower_bound (f : PowerSeries k) (m : ℕ)
    (hf : ∀ j < m, PowerSeries.coeff j f = 0) :
    ((m : ℤ) : WithTop ℤ) ≤ (f : LaurentSeries k).orderTop := by
  apply Litt3.QuotientGeometry.laurent_orderTop_lower_bound_of_coefficients
  intro n hn
  rw [PowerSeries.coeff_coe]
  by_cases hneg : n < 0
  · rw [if_pos hneg]
  · rw [if_neg hneg]
    apply hf
    have hnonneg : 0 ≤ n := le_of_not_gt hneg
    have habs : (n.natAbs : ℤ) = n := by rw [Int.natCast_natAbs, abs_of_nonneg hnonneg]
    omega

theorem power_series_coefficient_zero_of_laurent_order (f : PowerSeries k) (m j : ℕ)
    (hf : ((m : ℤ) : WithTop ℤ) ≤ (f : LaurentSeries k).orderTop) (hj : j < m) :
    PowerSeries.coeff j f = 0 := by
  have hz := HahnSeries.coeff_eq_zero_of_lt_orderTop
    ((WithTop.coe_lt_coe.mpr (by exact_mod_cast hj : (j : ℤ) < m)).trans_le hf)
  simpa only [PowerSeries.coeff_coe, Int.natCast_nonneg, not_lt, if_false, Int.natAbs_natCast] using hz

/-- Every coefficient of the actual small-root polynomial has the
root-product order bound, including repeated leading jets and zero roots. -/
theorem power_series_nodal_coefficient_low_zero (s : Finset ι) (node : ι → PowerSeries k)
    (hnode : ∀ i ∈ s, PowerSeries.constantCoeff (node i) = 0)
    (j : ℕ) (hj : j ≤ s.card) (l : ℕ) (hl : l < s.card - j) :
    PowerSeries.coeff l ((Lagrange.nodal s node).coeff j) = 0 := by
  have hs : ∀ i ∈ s, (1 : WithTop ℤ) ≤ (node i : LaurentSeries k).orderTop := by
    intro i hi
    apply power_series_laurent_order_lower_bound (node i) 1
    intro n hn
    have hn0 : n = 0 := by omega
    subst n
    exact (PowerSeries.coeff_zero_eq_constantCoeff_apply _).trans (hnode i hi)
  have hb := Litt3.SharedTensors.laurent_nodal_coeff_orderTop_bound s
    (fun i => (node i : LaurentSeries k)) 1 hs j hj
  rw [← polynomial_map_nodal (HahnSeries.ofPowerSeries ℤ k), Polynomial.coeff_map] at hb
  apply power_series_coefficient_zero_of_laurent_order _ (s.card - j) l _ hl
  simpa only [mul_one] using hb

end Litt3.CartierAndSpin
