import Mathlib.Algebra.Polynomial.Coeff
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R : Type*} [CommRing R]

theorem polynomial_product_first_coefficient (P Q : R[X]) :
    (P * Q).coeff 1 = P.coeff 0 * Q.coeff 1 + P.coeff 1 * Q.coeff 0 := by
  simp [Polynomial.coeff_mul, Finset.Nat.antidiagonal_succ]

theorem polynomial_product_third_coefficient (P Q : R[X]) :
    (P * Q).coeff 3 = P.coeff 0 * Q.coeff 3 + P.coeff 1 * Q.coeff 2 +
      P.coeff 2 * Q.coeff 1 + P.coeff 3 * Q.coeff 0 := by
  simp [Polynomial.coeff_mul, Finset.Nat.antidiagonal_succ] <;> ring

end Litt3.CartierAndSpin
