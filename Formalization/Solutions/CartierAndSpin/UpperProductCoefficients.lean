import Mathlib.Algebra.Polynomial.Reverse
import Solutions.CartierAndSpin.PolynomialLowProducts

namespace Litt3.CartierAndSpin

open Polynomial

variable {R : Type*} [CommRing R]

/-- Coefficient convolution near arbitrary formal upper degrees. Upper
coefficients may vanish: no leading coefficient is inverted. -/
theorem polynomial_upper_product_convolution (P Q : R[X]) (m n r : ℕ)
    (hP : P.natDegree ≤ m) (hQ : Q.natDegree ≤ n) (hrm : r ≤ m) (hrn : r ≤ n) :
    (P * Q).coeff (m + n - r) =
      ∑ ij ∈ Finset.antidiagonal r,
        P.coeff (m - ij.1) * Q.coeff (n - ij.2) := by
  have hreflection := congrArg (fun S : R[X] => S.coeff r)
    (reflect_mul P Q hP hQ)
  dsimp only at hreflection
  rw [coeff_reflect, revAt_le (by omega)] at hreflection
  rw [hreflection, coeff_mul]
  apply Finset.sum_congr rfl
  intro ij hij
  have hsum := Finset.mem_antidiagonal.mp hij
  rw [coeff_reflect, coeff_reflect, revAt_le (by omega), revAt_le (by omega)]

theorem polynomial_upper_product_first (P Q : R[X]) (m n : ℕ)
    (hP : P.natDegree ≤ m) (hQ : Q.natDegree ≤ n) (hm : 1 ≤ m) (hn : 1 ≤ n) :
    (P * Q).coeff (m + n - 1) =
      P.coeff m * Q.coeff (n - 1) + P.coeff (m - 1) * Q.coeff n := by
  rw [polynomial_upper_product_convolution P Q m n 1 hP hQ hm hn]
  simp [Finset.Nat.antidiagonal_succ]

theorem polynomial_upper_product_second (P Q : R[X]) (m n : ℕ)
    (hP : P.natDegree ≤ m) (hQ : Q.natDegree ≤ n) (hm : 2 ≤ m) (hn : 2 ≤ n) :
    (P * Q).coeff (m + n - 2) =
      P.coeff m * Q.coeff (n - 2) + P.coeff (m - 1) * Q.coeff (n - 1) +
        P.coeff (m - 2) * Q.coeff n := by
  rw [polynomial_upper_product_convolution P Q m n 2 hP hQ hm hn]
  simp [Finset.Nat.antidiagonal_succ] <;> ring

end Litt3.CartierAndSpin
