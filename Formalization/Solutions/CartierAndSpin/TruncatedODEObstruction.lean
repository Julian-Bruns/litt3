import Solutions.CartierAndSpin.TruncatedODELowerEquations
import Solutions.CartierAndSpin.LogarithmicPowerSeriesCoefficient
import Mathlib.RingTheory.PowerSeries.Inverse

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The already proved forward logarithmic coefficient identity removes
the LAST truncated ODE obstruction. The actual coefficient recursion
constructs the unit; no solution, curvature or nilpotence is assumed. -/
theorem truncated_ode_all_coefficient_equations (F : K[X])
    (hF : F.coeff (p - 1) = (F.coeff 0) ^ p) (n : ℕ) (hn : n < p) :
    (truncatedODEPolynomial F p).derivative.coeff n =
      (F * truncatedODEPolynomial F p).coeff n := by
  classical
  have hp : 2 ≤ p := (Fact.out : p.Prime).two_le
  let U := truncatedODEPolynomial F p
  have hU0 : U.coeff 0 = 1 := truncated_ode_polynomial_constant F p (by omega)
  have hunit : IsUnit (U : PowerSeries K) := by
    apply PowerSeries.isUnit_iff_constantCoeff.mpr
    rw [Polynomial.constantCoeff_coe, hU0]
    exact isUnit_one
  obtain ⟨up, hup⟩ := hunit
  let ell := PowerSeries.derivative K (up : PowerSeries K) * (↑up⁻¹ : PowerSeries K)
  let residual := U.derivative - F * U
  have hmul : (ell - (F : PowerSeries K)) * (up : PowerSeries K) =
      (residual : PowerSeries K) := by
    dsimp only [ell, residual]
    calc
      _ = PowerSeries.derivative K (up : PowerSeries K) *
          ((↑up⁻¹ : PowerSeries K) * (up : PowerSeries K)) -
          (F : PowerSeries K) * (up : PowerSeries K) := by ring
      _ = _ := by
        rw [Units.inv_mul, mul_one, hup, PowerSeries.derivative_coe,
          Polynomial.coe_sub, Polynomial.coe_mul]
  have hdiff : ell - (F : PowerSeries K) =
      (residual : PowerSeries K) * (↑up⁻¹ : PowerSeries K) := by
    rw [← hmul, mul_assoc, Units.mul_inv, mul_one]
  have hreslow (i : ℕ) (hi : i < p - 1) : residual.coeff i = 0 := by
    dsimp only [residual, U]
    rw [coeff_sub, truncated_ode_lower_equation p F i (by omega), sub_self]
  have hlow (i : ℕ) (hi : i < p - 1) : PowerSeries.coeff i ell = F.coeff i := by
    have hz : PowerSeries.coeff i (ell - (F : PowerSeries K)) = 0 := by
      rw [hdiff, PowerSeries.coeff_mul]
      apply sum_eq_zero
      intro ij hij
      have hsum := mem_antidiagonal.mp hij
      rw [Polynomial.coeff_coe, hreslow ij.1 (by omega), zero_mul]
    simpa only [map_sub, Polynomial.coeff_coe, sub_eq_zero] using hz
  have hlog := logarithmic_power_series_coefficient_frobenius (p := p) up
  change PowerSeries.coeff (p - 1) ell = (PowerSeries.coeff 0 ell) ^ p at hlog
  rw [hlow 0 (by omega)] at hlog
  have htop : PowerSeries.coeff (p - 1) ell = F.coeff (p - 1) := hlog.trans hF.symm
  have hdiffzero (i : ℕ) (hi : i < p) :
      PowerSeries.coeff i (ell - (F : PowerSeries K)) = 0 := by
    rw [map_sub, Polynomial.coeff_coe]
    apply sub_eq_zero.mpr
    by_cases hitop : i = p - 1
    · simpa only [hitop] using htop
    · exact hlow i (by omega)
  have hreszero : PowerSeries.coeff n (residual : PowerSeries K) = 0 := by
    rw [← hmul, PowerSeries.coeff_mul]
    apply sum_eq_zero
    intro ij hij
    have hsum := mem_antidiagonal.mp hij
    rw [hdiffzero ij.1 (by omega), zero_mul]
  rw [Polynomial.coeff_coe] at hreszero
  dsimp only [residual] at hreszero
  rw [coeff_sub] at hreszero
  exact sub_eq_zero.mp hreszero

end Litt3.CartierAndSpin
