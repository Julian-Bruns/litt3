import Definitions.Deformations.PolynomialCyclicPresentation
import Solutions.Deformations.IntegralCyclicRelation

namespace Litt3.Deformations

open Polynomial

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

@[simp] theorem polynomial_scalar_operator_apply (P : R[X]) (u : PolynomialModule R K) :
    polynomialScalarOperator P u = P • u := (PolynomialModule.smul_def P u).symm

theorem cyclic_group_polynomial_constant (p a : ℕ) :
    (cyclicGroupPolynomial (R := R) p a).coeff 0 = 0 := by
  simp [cyclicGroupPolynomial, Polynomial.coeff_zero_eq_eval_zero]

theorem cyclic_group_polynomial_divX (p a : ℕ) :
    (X : R[X]) * cyclicGroupNormPolynomial (R := R) p a =
      cyclicGroupPolynomial (R := R) p a := by
  have identity := Polynomial.X_mul_divX_add (cyclicGroupPolynomial (R := R) p a)
  simpa only [cyclic_group_polynomial_constant, map_zero, add_zero,
    cyclicGroupNormPolynomial] using identity

/-- The literal quotient F/e is exactly the complete integral
binomial norm polynomial, including every term in the full cyclic order. -/
theorem cyclic_group_norm_full_polynomial (p a : ℕ) :
    cyclicGroupNormPolynomial (R := R) p a =
      integralCyclicNormValue (R := R) p a (X : R[X]) := by
  apply (Polynomial.isRegular_X (R := R)).1
  dsimp only
  rw [cyclic_group_polynomial_divX]
  exact integral_cyclic_relation_norm (R := R) p a (X : R[X])

theorem cyclic_group_norm_aeval {B : Type*} [Ring B] [Algebra R B]
    (p a : ℕ) (x : B) :
    Polynomial.aeval x (cyclicGroupNormPolynomial (R := R) p a) =
      integralCyclicNormValue (R := R) p a x := by
  rw [cyclic_group_norm_full_polynomial]
  simp only [integralCyclicNormValue, map_sum, map_smul, map_pow, Polynomial.aeval_X]

theorem polynomial_cyclic_norm_original (p a : ℕ) :
    polynomialCyclicNormOperator (R := R) (K := K) p a =
      integralCyclicNormValue (R := R) p a
        (Finsupp.lmapDomain K R Nat.succ : Module.End R (PolynomialModule R K)) :=
  cyclic_group_norm_aeval p a _

end Litt3.Deformations
