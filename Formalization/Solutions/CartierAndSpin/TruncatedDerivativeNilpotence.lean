import Solutions.CartierAndSpin.TruncatedPolynomialDerivation

namespace Litt3.CartierAndSpin

open Polynomial

/-- Every formal polynomial derivative has zero characteristic-th
iterate in positive characteristic, over ANY commutative coefficient
ring. This follows symbolically from factorial divisibility. -/
theorem polynomial_derivative_characteristic_iterate_zero
    {R : Type*} [CommRing R] {p : ℕ} [CharP R p] (hp : 0 < p) (P : R[X]) :
    Polynomial.derivative^[p] P = 0 := by
  have hfactorial : ((p.factorial : ℕ) : R[X]) = 0 :=
    (CharP.cast_eq_zero_iff (R[X]) p _).mpr (Nat.dvd_factorial hp le_rfl)
  rw [Polynomial.iterate_derivative_eq_factorial_smul_sum, nsmul_eq_mul,
    hfactorial, zero_mul]

variable {K : Type*} [Field K] {p : ℕ} [CharP K p]

theorem truncated_polynomial_derivation_iterate_mk (P : K[X]) (n : ℕ) :
    (truncatedPolynomialDerivation K p)^[n] (AdjoinRoot.mk ((X : K[X]) ^ p) P) =
      AdjoinRoot.mk ((X : K[X]) ^ p) (Polynomial.derivative^[n] P) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [Function.iterate_succ_apply', ih, truncated_polynomial_derivation_mk,
      Function.iterate_succ_apply']

/-- Nilpotence of the actual quotient derivation, for EVERY element of
the entire truncated algebra, not merely its chosen polynomial generators. -/
theorem truncated_polynomial_derivation_characteristic_iterate_zero
    (hp : 0 < p) (a : TruncatedPolynomialAlgebra K p) :
    (truncatedPolynomialDerivation K p)^[p] a = 0 := by
  obtain ⟨P, rfl⟩ := AdjoinRoot.mk_surjective a
  rw [truncated_polynomial_derivation_iterate_mk,
    polynomial_derivative_characteristic_iterate_zero hp, map_zero]

end Litt3.CartierAndSpin
