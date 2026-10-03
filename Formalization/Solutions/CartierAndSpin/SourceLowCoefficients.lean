import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R : Type*} [CommRing R]

theorem source_polynomial_low_coefficient (F H : R[X]) (p j : ℕ) (q tau : R)
    (hsource : F = (X ^ p + C q) * H + C tau) (hj : j < p) :
    F.coeff j = q * H.coeff j + if j = 0 then tau else 0 := by
  rw [hsource, add_mul, coeff_add, coeff_add, coeff_X_pow_mul',
    if_neg (by omega : ¬ p ≤ j), coeff_C_mul, zero_add, coeff_C]

end Litt3.CartierAndSpin
