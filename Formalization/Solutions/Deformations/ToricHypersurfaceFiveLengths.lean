import Solutions.Deformations.ToricHypersurfaceClosedLengths
import Solutions.Deformations.ToricHypersurfaceFiveArithmetic

namespace Litt3.Deformations

variable (K : Type*) [CommRing K] [Nontrivial K]

theorem toric_hypersurface_series_length_remainder_one (Q R s : ℕ)
    (positiveR : 0<R) (below : R≤Q) (quadratic : 2≤s) (remainder : R%s=1) :
    Module.finrank K (ToricHypersurfaceSeriesAlgebra K Q R s) =
      2*Q*R-(R^2+s-1)/s := by
  rw [toric_hypersurface_series_length_sum K Q R s (by omega) positiveR below (by omega)]
  exact toric_hypersurface_length_remainder_one Q R s positiveR below quadratic remainder

/-- Actual original quotient, all powers of five including one; no
characteristic restriction is needed for the toric quotient computation. -/
theorem toric_hypersurface_series_length_five_two (Q n : ℕ) (below : 5^n≤Q) :
    Module.finrank K (ToricHypersurfaceSeriesAlgebra K Q (5^n) 2) =
      2*Q*5^n-((5^n)^2+1)/2 := by
  have h := toric_hypersurface_series_length_remainder_one K Q (5^n) 2
    (pow_pos (by decide) _) below (by decide) (toric_hypersurface_five_power_mod_two n)
  have numerator : (5^n)^2+2-1=(5^n)^2+1 := by omega
  simpa only [numerator] using h

theorem toric_hypersurface_series_length_five_four (Q n : ℕ) (below : 5^n≤Q) :
    Module.finrank K (ToricHypersurfaceSeriesAlgebra K Q (5^n) 4) =
      2*Q*5^n-((5^n)^2+3)/4 := by
  have h := toric_hypersurface_series_length_remainder_one K Q (5^n) 4
    (pow_pos (by decide) _) below (by decide) (toric_hypersurface_five_power_mod_four n)
  have numerator : (5^n)^2+4-1=(5^n)^2+3 := by omega
  simpa only [numerator] using h

theorem toric_hypersurface_series_balanced_length_five_two (n : ℕ) :
    Module.finrank K (ToricHypersurfaceSeriesAlgebra K (5^n) (5^n) 2) =
      (3*(5^n)^2-1)/2 := by
  rw [toric_hypersurface_series_length_sum K (5^n) (5^n) 2
    (pow_pos (by decide) _) (pow_pos (by decide) _) le_rfl (by decide)]
  exact toric_hypersurface_balanced_length_remainder_one (5^n) 2
    (pow_pos (by decide) _) (by decide) (toric_hypersurface_five_power_mod_two n)

theorem toric_hypersurface_series_balanced_length_five_four (n : ℕ) :
    Module.finrank K (ToricHypersurfaceSeriesAlgebra K (5^n) (5^n) 4) =
      (7*(5^n)^2-3)/4 := by
  rw [toric_hypersurface_series_length_sum K (5^n) (5^n) 4
    (pow_pos (by decide) _) (pow_pos (by decide) _) le_rfl (by decide)]
  exact toric_hypersurface_balanced_length_remainder_one (5^n) 4
    (pow_pos (by decide) _) (by decide) (toric_hypersurface_five_power_mod_four n)

end Litt3.Deformations
