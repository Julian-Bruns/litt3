import Solutions.QuotientGeometry.DVRFunctionFieldCompletion

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry Litt3.Jacobians

variable {k R K : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [Field K] [Algebra R K] [IsFractionRing R K]

theorem dvr_height_one_place_unique (v : IsDedekindDomain.HeightOneSpectrum R) :
    v = discreteValuationPlace R := by
  apply IsDedekindDomain.HeightOneSpectrum.ext
  exact IsLocalRing.eq_maximalIdeal (v.isPrime.isMaximal v.ne_bot)

/-- An original rational function is regular in the actual DVR exactly
when its constructed full Laurent expansion belongs to k[[t]]. -/
theorem actual_dvr_regular_iff_completed_power_series
    (d : DVRCompletionParameters k R) (f : K) :
    f ∈ (algebraMap R K).range ↔
      ∃ g : PowerSeries k, (g : LaurentSeries k) = dvrFunctionFieldCompletion d f := by
  constructor
  · rintro ⟨r, rfl⟩
    exact ⟨completedDVRStalkEmbedding d r, (dvrFunctionFieldCompletion_ring d r).symm⟩
  · rintro ⟨g, hg⟩
    apply IsDedekindDomain.HeightOneSpectrum.mem_integers_of_valuation_le_one
    intro v
    rw [dvr_height_one_place_unique v, ← dvrFunctionFieldCompletion_valuation d f, ← hg]
    exact (discreteValuationPlace (PowerSeries k)).valuation_le_one _

end Litt3.SharedTensors
