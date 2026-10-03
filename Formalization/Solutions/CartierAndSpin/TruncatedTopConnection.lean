import Solutions.CartierAndSpin.ConnectionLeibniz
import Solutions.CartierAndSpin.TruncatedDerivativeNilpotence
import Mathlib.NumberTheory.Wilson
import Mathlib.Algebra.CharP.Algebra

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

theorem truncated_top_derivative_product_zero (n : ℕ) (hn : n < p - 1) :
    (AdjoinRoot.root ((X : K[X]) ^ p)) ^ (p - 1) *
      AdjoinRoot.mk ((X : K[X]) ^ p)
        (Polynomial.derivative^[n] ((X : K[X]) ^ (p - 1))) = 0 := by
  rw [Polynomial.iterate_derivative_X_pow_eq_C_mul, map_mul, AdjoinRoot.mk_C,
    map_pow, AdjoinRoot.mk_X, ← AdjoinRoot.algebraMap_eq]
  have hx : (AdjoinRoot.root ((X : K[X]) ^ p)) ^ p = 0 := by
    rw [← AdjoinRoot.mk_X, ← map_pow, AdjoinRoot.mk_self]
  calc
    _ = algebraMap K (TruncatedPolynomialAlgebra K p)
          ((p - 1).descFactorial n : K) *
        (AdjoinRoot.root ((X : K[X]) ^ p)) ^ ((p - 1) + (p - 1 - n)) := by
      rw [pow_add]
      ring
    _ = 0 := by rw [pow_eq_zero_of_le (by omega) hx, mul_zero]

/-- The top-coefficient connection runs through the literal derivative
chain of epsilon^(p-1). No matrix or sampled-prime calculation occurs. -/
theorem truncated_top_connection_iterate_one (c : K) (n : ℕ) (hn : n < p) :
    (scalarDerivationConnection (truncatedPolynomialDerivation K p)
      (algebraMap K (TruncatedPolynomialAlgebra K p) c *
        (AdjoinRoot.root ((X : K[X]) ^ p)) ^ (p - 1)))^[n + 1] 1 =
      -algebraMap K (TruncatedPolynomialAlgebra K p) c *
        AdjoinRoot.mk ((X : K[X]) ^ p)
          (Polynomial.derivative^[n] ((X : K[X]) ^ (p - 1))) := by
  induction n with
  | zero =>
    change truncatedPolynomialDerivation K p 1 -
      (algebraMap K (TruncatedPolynomialAlgebra K p) c *
        (AdjoinRoot.root ((X : K[X]) ^ p)) ^ (p - 1)) * 1 = _
    simp only [Derivation.map_one_eq_zero, zero_sub, mul_one,
      Function.iterate_zero_apply, map_pow, AdjoinRoot.mk_X, neg_mul]
  | succ n ih =>
    have hvan := truncated_top_derivative_product_zero (K := K) (p := p) n (by omega)
    rw [Function.iterate_succ_apply', ih (by omega)]
    change truncatedPolynomialDerivation K p
        (-algebraMap K (TruncatedPolynomialAlgebra K p) c *
          AdjoinRoot.mk ((X : K[X]) ^ p)
            (Polynomial.derivative^[n] ((X : K[X]) ^ (p - 1)))) -
        (algebraMap K (TruncatedPolynomialAlgebra K p) c *
          (AdjoinRoot.root ((X : K[X]) ^ p)) ^ (p - 1)) *
        (-algebraMap K (TruncatedPolynomialAlgebra K p) c *
          AdjoinRoot.mk ((X : K[X]) ^ p)
            (Polynomial.derivative^[n] ((X : K[X]) ^ (p - 1)))) = _
    have hderive : truncatedPolynomialDerivation K p
        (-algebraMap K (TruncatedPolynomialAlgebra K p) c *
          AdjoinRoot.mk ((X : K[X]) ^ p)
            (Polynomial.derivative^[n] ((X : K[X]) ^ (p - 1)))) =
        -algebraMap K (TruncatedPolynomialAlgebra K p) c *
          AdjoinRoot.mk ((X : K[X]) ^ p)
            (Polynomial.derivative (Polynomial.derivative^[n]
              ((X : K[X]) ^ (p - 1)))) := by
      rw [Derivation.leibniz, map_neg,
        (truncatedPolynomialDerivation K p).map_algebraMap,
        neg_zero, smul_zero, add_zero, smul_eq_mul,
        truncated_polynomial_derivation_mk]
    rw [hderive, Function.iterate_succ_apply']
    linear_combination (algebraMap K (TruncatedPolynomialAlgebra K p) c) ^ 2 * hvan

/-- Wilson's uniform prime theorem closes the actual nilpotent cycle:
the pth iterate is multiplication by the ORIGINAL coefficient c. -/
theorem truncated_top_connection_prime_iterate (c : K)
    (a : TruncatedPolynomialAlgebra K p) :
    (scalarDerivationConnection (truncatedPolynomialDerivation K p)
      (algebraMap K (TruncatedPolynomialAlgebra K p) c *
        (AdjoinRoot.root ((X : K[X]) ^ p)) ^ (p - 1)))^[p] a =
      a * algebraMap K (TruncatedPolynomialAlgebra K p) c := by
  letI : Nontrivial (TruncatedPolynomialAlgebra K p) :=
    AdjoinRoot.nontrivial ((X : K[X]) ^ p) (by
      rw [degree_X_pow]
      exact_mod_cast (Fact.out : p.Prime).ne_zero)
  letI : CharP (TruncatedPolynomialAlgebra K p) p :=
    charP_of_injective_algebraMap
      (algebraMap K (TruncatedPolynomialAlgebra K p)).injective p
  have hp : 0 < p := (Fact.out : p.Prime).pos
  have hwilson : ((p - 1).factorial : K) = -1 := by
    have h := congrArg (ZMod.castHom (dvd_refl p) K) (ZMod.wilsons_lemma p)
    simpa only [map_natCast, map_neg, map_one] using h
  have hone := truncated_top_connection_iterate_one (p := p) c (p - 1) (by omega)
  rw [Nat.sub_add_cancel hp, Polynomial.iterate_derivative_X_pow_eq_C_mul,
    Nat.descFactorial_self, Nat.sub_self, pow_zero, mul_one,
    AdjoinRoot.mk_C, hwilson, map_neg, map_one, neg_mul_neg, mul_one] at hone
  rw [scalar_connection_prime_iterate_scalar _ _
    (truncated_polynomial_derivation_characteristic_iterate_zero hp), hone]

end Litt3.CartierAndSpin
