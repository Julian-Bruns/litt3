import Theorems.Deformations.HermitianValuationStep
import Solutions.Deformations.HermitianLeadingExtraction
import Solutions.Deformations.SignedLeadingSplit
import Solutions.Deformations.TruncatedSchurStep

namespace Litt3.Deformations

open Module

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

/-- Every nonzero actual Hermitian matrix admits a full actual
valuation split with positive removed rank, strictly smaller
remaining rank, and the parity forced by its leading symmetry. -/
theorem hermitian_valuation_step (two_ne_zero : (2 : k) ≠ 0)
    (N : ℕ) (positive : 0 < N)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) (nonzero : A ≠ 0)
    (hermitian : truncatedHermitianTranspose k N A = A) :
    Specifications.HermitianValuationStep N A := by
  obtain ⟨e, less, B, factorization, signed, i, j, primitiveEntry⟩ :=
    hermitian_primitive_division N positive A nonzero hermitian
  let L := N - e
  have positiveL : 0 < L := Nat.sub_pos_of_lt less
  let short := truncatedMatrixRestriction k N L (Nat.sub_le _ _) B
  have primitive : truncatedResidueMatrix k L positiveL short ≠ 0 := by
    intro hz
    apply primitiveEntry
    exact congrArg (fun M => M i j) hz
  obtain ⟨data⟩ := signed_leading_split two_ne_zero L positiveL e short signed primitive
  let base := Pi.basisFun k ι
  let split := radicalSplitBasis (leadingResidueForm L positiveL short) data.U data.complement
  let P₀ := truncatedBasisMatrix N base split
  let Q₀ := truncatedBasisMatrix N split base
  let changed := P₀.conjTranspose * B * P₀
  let shortChanged := signedLeadingChangedMatrix L positiveL short data.U data.complement
  have baseInverse : MatrixInversePair P₀ Q₀ := by
    obtain ⟨hleft, hright⟩ := truncated_basis_matrices_inverse N base split
    exact ⟨hleft, hright⟩
  have reduction : truncatedMatrixRestriction k N L (Nat.sub_le _ _) changed = shortChanged := by
    change (P₀.conjTranspose * B * P₀).map
      (truncatedRestriction k N L (Nat.sub_le _ _)).toRingHom = _
    rw [Matrix.map_mul (f := (truncatedRestriction k N L (Nat.sub_le _ _)).toRingHom),
      Matrix.map_mul (f := (truncatedRestriction k N L (Nat.sub_le _ _)).toRingHom)]
    change truncatedMatrixRestriction k N L (Nat.sub_le _ _) P₀.conjTranspose * short *
      truncatedMatrixRestriction k N L (Nat.sub_le _ _) P₀ = _
    rw [truncated_matrix_restriction_conjTranspose]
    change (truncatedMatrixRestriction k N L (Nat.sub_le _ _)
      (truncatedBasisMatrix N base split)).conjTranspose * short *
      truncatedMatrixRestriction k N L (Nat.sub_le _ _) (truncatedBasisMatrix N base split) = _
    rw [truncated_basis_matrix_restriction]
    rfl
  let C₀ := shortChanged.toBlocks₁₁
  let D₀ := shortChanged.toBlocks₁₂
  let F₀ := shortChanged.toBlocks₂₂
  letI : Invertible C₀ := data.unit_leading.invertible
  have schur : Specifications.TruncatedSchurHigherValuationStep N e changed := by
    rcases Nat.even_or_odd e with even | odd
    · have sign : (-1 : TruncatedCoefficientRing k L) ^ e = 1 := by
        simpa only [one_pow] using even.neg_pow (1 : TruncatedCoefficientRing k L)
      have hC : C₀.conjTranspose = C₀ := by
        simpa only [sign, one_smul] using data.leading_symmetry
      have hshape : shortChanged = Matrix.fromBlocks C₀ D₀ D₀.conjTranspose F₀ := by
        simpa only [sign, one_smul] using data.signed_shape
      apply hermitian_truncated_schur_step N e less changed C₀ D₀ F₀ hC
        data.zero_cross data.zero_remaining
      exact reduction.trans hshape
    · have sign : (-1 : TruncatedCoefficientRing k L) ^ e = -1 := by
        simpa only [one_pow] using odd.neg_pow (1 : TruncatedCoefficientRing k L)
      have hC : C₀.conjTranspose = -C₀ := by
        simpa only [sign, neg_one_smul] using data.leading_symmetry
      have hshape : shortChanged = Matrix.fromBlocks C₀ D₀ (-D₀.conjTranspose) F₀ := by
        simpa only [sign, neg_one_smul] using data.signed_shape
      apply skew_hermitian_truncated_schur_step N e less changed C₀ D₀ F₀ hC
        data.zero_cross data.zero_remaining
      exact reduction.trans hshape
  obtain ⟨S, hS, C, hC, F, fullSplit⟩ := schur
  letI : Invertible S := hS.invertible
  let P := P₀ * S
  let Q := ⅟S * Q₀
  have inversePair : MatrixInversePair P Q := {
    left_inverse := by
      change (⅟S * Q₀) * (P₀ * S) = 1
      calc
        _ = ⅟S * (Q₀ * P₀) * S := by simp only [Matrix.mul_assoc]
        _ = 1 := by rw [baseInverse.left_inverse, Matrix.mul_one, invOf_mul_self]
    right_inverse := by
      change (P₀ * S) * (⅟S * Q₀) = 1
      calc
        _ = P₀ * (S * ⅟S) * Q₀ := by simp only [Matrix.mul_assoc]
        _ = 1 := by rw [mul_invOf_self, Matrix.mul_one, baseInverse.right_inverse] }
  have fullIdentity : P.conjTranspose * A * P =
      Matrix.fromBlocks (truncatedParameter k N ^ e • C) 0 0
        (truncatedParameter k N ^ (e + 1) • F) := by
    change (P₀ * S).conjTranspose * A * (P₀ * S) = _
    rw [Matrix.conjTranspose_mul, factorization]
    have hscaled : P₀.conjTranspose * (truncatedParameter k N ^ e • B) * P₀ =
        truncatedParameter k N ^ e • changed := by
      rw [Matrix.mul_smul, Matrix.smul_mul]
    calc
      _ = S.conjTranspose * (P₀.conjTranspose *
          (truncatedParameter k N ^ e • B) * P₀) * S := by simp only [Matrix.mul_assoc]
      _ = _ := by rw [hscaled]; exact fullSplit
  have changedHermitian : (P.conjTranspose * A * P).conjTranspose = P.conjTranspose * A * P := by
    simp only [Matrix.conjTranspose_mul, Matrix.conjTranspose_conjTranspose,
      show A.conjTranspose = A from hermitian, Matrix.mul_assoc]
  have remainderHermitian : (truncatedParameter k N ^ (e + 1) • F).conjTranspose =
      truncatedParameter k N ^ (e + 1) • F := by
    rw [fullIdentity] at changedHermitian
    ext x y
    exact congrArg (fun M => M (Sum.inr x) (Sum.inr y)) changedHermitian
  refine ⟨{
    e := e
    less := less
    m := Module.finrank k data.U
    r := Module.finrank k (BilinearRadical (leadingResidueForm L positiveL short))
    positive_rank := data.positive_rank
    radical_drop := data.radical_drop
    rank_sum := ?_
    P := P
    Q := Q
    inverse_pair := inversePair
    C := C
    unit_leading := hC
    F := F
    congruence := fullIdentity
    remainder_hermitian := remainderHermitian
    odd_rank := data.odd_rank }⟩
  have h := Submodule.finrank_add_eq_of_isCompl data.complement
  simpa only [Module.finrank_fintype_fun_eq_card] using h

end Litt3.Deformations
