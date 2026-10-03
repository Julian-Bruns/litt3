import Solutions.CartierAndSpin.AffineSourceQuotient
import Mathlib.FieldTheory.Separable

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- An arbitrary separable polynomial stays separable after the actual
inverse affine coordinate substitution. This uses a transported Bezout
identity, and works in every characteristic and every degree. -/
theorem separable_inverse_affine_comp (F : K[X]) (hs : F.Separable)
    (a b : K) (ha : a ≠ 0) :
    (F.comp (C a⁻¹ * (X - C b))).Separable := by
  obtain ⟨U, V, h⟩ := hs
  let L : K[X] := C a⁻¹ * (X - C b)
  have hderiv : L.derivative = C a⁻¹ := by simp [L]
  have hunit : C a * C a⁻¹ = (1 : K[X]) := by
    rw [← C_mul, mul_inv_cancel₀ ha, C_1]
  refine ⟨U.comp L, C a * V.comp L, ?_⟩
  rw [derivative_comp, hderiv]
  calc
    _ = U.comp L * F.comp L + (C a * C a⁻¹) * (V.comp L * F.derivative.comp L) := by ring
    _ = (U * F + V * F.derivative).comp L := by
      rw [hunit, one_mul, add_comp, mul_comp, mul_comp]
    _ = 1 := by rw [h, one_comp]

/-- The literal polynomial of any nonzero meromorphic source-frame
change is separable, with no degree or source-specific restrictions. -/
theorem affine_source_frame_separable (F : K[X]) (hs : F.Separable)
    (a b : K) (N : ℕ) (ha : a ≠ 0) :
    (affineSourceFramePolynomial F a b N).Separable := by
  exact Polynomial.Separable.unit_mul
    (isUnit_C.mpr (isUnit_iff_ne_zero.mpr (pow_ne_zero N ha)))
    (separable_inverse_affine_comp F hs a b ha)

end Litt3.CartierAndSpin
