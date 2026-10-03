import Solutions.Deformations.PreparedCoefficientReduction
import Solutions.Deformations.PreparedCyclicLogNorm
import Solutions.Deformations.FiniteShiftScalarKernel

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The entire actual truncated logarithm reduces to the literal
truncated logarithm in the actual finite scalar coefficient module. -/
theorem prepared_coefficient_reduction_log (h : ℕ) (r : R) (nilpotent : IsNilpotent r)
    (C : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1))
    (v : CoefficientSeries (K := K) ⧸ LinearMap.range (preparedSeriesOperator h r C)) :
    preparedCoefficientReduction h r nilpotent C
      (truncatedLogValue (R := R) h (preparedSeriesQuotientAugmentation h r C
        (prepared_series_operator_commute_shift h r C commute)) v) =
      truncatedLogValue (R := R) h (finiteCoefficientShift (R := R) h)
        (preparedCoefficientReduction h r nilpotent C v) := by
  rw [truncated_log_value_aeval, truncated_log_value_aeval]
  exact linear_map_intertwining_polynomial (preparedCoefficientReduction h r nilpotent C) _ _
    (prepared_coefficient_reduction_augmentation h r nilpotent C commute) _ v

theorem prepared_last_scalar_zero_reduction (p a h : ℕ) (positive : 0 < p)
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0)
    (C : Module.End (ZMod (p ^ (a + 1))) (CoefficientSeries (K := K)))
    (v : CoefficientSeries (K := K) ⧸ LinearMap.range
      (preparedSeriesOperator h (p : ZMod (p ^ (a + 1))) C))
    (zero : (p : ZMod (p ^ (a + 1))) ^ a • v = 0) :
    preparedCoefficientReduction h (p : ZMod (p ^ (a + 1))) ⟨a + 1, vanish⟩ C v = 0 := by
  let e := preparedSeriesQuotientEquiv h (p : ZMod (p ^ (a + 1))) ⟨a + 1, vanish⟩ C
  have coordinates : (p : ZMod (p ^ (a + 1))) ^ a • e v = 0 := by
    rw [← map_smul, zero, map_zero]
  funext j
  exact free_zmod_last_scalar_reduction_zero p a positive K (e v j) (congrFun coordinates j)

end Litt3.Deformations
