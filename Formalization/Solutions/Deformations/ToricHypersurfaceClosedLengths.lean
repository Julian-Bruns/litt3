import Solutions.Deformations.ToricHypersurfaceSeriesDimensions
import Solutions.Deformations.ToricHypersurfaceLengthArithmetic

namespace Litt3.Deformations

variable (K : Type*) [CommRing K]

/-- Explicit constructed finite basis of the literal ORIGINAL series
quotient, transported by the genuine coefficient algebra equivalence. -/
noncomputable def toricHypersurfaceSeriesBasis (Q R s : ℕ)
    (positiveQ : 0<Q) (positiveR : 0<R) (below : R≤Q) (positiveS : 0<s) :
    Module.Basis (ToricHypersurfaceFiniteIndex Q R s) K
      (ToricHypersurfaceSeriesAlgebra K Q R s) :=
  (toricHypersurfaceFiniteBasis K Q R s positiveQ below positiveS).map
    (toricHypersurfaceSeriesPolynomialEquiv K Q R s positiveQ positiveR).symm.toLinearEquiv

variable [Nontrivial K]

/-- Exact canonical summation for the ORIGINAL toric formal-series
quotient; j=0 contributes zero, so this is the displayed sum j=1,...,Q-1. -/
theorem toric_hypersurface_series_length_sum (Q R s : ℕ)
    (positiveQ : 0<Q) (positiveR : 0<R) (below : R≤Q) (positiveS : 0<s) :
    Module.finrank K (ToricHypersurfaceSeriesAlgebra K Q R s) =
      toricHypersurfaceLengthSum Q R s := by
  rw [toric_hypersurface_series_finrank K Q R s positiveQ positiveR below positiveS,
    toric_hypersurface_fin_sum_eq_range Q R s positiveQ]
  rfl

/-- Exact floor/remainder length of the ACTUAL original toric series
quotient, valid in every characteristic and over every nontrivial
commutative coefficient ring. -/
theorem toric_hypersurface_series_length_floor (Q R s : ℕ)
    (positiveR : 0<R) (below : R≤Q) (quadratic : 2≤s) :
    Module.finrank K (ToricHypersurfaceSeriesAlgebra K Q R s) =
      2*Q*R-s*(R/s)^2-(R%s)*(2*(R/s)+1) := by
  rw [toric_hypersurface_series_length_sum K Q R s (by omega) positiveR below (by omega)]
  exact toric_hypersurface_length_floor Q R s positiveR below quadratic

end Litt3.Deformations
