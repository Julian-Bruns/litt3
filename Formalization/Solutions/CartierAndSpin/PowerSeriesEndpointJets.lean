import Solutions.CartierAndSpin.SmallFactorEndpointCoefficients
import Solutions.CartierAndSpin.SecondNewtonCoefficient

namespace Litt3.CartierAndSpin

open Polynomial Lagrange

variable {k ι : Type*} [Field k]

/-- The endpoint jet identities follow from the actual complete split
source. The statement even holds in any characteristic with 2 nonzero;
no distinctness of the roots' leading coefficients is required. -/
theorem power_series_endpoint_jets [DecidableEq k]
    (s : Finset ι) (node : ι → PowerSeries k)
    (F H : (PowerSeries k)[X]) (q tau leading : PowerSeries k)
    (htwo : (2 : k) ≠ 0) (hleading : PowerSeries.constantCoeff leading ≠ 0)
    (hq : ∀ j < 3, PowerSeries.coeff j q = 0)
    (hqthree : PowerSeries.coeff 3 q ≠ 0)
    (htau0 : PowerSeries.constantCoeff tau = 0)
    (htauthree : PowerSeries.coeff 3 tau ≠ 0)
    (hfactor : F = C leading * nodal s node)
    (hsource : F = (X ^ 5 + C q) * H + C tau) :
    let small := s.filter (fun i => PowerSeries.constantCoeff (node i) = 0)
    let e0 := PowerSeries.constantCoeff (H.coeff 0)
    e0 ≠ 0 ∧ small.card = 5 ∧
    e0 * PowerSeries.coeff 3 q + PowerSeries.coeff 3 tau = 0 ∧
    (∑ i ∈ small, PowerSeries.coeff 1 (node i) ^ 2) = 0 ∧
    (∑ i ∈ small, PowerSeries.coeff 1 (node i) * PowerSeries.coeff 2 (node i)) =
      -(PowerSeries.coeff 3 q * PowerSeries.constantCoeff (H.coeff 3)) / e0 := by
  classical
  let small := s.filter (fun i => PowerSeries.constantCoeff (node i) = 0)
  let big := s.filter (fun i => PowerSeries.constantCoeff (node i) ≠ 0)
  let B := nodal small node
  let G := C leading * nodal big node
  have hq0 : PowerSeries.constantCoeff q = 0 := by
    simpa only [PowerSeries.coeff_zero_eq_constantCoeff_apply] using hq 0 (by omega)
  obtain ⟨he0, hcard, hfirst⟩ := power_series_endpoint_root_count s node F H q tau leading 5 3
    (by omega) (by omega) hleading hq htau0 htauthree hfactor hsource
  obtain ⟨hFG, hBres, hGres⟩ := power_series_small_factor_residue s node F H q tau leading 5
    hq0 htau0 hfactor hsource hcard
  have hGzero : PowerSeries.constantCoeff (G.coeff 0) = PowerSeries.constantCoeff (H.coeff 0) := by
    have h := congrArg (fun P : k[X] => P.coeff 0) hGres
    simpa only [Polynomial.coeff_map] using h
  have hsmall : ∀ i ∈ small, PowerSeries.constantCoeff (node i) = 0 :=
    fun i hi => (Finset.mem_filter.mp hi).2
  have hsmallcoeff : ∀ i ∈ small, PowerSeries.coeff 0 (node i) = 0 := by
    simpa only [PowerSeries.coeff_zero_eq_constantCoeff_apply] using hsmall
  obtain ⟨hBthree, hBfour, hGone, hBthreejet⟩ := small_factor_endpoint_coefficients small node F H G q tau
    hcard hsmall hFG hsource hGres (hGzero ▸ he0) hq hqthree
  have hNewton := nodal_five_second_newton small node hcard
  have hsquare : (∑ i ∈ small, PowerSeries.coeff 1 (node i) ^ 2) = 0 := by
    have h := congrArg (PowerSeries.coeff 2) hNewton
    rw [power_series_sum_square_second_coefficient small node hsmallcoeff,
      map_sub, power_series_square_second_coefficient (B.coeff 4) (hBfour 0 (by omega)),
      hBfour 1 (by omega), zero_pow (by omega : (2 : ℕ) ≠ 0), two_mul, map_add,
      hBthree 2 (by omega), add_zero, sub_zero] at h
    exact h
  have hmixed : (∑ i ∈ small, PowerSeries.coeff 1 (node i) * PowerSeries.coeff 2 (node i)) =
      -PowerSeries.coeff 3 (B.coeff 3) := by
    have h := congrArg (PowerSeries.coeff 3) hNewton
    rw [power_series_sum_square_third_coefficient small node hsmallcoeff,
      map_sub, power_series_square_third_coefficient (B.coeff 4) (hBfour 0 (by omega)),
      hBfour 1 (by omega), mul_zero, zero_mul] at h
    simp only [two_mul, map_add, zero_sub] at h
    apply mul_left_cancel₀ htwo
    linear_combination h
  rw [hGzero] at hBthreejet
  have hratio : PowerSeries.coeff 3 (B.coeff 3) =
      PowerSeries.coeff 3 q * PowerSeries.constantCoeff (H.coeff 3) /
        PowerSeries.constantCoeff (H.coeff 0) := (eq_div_iff he0).mpr hBthreejet
  dsimp only
  refine ⟨he0, hcard, ?_, hsquare, ?_⟩
  · simpa only [mul_comm] using hfirst
  · rw [hmixed, hratio, neg_div]

end Litt3.CartierAndSpin
