import Mathlib.RingTheory.MvPowerSeries.Order
import Mathlib.RingTheory.MvPowerSeries.Inverse
import Mathlib.RingTheory.LocalRing.MaximalIdeal.Basic

namespace Litt3.Deformations

variable (K I : Type*) [Field K]

/-- The maximal ideal of the ORIGINAL formal-series local ring is
exactly the kernel of its unchanged original constant coefficient. -/
theorem original_series_maximal_ideal_eq_constant_kernel :
    IsLocalRing.maximalIdeal (MvPowerSeries I K) = RingHom.ker MvPowerSeries.constantCoeff := by
  symm
  exact IsLocalRing.ker_eq_maximalIdeal (MvPowerSeries.constantCoeff : MvPowerSeries I K →+* K)
    (fun c => ⟨MvPowerSeries.C c, MvPowerSeries.constantCoeff_C c⟩)

/-- The original maximal-square condition derives order at least two;
no coefficient vanishing or quadratic normal form is supplied. -/
theorem original_series_maximal_square_order (f : MvPowerSeries I K)
    (quadratic : f ∈ IsLocalRing.maximalIdeal (MvPowerSeries I K) ^ 2) :
    2 ≤ f.order := by
  have positive (g : MvPowerSeries I K)
      (member : g ∈ IsLocalRing.maximalIdeal (MvPowerSeries I K)) : 1 ≤ g.order := by
    apply ENat.one_le_iff_ne_zero.mpr
    apply MvPowerSeries.order_ne_zero_iff_constCoeff_eq_zero.mpr
    rwa [original_series_maximal_ideal_eq_constant_kernel, RingHom.mem_ker] at member
  rw [pow_two] at quadratic
  refine Submodule.mul_induction_on quadratic ?_ ?_
  · intro g hg h hh
    exact (show (2 : ℕ∞) ≤ g.order + h.order by
      exact add_le_add (positive g hg) (positive h hh)).trans (MvPowerSeries.le_order_mul (f := g) (g := h))
  · intro g h hg hh
    exact (le_min hg hh).trans (MvPowerSeries.min_order_le_add (f := g) (g := h))

end Litt3.Deformations
