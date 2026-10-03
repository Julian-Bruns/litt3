import Theorems.Deformations.PairedMinimalHermitian
import Solutions.Deformations.MinimalComplex
import Solutions.Deformations.TruncatedReflection
import Solutions.Deformations.KernelTransport
import Mathlib.Tactic.Ring

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

omit [Fintype ι] [DecidableEq ι] in
theorem truncated_matrix_reflection_involution (N : ℕ)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) :
    truncatedMatrixReflection N (truncatedMatrixReflection N A) = A := by
  ext i j
  exact truncated_reflection_involution N (A i j)

omit [Fintype ι] [DecidableEq ι] in
theorem truncated_matrix_reflection_conjTranspose (N : ℕ)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) :
    (truncatedMatrixReflection N A).conjTranspose = A.transpose := by
  ext i j
  exact truncated_reflection_involution N (A j i)

omit [Fintype ι] [DecidableEq ι] in
theorem truncated_matrix_reflection_transpose (N : ℕ)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) :
    truncatedMatrixReflection N A.transpose = A.conjTranspose := rfl

variable [Invertible (2 : k)]

/-- Averaging an actual mixed chain pairing with its negative
adjoint gives the exact strict skew relation and retains the
actual invertible mixed component of a minimal complex. -/
theorem strict_mixed_pairing_unit (N : ℕ) (positive : 0 < N)
    (A H J T : Matrix ι ι (TruncatedCoefficientRing k N))
    (minimal : truncatedResidueMatrix k N positive A = 0)
    (unitH : IsUnit H)
    (skew_homotopy : H + J.conjTranspose = A.transpose * T) :
    IsUnit (strictMixedPairing N H J) := by
  letI := truncatedInvertibleTwo (k := k) N
  have halves : ⅟ (2 : TruncatedCoefficientRing k N) + ⅟ (2 : TruncatedCoefficientRing k N) = 1 := by
    rw [← mul_two, invOf_mul_self]
  have balance : strictMixedPairing N H J = H -
      (⅟ (2 : TruncatedCoefficientRing k N)) • (H + J.conjTranspose) := by
    ext i j
    change ⅟ (2 : TruncatedCoefficientRing k N) * (H i j - J.conjTranspose i j) =
      H i j - ⅟ (2 : TruncatedCoefficientRing k N) * (H i j + J.conjTranspose i j)
    calc
      _ = (⅟ (2 : TruncatedCoefficientRing k N) + ⅟ (2 : TruncatedCoefficientRing k N)) * H i j -
          ⅟ (2 : TruncatedCoefficientRing k N) * (H i j + J.conjTranspose i j) := by ring
      _ = _ := by rw [halves, one_mul]
  have residueEqual : truncatedResidueMatrix k N positive (strictMixedPairing N H J) =
      truncatedResidueMatrix k N positive H := by
    rw [balance, skew_homotopy]
    change (H - ⅟ (2 : TruncatedCoefficientRing k N) • (A.transpose * T)).map
      (truncatedResidue k N positive) = H.map (truncatedResidue k N positive)
    have mapScaled : (⅟ (2 : TruncatedCoefficientRing k N) • (A.transpose * T)).map
        (truncatedResidue k N positive) =
      (truncatedResidue k N positive (⅟ (2 : TruncatedCoefficientRing k N))) •
        ((A.transpose * T).map (truncatedResidue k N positive)) := by
      ext i j
      exact map_mul (truncatedResidue k N positive) _ _
    change (truncatedResidue k N positive).mapMatrix
      (H - ⅟ (2 : TruncatedCoefficientRing k N) • (A.transpose * T)) = _
    rw [map_sub]
    change H.map (truncatedResidue k N positive) -
      (⅟ (2 : TruncatedCoefficientRing k N) • (A.transpose * T)).map
        (truncatedResidue k N positive) = _
    rw [mapScaled, Matrix.map_mul]
    have zeroTranspose : A.transpose.map (truncatedResidue k N positive) = 0 := by
      change (truncatedResidueMatrix k N positive A).transpose = 0
      rw [minimal, Matrix.transpose_zero]
    rw [zeroTranspose, Matrix.zero_mul, smul_zero, sub_zero]
  apply (truncated_matrix_unit_criterion N positive _).mpr
  change IsUnit (truncatedResidueMatrix k N positive (strictMixedPairing N H J))
  rw [residueEqual]
  exact (truncated_matrix_unit_criterion N positive H).mp unitH

end Litt3.Deformations
