import Solutions.Deformations.PolynomialCoefficientSeries
import Solutions.Deformations.OperatorPolynomialIntertwining

namespace Litt3.Deformations

open Polynomial

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The literal inclusion of original polynomial coefficients into
the full original formal coefficient sequence. -/
noncomputable def polynomialCoefficientFullMap :
    PolynomialModule R K →ₗ[R] CoefficientSeries (K := K) :=
  (polynomialCoefficientSeries (R := R) (K := K)).subtype.comp polynomialCoefficientInclusion

@[simp] theorem polynomial_coefficient_full_map_apply (u : PolynomialModule R K) (m : ℕ) :
    polynomialCoefficientFullMap (R := R) u m = u m := rfl

/-- Original multiplication by X is the literal formal shift under
the original inclusion, at every original coefficient. -/
theorem polynomial_coefficient_full_map_X (u : PolynomialModule R K) :
    polynomialCoefficientFullMap (R := R) ((X : R[X]) • u) =
      coefficientSeriesShift (R := R) 1 (polynomialCoefficientFullMap (R := R) u) := by
  funext m
  change ((X : R[X]) • u) m = if 1 ≤ m then u (m - 1) else 0
  have action := PolynomialModule.monomial_smul_apply 1 (1 : R) u m
  simpa only [Polynomial.monomial_one_right_eq_X_pow, pow_one, one_smul] using action

/-- The whole original polynomial scalar action, not only its
generator, is retained by the actual original coefficient inclusion. -/
theorem polynomial_coefficient_full_map_smul (P : R[X]) (u : PolynomialModule R K) :
    polynomialCoefficientFullMap (R := R) (P • u) =
      Polynomial.aeval (coefficientSeriesShift (R := R) (K := K) 1) P
        (polynomialCoefficientFullMap (R := R) u) := by
  rw [PolynomialModule.smul_def]
  apply linear_map_intertwining_polynomial
  intro v
  have action := polynomial_coefficient_full_map_X (R := R) v
  simpa only [PolynomialModule.smul_def, Polynomial.aeval_X] using action

end Litt3.Deformations
