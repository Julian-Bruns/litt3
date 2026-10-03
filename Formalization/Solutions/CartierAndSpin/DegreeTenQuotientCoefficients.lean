import Solutions.CartierAndSpin.UpperProductCoefficients
import Solutions.CartierAndSpin.CriticalInterpolationIdentity
import Definitions.CartierAndSpin.CriticalQuadratic

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The three critical quotient coefficients follow from the exact
interpolation identity. No critical leading coefficient or discriminant
is inverted, and all numerator/critical degree drops remain valid. -/
theorem degree_ten_general_critical_quotient_coefficients (F D U V2 Q : K[X])
    (hFdegree : F.natDegree = 10)
    (hU : U.natDegree ≤ 5) (hD : D.natDegree ≤ 3)
    (hV : V2.natDegree ≤ 9) (hQ : Q.natDegree ≤ 2)
    (hidentity : U ^ 2 - F * Q = D * V2) :
    F.leadingCoeff * Q.coeff 2 = -D.coeff 3 * V2.coeff 9 ∧
    F.leadingCoeff * Q.coeff 1 + F.coeff 9 * Q.coeff 2 =
      -D.coeff 3 * V2.coeff 8 - D.coeff 2 * V2.coeff 9 ∧
    F.leadingCoeff * Q.coeff 0 + F.coeff 9 * Q.coeff 1 + F.coeff 8 * Q.coeff 2 = U.coeff 5 ^ 2 -
      D.coeff 3 * V2.coeff 7 - D.coeff 2 * V2.coeff 8 - D.coeff 1 * V2.coeff 9 := by
  have hF : F.natDegree ≤ 10 := hFdegree.le
  have hleading : F.coeff 10 = F.leadingCoeff := by
    rw [← hFdegree, coeff_natDegree]
  have hUdegree : (U ^ 2).natDegree ≤ 10 := by
    rw [natDegree_pow]
    omega
  have h12 := congrArg (fun P : K[X] => P.coeff 12) hidentity
  have h11 := congrArg (fun P : K[X] => P.coeff 11) hidentity
  have h10 := congrArg (fun P : K[X] => P.coeff 10) hidentity
  dsimp only at h12 h11 h10
  have hFQ12 : (F * Q).coeff 12 = F.leadingCoeff * Q.coeff 2 := by
    exact (coeff_mul_add_eq_of_natDegree_le hF hQ).trans (by rw [hleading])
  have hDV12 : (D * V2).coeff 12 = D.coeff 3 * V2.coeff 9 :=
    coeff_mul_add_eq_of_natDegree_le hD hV
  have hFQ11 : (F * Q).coeff 11 =
      F.leadingCoeff * Q.coeff 1 + F.coeff 9 * Q.coeff 2 := by
    have h := polynomial_upper_product_first F Q 10 2 hF hQ (by omega) (by omega)
    simpa only [hleading] using h
  have hDV11 : (D * V2).coeff 11 =
      D.coeff 3 * V2.coeff 8 + D.coeff 2 * V2.coeff 9 := by
    exact polynomial_upper_product_first D V2 3 9 hD hV (by omega) (by omega)
  have hFQ10 : (F * Q).coeff 10 = F.leadingCoeff * Q.coeff 0 +
      F.coeff 9 * Q.coeff 1 + F.coeff 8 * Q.coeff 2 := by
    have h := polynomial_upper_product_second F Q 10 2 hF hQ (by omega) (by omega)
    simpa only [hleading] using h
  have hDV10 : (D * V2).coeff 10 = D.coeff 3 * V2.coeff 7 +
      D.coeff 2 * V2.coeff 8 + D.coeff 1 * V2.coeff 9 := by
    exact polynomial_upper_product_second D V2 3 9 hD hV (by omega) (by omega)
  rw [coeff_sub, coeff_eq_zero_of_natDegree_lt (hUdegree.trans_lt (by omega)),
    hFQ12, hDV12] at h12
  rw [coeff_sub, coeff_eq_zero_of_natDegree_lt (hUdegree.trans_lt (by omega)),
    hFQ11, hDV11] at h11
  rw [coeff_sub, coeff_pow_of_natDegree_le hU, hFQ10, hDV10] at h10
  refine ⟨?_, ?_, ?_⟩
  · linear_combination -h12
  · linear_combination -h11
  · linear_combination -h10

/-- The two-gap specialization, kept as a useful independent boundary
case rather than imposed on general raw degree-ten source polynomials. -/
theorem degree_ten_critical_quotient_coefficients (F D U V2 Q : K[X])
    (hFdegree : F.natDegree = 10) (hF9 : F.coeff 9 = 0) (hF8 : F.coeff 8 = 0)
    (hU : U.natDegree ≤ 5) (hD : D.natDegree ≤ 3)
    (hV : V2.natDegree ≤ 9) (hQ : Q.natDegree ≤ 2)
    (hidentity : U ^ 2 - F * Q = D * V2) :
    F.leadingCoeff * Q.coeff 2 = -D.coeff 3 * V2.coeff 9 ∧
    F.leadingCoeff * Q.coeff 1 =
      -D.coeff 3 * V2.coeff 8 - D.coeff 2 * V2.coeff 9 ∧
    F.leadingCoeff * Q.coeff 0 = U.coeff 5 ^ 2 -
      D.coeff 3 * V2.coeff 7 - D.coeff 2 * V2.coeff 8 - D.coeff 1 * V2.coeff 9 := by
  simpa only [hF9, hF8, zero_mul, add_zero] using
    degree_ten_general_critical_quotient_coefficients F D U V2 Q
      hFdegree hU hD hV hQ hidentity

end Litt3.CartierAndSpin
