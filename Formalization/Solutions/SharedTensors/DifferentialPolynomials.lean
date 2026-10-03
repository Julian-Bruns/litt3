import Definitions.SharedTensors.DifferentialPolynomials
import Solutions.SharedTensors.CharacteristicPowerFactorization

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

theorem coefficient_differential_coeff (D : K →ₗ[k] K) (F : K[X]) (i : ℕ) :
    (coefficientDifferential D F).coeff i = D (F.coeff i) := rfl

theorem affine_differential_polynomial_coeff (D : K →ₗ[k] K)
    (eta beta : K) (N : ℕ) (F : K[X]) (i : ℕ) :
    (affineDifferentialPolynomial D eta beta N F).coeff i =
      D (F.coeff i) + ((i + 1 : ℕ) : K) * eta * F.coeff (i + 1) +
        ((i : K) - (N : K)) * beta * F.coeff i := by
  have hX : ((C beta * X) * derivative F).coeff i =
      beta * (i : K) * F.coeff i := by
    cases i with
    | zero => simp only [mul_assoc, coeff_C_mul, coeff_X_mul_zero, Nat.cast_zero,
        mul_zero, zero_mul]
    | succ i =>
        rw [mul_assoc, coeff_C_mul, coeff_X_mul, coeff_derivative]
        push_cast
        ring
  simp only [affineDifferentialPolynomial, coeff_sub, coeff_add,
    coefficient_differential_coeff, add_mul, coeff_C_mul, coeff_derivative, hX]
  push_cast
  ring

/-- The checked block equations are equivalent to the actual polynomial
differential equation, rather than supplied as unrelated scalar data. -/
theorem affine_differential_polynomial_zero_iff (D : K →ₗ[k] K)
    (eta beta : K) (N : ℕ) (F : K[X]) :
    affineDifferentialPolynomial D eta beta N F = 0 ↔
      IsCharacterBlock D eta beta N F := by
  constructor
  · intro h i
    have hi := congrArg (fun P : K[X] => P.coeff i) h
    dsimp only at hi
    rw [affine_differential_polynomial_coeff, coeff_zero] at hi
    linear_combination hi
  · intro h
    ext i
    rw [affine_differential_polynomial_coeff, coeff_zero]
    have hi := h i
    linear_combination hi

/-- Full algebraic source factorization for the original literal
differential equation. -/
theorem affine_differential_characteristic_power_factorization
    (p : ℕ) [CharP K p] (hp : 0 < p)
    (D : K →ₗ[k] K) (eta beta : K) (V : Submodule k K)
    (characters : NoHomogeneousCharacters D beta V p)
    (constants : NoNonconstantDifferentialConstants D V)
    (F : K[X]) (monic : F.Monic) (coefficients : CoefficientsIn V F)
    (equation : affineDifferentialPolynomial D eta beta F.natDegree F = 0) :
    CharacteristicPowerFactorization (k := k) p F :=
  characteristic_power_factorization p hp D eta beta V characters constants
    F monic coefficients ((affine_differential_polynomial_zero_iff ..).mp equation)

end Litt3.SharedTensors
