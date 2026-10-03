import Solutions.CartierAndSpin.PowerSeriesSmallFactor
import Solutions.CartierAndSpin.PowerSeriesFactorCoefficients
import Solutions.CartierAndSpin.PolynomialLowProducts
import Solutions.CartierAndSpin.SourceLowCoefficients

namespace Litt3.CartierAndSpin

open Polynomial

variable {k ι : Type*} [Field k]

/-- The original source forces the improved small-factor coefficients,
including the third parameter coefficient needed for the mixed jet sum. -/
theorem small_factor_endpoint_coefficients (s : Finset ι) (node : ι → PowerSeries k)
    (F H G : (PowerSeries k)[X]) (q tau : PowerSeries k)
    (hcard : s.card = 5) (hnode : ∀ i ∈ s, PowerSeries.constantCoeff (node i) = 0)
    (hFG : F = Lagrange.nodal s node * G)
    (hsource : F = (X ^ 5 + C q) * H + C tau)
    (hresidue : G.map PowerSeries.constantCoeff = H.map PowerSeries.constantCoeff)
    (hGzero : PowerSeries.constantCoeff (G.coeff 0) ≠ 0)
    (hq : ∀ j < 3, PowerSeries.coeff j q = 0)
    (hqthree : PowerSeries.coeff 3 q ≠ 0) :
    let B := Lagrange.nodal s node
    (∀ l < 3, PowerSeries.coeff l (B.coeff 3) = 0) ∧
    (∀ l < 3, PowerSeries.coeff l (B.coeff 4) = 0) ∧
    PowerSeries.constantCoeff (G.coeff 1) = 0 ∧
    PowerSeries.coeff 3 (B.coeff 3) * PowerSeries.constantCoeff (G.coeff 0) =
      PowerSeries.coeff 3 q * PowerSeries.constantCoeff (H.coeff 3) := by
  classical
  let B := Lagrange.nodal s node
  have hFG' : F = B * G := hFG
  change (∀ l < 3, PowerSeries.coeff l (B.coeff 3) = 0) ∧ _
  have hBlow : ∀ j < 3, ∀ l < 5 - j, PowerSeries.coeff l (B.coeff j) = 0 := by
    intro j hj l hl
    apply power_series_nodal_coefficient_low_zero s node hnode j (by omega) l
    simpa only [hcard] using hl
  have hFl : ∀ j, 0 < j → j < 5 → ∀ l < 3,
      PowerSeries.coeff l (F.coeff j) = 0 := by
    intro j hj hj5 l hl
    have hc := source_polynomial_low_coefficient F H 5 j q tau hsource hj5
    simp only [if_neg (by omega : j ≠ 0), add_zero] at hc
    rw [hc]
    exact power_series_product_low_coefficient_zero q _ 3 hq l hl
  have hBthree : ∀ l < 3, PowerSeries.coeff l (B.coeff 3) = 0 := by
    apply power_series_polynomial_factor_coefficient_low_zero B G 3 3 hGzero
    · intro j hj l hl
      exact hBlow j hj l (by omega)
    · simpa only [← hFG'] using hFl 3 (by omega) (by omega)
  have hBfour : ∀ l < 3, PowerSeries.coeff l (B.coeff 4) = 0 := by
    apply power_series_polynomial_factor_coefficient_low_zero B G 4 3 hGzero
    · intro j hj l hl
      by_cases hj3 : j < 3
      · exact hBlow j hj3 l (by omega)
      · have hjEq : j = 3 := by omega
        subst j
        exact hBthree l hl
    · simpa only [← hFG'] using hFl 4 (by omega) (by omega)
  have hFone : PowerSeries.coeff 3 (F.coeff 1) = 0 := by
    rw [hFG', power_series_polynomial_product_coefficient_mod B G 1 4
      (by
        intro j hj l hl
        have hj0 : j = 0 := by omega
        subst j
        exact hBlow 0 (by omega) l (by omega))
      3 (by omega)]
    exact power_series_product_low_coefficient_zero _ _ 4 (hBlow 1 (by omega)) 3 (by omega)
  have hHone : PowerSeries.constantCoeff (H.coeff 1) = 0 := by
    have hc := source_polynomial_low_coefficient F H 5 1 q tau hsource (by omega)
    simp only [if_neg (by omega : (1 : ℕ) ≠ 0), add_zero] at hc
    rw [hc, power_series_leading_product_coefficient q _ 3 hq] at hFone
    exact (mul_eq_zero.mp hFone).resolve_left hqthree
  have hGone : PowerSeries.constantCoeff (G.coeff 1) = 0 := by
    have h := congrArg (fun P : k[X] => P.coeff 1) hresidue
    simpa only [Polynomial.coeff_map, hHone] using h
  have hFthree : PowerSeries.coeff 3 (F.coeff 3) =
      PowerSeries.coeff 3 q * PowerSeries.constantCoeff (H.coeff 3) := by
    have hc := source_polynomial_low_coefficient F H 5 3 q tau hsource (by omega)
    simp only [if_neg (by omega : (3 : ℕ) ≠ 0), add_zero] at hc
    rw [hc, power_series_leading_product_coefficient q _ 3 hq]
  have hFthree' : PowerSeries.coeff 3 (F.coeff 3) =
      PowerSeries.coeff 3 (B.coeff 3) * PowerSeries.constantCoeff (G.coeff 0) := by
    rw [hFG', polynomial_product_third_coefficient, map_add, map_add, map_add,
      power_series_product_low_coefficient_zero _ _ 4 (by intro l hl; exact hBlow 0 (by omega) l (by omega)) 3 (by omega),
      power_series_product_low_coefficient_zero _ _ 4 (hBlow 1 (by omega)) 3 (by omega),
      power_series_leading_product_coefficient _ _ 3 (hBlow 2 (by omega)), hGone,
      mul_zero, zero_add, zero_add,
      power_series_leading_product_coefficient _ _ 3 hBthree, zero_add]
  exact ⟨hBthree, hBfour, hGone, hFthree'.symm.trans hFthree⟩

end Litt3.CartierAndSpin
