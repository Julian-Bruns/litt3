import Theorems.Deformations.StrictSkewPairing
import Solutions.Deformations.MixedHermitianModel
import Mathlib.Tactic.Abel

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]
variable [Invertible (2 : k)]

theorem truncated_reflection_inverse_two (N : ℕ) :
    letI := truncatedInvertibleTwo (k := k) N
    truncatedReflection k N (⅟ (2 : TruncatedCoefficientRing k N)) =
      ⅟ (2 : TruncatedCoefficientRing k N) := by
  letI := truncatedInvertibleTwo (k := k) N
  have inverse : (2 : TruncatedCoefficientRing k N) *
      truncatedReflection k N (⅟ (2 : TruncatedCoefficientRing k N)) = 1 := by
    calc
      _ = truncatedReflection k N ((2 : TruncatedCoefficientRing k N) *
          ⅟ (2 : TruncatedCoefficientRing k N)) := by rw [map_mul, map_ofNat]
      _ = 1 := by rw [mul_invOf_self, map_one]
  exact (invOf_eq_right_inv inverse).symm

omit [Fintype ι] [DecidableEq ι] in
theorem strict_mixed_pairing_adjoint (N : ℕ)
    (H J : Matrix ι ι (TruncatedCoefficientRing k N)) :
    letI := truncatedInvertibleTwo (k := k) N
    (strictMixedPairing N H J).conjTranspose =
      (⅟ (2 : TruncatedCoefficientRing k N)) • (H.conjTranspose - J) := by
  letI := truncatedInvertibleTwo (k := k) N
  ext i j
  change truncatedReflection k N (⅟ (2 : TruncatedCoefficientRing k N) *
      (H j i - truncatedReflection k N (J i j))) =
    ⅟ (2 : TruncatedCoefficientRing k N) * (truncatedReflection k N (H j i) - J i j)
  rw [map_mul, map_sub, truncated_reflection_inverse_two,
    truncated_reflection_involution]

omit [DecidableEq ι] in
/-- The actual average is a strict skew chain pairing;
the chain-map relation follows from the original relation
and its actual conjugate transpose. -/
theorem strict_mixed_pairing_compatibility (N : ℕ)
    (A H J : Matrix ι ι (TruncatedCoefficientRing k N))
    (chain : A.transpose * J + H * truncatedMatrixReflection N A = 0) :
    strictMixedPairing N H J * truncatedMatrixReflection N A =
      A.transpose * (strictMixedPairing N H J).conjTranspose := by
  letI := truncatedInvertibleTwo (k := k) N
  have adjointChain := congrArg Matrix.conjTranspose chain
  rw [Matrix.conjTranspose_add, Matrix.conjTranspose_mul, Matrix.conjTranspose_mul,
    Matrix.conjTranspose_zero, truncated_matrix_reflection_conjTranspose,
    show A.transpose.conjTranspose = truncatedMatrixReflection N A from rfl] at adjointChain
  have first : H * truncatedMatrixReflection N A = -(A.transpose * J) :=
    add_eq_zero_iff_eq_neg.mp (by simpa only [add_comm] using chain)
  have second : J.conjTranspose * truncatedMatrixReflection N A = -(A.transpose * H.conjTranspose) :=
    add_eq_zero_iff_eq_neg.mp adjointChain
  rw [strict_mixed_pairing_adjoint]
  change ((⅟ (2 : TruncatedCoefficientRing k N)) • (H - J.conjTranspose)) *
    truncatedMatrixReflection N A =
      A.transpose * ((⅟ (2 : TruncatedCoefficientRing k N)) • (H.conjTranspose - J))
  rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.sub_mul, Matrix.mul_sub, first, second]
  congr 1
  abel

/-- A genuine minimal perfect pairing with its actual
skew-symmetry homotopy yields an actual Hermitian model
of the complete kernel, via strict averaging and an actual
invertible codomain change. -/
theorem minimal_skew_pairing_hermitian (N : ℕ) (positive : 0 < N)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) :
    Specifications.MinimalSkewPairingHermitian N positive A := by
  intro w
  let H := w.equivalence.f₀.transpose
  let J := w.equivalence.f₁.transpose
  have unitH : IsUnit H := (Matrix.isUnit_transpose _).mpr
    (minimal_homotopy_equivalence_components_invertible N positive A (-A.conjTranspose)
      w.equivalence).1
  have chain : A.transpose * J + H * truncatedMatrixReflection N A = 0 := by
    have h := congrArg Matrix.transpose w.equivalence.forward_chain_map
    rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_neg] at h
    change A.transpose * J = H * (-truncatedMatrixReflection N A) at h
    rw [Matrix.mul_neg] at h
    exact add_eq_zero_iff_eq_neg.mpr h
  have unitStrict := strict_mixed_pairing_unit N positive A H J w.skew_homotopy
    w.equivalence.source_minimal unitH w.skew_zero_homotopy
  exact mixed_hermitian_model N A (strictMixedPairing N H J)
    (strict_mixed_pairing_compatibility N A H J chain) unitStrict

end Litt3.Deformations
