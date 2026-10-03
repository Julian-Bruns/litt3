import Solutions.CartierAndSpin.PowerSeriesRootResidues

namespace Litt3.CartierAndSpin

open Polynomial Lagrange

variable {k ι : Type*} [Field k]

/-- All endpoint hypotheses come from the original full split source:
nonzero first tau coefficient forces H(0) to be a unit and counts exactly p
small roots. No distinct residue or leading coefficient is assumed. -/
theorem power_series_endpoint_root_count [DecidableEq k]
    (s : Finset ι) (node : ι → PowerSeries k)
    (F H : (PowerSeries k)[X]) (q tau leading : PowerSeries k) (p m : ℕ)
    (hm : 0 < m) (hmp : m < p)
    (hleading : PowerSeries.constantCoeff leading ≠ 0)
    (hq : ∀ j < m, PowerSeries.coeff j q = 0)
    (htau0 : PowerSeries.constantCoeff tau = 0)
    (htau : PowerSeries.coeff m tau ≠ 0)
    (hfactor : F = C leading * nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau) :
    PowerSeries.constantCoeff (H.coeff 0) ≠ 0 ∧
    (s.filter (fun i => PowerSeries.constantCoeff (node i) = 0)).card = p ∧
    PowerSeries.coeff m q * PowerSeries.constantCoeff (H.coeff 0) +
      PowerSeries.coeff m tau = 0 := by
  classical
  have hq0 : PowerSeries.constantCoeff q = 0 := by
    simpa only [PowerSeries.coeff_zero_eq_constantCoeff_apply] using hq 0 hm
  obtain ⟨i, hi, hwi⟩ := power_series_source_has_small_root s node F H q tau leading p
    (by omega) hleading hq0 htau0 hfactor hsource
  have hroot : (node i ^ p + q) * H.eval (node i) + tau = 0 := by
    have hz : F.eval (node i) = 0 := by rw [hfactor, eval_mul, eval_nodal_at_node hi, mul_zero]
    simpa only [hsource, eval_add, eval_mul, eval_pow, eval_X, eval_C] using hz
  have hH := power_series_small_root_constant_unit H (node i) q tau p m hmp hwi hq htau hroot
  exact ⟨hH, power_series_source_small_root_count s node F H q tau leading p
    hleading hq0 htau0 hH hfactor hsource,
    power_series_small_root_leading_relation H (node i) q tau p m hmp hwi hq hroot⟩

end Litt3.CartierAndSpin
