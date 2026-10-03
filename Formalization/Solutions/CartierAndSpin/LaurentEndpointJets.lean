import Solutions.CartierAndSpin.CharacteristicFiveEndpointJets
import Solutions.CartierAndSpin.LaurentPowerSeriesCoordinates

namespace Litt3.CartierAndSpin

open Polynomial Lagrange

variable {k ι : Type*} [Field k] [CharP k 5] [Fintype ι]

/-- The canonical endpoint identities hold directly for the actual
Laurent-series source. All roots are retained; their first coefficients
may repeat or vanish. The remainder coefficient is the actual one. -/
theorem laurent_characteristic_five_endpoint_jets [DecidableEq k]
    (F H : (LaurentSeries k)[X]) (q tau leading : LaurentSeries k)
    (node : ι → LaurentSeries k)
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop)
    (hHleading : H.leadingCoeff.orderTop = 0)
    (hq : q.orderTop = 3) (htau : tau.orderTop = 3)
    (hnodes : ∀ i, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hfactor : F = C leading * nodal Finset.univ node)
    (hsource : F = (X ^ 5 + C q) * H + C tau) :
    let small := Finset.univ.filter (fun i => (node i).coeff 0 = 0)
    let e0 := (H.coeff 0).coeff 0
    let c := (H %ₘ (X ^ 5 + C q)).coeff 3
    e0 ≠ 0 ∧ small.card = 5 ∧
    e0 * q.coeff 3 + tau.coeff 3 = 0 ∧
    (∑ i ∈ small, (node i).coeff 1 ^ 2) = 0 ∧
    (∑ i ∈ small, (node i).coeff 1 * (node i).coeff 2) =
      -(q.coeff 3 * c.coeff 0) / e0 := by
  classical
  let f := HahnSeries.ofPowerSeries ℤ k
  obtain ⟨P, hP, hPleading⟩ := laurent_polynomial_unit_leading_descends H hH hHleading
  obtain ⟨Q, hQ, hQorder⟩ := laurent_exact_order_descends q 3 hq
  obtain ⟨T, hT, hTorder⟩ := laurent_exact_order_descends tau 3 htau
  choose w hw using fun i => laurent_integral_order_descends (node i) (hnodes i)
  have hHne : H ≠ 0 := by
    intro hz
    rw [hz, leadingCoeff_zero, HahnSeries.orderTop_zero] at hHleading
    exact WithTop.top_ne_coe hHleading
  have hl : leading = H.leadingCoeff := full_split_source_leading_coefficient
    Finset.univ node F H 5 q tau leading (by omega) hHne hfactor hsource
  have hPl : f P.leadingCoeff = leading := by
    rw [hl, ← hP, leadingCoeff_map_of_injective HahnSeries.ofPowerSeries_injective]
  let FP : (PowerSeries k)[X] := (X ^ 5 + C Q) * P + C T
  have hFP : FP.map f = F := by
    dsimp only [FP]
    rw [Polynomial.map_add, Polynomial.map_mul, Polynomial.map_add,
      Polynomial.map_pow, Polynomial.map_X, Polynomial.map_C, Polynomial.map_C]
    rw [show f Q = q from hQ, show f T = tau from hT, hP, hsource]
  have hfactorP : FP = C P.leadingCoeff * nodal Finset.univ w := by
    apply Polynomial.map_injective f HahnSeries.ofPowerSeries_injective
    rw [hFP, Polynomial.map_mul, Polynomial.map_C, polynomial_map_nodal, hPl]
    simpa only [show (fun i => f (w i)) = node from funext hw] using hfactor
  have hjets := characteristic_five_endpoint_jets Finset.univ w FP P Q T P.leadingCoeff
    hPleading hQorder hTorder hfactorP rfl
  have hcoeff (i : ι) (j : ℕ) : PowerSeries.coeff j (w i) = (node i).coeff j := by
    rw [← hw i, power_series_laurent_coefficient]
  have hPcoeff (j n : ℕ) : PowerSeries.coeff n (P.coeff j) = (H.coeff j).coeff n := by
    rw [← hP, Polynomial.coeff_map]
    exact (power_series_laurent_coefficient _ _).symm
  have hQcoeff (n : ℕ) : PowerSeries.coeff n Q = q.coeff n := by
    rw [← hQ, power_series_laurent_coefficient]
  have hTcoeff (n : ℕ) : PowerSeries.coeff n T = tau.coeff n := by
    rw [← hT, power_series_laurent_coefficient]
  have hrem : (P %ₘ (X ^ 5 + C Q)).map f = H %ₘ (X ^ 5 + C q) := by
    rw [Polynomial.map_modByMonic f (monic_X_pow_add_C Q (by omega)), hP,
      Polynomial.map_add, Polynomial.map_pow, Polynomial.map_X, Polynomial.map_C]
    rw [show f Q = q from hQ]
  have hc : PowerSeries.constantCoeff ((P %ₘ (X ^ 5 + C Q)).coeff 3) =
      ((H %ₘ (X ^ 5 + C q)).coeff 3).coeff 0 := by
    rw [← hrem, Polynomial.coeff_map]
    simpa only [PowerSeries.coeff_zero_eq_constantCoeff_apply] using
      (power_series_laurent_coefficient ((P %ₘ (X ^ 5 + C Q)).coeff 3) 0).symm
  simpa only [← PowerSeries.coeff_zero_eq_constantCoeff_apply, hcoeff, hPcoeff,
    hQcoeff, hTcoeff, hc] using hjets

end Litt3.CartierAndSpin
