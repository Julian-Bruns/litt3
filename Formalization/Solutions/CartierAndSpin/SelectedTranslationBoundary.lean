import Solutions.CartierAndSpin.NormalizedDVRBoundary
import Mathlib.RingTheory.LocalRing.Basic

namespace Litt3.CartierAndSpin

open IsLocalRing
open scoped WithZero

theorem local_nonunit_minus_unit_isUnit {R : Type*} [CommRing R] [IsLocalRing R]
    (u z : R) (hu : ¬ IsUnit u) (hz : IsUnit z) : IsUnit (u - z) := by
  have hsum : IsUnit (u + (z - u)) := by
    rw [show u + (z - u) = z by ring]
    exact hz
  rcases isUnit_or_isUnit_of_isUnit_add hsum with hu' | hz'
  · exact False.elim (hu hu')
  · simpa only [neg_sub] using hz'.neg

variable {R K : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
  [Field K] [Algebra R K] [IsFractionRing R K]

/-- Subtracting an actual R-unit from an actual nonzero element of
normalized order two gives an actual R-unit of normalized order zero.
This proves loss of the selected double zero in the same local field. -/
theorem dvr_order_two_translation_zero_order (u : K) (hu : u ≠ 0)
    (horder : integerFieldOrder ((Litt3.Jacobians.discreteValuationPlace R).valuation K) u = 2)
    (z : R) (hz : IsUnit z) :
    ∃ b : R, IsUnit b ∧ algebraMap R K b = u - algebraMap R K z ∧
      u - algebraMap R K z ≠ 0 ∧
      integerFieldOrder ((Litt3.Jacobians.discreteValuationPlace R).valuation K)
        (u - algebraMap R K z) = 0 := by
  let v := (Litt3.Jacobians.discreteValuationPlace R).valuation K
  have hv : v.Integers R := dvr_height_one_valuation_integers
  have hlog : WithZero.log (v u) = -2 := by
    change -WithZero.log (v u) = 2 at horder
    omega
  have hvalue : v u = WithZero.exp (-2 : ℤ) := by
    rw [← WithZero.exp_log ((Valuation.ne_zero_iff v).mpr hu), hlog]
  have hregular : v u ≤ 1 := by
    rw [hvalue, ← WithZero.exp_zero, WithZero.exp_le_exp]
    norm_num
  obtain ⟨a, ha⟩ := hv.exists_of_le_one hregular
  have haunit : ¬ IsUnit a := by
    intro hunit
    have hvalueone : v u = 1 := by rw [← ha]; exact hv.one_of_isUnit hunit
    rw [hvalueone, WithZero.log_one] at hlog
    norm_num at hlog
  have htranslated := local_nonunit_minus_unit_isUnit a z haunit hz
  have htranslatedmap : algebraMap R K (a - z) = u - algebraMap R K z := by
    rw [map_sub, ha]
  have hnonzero : u - algebraMap R K z ≠ 0 := by
    rw [← htranslatedmap]
    exact (htranslated.map (algebraMap R K)).ne_zero
  refine ⟨a - z, htranslated, htranslatedmap, hnonzero, ?_⟩
  change integerFieldOrder v (u - algebraMap R K z) = 0
  rw [← htranslatedmap]
  simp only [integerFieldOrder, hv.one_of_isUnit htranslated, WithZero.log_one, neg_zero]

/-- Every nonzero constant-field scalar is automatically a unit in the
actual DVR, so the preceding boundary applies without a unit hypothesis. -/
theorem dvr_nonzero_scalar_translation_zero_order {k : Type*} [Field k]
    [Algebra k R] [Algebra k K] [IsScalarTower k R K]
    (u : K) (hu : u ≠ 0)
    (horder : integerFieldOrder ((Litt3.Jacobians.discreteValuationPlace R).valuation K) u = 2)
    (z : k) (hz : z ≠ 0) :
    ∃ b : R, IsUnit b ∧ algebraMap R K b = u - algebraMap k K z ∧
      u - algebraMap k K z ≠ 0 ∧
      integerFieldOrder ((Litt3.Jacobians.discreteValuationPlace R).valuation K)
        (u - algebraMap k K z) = 0 := by
  simpa only [IsScalarTower.algebraMap_apply k R K] using
    dvr_order_two_translation_zero_order (R := R) u hu horder (algebraMap k R z)
      ((isUnit_iff_ne_zero.mpr hz).map (algebraMap k R))

end Litt3.CartierAndSpin
