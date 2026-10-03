import Definitions.CartierAndSpin.LaurentWeightedRescale
import Solutions.CartierAndSpin.LaurentEndpointBounds

namespace Litt3.CartierAndSpin

open Polynomial

variable {k : Type*} [Field k]

theorem laurent_weighted_rescale_coefficient (P : (LaurentSeries k)[X])
    (a weight : ℤ) (j : ℕ) :
    (laurentWeightedRescale P a weight).coeff j =
      HahnSeries.single (-a + weight * (j : ℤ)) 1 * P.coeff j := by
  rw [laurentWeightedRescale, coeff_C_mul, comp_C_mul_X_coeff,
    HahnSeries.single_pow]
  simp only [one_pow, nsmul_eq_mul]
  calc
    HahnSeries.single (-a) 1 *
        (P.coeff j * HahnSeries.single ((j : ℤ) * weight) 1) =
        (HahnSeries.single (-a) 1 * HahnSeries.single ((j : ℤ) * weight) 1) * P.coeff j := by ring
    _ = _ := by rw [HahnSeries.single_mul_single, one_mul, mul_comm (j : ℤ) weight]

theorem laurent_weighted_rescale_product (P Q : (LaurentSeries k)[X])
    (a b weight : ℤ) :
    laurentWeightedRescale (P * Q) (a + b) weight =
      laurentWeightedRescale P a weight * laurentWeightedRescale Q b weight := by
  simp only [laurentWeightedRescale, mul_comp]
  have hsingle : (HahnSeries.single (-(a + b)) 1 : LaurentSeries k) =
      HahnSeries.single (-a) 1 * HahnSeries.single (-b) 1 := by
    rw [HahnSeries.single_mul_single, one_mul, neg_add]
  rw [hsingle, C_mul]
  ring

theorem laurent_weighted_rescale_orderTop (P : (LaurentSeries k)[X])
    (a weight : ℤ) (j : ℕ) :
    ((laurentWeightedRescale P a weight).coeff j).orderTop =
      ((-a + weight * (j : ℤ) : ℤ) : WithTop ℤ) + (P.coeff j).orderTop := by
  rw [laurent_weighted_rescale_coefficient]
  change (HahnSeries.addVal ℤ k)
    (HahnSeries.single (-a + weight * (j : ℤ)) 1 * P.coeff j) = _
  rw [(HahnSeries.addVal ℤ k).map_mul]
  change (HahnSeries.single (-a + weight * (j : ℤ)) (1 : k)).orderTop +
    (P.coeff j).orderTop = _
  rw [HahnSeries.orderTop_single one_ne_zero]

/-- A weighted coefficient bound is exactly regularity after the actual
weighted Laurent coordinate rescaling. Infinite zero orders are retained. -/
theorem laurent_weighted_rescale_regular_iff (P : (LaurentSeries k)[X])
    (a weight : ℤ) (j : ℕ) :
    ((a - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (P.coeff j).orderTop ↔
      (0 : WithTop ℤ) ≤ ((laurentWeightedRescale P a weight).coeff j).orderTop := by
  by_cases hz : P.coeff j = 0
  · simp only [laurent_weighted_rescale_coefficient, hz, mul_zero,
      HahnSeries.orderTop_zero, le_top]
  · rw [laurent_weighted_rescale_orderTop,
      ← HahnSeries.order_eq_orderTop_of_ne_zero hz, ← WithTop.coe_add]
    constructor
    · intro h
      apply WithTop.coe_le_coe.mpr
      have := WithTop.coe_le_coe.mp h
      omega
    · intro h
      apply WithTop.coe_le_coe.mpr
      have := WithTop.coe_le_coe.mp h
      omega

end Litt3.CartierAndSpin
