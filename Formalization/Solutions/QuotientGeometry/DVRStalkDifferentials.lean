import Solutions.QuotientGeometry.DVRFunctionFieldDifferentials
import Mathlib.RingTheory.Kaehler.Basic

namespace Litt3.QuotientGeometry

variable {k R : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]

noncomputable def completedDVRStalkPowerSeriesAlgebra
    (d : DVRCompletionParameters k R) : Algebra R (PowerSeries k) :=
  (completedDVRStalkEmbedding d).toRingHom.toAlgebra

/-- Differentiation of the entire expansion of an actual regular function. -/
noncomputable def dvrStalkDerivation
    (d : DVRCompletionParameters k R) :
    letI := completedDVRStalkPowerSeriesAlgebra d
    letI : SMul R (PowerSeries k) := (completedDVRStalkPowerSeriesAlgebra d).toSMul
    letI : Module R (PowerSeries k) := Algebra.toModule
    Derivation k R (PowerSeries k) :=
  fieldDerivationAlongAlgHom (completedDVRStalkEmbedding d) (PowerSeries.derivative k)

theorem dvrStalkDerivation_apply
    (d : DVRCompletionParameters k R) (r : R) :
    letI := completedDVRStalkPowerSeriesAlgebra d
    letI : SMul R (PowerSeries k) := (completedDVRStalkPowerSeriesAlgebra d).toSMul
    letI : Module R (PowerSeries k) := Algebra.toModule
    dvrStalkDerivation d r = PowerSeries.derivative k (completedDVRStalkEmbedding d r) :=
  fieldDerivationAlongAlgHom_apply (completedDVRStalkEmbedding d) (PowerSeries.derivative k) r

/-- The genuine universal differential is expanded by the genuine
derivation of the constructed whole completed stalk. -/
noncomputable def dvrStalkDifferential
    (d : DVRCompletionParameters k R) :
    letI := completedDVRStalkPowerSeriesAlgebra d
    letI : SMul R (PowerSeries k) := (completedDVRStalkPowerSeriesAlgebra d).toSMul
    letI : Module R (PowerSeries k) := Algebra.toModule
    KaehlerDifferential k R →ₗ[R] PowerSeries k := by
  letI := completedDVRStalkPowerSeriesAlgebra d
  letI : SMul R (PowerSeries k) := (completedDVRStalkPowerSeriesAlgebra d).toSMul
  letI : Module R (PowerSeries k) := Algebra.toModule
  haveI : IsScalarTower k R (PowerSeries k) :=
    IsScalarTower.of_algHom (completedDVRStalkEmbedding d)
  exact (dvrStalkDerivation d).liftKaehlerDifferential

theorem dvrStalkDifferential_D
    (d : DVRCompletionParameters k R) (r : R) :
    letI := completedDVRStalkPowerSeriesAlgebra d
    letI : SMul R (PowerSeries k) := (completedDVRStalkPowerSeriesAlgebra d).toSMul
    letI : Module R (PowerSeries k) := Algebra.toModule
    dvrStalkDifferential d (KaehlerDifferential.D k R r) =
      PowerSeries.derivative k (completedDVRStalkEmbedding d r) := by
  letI := completedDVRStalkPowerSeriesAlgebra d
  letI : SMul R (PowerSeries k) := (completedDVRStalkPowerSeriesAlgebra d).toSMul
  letI : Module R (PowerSeries k) := Algebra.toModule
  haveI : IsScalarTower k R (PowerSeries k) :=
    IsScalarTower.of_algHom (completedDVRStalkEmbedding d)
  exact (dvrStalkDerivation d).liftKaehlerDifferential_comp_D r

theorem dvrStalkDifferential_parameter
    (d : DVRCompletionParameters k R) :
    letI := completedDVRStalkPowerSeriesAlgebra d
    letI : SMul R (PowerSeries k) := (completedDVRStalkPowerSeriesAlgebra d).toSMul
    letI : Module R (PowerSeries k) := Algebra.toModule
    dvrStalkDifferential d (KaehlerDifferential.D k R d.parameter) = 1 := by
  letI := completedDVRStalkPowerSeriesAlgebra d
  letI : SMul R (PowerSeries k) := (completedDVRStalkPowerSeriesAlgebra d).toSMul
  letI : Module R (PowerSeries k) := Algebra.toModule
  rw [dvrStalkDifferential_D, completedDVRStalkEmbedding_parameter]
  simp

/-- A literal identity of universal differentials of the original regular
functions produces its literal infinite-series identity. Neither the
series nor the series differential equation is an input. -/
theorem dvr_differential_identity_expands
    (d : DVRCompletionParameters k R) (g s : R) (c : k) (n : ℕ)
    (hdg : KaehlerDifferential.D k R g =
      (algebraMap k R c * d.parameter ^ n * s) • KaehlerDifferential.D k R d.parameter) :
    PowerSeries.derivative k (completedDVRStalkEmbedding d g) =
      PowerSeries.C c * PowerSeries.X ^ n * completedDVRStalkEmbedding d s := by
  letI := completedDVRStalkPowerSeriesAlgebra d
  letI : SMul R (PowerSeries k) := (completedDVRStalkPowerSeriesAlgebra d).toSMul
  letI : Module R (PowerSeries k) := Algebra.toModule
  have he := congrArg (dvrStalkDifferential d) hdg
  rw [dvrStalkDifferential_D, map_smul, dvrStalkDifferential_parameter] at he
  change PowerSeries.derivative k (completedDVRStalkEmbedding d g) =
    completedDVRStalkEmbedding d (algebraMap k R c * d.parameter ^ n * s) * 1 at he
  simpa only [map_mul, map_pow, completedDVRStalkEmbedding_parameter,
    (completedDVRStalkEmbedding d).commutes, PowerSeries.algebraMap_apply,
    Algebra.id.map_eq_id, RingHom.id_apply, mul_one] using he

/-- A unit of the original local ring has nonzero constant term in its
constructed expansion. -/
theorem completedDVRStalkEmbedding_unit_constant_nonzero
    (d : DVRCompletionParameters k R) (u : R) (hu : IsUnit u) :
    PowerSeries.constantCoeff (completedDVRStalkEmbedding d u) ≠ 0 := by
  exact (PowerSeries.isUnit_iff_constantCoeff).mp (hu.map (completedDVRStalkEmbedding d))
    |>.ne_zero

end Litt3.QuotientGeometry
