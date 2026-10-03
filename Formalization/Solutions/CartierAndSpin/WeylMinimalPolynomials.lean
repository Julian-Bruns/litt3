import Solutions.CartierAndSpin.WeylPolynomialCommutators
import Mathlib.FieldTheory.Minpoly.Field
import Mathlib.Algebra.CharP.Basic

namespace Litt3.CartierAndSpin

open Polynomial

variable {K A : Type*} [Field K] [Ring A] [Algebra K A]

/-- Every actual Weyl operator has a minimal polynomial with
zero literal formal derivative. No finite dimension, characteristic,
matrix representation or supplied minimal polynomial is assumed. -/
theorem weyl_minpoly_derivative_zero
    (T M : A) (hweyl : T * M - M * T = 1) :
    (minpoly K T).derivative = 0 := by
  have h := weyl_polynomial_commutator T M hweyl (minpoly K T)
  have heval : aeval T (minpoly K T).derivative = 0 := by
    simpa only [minpoly.aeval, zero_mul, mul_zero, sub_self] using h.symm
  exact Polynomial.dvd_derivative_iff.mp (minpoly.dvd K T heval)

/-- A nonconstant actual monic polynomial with zero formal derivative
has degree at least the characteristic. The bound is symbolic and does
not need primality or perfect coefficients. -/
theorem monic_zero_derivative_characteristic_le_degree
    {p : ℕ} [CharP K p] (F : K[X]) (hmonic : F.Monic)
    (hpositive : 0 < F.natDegree) (hderivative : F.derivative = 0) :
    p ≤ F.natDegree := by
  have hindex : F.natDegree - 1 + 1 = F.natDegree := Nat.sub_add_cancel hpositive
  have hcoeff := congrArg (fun G : K[X] => G.coeff (F.natDegree - 1)) hderivative
  dsimp only at hcoeff
  rw [Polynomial.coeff_derivative, hindex, hmonic.coeff_natDegree,
    one_mul, Polynomial.coeff_zero] at hcoeff
  have hcast : (F.natDegree : K) = 0 := by
    calc
      (F.natDegree : K) = ((F.natDegree - 1 + 1 : ℕ) : K) :=
        congrArg (fun n : ℕ => (n : K)) hindex.symm
      _ = ((F.natDegree - 1 : ℕ) : K) + 1 := by rw [Nat.cast_add, Nat.cast_one]
      _ = 0 := hcoeff
  exact Nat.le_of_dvd hpositive ((CharP.cast_eq_zero_iff K p _).mp hcast)

/-- For an actual integral Weyl operator in a nonzero algebra, the
minimal-polynomial degree is at least the characteristic. No companion
matrix, normal form or cyclic-vector premise is used. -/
theorem weyl_characteristic_le_minpoly_degree
    [Nontrivial A] {p : ℕ} [CharP K p]
    (T M : A) (hweyl : T * M - M * T = 1) (hintegral : IsIntegral K T) :
    p ≤ (minpoly K T).natDegree :=
  monic_zero_derivative_characteristic_le_degree (minpoly K T)
    (minpoly.monic hintegral) (minpoly.natDegree_pos hintegral)
    (weyl_minpoly_derivative_zero T M hweyl)

end Litt3.CartierAndSpin
