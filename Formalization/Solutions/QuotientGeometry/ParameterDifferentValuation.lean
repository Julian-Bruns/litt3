import Solutions.QuotientGeometry.ParameterDifferent
import Solutions.QuotientGeometry.ParameterRelationDerivative
import Solutions.QuotientGeometry.PowerSeriesPrincipalOrders

namespace Litt3.QuotientGeometry

attribute [local instance] FractionRing.liftAlgebra FractionRing.isScalarTower_liftAlgebra

/-- The genuine trace-defined different for an arbitrary original positive
parameter is exactly its actual derivative ideal. Its different exponent
is the true Laurent order, proved before any choice of normal form. -/
theorem finite_parameter_completed_different_and_valuation
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0)
    (hb0 : PowerSeries.constantCoeff b = 0) :
    letI : IsDomain (CompletedPowerSeriesBase k) := completed_power_series_base_isDomain
    letI : Algebra (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding b hb0).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding b hb0).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (PowerSeries k) := Algebra.toModule
    letI : NoZeroSMulDivisors (CompletedPowerSeriesBase k) (PowerSeries k) :=
      NoZeroSMulDivisors.iff_algebraMap_injective.mpr
        (lifted_finite_parameter_embedding_injective n hn b c hb hc hb0)
    letI : IsIntegrallyClosed (CompletedPowerSeriesBase k) :=
      completed_power_series_base_integrally_closed
    letI : Algebra (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) := Algebra.toModule
    letI : FaithfulSMul (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (faithfulSMul_iff_algebraMap_injective _ _).mpr
        (lifted_finite_parameter_fraction_embedding_injective n hn b c hb hc hb0)
    letI : Algebra (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      FractionRing.liftAlgebra _ _
    letI : SMul (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      (FractionRing.liftAlgebra _ _).toSMul
    letI : Module (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      Algebra.toModule
    Algebra.IsSeparable (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) →
      differentIdeal (CompletedPowerSeriesBase k) (PowerSeries k) =
        Ideal.span {PowerSeries.derivative k b} ∧
      Module.finrank (FractionRing (CompletedPowerSeriesBase k))
        (FractionRing (PowerSeries k)) = n ∧
      (∀ d : ℕ, differentIdeal (CompletedPowerSeriesBase k) (PowerSeries k) =
        Ideal.span {(PowerSeries.X : PowerSeries k) ^ d} ↔
          PowerSeries.derivative k b ≠ 0 ∧
            ((PowerSeries.derivative k b : PowerSeries k) : LaurentSeries k).order = (d : ℤ)) := by
  let A := CompletedPowerSeriesBase k
  let B := PowerSeries k
  letI : IsDomain A := completed_power_series_base_isDomain
  let φ := liftedCompletedEmbedding b hb0
  letI : Algebra A B := φ.toAlgebra
  letI : SMul A B := φ.toAlgebra.toSMul
  letI : Module A B := Algebra.toModule
  letI : NoZeroSMulDivisors A B := NoZeroSMulDivisors.iff_algebraMap_injective.mpr
    (lifted_finite_parameter_embedding_injective n hn b c hb hc hb0)
  letI : IsIntegrallyClosed A := completed_power_series_base_integrally_closed
  letI : Algebra A (FractionRing B) :=
    (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra
  letI : SMul A (FractionRing B) :=
    (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra.toSMul
  letI : Module A (FractionRing B) := Algebra.toModule
  letI : FaithfulSMul A (FractionRing B) :=
    (faithfulSMul_iff_algebraMap_injective _ _).mpr
      (lifted_finite_parameter_fraction_embedding_injective n hn b c hb hc hb0)
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
  obtain ⟨pb, hgen, hdim⟩ := finite_parameter_completed_power_basis n hn b c hb hc hb0
  haveI : Module.Finite A B := pb.finite
  haveI : Algebra.IsIntegral A B := inferInstance
  haveI : IsIntegralClosure B A L := IsIntegralClosure.of_isIntegrallyClosed B A L
  haveI : IsLocalization (Algebra.algebraMapSubmonoid B (nonZeroDivisors A)) L :=
    IsIntegralClosure.isLocalization A K L B
  haveI : FiniteDimensional K L := Module.Finite.of_isLocalization A B (nonZeroDivisors A)
  have hd := integral_power_basis_different_ideal (K := K) (L := L) pb
  rw [hgen] at hd
  have hdegree : (minpoly A (PowerSeries.X : B)).natDegree = n := by
    simpa only [hgen, hdim] using pb.natDegree_minpoly
  have hmonic : (minpoly A (PowerSeries.X : B)).Monic := by
    rw [← hgen]
    exact minpoly.monic pb.isIntegral_gen
  have hroot : (minpoly A (PowerSeries.X : B)).eval₂ φ PowerSeries.X = 0 :=
    minpoly.aeval A (PowerSeries.X : B)
  have hparam := hd.trans (finite_parameter_relation_derivative_ideal n hn b c hb hb0
    (minpoly A (PowerSeries.X : B)) hmonic hdegree hroot)
  refine ⟨hparam, ?_, ?_⟩
  · have hfield := Module.finrank_eq_nat_card_basis
      (pb.basis.localizationLocalization K (nonZeroDivisors A) L)
    simpa only [Nat.card_fin, hdim] using hfield
  · intro d
    rw [hparam]
    exact power_series_principal_ideal_laurent_order_iff (PowerSeries.derivative k b) d

end Litt3.QuotientGeometry
