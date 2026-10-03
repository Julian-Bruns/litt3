import Definitions.QuotientGeometry.LiftedCompletedEmbedding
import Solutions.QuotientGeometry.ConstantPolynomialParameter
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

namespace Litt3.QuotientGeometry

theorem completed_power_series_base_isDomain
    {k : Type*} [Field k] : IsDomain (CompletedPowerSeriesBase k) :=
  Function.Injective.isDomain
    (ULift.ringEquiv : CompletedPowerSeriesBase k ≃+* PowerSeries k).toRingHom
    (ULift.ringEquiv : CompletedPowerSeriesBase k ≃+* PowerSeries k).injective

theorem completed_power_series_base_integrally_closed
    {k : Type*} [Field k] : IsIntegrallyClosed (CompletedPowerSeriesBase k) :=
  IsIntegrallyClosed.of_equiv
    (ULift.ringEquiv : CompletedPowerSeriesBase k ≃+* PowerSeries k).symm

theorem lifted_constant_polynomial_completed_embedding_injective
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    Function.Injective (liftedCompletedEmbedding (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg)) := by
  intro x y hxy
  have hdown : x.down = y.down :=
    (constant_polynomial_parameter_injective g hg) (by
      simpa only [liftedCompletedEmbedding, RingHom.comp_apply, AlgHom.toRingHom_eq_coe,
        AlgHom.coe_toRingHom, PowerSeries.coe_substAlgHom] using hxy)
  exact ULift.down_injective hdown

theorem lifted_constant_polynomial_fraction_coefficient_embedding_injective
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    Function.Injective (liftedCompletedFractionCoefficientEmbedding (constantPolynomialParameter g)
      (constant_polynomial_parameter_zero g hg)) :=
  (IsFractionRing.injective (PowerSeries k) (FractionRing (PowerSeries k))).comp
    (lifted_constant_polynomial_completed_embedding_injective g hg)

end Litt3.QuotientGeometry
