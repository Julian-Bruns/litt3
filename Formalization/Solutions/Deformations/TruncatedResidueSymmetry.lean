import Theorems.Deformations.TruncatedResidueSymmetry
import Solutions.Deformations.HermitianLeadingExtraction
import Solutions.Deformations.SkewMatrixForm
import Solutions.Deformations.RadicalDimensionDrop

namespace Litt3.Deformations

open Polynomial

variable {k : Type*} [CommRing k]

/-- The actual residue is fixed by the full actual reflection. -/
theorem truncated_residue_reflection (N : ℕ) (positive : 0 < N)
    (x : TruncatedCoefficientRing k N) :
    truncatedResidue k N positive (truncatedReflection k N x) =
      truncatedResidue k N positive x := by
  have h : (truncatedResidue k N positive).comp (truncatedReflection k N) =
      truncatedResidue k N positive := by
    apply AdjoinRoot.ringHom_ext
    · apply RingHom.ext
      intro c
      simp only [RingHom.comp_apply, truncated_reflection_constant]
    · change truncatedResidue k N positive
        (truncatedReflection k N (truncatedParameter k N)) =
          truncatedResidue k N positive (truncatedParameter k N)
      rw [truncated_reflection_parameter, map_neg, truncated_residue_parameter, neg_zero]
  exact DFunLike.congr_fun h x

/-- The entire signed symmetry descends to the entire actual
residue matrix, over arbitrary commutative coefficients. -/
theorem truncated_signed_residue_symmetry {ι : Type*} (N : ℕ) (positive : 0 < N)
    (ε : TruncatedCoefficientRing k N) (B : Matrix ι ι (TruncatedCoefficientRing k N))
    (symmetry : truncatedHermitianTranspose k N B = ε • B) :
    (truncatedResidueMatrix k N positive B).transpose =
      truncatedResidue k N positive ε • truncatedResidueMatrix k N positive B := by
  ext i j
  have h := congrArg (fun M : Matrix ι ι (TruncatedCoefficientRing k N) => M i j) symmetry
  change truncatedReflection k N (B j i) = ε * B i j at h
  have hr := congrArg (truncatedResidue k N positive) h
  rw [truncated_residue_reflection, map_mul] at hr
  exact hr

theorem odd_signed_residue_skew {ι : Type*} (N : ℕ) (positive : 0 < N)
    (e : ℕ) (odd : Odd e) (B : Matrix ι ι (TruncatedCoefficientRing k N))
    (symmetry : truncatedHermitianTranspose k N B = (-1 : TruncatedCoefficientRing k N) ^ e • B) :
    (truncatedResidueMatrix k N positive B).transpose =
      -truncatedResidueMatrix k N positive B := by
  have h := truncated_signed_residue_symmetry N positive ((-1) ^ e) B symmetry
  simpa only [map_pow, map_neg, map_one, odd.neg_one_pow, neg_one_smul] using h

/-- Every actual primitive odd leading matrix removes a
positive even rank nondegenerate block; its complete radical
has strictly smaller rank. This supplies the recursion measure. -/
theorem odd_leading_positive_even_split {K ι : Type*} [Field K] [Fintype ι] [DecidableEq ι]
    (two_ne_zero : (2 : K) ≠ 0) (N : ℕ) (positive : 0 < N)
    (e : ℕ) (odd : Odd e) (B : Matrix ι ι (TruncatedCoefficientRing K N))
    (symmetry : truncatedHermitianTranspose K N B = (-1 : TruncatedCoefficientRing K N) ^ e • B)
    (primitive : truncatedResidueMatrix K N positive B ≠ 0) :
    Specifications.OddLeadingPositiveEvenSplit N positive B := by
  let form := residueMatrixForm (truncatedResidueMatrix K N positive B)
  have alternating : form.IsAlt :=
    skew_matrix_alternating_form two_ne_zero _ (odd_signed_residue_skew N positive e odd B symmetry)
  have nonzero : form ≠ 0 := by
    intro hz
    apply primitive
    have h := congrArg Matrix.toBilin'.symm hz
    simpa only [form, residueMatrixForm, LinearEquiv.symm_apply_apply, map_zero] using h
  obtain ⟨U, complement, nondegenerate, positiveRank, radicalDrop⟩ :=
    nonzero_reflexive_radical_dimension_drop form alternating.isRefl nonzero
  refine ⟨U, complement, nondegenerate, positiveRank, ?_, ?_⟩
  · exact nondegenerate_alternating_finrank_even two_ne_zero (form.restrict U)
      (fun x => alternating x.val) nondegenerate
  · simpa only [Module.finrank_fintype_fun_eq_card] using radicalDrop

end Litt3.Deformations
