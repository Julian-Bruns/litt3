import Solutions.CartierAndSpin.FiniteRootPolynomial

namespace Litt3.CartierAndSpin

open Polynomial

variable {R : Type*} [CommRing R]

/-- A symbolic coefficient calculation for two pure-power blocks and an
arbitrary monic lower-degree factor. No coefficient expansion is enumerated. -/
theorem two_block_polynomial_carry_coefficient (p q m : ℕ) (hqp : p < q) (hmp : m < p)
    (a b : R) (A : R[X]) (hA : A.Monic) (hdegree : A.natDegree = m) :
    ((X ^ q - C a) * (X ^ p - C b) * A).coeff (q + m) = -b := by
  have hexpand : (X ^ q - C a) * (X ^ p - C b) * A =
      X ^ (q + p) * A - C b * (X ^ q * A) - C a * (X ^ p * A) + C (a * b) * A := by
    rw [pow_add, C_mul]
    ring
  have hfirst : (X ^ (q + p) * A).coeff (q + m) = 0 := by
    rw [coeff_X_pow_mul', if_neg (by omega)]
  have hmiddle : (X ^ q * A).coeff (q + m) = 1 := by
    rw [Nat.add_comm q m, coeff_X_pow_mul, ← hdegree]
    exact hA.coeff_natDegree
  have hlower : (X ^ p * A).coeff (q + m) = 0 := by
    rw [coeff_X_pow_mul', if_pos (by omega)]
    exact coeff_eq_zero_of_natDegree_lt (by omega)
  have hconstant : A.coeff (q + m) = 0 :=
    coeff_eq_zero_of_natDegree_lt (by omega)
  rw [hexpand, coeff_add, coeff_sub, coeff_sub, coeff_C_mul, coeff_C_mul, coeff_C_mul,
    hfirst, hmiddle, hlower, hconstant]
  simp

end Litt3.CartierAndSpin
