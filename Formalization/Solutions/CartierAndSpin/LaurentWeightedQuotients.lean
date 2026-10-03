import Solutions.CartierAndSpin.LaurentRegularPolynomials
import Solutions.CartierAndSpin.LaurentWeightedRescale
import Solutions.CartierAndSpin.PrimitiveCriticalIntegrality
import Mathlib.RingTheory.PowerSeries.Ideal

namespace Litt3.CartierAndSpin

open Polynomial

variable {k : Type*} [Field k]

/-- Exact weighted Gauss division for literal Laurent polynomials.
A single coefficient realizing the source's weight certifies primitive
content after actual coordinate rescaling. No source leading coefficient,
separability, or split-root hypothesis is needed. -/
theorem laurent_weighted_polynomial_quotient_bound
    (F Q : (LaurentSeries k)[X]) (a b weight : ℤ)
    (hF : ∀ j : ℕ, ((a - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (F.coeff j).orderTop)
    (hexact : ∃ j : ℕ, (F.coeff j).orderTop =
      ((a - weight * (j : ℤ) : ℤ) : WithTop ℤ))
    (hproduct : ∀ j : ℕ, ((a + b - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤
      ((F * Q).coeff j).orderTop) (j : ℕ) :
    ((b - weight * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (Q.coeff j).orderTop := by
  classical
  letI : NormalizedGCDMonoid (PowerSeries k) := Classical.arbitrary _
  obtain ⟨F0, hF0⟩ := laurent_regular_polynomial_descends
    (laurentWeightedRescale F a weight)
    (fun i => (laurent_weighted_rescale_regular_iff F a weight i).mp (hF i))
  obtain ⟨P0, hP0⟩ := laurent_regular_polynomial_descends
    (laurentWeightedRescale (F * Q) (a + b) weight)
    (fun i => (laurent_weighted_rescale_regular_iff (F * Q) (a + b) weight i).mp
      (hproduct i))
  obtain ⟨i, hi⟩ := hexact
  have hrescale : ((laurentWeightedRescale F a weight).coeff i).orderTop = 0 := by
    rw [laurent_weighted_rescale_orderTop, hi, ← WithTop.coe_add]
    have hcancel : -a + weight * (i : ℤ) + (a - weight * (i : ℤ)) = 0 := by ring
    rw [hcancel, WithTop.coe_zero]
  have hcoeff := congrArg (fun P : (LaurentSeries k)[X] => P.coeff i) hF0
  dsimp only at hcoeff
  rw [Polynomial.coeff_map] at hcoeff
  have hunit : IsUnit (F0.coeff i) := by
    apply power_series_isUnit_of_laurent_order_zero
    rw [hcoeff]
    exact hrescale
  have hidentity : F0.map (algebraMap (PowerSeries k) (LaurentSeries k)) *
      laurentWeightedRescale Q b weight = P0.map (algebraMap (PowerSeries k) (LaurentSeries k)) := by
    rw [hF0, hP0]
    exact (laurent_weighted_rescale_product F Q a b weight).symm
  obtain ⟨Q0, hQ0⟩ := primitive_fraction_quotient_is_integral F0 P0
    (polynomial_isPrimitive_of_unit_coefficient F0 i hunit)
    (laurentWeightedRescale Q b weight) hidentity
  apply (laurent_weighted_rescale_regular_iff Q b weight j).mpr
  rw [← hQ0, Polynomial.coeff_map]
  exact (laurent_regular_iff_power_series
    (algebraMap (PowerSeries k) (LaurentSeries k) (Q0.coeff j))).mpr ⟨Q0.coeff j, rfl⟩

end Litt3.CartierAndSpin
