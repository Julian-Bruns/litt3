import Theorems.QuotientGeometry.ParameterCoordinates
import Solutions.QuotientGeometry.ParameterSubstitution

namespace Litt3.QuotientGeometry

theorem parameter_power_series_automorphism : ParameterPowerSeriesAutomorphism := by
  intro k _ b hb hlinear
  let e : PowerSeries k ≃ₐ[k] PowerSeries k := AlgEquiv.ofBijective
    (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb))
    ⟨parameter_substitution_injective b hb hlinear,
      parameter_substitution_surjective b hb hlinear⟩
  refine ⟨e, ?_⟩
  intro f
  simp only [e, AlgEquiv.ofBijective_apply, PowerSeries.coe_substAlgHom]

theorem parameter_laurent_automorphism : ParameterLaurentAutomorphism := by
  intro k _ b hb hlinear
  letI : SMul k (LaurentSeries k) := (inferInstance : Algebra k (LaurentSeries k)).toSMul
  haveI : IsScalarTower k (PowerSeries k) (LaurentSeries k) :=
    IsScalarTower.of_algebraMap_eq' (R := k) (S := PowerSeries k) (A := LaurentSeries k) rfl
  obtain ⟨e, he⟩ := parameter_power_series_automorphism b hb hlinear
  let E : LaurentSeries k ≃ₐ[k] LaurentSeries k := IsFractionRing.algEquivOfAlgEquiv e
  refine ⟨E, ?_⟩
  intro f
  change E (algebraMap (PowerSeries k) (LaurentSeries k) f) = _
  rw [IsFractionRing.algEquivOfAlgEquiv_algebraMap, he]
  rfl

end Litt3.QuotientGeometry
