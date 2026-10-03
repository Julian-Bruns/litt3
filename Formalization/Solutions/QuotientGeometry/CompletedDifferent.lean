import Solutions.QuotientGeometry.CompletedPowerBasis
import Solutions.QuotientGeometry.CompletedEmbeddingRegularity
import Solutions.QuotientGeometry.MonogenicDifferent
import Solutions.QuotientGeometry.CompletedDerivativeIdeal
import Solutions.QuotientGeometry.PowerSeriesPrincipalOrders

namespace Litt3.QuotientGeometry

attribute [local instance] FractionRing.liftAlgebra FractionRing.isScalarTower_liftAlgebra

/-- For the actual completed substitution extension, the genuine
trace-defined different is its actual reciprocal derivative ideal.
Separability is a field-extension hypothesis; monogenicity, finite
generation and integral closure are all proved from the whole ring. -/
theorem constant_polynomial_completed_different
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    letI : IsDomain (CompletedPowerSeriesBase k) := completed_power_series_base_isDomain
    letI : Algebra (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (PowerSeries k) := Algebra.toModule
    letI : NoZeroSMulDivisors (CompletedPowerSeriesBase k) (PowerSeries k) :=
      NoZeroSMulDivisors.iff_algebraMap_injective.mpr
        (lifted_constant_polynomial_completed_embedding_injective g hg)
    letI : IsIntegrallyClosed (CompletedPowerSeriesBase k) :=
      completed_power_series_base_integrally_closed
    letI : Algebra (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (liftedCompletedFractionCoefficientEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (liftedCompletedFractionCoefficientEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) := Algebra.toModule
    letI : FaithfulSMul (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (faithfulSMul_iff_algebraMap_injective _ _).mpr
        (lifted_constant_polynomial_fraction_coefficient_embedding_injective g hg)
    letI : Algebra (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      FractionRing.liftAlgebra _ _
    letI : SMul (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      (FractionRing.liftAlgebra _ _).toSMul
    letI : Module (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      Algebra.toModule
    Algebra.IsSeparable (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) →
      differentIdeal (CompletedPowerSeriesBase k) (PowerSeries k) = Ideal.span
        {Polynomial.aeval (PowerSeries.X : PowerSeries k)
          (Polynomial.derivative (liftedConstantPoleReciprocal g))} := by
  let A := CompletedPowerSeriesBase k
  let B := PowerSeries k
  letI : IsDomain A := completed_power_series_base_isDomain
  let φ := liftedCompletedEmbedding (constantPolynomialParameter g)
    (constant_polynomial_parameter_zero g hg)
  letI : Algebra A B := φ.toAlgebra
  letI : SMul A B := φ.toAlgebra.toSMul
  letI : Module A B := Algebra.toModule
  letI : NoZeroSMulDivisors A B := NoZeroSMulDivisors.iff_algebraMap_injective.mpr
    (lifted_constant_polynomial_completed_embedding_injective g hg)
  letI : IsIntegrallyClosed A := completed_power_series_base_integrally_closed
  letI : Algebra A (FractionRing B) :=
    (liftedCompletedFractionCoefficientEmbedding (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg)).toAlgebra
  letI : SMul A (FractionRing B) :=
    (liftedCompletedFractionCoefficientEmbedding (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg)).toAlgebra.toSMul
  letI : Module A (FractionRing B) := Algebra.toModule
  letI : FaithfulSMul A (FractionRing B) :=
    (faithfulSMul_iff_algebraMap_injective _ _).mpr
      (lifted_constant_polynomial_fraction_coefficient_embedding_injective g hg)
  letI : Algebra (FractionRing A) (FractionRing B) := FractionRing.liftAlgebra _ _
  letI : SMul (FractionRing A) (FractionRing B) := (FractionRing.liftAlgebra _ _).toSMul
  letI : Module (FractionRing A) (FractionRing B) := Algebra.toModule
  intro hsep
  let K := FractionRing A
  let L := FractionRing B
  letI : SMul A K := (inferInstance : Algebra A K).toSMul
  letI : Module A K := Algebra.toModule
  letI : SMul B L := (inferInstance : Algebra B L).toSMul
  letI : Module B L := Algebra.toModule
  letI : IsScalarTower A B L := IsScalarTower.of_algebraMap_eq fun _ => rfl
  letI : IsScalarTower A K L := IsScalarTower.of_algebraMap_eq fun r => by
    change (algebraMap A L) r =
      IsFractionRing.lift (FaithfulSMul.algebraMap_injective A L) (algebraMap A K r)
    exact (IsFractionRing.lift_algebraMap (FaithfulSMul.algebraMap_injective A L) r).symm
  haveI : Algebra.IsSeparable K L := hsep
  obtain ⟨pb, hgen, hmin⟩ := constant_polynomial_completed_power_basis g hg hzero
  haveI : Module.Finite A B := pb.finite
  haveI : Algebra.IsIntegral A B := inferInstance
  haveI : IsIntegralClosure B A L := IsIntegralClosure.of_isIntegrallyClosed B A L
  haveI : IsLocalization (Algebra.algebraMapSubmonoid B (nonZeroDivisors A)) L :=
    IsIntegralClosure.isLocalization A K L B
  haveI : FiniteDimensional K L := Module.Finite.of_isLocalization A B (nonZeroDivisors A)
  have hd := integral_power_basis_different_ideal (K := K) (L := L) pb
  rw [hgen, hmin] at hd
  exact hd

/-- The genuine completed different is exactly the actual base-parameter
derivative ideal, and its exponent is exactly the actual Laurent order. -/
theorem constant_polynomial_completed_different_and_valuation
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    letI : IsDomain (CompletedPowerSeriesBase k) := completed_power_series_base_isDomain
    letI : Algebra (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (PowerSeries k) := Algebra.toModule
    letI : NoZeroSMulDivisors (CompletedPowerSeriesBase k) (PowerSeries k) :=
      NoZeroSMulDivisors.iff_algebraMap_injective.mpr
        (lifted_constant_polynomial_completed_embedding_injective g hg)
    letI : IsIntegrallyClosed (CompletedPowerSeriesBase k) :=
      completed_power_series_base_integrally_closed
    letI : Algebra (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (liftedCompletedFractionCoefficientEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (liftedCompletedFractionCoefficientEmbedding (constantPolynomialParameter g)
        (constant_polynomial_parameter_zero g hg)).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) := Algebra.toModule
    letI : FaithfulSMul (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (faithfulSMul_iff_algebraMap_injective _ _).mpr
        (lifted_constant_polynomial_fraction_coefficient_embedding_injective g hg)
    letI : Algebra (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      FractionRing.liftAlgebra _ _
    letI : SMul (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      (FractionRing.liftAlgebra _ _).toSMul
    letI : Module (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      Algebra.toModule
    Algebra.IsSeparable (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) →
      (differentIdeal (CompletedPowerSeriesBase k) (PowerSeries k) =
        Ideal.span {PowerSeries.derivative k (constantPolynomialParameter g)}) ∧
      ∀ n : ℕ, differentIdeal (CompletedPowerSeriesBase k) (PowerSeries k) =
          Ideal.span {(PowerSeries.X : PowerSeries k) ^ n} ↔
        PowerSeries.derivative k (constantPolynomialParameter g) ≠ 0 ∧
          ((PowerSeries.derivative k (constantPolynomialParameter g) : PowerSeries k) :
            LaurentSeries k).order = (n : ℤ) := by
  let A := CompletedPowerSeriesBase k
  let B := PowerSeries k
  letI : IsDomain A := completed_power_series_base_isDomain
  let φ := liftedCompletedEmbedding (constantPolynomialParameter g)
    (constant_polynomial_parameter_zero g hg)
  letI : Algebra A B := φ.toAlgebra
  letI : SMul A B := φ.toAlgebra.toSMul
  letI : Module A B := Algebra.toModule
  letI : NoZeroSMulDivisors A B := NoZeroSMulDivisors.iff_algebraMap_injective.mpr
    (lifted_constant_polynomial_completed_embedding_injective g hg)
  letI : IsIntegrallyClosed A := completed_power_series_base_integrally_closed
  letI : Algebra A (FractionRing B) :=
    (liftedCompletedFractionCoefficientEmbedding (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg)).toAlgebra
  letI : SMul A (FractionRing B) :=
    (liftedCompletedFractionCoefficientEmbedding (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg)).toAlgebra.toSMul
  letI : Module A (FractionRing B) := Algebra.toModule
  letI : FaithfulSMul A (FractionRing B) :=
    (faithfulSMul_iff_algebraMap_injective _ _).mpr
      (lifted_constant_polynomial_fraction_coefficient_embedding_injective g hg)
  letI : Algebra (FractionRing A) (FractionRing B) := FractionRing.liftAlgebra _ _
  letI : SMul (FractionRing A) (FractionRing B) := (FractionRing.liftAlgebra _ _).toSMul
  letI : Module (FractionRing A) (FractionRing B) := Algebra.toModule
  intro hsep
  have hd := constant_polynomial_completed_different g hg hzero hsep
  change differentIdeal A B = Ideal.span
    {(Polynomial.derivative (liftedConstantPoleReciprocal g)).eval₂ φ PowerSeries.X} at hd
  have hparameter : differentIdeal A B =
      Ideal.span {PowerSeries.derivative k (constantPolynomialParameter g)} :=
    hd.trans (lifted_constant_pole_reciprocal_derivative_ideal g hg)
  refine ⟨hparameter, fun n => ?_⟩
  rw [hparameter]
  exact power_series_principal_ideal_laurent_order_iff
    (PowerSeries.derivative k (constantPolynomialParameter g)) n

end Litt3.QuotientGeometry
