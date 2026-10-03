import Mathlib.RingTheory.MvPowerSeries.Inverse

namespace Litt3.Deformations

variable (K I : Type*) [Field K]

/-- Every actual formal-series ring automorphism preserves zero
constant term of each original variable. Continuity or a coefficient
algebra condition is unnecessary: the literal unit criterion suffices. -/
theorem series_automorphism_variable_constant_zero
    (e : MvPowerSeries I K ≃+* MvPowerSeries I K) (i : I) :
    MvPowerSeries.coeff 0 (e (MvPowerSeries.X i)) = 0 := by
  change MvPowerSeries.constantCoeff (e (MvPowerSeries.X i)) = 0
  by_contra nonzero
  have imageUnit : IsUnit (e (MvPowerSeries.X i)) :=
    MvPowerSeries.isUnit_iff_constantCoeff.mpr (isUnit_iff_ne_zero.mpr nonzero)
  have sourceUnit : IsUnit (MvPowerSeries.X i : MvPowerSeries I K) := by
    have lifted := imageUnit.map e.symm.toRingHom
    change IsUnit (e.symm (e (MvPowerSeries.X i))) at lifted
    simpa only [e.symm_apply_apply] using lifted
  have zeroUnit : IsUnit (0 : K) := by
    simpa only [MvPowerSeries.constantCoeff_X] using
      MvPowerSeries.isUnit_iff_constantCoeff.mp sourceUnit
  exact not_isUnit_zero zeroUnit

end Litt3.Deformations
