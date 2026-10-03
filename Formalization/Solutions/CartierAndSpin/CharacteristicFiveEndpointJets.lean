import Solutions.CartierAndSpin.PowerSeriesEndpointJets
import Solutions.CartierAndSpin.SourceLeadingCoefficient
import Solutions.CartierAndSpin.LaurentIntegralPolynomials

namespace Litt3.CartierAndSpin

open Polynomial Lagrange

variable {k ι : Type*} [Field k] [CharP k 5]

/-- The literal characteristic-five endpoint jet clause, with the unit
leading coefficient and actual monic remainder from the canonical source. -/
theorem characteristic_five_endpoint_jets [DecidableEq k]
    (s : Finset ι) (node : ι → PowerSeries k)
    (F H : (PowerSeries k)[X]) (q tau leading : PowerSeries k)
    (hHleading : PowerSeries.constantCoeff H.leadingCoeff ≠ 0)
    (hq : q.order = 3) (htau : tau.order = 3)
    (hfactor : F = C leading * nodal s node)
    (hsource : F = (X ^ 5 + C q) * H + C tau) :
    let small := s.filter (fun i => PowerSeries.constantCoeff (node i) = 0)
    let e0 := PowerSeries.constantCoeff (H.coeff 0)
    let c := (H %ₘ (X ^ 5 + C q)).coeff 3
    e0 ≠ 0 ∧ small.card = 5 ∧
    e0 * PowerSeries.coeff 3 q + PowerSeries.coeff 3 tau = 0 ∧
    (∑ i ∈ small, PowerSeries.coeff 1 (node i) ^ 2) = 0 ∧
    (∑ i ∈ small, PowerSeries.coeff 1 (node i) * PowerSeries.coeff 2 (node i)) =
      -(PowerSeries.coeff 3 q * PowerSeries.constantCoeff c) / e0 := by
  classical
  have hH : H ≠ 0 := by
    intro hz
    simp only [hz, leadingCoeff_zero, map_zero, ne_eq, not_true_eq_false] at hHleading
  have hleading : PowerSeries.constantCoeff leading ≠ 0 := by
    rw [full_split_source_leading_coefficient s node F H 5 q tau leading
      (by omega) hH hfactor hsource]
    exact hHleading
  obtain ⟨hqthree, hqlow⟩ := (PowerSeries.order_eq_nat (n := 3)).mp hq
  obtain ⟨htauthree, htaulow⟩ := (PowerSeries.order_eq_nat (n := 3)).mp htau
  have hqzero : PowerSeries.constantCoeff q = 0 := by
    simpa only [PowerSeries.coeff_zero_eq_constantCoeff_apply] using hqlow 0 (by omega)
  have htauzero : PowerSeries.constantCoeff tau = 0 := by
    simpa only [PowerSeries.coeff_zero_eq_constantCoeff_apply] using htaulow 0 (by omega)
  have htwo : (2 : k) ≠ 0 := by
    change ((2 : ℕ) : k) ≠ 0
    rw [Ne, CharP.cast_eq_zero_iff k 5]
    norm_num
  have h := power_series_endpoint_jets s node F H q tau leading htwo hleading
    hqlow hqthree htauzero htauthree hfactor hsource
  have hc : PowerSeries.constantCoeff (H.coeff 3) =
      PowerSeries.constantCoeff ((H %ₘ (X ^ 5 + C q)).coeff 3) := by
    have heq := congrArg PowerSeries.constantCoeff
      (characteristic_remainder_low_coefficient_difference H q 5 3 (by omega) (by omega))
    rw [map_sub, map_mul, hqzero, zero_mul] at heq
    exact sub_eq_zero.mp heq
  simpa only [hc] using h

end Litt3.CartierAndSpin
