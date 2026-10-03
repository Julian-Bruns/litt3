import Solutions.QuotientGeometry.CompletedPowerBasis
import Mathlib.RingTheory.PowerSeries.Derivative

namespace Litt3.QuotientGeometry

theorem constant_polynomial_parameter_derivative_relation
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    PowerSeries.derivative k (constantPolynomialParameter g) * constantPolynomialUnit g =
      (g.natDegree : PowerSeries k) * PowerSeries.X ^ (g.natDegree - 1) -
        constantPolynomialParameter g * PowerSeries.derivative k (constantPolynomialUnit g) := by
  have hc : PowerSeries.constantCoeff (constantPolynomialUnit g) ≠ 0 := by
    rw [constant_polynomial_unit_constant]
    exact Polynomial.leadingCoeff_ne_zero.mpr (by intro hz; simp [hz] at hg)
  have hprod : constantPolynomialParameter g * constantPolynomialUnit g =
      PowerSeries.X ^ g.natDegree := by
    rw [constantPolynomialParameter, mul_assoc, PowerSeries.inv_mul_cancel _ hc, mul_one]
  have hpower : PowerSeries.derivative k (PowerSeries.X ^ g.natDegree) =
      (g.natDegree : PowerSeries k) * PowerSeries.X ^ (g.natDegree - 1) := by
    rw [(PowerSeries.derivative k).leibniz_pow, PowerSeries.derivative_X]
    simp only [smul_eq_mul, mul_one, nsmul_eq_mul]
  have hd := congrArg (PowerSeries.derivative k) hprod
  rw [(PowerSeries.derivative k).leibniz, hpower] at hd
  simp only [smul_eq_mul] at hd
  linear_combination hd

theorem constant_pole_reciprocal_derivative_evaluation
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    (Polynomial.derivative (constantPoleReciprocal g)).eval₂
      (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
        (constant_polynomial_parameter_zero g hg))).toRingHom PowerSeries.X =
      PowerSeries.derivative k (constantPolynomialParameter g) * constantPolynomialUnit g := by
  let φ : PowerSeries k →+* PowerSeries k :=
    (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
      (constant_polynomial_parameter_zero g hg))).toRingHom
  have hcomp : φ.comp PowerSeries.C = PowerSeries.C := by
    apply RingHom.ext
    intro a
    exact (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
      (constant_polynomial_parameter_zero g hg))).commutes a
  have hX : φ PowerSeries.X = constantPolynomialParameter g := by
    change (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
      (constant_polynomial_parameter_zero g hg))) PowerSeries.X = _
    rw [PowerSeries.substAlgHom_X]
  change (Polynomial.derivative (constantPoleReciprocal g)).eval₂ φ PowerSeries.X = _
  rw [constantPoleReciprocal, Polynomial.derivative_sub, Polynomial.derivative_X_pow,
    Polynomial.derivative_mul, Polynomial.derivative_C, zero_mul, zero_add,
    Polynomial.derivative_map, Polynomial.eval₂_sub, Polynomial.eval₂_mul,
    Polynomial.eval₂_mul, Polynomial.eval₂_C, Polynomial.eval₂_C,
    Polynomial.eval₂_X_pow, map_natCast, Polynomial.eval₂_map, hcomp, hX]
  rw [Polynomial.eval₂_C_X_eq_coe, ← PowerSeries.derivative_coe,
    ← Polynomial.eval₂_C_X_eq_coe]
  exact (constant_polynomial_parameter_derivative_relation g hg).symm

/-- The reciprocal derivative and the derivative of the actual base
parameter generate exactly the same integral ideal; their factor is
a genuine power-series unit. -/
theorem constant_pole_reciprocal_derivative_ideal
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    Ideal.span {(Polynomial.derivative (constantPoleReciprocal g)).eval₂
      (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
        (constant_polynomial_parameter_zero g hg))).toRingHom PowerSeries.X} =
      Ideal.span {PowerSeries.derivative k (constantPolynomialParameter g)} := by
  rw [constant_pole_reciprocal_derivative_evaluation g hg]
  apply Ideal.span_singleton_mul_right_unit
  apply PowerSeries.isUnit_iff_constantCoeff.mpr
  rw [constant_polynomial_unit_constant]
  exact isUnit_iff_ne_zero.mpr
    (Polynomial.leadingCoeff_ne_zero.mpr (by intro hz; simp [hz] at hg))

theorem lifted_constant_pole_reciprocal_derivative_evaluation
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    (Polynomial.derivative (liftedConstantPoleReciprocal g)).eval₂
      (liftedCompletedEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)) PowerSeries.X =
      PowerSeries.derivative k (constantPolynomialParameter g) * constantPolynomialUnit g := by
  rw [liftedConstantPoleReciprocal, Polynomial.derivative_map, Polynomial.eval₂_map]
  have hcomp : (liftedCompletedEmbedding (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg)).comp
      (ULift.ringEquiv : CompletedPowerSeriesBase k ≃+* PowerSeries k).symm.toRingHom =
      (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero'
        (constant_polynomial_parameter_zero g hg))).toRingHom := by
    apply RingHom.ext
    intro r
    rfl
  rw [hcomp]
  exact constant_pole_reciprocal_derivative_evaluation g hg

theorem lifted_constant_pole_reciprocal_derivative_ideal
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    Ideal.span {(Polynomial.derivative (liftedConstantPoleReciprocal g)).eval₂
      (liftedCompletedEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)) PowerSeries.X} =
      Ideal.span {PowerSeries.derivative k (constantPolynomialParameter g)} := by
  rw [lifted_constant_pole_reciprocal_derivative_evaluation g hg]
  apply Ideal.span_singleton_mul_right_unit
  apply PowerSeries.isUnit_iff_constantCoeff.mpr
  rw [constant_polynomial_unit_constant]
  exact isUnit_iff_ne_zero.mpr
    (Polynomial.leadingCoeff_ne_zero.mpr (by intro hz; simp [hz] at hg))

end Litt3.QuotientGeometry
