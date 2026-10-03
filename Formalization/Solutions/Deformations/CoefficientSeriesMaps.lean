import Definitions.Deformations.CoefficientSeriesMaps
import Solutions.Deformations.CoefficientSeriesShiftPowers

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

@[simp] theorem coefficient_series_map_apply (f : Module.End R K)
    (v : CoefficientSeries (K := K)) (n : ℕ) :
    coefficientSeriesMap f v n = f (v n) := rfl

theorem coefficient_series_map_commute_shift (f : Module.End R K) (h : ℕ) :
    Commute (coefficientSeriesMap f) (coefficientSeriesShift h) := by
  apply LinearMap.ext
  intro v
  funext n
  by_cases high : h ≤ n
  · simp [coefficientSeriesMap, coefficientSeriesShift, high]
  · simp [coefficientSeriesMap, coefficientSeriesShift, high]

theorem coefficient_series_map_commute_tail (f : Module.End R K) (h : ℕ) :
    Commute (coefficientSeriesMap f) (coefficientSeriesTail h) := by
  apply LinearMap.ext
  intro v
  rfl

@[simp] theorem coefficient_series_map_one :
    coefficientSeriesMap (1 : Module.End R K) = 1 := by
  apply LinearMap.ext
  intro v
  rfl

@[simp] theorem coefficient_series_map_zero :
    coefficientSeriesMap (0 : Module.End R K) = 0 := by
  apply LinearMap.ext
  intro v
  rfl

@[simp] theorem coefficient_series_map_add (f g : Module.End R K) :
    coefficientSeriesMap (f + g) = coefficientSeriesMap f + coefficientSeriesMap g := by
  apply LinearMap.ext
  intro v
  rfl

@[simp] theorem coefficient_series_map_mul (f g : Module.End R K) :
    coefficientSeriesMap (f * g) = coefficientSeriesMap f * coefficientSeriesMap g := by
  apply LinearMap.ext
  intro v
  rfl

/-- The actual full noncommutative coefficient algebra acts through
coefficientwise operators; no coefficient commutativity is assumed. -/
def coefficientSeriesMapHom : Module.End R K →+* Module.End R (CoefficientSeries (K := K)) where
  toFun := coefficientSeriesMap
  map_one' := coefficient_series_map_one
  map_mul' := coefficient_series_map_mul
  map_zero' := coefficient_series_map_zero
  map_add' := coefficient_series_map_add

theorem coefficient_series_map_smul (c : R) (f : Module.End R K) :
    coefficientSeriesMap (c • f) = c • coefficientSeriesMap f := by
  apply LinearMap.ext
  intro v
  rfl

theorem coefficient_series_equiv_commute_shift (Phi : K ≃ₗ[R] K) (h : ℕ) :
    Commute (coefficientSeriesEquiv Phi).toLinearMap (coefficientSeriesShift h) :=
  coefficient_series_map_commute_shift Phi.toLinearMap h

end Litt3.Deformations
