import Solutions.QuotientGeometry.CompletedEmbeddingRegularity
import Solutions.QuotientGeometry.ParameterPowerBasis

namespace Litt3.QuotientGeometry

theorem lifted_completed_embedding_apply
    {k : Type*} [Field k] (b : PowerSeries k)
    (hb0 : PowerSeries.constantCoeff b = 0) (r : CompletedPowerSeriesBase k) :
    liftedCompletedEmbedding b hb0 r = PowerSeries.subst b r.down := by
  change (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)) r.down = _
  rw [PowerSeries.coe_substAlgHom]

theorem lifted_finite_parameter_embedding_injective
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0)
    (hb0 : PowerSeries.constantCoeff b = 0) :
    Function.Injective (liftedCompletedEmbedding b hb0) := by
  intro x y hxy
  apply ULift.down_injective
  apply finite_parameter_substitution_injective n hn b c hb hc
  simpa only [liftedCompletedEmbedding, RingHom.comp_apply, AlgHom.toRingHom_eq_coe,
    AlgHom.coe_toRingHom, PowerSeries.coe_substAlgHom] using hxy

theorem lifted_finite_parameter_fraction_embedding_injective
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0)
    (hb0 : PowerSeries.constantCoeff b = 0) :
    Function.Injective (liftedCompletedFractionCoefficientEmbedding b hb0) :=
  (IsFractionRing.injective (PowerSeries k) (FractionRing (PowerSeries k))).comp
    (lifted_finite_parameter_embedding_injective n hn b c hb hc hb0)

end Litt3.QuotientGeometry
