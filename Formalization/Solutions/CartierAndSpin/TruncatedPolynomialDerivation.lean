import Mathlib.RingTheory.AdjoinRoot
import Mathlib.RingTheory.Derivation.MapCoeffs
import Mathlib.Algebra.Polynomial.Derivative

namespace Litt3.CartierAndSpin

open Polynomial

variable (K : Type*) [Field K] (p : ℕ) [CharP K p]

/-- The literal truncated polynomial algebra. -/
abbrev TruncatedPolynomialAlgebra := AdjoinRoot ((X : K[X]) ^ p)

/-- The actual formal polynomial derivative stabilizes the literal
truncation ideal in prime characteristic. -/
theorem truncated_polynomial_derivative_stable (P : K[X])
    (hP : AdjoinRoot.mk ((X : K[X]) ^ p) P = 0) :
    AdjoinRoot.mk ((X : K[X]) ^ p) P.derivative = 0 := by
  obtain ⟨Q, rfl⟩ := AdjoinRoot.mk_eq_zero.mp hP
  rw [derivative_mul, derivative_X_pow]
  simp only [CharP.cast_eq_zero K p, map_zero, zero_mul, mul_zero, zero_add]
  rw [map_mul, AdjoinRoot.mk_self, zero_mul]

/-- The genuine derivation on K[epsilon]/epsilon^p, obtained by lifting
the complete formal polynomial derivative through the actual quotient. -/
noncomputable def truncatedPolynomialDerivation :
    Derivation K (TruncatedPolynomialAlgebra K p) (TruncatedPolynomialAlgebra K p) :=
  Derivation.liftOfSurjective (f := AdjoinRoot.mkₐ ((X : K[X]) ^ p))
    (d := Polynomial.derivative')
    (AdjoinRoot.mk_surjective) (truncated_polynomial_derivative_stable K p)

theorem truncated_polynomial_derivation_mk (P : K[X]) :
    truncatedPolynomialDerivation K p (AdjoinRoot.mk ((X : K[X]) ^ p) P) =
      AdjoinRoot.mk ((X : K[X]) ^ p) P.derivative := by
  change Derivation.liftOfSurjective (f := AdjoinRoot.mkₐ ((X : K[X]) ^ p))
    (d := Polynomial.derivative')
    AdjoinRoot.mk_surjective (truncated_polynomial_derivative_stable K p)
      (AdjoinRoot.mkₐ ((X : K[X]) ^ p) P) = _
  rw [Derivation.liftOfSurjective_apply]
  rfl

end Litt3.CartierAndSpin
