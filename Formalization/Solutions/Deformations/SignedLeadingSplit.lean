import Theorems.Deformations.SignedLeadingSplit
import Solutions.Deformations.TruncatedBasisLift
import Solutions.Deformations.RadicalSplitBasis
import Solutions.Deformations.SignedMatrixForm
import Solutions.Deformations.SignedBlockMatrices

namespace Litt3.Deformations

open Module

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

/-- Automatic actual residue-radical splitting and full basis
lifting for every primitive signed leading matrix. -/
theorem signed_leading_split (two_ne_zero : (2 : k) ≠ 0)
    (N : ℕ) (positive : 0 < N) (e : ℕ)
    (B : Matrix ι ι (TruncatedCoefficientRing k N))
    (symmetry : truncatedHermitianTranspose k N B = (-1 : TruncatedCoefficientRing k N) ^ e • B)
    (primitive : truncatedResidueMatrix k N positive B ≠ 0) :
    Specifications.SignedLeadingSplit N positive e B := by
  let form := leadingResidueForm N positive B
  have hresSigned : (truncatedResidueMatrix k N positive B).transpose =
      (-1 : k) ^ e • truncatedResidueMatrix k N positive B := by
    have h := truncated_signed_residue_symmetry N positive ((-1) ^ e) B symmetry
    simpa only [map_pow, map_neg, map_one] using h
  have reflexive : form.IsRefl :=
    signed_matrix_form_reflexive ((-1 : k) ^ e) (truncatedResidueMatrix k N positive B) hresSigned
  have nonzero : form ≠ 0 := by
    intro hz
    apply primitive
    have h := congrArg Matrix.toBilin'.symm hz
    simpa only [form, leadingResidueForm, residueMatrixForm,
      LinearEquiv.symm_apply_apply, map_zero] using h
  obtain ⟨U, complement, nondegenerate, positiveRank, radicalDrop⟩ :=
    nonzero_reflexive_radical_dimension_drop form reflexive nonzero
  let changed := signedLeadingChangedMatrix N positive B U complement
  let C₀ := _root_.BilinForm.toMatrix (Module.finBasis k U) (form.restrict U)
  have residueSplit : truncatedResidueMatrix k N positive changed =
      Matrix.fromBlocks C₀ 0 0 0 := by
    change truncatedResidueMatrix k N positive
      ((signedLeadingBasisMatrix N positive B U complement).conjTranspose * B *
        signedLeadingBasisMatrix N positive B U complement) = _
    unfold signedLeadingBasisMatrix
    rw [truncated_basis_residue_congruence]
    have hbase : _root_.BilinForm.toMatrix (Pi.basisFun k ι) form =
        truncatedResidueMatrix k N positive B := by
      rw [_root_.BilinForm.toMatrix_basisFun]
      exact LinearMap.BilinForm.toMatrix'_toBilin' _
    have h := _root_.BilinForm.toMatrix_mul_basis_toMatrix (Pi.basisFun k ι)
      (radicalSplitBasis form U complement) form
    rw [hbase] at h
    rw [h, radical_split_matrix form reflexive U complement]
  have leadingResidue : truncatedResidueMatrix k N positive changed.toBlocks₁₁ = C₀ := by
    ext i j
    exact congrArg (fun M => M (Sum.inl i) (Sum.inl j)) residueSplit
  have unitLeading : IsUnit changed.toBlocks₁₁ := by
    apply (truncated_matrix_unit_criterion N positive changed.toBlocks₁₁).mpr
    change IsUnit (truncatedResidueMatrix k N positive changed.toBlocks₁₁)
    rw [leadingResidue, Matrix.isUnit_iff_isUnit_det, isUnit_iff_ne_zero]
    exact (LinearMap.BilinForm.nondegenerate_iff_det_ne_zero (Module.finBasis k U)).mp nondegenerate
  have zeroCross : truncatedResidueMatrix k N positive changed.toBlocks₁₂ = 0 := by
    ext i j
    exact congrArg (fun M => M (Sum.inl i) (Sum.inr j)) residueSplit
  have zeroRemaining : truncatedResidueMatrix k N positive changed.toBlocks₂₂ = 0 := by
    ext i j
    exact congrArg (fun M => M (Sum.inr i) (Sum.inr j)) residueSplit
  have changedSigned : changed.conjTranspose = (-1 : TruncatedCoefficientRing k N) ^ e • changed := by
    change ((signedLeadingBasisMatrix N positive B U complement).conjTranspose * B *
        signedLeadingBasisMatrix N positive B U complement).conjTranspose =
      (-1 : TruncatedCoefficientRing k N) ^ e •
        ((signedLeadingBasisMatrix N positive B U complement).conjTranspose * B *
          signedLeadingBasisMatrix N positive B U complement)
    rw [Matrix.conjTranspose_mul, Matrix.conjTranspose_mul, Matrix.conjTranspose_conjTranspose,
      show B.conjTranspose = (-1 : TruncatedCoefficientRing k N) ^ e • B from symmetry,
      Matrix.smul_mul, Matrix.mul_smul]
    simp only [Matrix.mul_assoc]
  have squareOne : (-1 : TruncatedCoefficientRing k N) ^ e * (-1) ^ e = 1 := by
    rw [← mul_pow]
    simp only [neg_mul_neg, one_mul, one_pow]
  obtain ⟨shape, leadingSymmetry, remainingSymmetry⟩ :=
    signed_block_shape ((-1 : TruncatedCoefficientRing k N) ^ e) squareOne changed changedSigned
  refine ⟨{
    U := U
    complement := complement
    nondegenerate := nondegenerate
    positive_rank := positiveRank
    radical_drop := by simpa only [Module.finrank_fintype_fun_eq_card] using radicalDrop
    unit_leading := unitLeading
    zero_cross := zeroCross
    zero_remaining := zeroRemaining
    signed_shape := shape
    leading_symmetry := leadingSymmetry
    remaining_symmetry := remainingSymmetry
    odd_rank := ?_ }⟩
  intro odd
  have alternating : form.IsAlt :=
    skew_matrix_alternating_form two_ne_zero _ (odd_signed_residue_skew N positive e odd B symmetry)
  exact nondegenerate_alternating_finrank_even two_ne_zero (form.restrict U)
    (fun x => alternating x.val) nondegenerate

end Litt3.Deformations
