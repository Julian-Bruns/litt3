import Solutions.QuotientGeometry.ParameterEisensteinCoefficients
import Solutions.QuotientGeometry.ParameterChainRule
import Mathlib.RingTheory.Derivation.MapCoeffs
import Mathlib.RingTheory.Ideal.Span

namespace Litt3.QuotientGeometry

noncomputable def powerSeriesCoefficientDerivative
    {k : Type*} [Field k] (q : Polynomial (PowerSeries k)) : Polynomial (PowerSeries k) :=
  PolynomialModule.equivPolynomialSelf ((PowerSeries.derivative k).mapCoeffs q)

theorem power_series_coefficient_derivative_coeff
    {k : Type*} [Field k] (q : Polynomial (PowerSeries k)) (i : ℕ) :
    (powerSeriesCoefficientDerivative q).coeff i = PowerSeries.derivative k (q.coeff i) := rfl

theorem power_series_coefficient_derivative_add
    {k : Type*} [Field k] (q r : Polynomial (PowerSeries k)) :
    powerSeriesCoefficientDerivative (q + r) =
      powerSeriesCoefficientDerivative q + powerSeriesCoefficientDerivative r := by
  simp only [powerSeriesCoefficientDerivative, map_add]

theorem power_series_coefficient_derivative_monomial
    {k : Type*} [Field k] (j : ℕ) (a : PowerSeries k) :
    powerSeriesCoefficientDerivative (Polynomial.monomial j a) =
      Polynomial.monomial j (PowerSeries.derivative k a) := by
  rw [powerSeriesCoefficientDerivative, Derivation.mapCoeffs_monomial,
    PolynomialModule.equivPolynomialSelf_apply_eq, PolynomialModule.equivPolynomial_single]

theorem parameter_polynomial_derivative
    {k : Type*} [Field k] (b : PowerSeries k) (hb0 : PowerSeries.constantCoeff b = 0)
    (q : Polynomial (PowerSeries k)) :
    PowerSeries.derivative k
      (q.eval₂ (PowerSeries.substAlgHom
        (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)).toRingHom PowerSeries.X) =
      PowerSeries.derivative k b *
        (powerSeriesCoefficientDerivative q).eval₂
          (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)).toRingHom
          PowerSeries.X +
      q.derivative.eval₂
        (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)).toRingHom
        PowerSeries.X := by
  induction q using Polynomial.induction_on' with
  | add q r hq hr =>
    rw [Polynomial.eval₂_add, map_add, hq, hr, power_series_coefficient_derivative_add,
      Polynomial.eval₂_add, Polynomial.derivative_add, Polynomial.eval₂_add]
    ring
  | monomial j a =>
    simp only [Polynomial.eval₂_monomial, Derivation.leibniz, PowerSeries.coe_substAlgHom,
      AlgHom.toRingHom_eq_coe, AlgHom.coe_toRingHom, parameter_substitution_derivative b a hb0,
      power_series_coefficient_derivative_monomial, Polynomial.derivative_monomial,
      Derivation.leibniz_pow, PowerSeries.derivative_X, smul_eq_mul, mul_one,
      map_mul, map_natCast]
    ring

theorem parameter_polynomial_constant_coefficient
    {k : Type*} [Field k] (b : PowerSeries k) (hb0 : PowerSeries.constantCoeff b = 0)
    (q : Polynomial (PowerSeries k)) :
    PowerSeries.constantCoeff
      (q.eval₂ (PowerSeries.substAlgHom
        (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)).toRingHom PowerSeries.X) =
      PowerSeries.constantCoeff (q.coeff 0) := by
  induction q using Polynomial.induction_on' with
  | add q r hq hr =>
    simp only [Polynomial.eval₂_add, map_add, hq, hr, Polynomial.coeff_add]
  | monomial j a =>
    simp only [Polynomial.eval₂_monomial, map_mul, map_pow, PowerSeries.constantCoeff_X,
      AlgHom.toRingHom_eq_coe, AlgHom.coe_toRingHom, PowerSeries.coe_substAlgHom,
      parameter_substitution_constant_coefficient b a hb0]
    by_cases hj : j = 0
    · subst j
      simp
    · simp [hj, Polynomial.coeff_monomial, Ne.symm hj]

/-- For an arbitrary original positive parameter, the genuine minimal
polynomial derivative differs from the parameter derivative by an
actual completed-ring unit. -/
theorem finite_parameter_relation_derivative_ideal
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hb0 : PowerSeries.constantCoeff b = 0)
    (q : Polynomial (CompletedPowerSeriesBase k)) (hmonic : q.Monic)
    (hdegree : q.natDegree = n)
    (hq : q.eval₂ (liftedCompletedEmbedding b hb0) PowerSeries.X = 0) :
    Ideal.span {q.derivative.eval₂ (liftedCompletedEmbedding b hb0) PowerSeries.X} =
      Ideal.span {PowerSeries.derivative k b} := by
  let down : CompletedPowerSeriesBase k →+* PowerSeries k :=
    (ULift.ringEquiv : CompletedPowerSeriesBase k ≃+* PowerSeries k).toRingHom
  let r := q.map down
  let φ : PowerSeries k →+* PowerSeries k := (PowerSeries.substAlgHom (R := k)
    (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)).toRingHom
  have hr : r.eval₂ φ PowerSeries.X = 0 := by
    simpa only [r, Polynomial.eval₂_map] using hq
  let u := (powerSeriesCoefficientDerivative r).eval₂ φ PowerSeries.X
  have hcu : PowerSeries.constantCoeff u = PowerSeries.coeff 1 (q.coeff 0).down := by
    rw [parameter_polynomial_constant_coefficient b hb0 (powerSeriesCoefficientDerivative r),
      power_series_coefficient_derivative_coeff]
    dsimp only [r]
    rw [Polynomial.coeff_map]
    change PowerSeries.constantCoeff (PowerSeries.derivative k (q.coeff 0).down) = _
    simpa using PowerSeries.coeff_derivative (q.coeff 0).down 0
  have hu : IsUnit u := by
    apply PowerSeries.isUnit_iff_constantCoeff.mpr
    apply isUnit_iff_ne_zero.mpr
    rw [hcu]
    intro hz
    have heq := finite_parameter_relation_constant_first_coefficient n hn b c hb hb0 q
      hmonic hdegree hq
    rw [hz, zero_mul] at heq
    exact one_ne_zero (neg_eq_zero.mp heq.symm)
  have hD := parameter_polynomial_derivative b hb0 r
  rw [hr, map_zero] at hD
  have heval : q.derivative.eval₂ (liftedCompletedEmbedding b hb0) PowerSeries.X =
      r.derivative.eval₂ φ PowerSeries.X := by
    dsimp only [r]
    rw [Polynomial.derivative_map, Polynomial.eval₂_map]
    rfl
  have hfactor : q.derivative.eval₂ (liftedCompletedEmbedding b hb0) PowerSeries.X =
      PowerSeries.derivative k b * (-u) := by
    rw [heval]
    change 0 = PowerSeries.derivative k b * u + r.derivative.eval₂ φ PowerSeries.X at hD
    rw [mul_neg]
    exact eq_neg_of_add_eq_zero_right hD.symm
  rw [hfactor]
  exact Ideal.span_singleton_mul_right_unit hu.neg _

end Litt3.QuotientGeometry
