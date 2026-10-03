import Definitions.CartierAndSpin.PolynomialResidueMoments
import Solutions.CartierAndSpin.GeneralTwoStepRemainderCoefficients
import Solutions.CartierAndSpin.PolynomialResiduePairing

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- Exact inverse residue pairing in the actual cubic polynomial
quotient, valid for repeated and inseparable critical polynomials. -/
theorem cubic_residue_reconstruction (D P : K[X]) (hdegree : D.natDegree = 3)
    (hP : P.degree < D.degree) :
    P = cubicResidueReconstruction D (polynomialResidueMoment D P) := by
  have hD : D ≠ 0 := by intro hz; simp [hz] at hdegree
  have hleading : D.leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr hD
  have hleadingCoeff : D.coeff 3 = D.leadingCoeff := by rw [← hdegree, coeff_natDegree]
  have hPbound : P.natDegree ≤ 2 := by
    by_cases hz : P = 0
    · simp [hz]
    · have hlt := natDegree_lt_natDegree hz hP
      omega
  let z := polynomialResidueMoment D P
  have hz0 : z 0 = P.coeff 2 / D.leadingCoeff := by
    simp only [z, polynomialResidueMoment, pow_zero, one_mul,
      (mod_eq_self_iff hD).mpr hP, hdegree, Nat.reduceSub]
  have hz1 : z 1 = ((X * P) % D).coeff 2 / D.leadingCoeff := by
    simp only [z, polynomialResidueMoment, pow_one, hdegree, Nat.reduceSub]
  have hz2 : z 2 = ((X ^ 2 * P) % D).coeff 2 / D.leadingCoeff := by
    simp only [z, polynomialResidueMoment, hdegree, Nat.reduceSub]
  obtain ⟨hrec1, hrec2⟩ := source_two_step_remainder_top_recurrence D P hD (by omega) hP
  simp only [hdegree, Nat.reduceSub] at hrec1 hrec2
  have hp2 : P.coeff 2 = D.coeff 3 * z 0 := by
    rw [hleadingCoeff, hz0]
    field_simp [hleading]
  have hp1 : P.coeff 1 = D.coeff 3 * z 1 + D.coeff 2 * z 0 := by
    rw [hleadingCoeff, hz1, hz0, hrec1]
    field_simp [hleading]
    ring
  have hp0 : P.coeff 0 = D.coeff 3 * z 2 + D.coeff 2 * z 1 + D.coeff 1 * z 0 := by
    rw [hleadingCoeff, hz2, hz1, hz0, hrec2]
    field_simp [hleading]
    ring
  change P = cubicResidueReconstruction D z
  ext j
  by_cases hj : j ≤ 2
  · interval_cases j
    · simpa only [cubicResidueReconstruction, coeff_add, coeff_C_mul,
        coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
        ↓reduceIte, mul_zero, add_zero] using hp0
    · simpa only [cubicResidueReconstruction, coeff_add, coeff_C_mul,
        coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
        ↓reduceIte, mul_zero, mul_one, add_zero, zero_add] using hp1
    · simpa only [cubicResidueReconstruction, coeff_add, coeff_C_mul,
        coeff_X, coeff_X_pow, coeff_C, Nat.reduceEqDiff,
        ↓reduceIte, mul_zero, mul_one, add_zero, zero_add] using hp2
  · have hj0 : j ≠ 0 := by omega
    have hj1 : 1 ≠ j := by omega
    have hj2 : j ≠ 2 := by omega
    rw [coeff_eq_zero_of_natDegree_lt (hPbound.trans_lt (by omega))]
    simp only [cubicResidueReconstruction, coeff_add, coeff_C_mul,
      coeff_X, coeff_X_pow, coeff_C, hj0, hj1, hj2, if_false, mul_zero, add_zero]

end Litt3.CartierAndSpin
