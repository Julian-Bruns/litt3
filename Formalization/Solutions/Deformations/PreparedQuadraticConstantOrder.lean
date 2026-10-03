import Mathlib.RingTheory.PowerSeries.WeierstrassPreparation

namespace Litt3.Deformations

variable {A : Type*} [CommRing A]

/-- Genuine unit-factor preparation preserves every original constant
coefficient ideal condition, including the quadratic augmentation order. -/
theorem prepared_polynomial_constant_mem (J : Ideal A) (g : PowerSeries A)
    (f : Polynomial A) (h : PowerSeries A) (unit : IsUnit h)
    (equation : g = (f : PowerSeries A) * h) (constant : PowerSeries.constantCoeff g ∈ J) :
    f.coeff 0 ∈ J := by
  obtain ⟨u, value⟩ := (PowerSeries.isUnit_iff_constantCoeff.mp unit)
  have coeff : PowerSeries.constantCoeff g = f.coeff 0 * (u : A) := by
    rw [equation, map_mul, value]
    rfl
  have multiplied := J.mul_mem_right ((u⁻¹ : Aˣ) : A) constant
  rwa [coeff, mul_assoc, Units.mul_inv, mul_one] at multiplied

end Litt3.Deformations
