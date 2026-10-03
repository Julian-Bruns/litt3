import Definitions.Deformations.TruncatedBasisLift
import Definitions.Deformations.RadicalSplitBasis

namespace Litt3.Deformations

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

noncomputable abbrev leadingResidueForm (N : ℕ) (positive : 0 < N)
    (B : Matrix ι ι (TruncatedCoefficientRing k N)) :=
  residueMatrixForm (truncatedResidueMatrix k N positive B)

noncomputable def signedLeadingBasisMatrix (N : ℕ) (positive : 0 < N)
    (B : Matrix ι ι (TruncatedCoefficientRing k N)) (U : Submodule k (ι → k))
    (complement : IsCompl U (BilinearRadical (leadingResidueForm N positive B))) :=
  truncatedBasisMatrix N (Pi.basisFun k ι)
    (radicalSplitBasis (leadingResidueForm N positive B) U complement)

noncomputable def signedLeadingChangedMatrix (N : ℕ) (positive : 0 < N)
    (B : Matrix ι ι (TruncatedCoefficientRing k N)) (U : Submodule k (ι → k))
    (complement : IsCompl U (BilinearRadical (leadingResidueForm N positive B))) :=
  truncatedHermitianTranspose k N (signedLeadingBasisMatrix N positive B U complement) *
    B * signedLeadingBasisMatrix N positive B U complement

/-- Actual leading-block data obtained from a genuine residue
radical complement and its genuine full constant basis lift. -/
structure SignedLeadingSplitData (N : ℕ) (positive : 0 < N) (e : ℕ)
    (B : Matrix ι ι (TruncatedCoefficientRing k N)) where
  U : Submodule k (ι → k)
  complement : IsCompl U (BilinearRadical (leadingResidueForm N positive B))
  nondegenerate : ((leadingResidueForm N positive B).restrict U).Nondegenerate
  positive_rank : 0 < Module.finrank k U
  radical_drop : Module.finrank k (BilinearRadical (leadingResidueForm N positive B)) < Fintype.card ι
  unit_leading : IsUnit (signedLeadingChangedMatrix N positive B U complement).toBlocks₁₁
  zero_cross : truncatedResidueMatrix k N positive
    (signedLeadingChangedMatrix N positive B U complement).toBlocks₁₂ = 0
  zero_remaining : truncatedResidueMatrix k N positive
    (signedLeadingChangedMatrix N positive B U complement).toBlocks₂₂ = 0
  signed_shape : signedLeadingChangedMatrix N positive B U complement =
    Matrix.fromBlocks
      (signedLeadingChangedMatrix N positive B U complement).toBlocks₁₁
      (signedLeadingChangedMatrix N positive B U complement).toBlocks₁₂
      ((-1 : TruncatedCoefficientRing k N) ^ e • truncatedHermitianTranspose k N
        (signedLeadingChangedMatrix N positive B U complement).toBlocks₁₂)
      (signedLeadingChangedMatrix N positive B U complement).toBlocks₂₂
  leading_symmetry : truncatedHermitianTranspose k N
    (signedLeadingChangedMatrix N positive B U complement).toBlocks₁₁ =
      (-1 : TruncatedCoefficientRing k N) ^ e •
        (signedLeadingChangedMatrix N positive B U complement).toBlocks₁₁
  remaining_symmetry : truncatedHermitianTranspose k N
    (signedLeadingChangedMatrix N positive B U complement).toBlocks₂₂ =
      (-1 : TruncatedCoefficientRing k N) ^ e •
        (signedLeadingChangedMatrix N positive B U complement).toBlocks₂₂
  odd_rank : Odd e → Even (Module.finrank k U)

end Litt3.Deformations
