import Theorems.Deformations.HermitianLeadingForms
import Mathlib.Algebra.Polynomial.Div

namespace Litt3.Deformations

open Polynomial

section CoefficientSymmetry

variable {k ι : Type*} [CommRing k]

/-- Reflection of a polynomial multiplies degree-e coefficients by
(-1)^e. No characteristic or degree bound is used. -/
theorem polynomial_reflection_coefficient (p : Polynomial k) (e : ℕ) :
    (p.comp (-X)).coeff e = p.coeff e * (-1 : k) ^ e := by
  have hX : (-X : Polynomial k) = C (-1) * X := by simp
  rw [hX, comp_C_mul_X_coeff]

/-- Hermitian symmetry modulo z^N gives the exact parity-dependent
coefficient symmetry below N, for all polynomial representatives. -/
theorem truncated_hermitian_coefficient (N : ℕ)
    (A : Matrix ι ι (Polynomial k)) (hermitian : IsTruncatedHermitian N A)
    (e : ℕ) (he : e < N) (i j : ι) :
    (A j i).coeff e = (A i j).coeff e * (-1 : k) ^ e := by
  have hz : (A j i - polynomialHermitianTranspose A j i).coeff e = 0 :=
    (X_pow_dvd_iff.mp (hermitian j i)) e he
  rw [coeff_sub, sub_eq_zero] at hz
  change (A j i).coeff e = ((A i j).comp (-X)).coeff e at hz
  rw [polynomial_reflection_coefficient] at hz
  exact hz

/-- An odd coefficient form is literally skew symmetric. -/
theorem odd_truncated_hermitian_coefficient_skew (N : ℕ)
    (A : Matrix ι ι (Polynomial k)) (hermitian : IsTruncatedHermitian N A)
    (e : ℕ) (he : e < N) (odd : Odd e) :
    (polynomialCoefficientMatrix A e).transpose =
      -polynomialCoefficientMatrix A e := by
  funext i j
  change (A j i).coeff e = -(A i j).coeff e
  rw [truncated_hermitian_coefficient N A hermitian e he,
    odd.neg_one_pow, mul_neg_one]

end CoefficientSymmetry

section DeterminantParity

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

/-- Invertible skew symmetric matrices have even size when two is
nonzero. The argument is determinant parity, not matrix enumeration. -/
theorem invertible_skew_matrix_even_size (two_ne_zero : (2 : k) ≠ 0)
    (A : Matrix ι ι k) (skew : A.transpose = -A) (det_ne_zero : A.det ≠ 0) :
    Even (Fintype.card ι) := by
  by_contra h
  have odd : Odd (Fintype.card ι) := Nat.not_even_iff_odd.mp h
  have hd : A.det = (-1 : k) ^ Fintype.card ι * A.det := by
    calc
      A.det = A.transpose.det := A.det_transpose.symm
      _ = (-A).det := congrArg Matrix.det skew
      _ = (-1 : k) ^ Fintype.card ι * A.det := Matrix.det_neg A
  rw [odd.neg_one_pow, neg_one_mul] at hd
  have hsum : A.det + A.det = 0 := eq_neg_iff_add_eq_zero.mp hd
  apply mul_ne_zero two_ne_zero det_ne_zero
  simpa only [two_mul] using hsum

/-- Every odd leading form of an actual truncated Hermitian matrix
has even size whenever that coefficient form is invertible. -/
theorem odd_leading_hermitian_even_size (two_ne_zero : (2 : k) ≠ 0)
    (N : ℕ) (A : Matrix ι ι (Polynomial k)) :
    Specifications.OddLeadingHermitianSize N A := by
  intro hermitian e he odd hdet
  exact invertible_skew_matrix_even_size two_ne_zero _
    (odd_truncated_hermitian_coefficient_skew N A hermitian e he odd) hdet

end DeterminantParity

end Litt3.Deformations
