import Definitions.Deformations.HermitianLeadingExtraction

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [CommRing k]

def HermitianPrimitiveDivision (N : ℕ)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  ∃ e : ℕ, ∃ less : e < N, ∃ B : Matrix ι ι (TruncatedCoefficientRing k N),
    A = truncatedParameter k N ^ e • B ∧
    truncatedHermitianTranspose k (N - e)
        (truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) B) =
      (-1 : TruncatedCoefficientRing k (N - e)) ^ e •
        truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) B ∧
    ∃ i j, truncatedResidue k (N - e) (Nat.sub_pos_of_lt less)
      (truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) B i j) ≠ 0

end Litt3.Deformations.Specifications
