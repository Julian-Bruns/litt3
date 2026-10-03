import Definitions.Deformations.TruncatedResidueSymmetry

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

def OddLeadingPositiveEvenSplit (N : ℕ) (positive : 0 < N)
    (B : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  ∃ U : Submodule k (ι → k),
    IsCompl U (BilinearRadical (residueMatrixForm (truncatedResidueMatrix k N positive B))) ∧
    ((residueMatrixForm (truncatedResidueMatrix k N positive B)).restrict U).Nondegenerate ∧
    0 < Module.finrank k U ∧ Even (Module.finrank k U) ∧
      Module.finrank k (BilinearRadical
        (residueMatrixForm (truncatedResidueMatrix k N positive B))) < Fintype.card ι

end Litt3.Deformations.Specifications
