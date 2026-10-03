import Solutions.CartierAndSpin.TruncatedLogarithmicODE

namespace Litt3.CartierAndSpin

open Polynomial Finset

/-- Multiplication by the top nilpotent power sees only the constant
coefficient, in the genuine quotient over ANY commutative ring. -/
theorem truncated_top_multiply_constant_one
    {R : Type*} [CommRing R] (p : ℕ) (hp : 0 < p)
    (U : R[X]) (hU0 : U.coeff 0 = 1) :
    AdjoinRoot.mk ((X : R[X]) ^ p) (X ^ (p - 1) * U) =
      AdjoinRoot.mk ((X : R[X]) ^ p) (X ^ (p - 1)) := by
  have hdiv : (X : R[X]) ∣ U - 1 := by
    rw [← pow_one (X : R[X]), X_pow_dvd_iff]
    intro n hn
    have hn0 : n = 0 := by omega
    subst n
    simp [coeff_sub, hU0]
  obtain ⟨Q, hQ⟩ := hdiv
  have hU : U = 1 + X * Q := by linear_combination hQ
  rw [hU, mul_add, mul_one, ← mul_assoc, ← pow_succ,
    Nat.sub_add_cancel hp, map_add, map_mul, AdjoinRoot.mk_self, zero_mul, add_zero]

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The literal recursively constructed ODE polynomial has an explicit
LAST residual coefficient for EVERY input, not only Cartier-fixed ones.
All lower coefficients vanish, and no differential equation is assumed. -/
theorem truncated_ode_residual_coeff (F : K[X]) (n : ℕ) (hn : n < p) :
    ((truncatedODEPolynomial F p).derivative - F * truncatedODEPolynomial F p).coeff n =
      if n = p - 1 then (F.coeff 0) ^ p - F.coeff (p - 1) else 0 := by
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
  by_cases hntop : n = p - 1
  · subst n
    have hlog := logarithmic_power_series_coefficient_frobenius (p := p) up
    change PowerSeries.coeff (p - 1) ell = (PowerSeries.coeff 0 ell) ^ p at hlog
    rw [hlow 0 (by omega)] at hlog
    have htop : PowerSeries.coeff (p - 1) (residual : PowerSeries K) =
        (F.coeff 0) ^ p - F.coeff (p - 1) := by
      rw [← hmul, PowerSeries.coeff_mul]
      rw [sum_eq_single (p - 1, 0)]
      · rw [map_sub, Polynomial.coeff_coe, hlog, hup, Polynomial.coeff_coe, hU0,
          mul_one]
      · intro ij hij hne
        have hsum := mem_antidiagonal.mp hij
        have hi : ij.1 < p - 1 := by
          by_contra h
          have heq : ij = (p - 1, 0) := Prod.ext (by omega) (by omega)
          exact hne heq
        rw [map_sub, Polynomial.coeff_coe, hlow ij.1 hi, sub_self, zero_mul]
      · simp
    simpa only [Polynomial.coeff_coe, residual, U, if_true] using htop
  · rw [if_neg hntop]
    exact hreslow n (by omega)

/-- An actual unit gauges an arbitrary truncated connection into a
single top-degree coefficient. The residual is derived from the ODE
recursion and the already proved logarithmic coefficient identity. -/
theorem truncated_connection_top_gauge (F : K[X]) :
    ∃ u : (TruncatedPolynomialAlgebra K p)ˣ,
      truncatedPolynomialDerivation K p (u : TruncatedPolynomialAlgebra K p) =
        (AdjoinRoot.mk ((X : K[X]) ^ p) F -
          algebraMap K (TruncatedPolynomialAlgebra K p)
            (F.coeff (p - 1) - (F.coeff 0) ^ p) *
          (AdjoinRoot.root ((X : K[X]) ^ p)) ^ (p - 1)) *
        (u : TruncatedPolynomialAlgebra K p) := by
  classical
  let U := truncatedODEPolynomial F p
  have hU0 : U.coeff 0 = 1 := truncated_ode_polynomial_constant F p
    (Fact.out : p.Prime).pos
  obtain ⟨u, hu⟩ := truncated_polynomial_unit_of_constant_one p U hU0
  refine ⟨u, ?_⟩
  rw [hu, truncated_polynomial_derivation_mk]
  have hres : AdjoinRoot.mk ((X : K[X]) ^ p)
      (U.derivative - F * U -
        C ((F.coeff 0) ^ p - F.coeff (p - 1)) * X ^ (p - 1)) = 0 := by
    apply AdjoinRoot.mk_eq_zero.mpr
    rw [X_pow_dvd_iff]
    intro n hn
    rw [coeff_sub, truncated_ode_residual_coeff F n hn, coeff_C_mul, coeff_X_pow]
    by_cases heq : n = p - 1
    · simp [heq]
    · simp [heq, Ne.symm heq]
  rw [map_sub, map_sub, map_mul, map_mul, AdjoinRoot.mk_C, map_pow,
    AdjoinRoot.mk_X] at hres
  have htop := truncated_top_multiply_constant_one p (Fact.out : p.Prime).pos U hU0
  rw [map_mul, map_pow, AdjoinRoot.mk_X] at htop
  rw [sub_mul, mul_assoc, htop]
  have hneg : algebraMap K (TruncatedPolynomialAlgebra K p)
      ((F.coeff 0) ^ p - F.coeff (p - 1)) =
      -algebraMap K (TruncatedPolynomialAlgebra K p)
        (F.coeff (p - 1) - (F.coeff 0) ^ p) := by
    rw [← map_neg]
    congr 1
    ring
  rw [← AdjoinRoot.algebraMap_eq, hneg] at hres
  linear_combination hres

end Litt3.CartierAndSpin
