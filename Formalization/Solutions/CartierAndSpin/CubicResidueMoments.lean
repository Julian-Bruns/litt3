import Solutions.CartierAndSpin.CubicResidueReconstruction

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

theorem cubic_residue_reconstruction_degree (D : K[X]) (z : ℕ → K) :
    (cubicResidueReconstruction D z).degree < 3 := by
  apply (degree_lt_iff_coeff_zero _ 3).mpr
  intro j hj
  have hj0 : j ≠ 0 := by omega
  have hj1 : 1 ≠ j := by omega
  have hj2 : j ≠ 2 := by omega
  simp only [cubicResidueReconstruction, coeff_add, coeff_C_mul,
    coeff_X, coeff_X_pow, coeff_C, hj0, hj1, hj2, if_false, mul_zero, add_zero]

/-- The literal cubic inverse recovers exactly the three prescribed
residue moments; no condition is imposed on values z(j) for j≥3. -/
theorem cubic_residue_reconstruction_moments (D : K[X])
    (hdegree : D.natDegree = 3) (z : ℕ → K) (j : ℕ) (hj : j < 3) :
    polynomialResidueMoment D (cubicResidueReconstruction D z) j = z j := by
  have hD : D ≠ 0 := by intro hz; simp [hz] at hdegree
  have hleading : D.coeff 3 ≠ 0 := by
    rw [← hdegree, coeff_natDegree]
    exact leadingCoeff_ne_zero.mpr hD
  let m := polynomialResidueMoment D (cubicResidueReconstruction D z)
  have hsmall : (cubicResidueReconstruction D z).degree < D.degree := by
    rw [degree_eq_natDegree hD, hdegree]
    exact cubic_residue_reconstruction_degree D z
  have hreconstruct := cubic_residue_reconstruction D
    (cubicResidueReconstruction D z) hdegree hsmall
  change cubicResidueReconstruction D z = cubicResidueReconstruction D m at hreconstruct
  have hc (i : ℕ) := congrArg (fun P : K[X] => P.coeff i) hreconstruct
  have h0 : m 0 = z 0 := by
    have h := hc 2
    dsimp only at h
    simp only [cubicResidueReconstruction, coeff_add, coeff_C_mul,
      coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
      ↓reduceIte, mul_zero, mul_one, add_zero, zero_add] at h
    exact (mul_left_cancel₀ hleading h).symm
  have h1 : m 1 = z 1 := by
    have h := hc 1
    dsimp only at h
    simp only [cubicResidueReconstruction, coeff_add, coeff_C_mul,
      coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
      ↓reduceIte, mul_zero, mul_one, add_zero, zero_add, h0] at h
    exact (mul_left_cancel₀ hleading (add_right_cancel h)).symm
  have h2 : m 2 = z 2 := by
    have h := hc 0
    dsimp only at h
    simp only [cubicResidueReconstruction, coeff_add, coeff_C_mul,
      coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
      ↓reduceIte, mul_zero, mul_one, add_zero, zero_add, h0, h1] at h
    exact (mul_left_cancel₀ hleading (add_right_cancel (add_right_cancel h))).symm
  change m j = z j
  interval_cases j
  · exact h0
  · exact h1
  · exact h2

/-- Cubic critical incidence is exactly equivalent to the three genuine
residue equations, even at repeated or inseparable critical roots. -/
theorem cubic_residue_moment_equations_iff (D P : K[X])
    (hdegree : D.natDegree = 3) (hP : P.degree < D.degree) (z : ℕ → K) :
    (∀ j : ℕ, j < 3 → polynomialResidueMoment D P j = z j) ↔
      P = cubicResidueReconstruction D z := by
  constructor
  · intro hmoments
    rw [cubic_residue_reconstruction D P hdegree hP]
    simp only [cubicResidueReconstruction, hmoments 0 (by omega),
      hmoments 1 (by omega), hmoments 2 (by omega)]
  · intro h
    subst P
    exact cubic_residue_reconstruction_moments D hdegree z

end Litt3.CartierAndSpin
