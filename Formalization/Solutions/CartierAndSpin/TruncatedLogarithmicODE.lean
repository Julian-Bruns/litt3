import Solutions.CartierAndSpin.TruncatedPolynomialDerivation
import Solutions.CartierAndSpin.TruncatedODEObstruction
import Mathlib.RingTheory.Nilpotent.Basic
import Mathlib.Algebra.Polynomial.Div

namespace Litt3.CartierAndSpin

open Polynomial

/-- Any polynomial with constant coefficient one is a genuine unit
in the literal truncated algebra, even over arbitrary commutative rings. -/
theorem truncated_polynomial_unit_of_constant_one
    {R : Type*} [CommRing R] (p : ℕ) (U : R[X]) (hU0 : U.coeff 0 = 1) :
    IsUnit (AdjoinRoot.mk ((X : R[X]) ^ p) U) := by
  have hdiv : (X : R[X]) ∣ U - 1 := by
    rw [← pow_one (X : R[X]), X_pow_dvd_iff]
    intro n hn
    have hn0 : n = 0 := by omega
    subst n
    simp [coeff_sub, hU0]
  obtain ⟨Q, hQ⟩ := hdiv
  have hx : (AdjoinRoot.mk ((X : R[X]) ^ p) X) ^ p = 0 := by
    rw [← map_pow, AdjoinRoot.mk_self]
  have hnil : IsNilpotent (AdjoinRoot.mk ((X : R[X]) ^ p) X *
      AdjoinRoot.mk ((X : R[X]) ^ p) Q) := by
    refine ⟨p, ?_⟩
    rw [mul_pow, hx, zero_mul]
  have hU : AdjoinRoot.mk ((X : R[X]) ^ p) U = 1 +
      AdjoinRoot.mk ((X : R[X]) ^ p) X * AdjoinRoot.mk ((X : R[X]) ^ p) Q := by
    have h := congrArg (AdjoinRoot.mk ((X : R[X]) ^ p)) hQ
    rw [map_sub, map_one, map_mul] at h
    linear_combination h
  rw [hU]
  exact hnil.isUnit_one_add

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Construct an ACTUAL unit solution to the first-order differential
equation in K[epsilon]/epsilon^p whenever the literal last obstruction
coefficient equals the pth power of the constant. The proof is uniform
in p, and K is not presumed perfect. -/
theorem truncated_logarithmic_ode_solution (F : K[X])
    (hF : F.coeff (p - 1) = (F.coeff 0) ^ p) :
    ∃ u : (TruncatedPolynomialAlgebra K p)ˣ,
      truncatedPolynomialDerivation K p (u : TruncatedPolynomialAlgebra K p) =
        AdjoinRoot.mk ((X : K[X]) ^ p) F * (u : TruncatedPolynomialAlgebra K p) := by
  let U := truncatedODEPolynomial F p
  have hU0 : U.coeff 0 = 1 :=
    truncated_ode_polynomial_constant F p (Fact.out : p.Prime).pos
  obtain ⟨u, hu⟩ := truncated_polynomial_unit_of_constant_one p U hU0
  refine ⟨u, ?_⟩
  rw [hu, truncated_polynomial_derivation_mk, ← map_mul]
  apply AdjoinRoot.mk_eq_mk.mpr
  rw [X_pow_dvd_iff]
  intro n hn
  rw [coeff_sub, truncated_ode_all_coefficient_equations F hF n hn, sub_self]

end Litt3.CartierAndSpin
