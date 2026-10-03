import Definitions.QuotientGeometry.ConstantPolePolynomial
import Mathlib.Algebra.Ring.ULift
import Mathlib.RingTheory.PowerSeries.Substitution
import Mathlib.RingTheory.Localization.FractionRing

namespace Litt3.QuotientGeometry

/-- A distinct copy of the downstairs completed ring, so its scalar
action cannot silently become the upstairs identity action. -/
abbrev CompletedPowerSeriesBase (k : Type*) := ULift.{0} (PowerSeries k)

noncomputable def liftedCompletedEmbedding
    {k : Type*} [Field k] (b : PowerSeries k) (hb : PowerSeries.constantCoeff b = 0) :
    CompletedPowerSeriesBase k →+* PowerSeries k :=
  (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)).toRingHom.comp
    (ULift.ringEquiv : CompletedPowerSeriesBase k ≃+* PowerSeries k).toRingHom

noncomputable def liftedConstantPoleReciprocal
    {k : Type*} [Field k] (g : Polynomial k) : Polynomial (CompletedPowerSeriesBase k) :=
  (constantPoleReciprocal g).map
    (ULift.ringEquiv : CompletedPowerSeriesBase k ≃+* PowerSeries k).symm.toRingHom

noncomputable def liftedCompletedFractionCoefficientEmbedding
    {k : Type*} [Field k] (b : PowerSeries k) (hb : PowerSeries.constantCoeff b = 0) :
    CompletedPowerSeriesBase k →+* FractionRing (PowerSeries k) :=
  (algebraMap (PowerSeries k) (FractionRing (PowerSeries k))).comp
    (liftedCompletedEmbedding b hb)

end Litt3.QuotientGeometry
