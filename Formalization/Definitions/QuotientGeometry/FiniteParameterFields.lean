import Mathlib.RingTheory.PowerSeries.Substitution
import Mathlib.RingTheory.LaurentSeries

namespace Litt3.QuotientGeometry

/-- The fraction-field extension of actual power-series substitution.
The injection argument is supplied only to define the localization map;
it is proved from positive parameter order in the solution module. -/
noncomputable def parameterLaurentMap
    {k : Type*} [Field k] (b : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0)
    (hinj : Function.Injective (PowerSeries.subst b : PowerSeries k → PowerSeries k)) :
    LaurentSeries k →+* LaurentSeries k :=
  IsFractionRing.map (A := PowerSeries k) (B := PowerSeries k)
    (j := (PowerSeries.substAlgHom
      (PowerSeries.HasSubst.of_constantCoeff_zero' hb) :
        PowerSeries k →ₐ[k] PowerSeries k).toRingHom)
    (by
      change Function.Injective
        (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb) :
          PowerSeries k → PowerSeries k)
      simpa only [PowerSeries.coe_substAlgHom] using hinj)

end Litt3.QuotientGeometry
